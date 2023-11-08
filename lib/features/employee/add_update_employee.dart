import 'package:auto_route/auto_route.dart';
import 'package:employee_app/blocs/blocs.dart';
import 'package:employee_app/i18n/strings.g.dart';
import 'package:employee_app/models/models.dart';
import 'package:employee_app/modules/modules.dart';
import 'package:employee_app/utils/constants.dart';
import 'package:employee_app/utils/methods/aliases.dart';
import 'package:employee_app/utils/methods/shortcuts.dart';
import 'package:employee_app/utils/r.dart';
import 'package:employee_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class AddUpdateEmployee extends StatelessWidget {
  final Employee? employee;

  final TextEditingController empNameController = TextEditingController();
  final TextEditingController roleController =
      TextEditingController(text: null);
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddUpdateEmployee({this.employee, super.key}) {
    if (employee != null) {
      empNameController.text = employee!.name;
      roleController.text = employee!.role;
      fromController.text = employee!.fromDate;
      toController.text = employee!.toDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          employee != null
              ? context.t.core.appBar.edit_employee
              : context.t.core.appBar.add_employee,
        ),
      ),
      body: BlocListener<EmployeeCubit, EmployeeState>(
        bloc: getIt<EmployeeCubit>(),
        listener: (context, state) {
          logIt.info(state);
          state.maybeWhen(
            orElse: () => logIt.info("orElse"),
            created: () {
              context.router.back();
              toast.showToast(context.t.employee.result.create_success);
            },
            updated: () {
              context.router.back();
              toast.showToast(context.t.employee.result.update_success);
            },
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: _form(context),
            ),
            _bottomBar(context),
          ],
        ),
      ),
    );
  }

  Expanded _bottomBar(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Divider(
            thickness: 2,
            color: $constants.palette.dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.router.back(),
                  child: Text(context.t.core.buttons.cancel),
                ),
                SizedBox(width: Adaptive.dp(10)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (employee != null) {
                        getIt<EmployeeCubit>().updateEmployee(
                          employee!.copyWith(
                            fromDate: fromController.text,
                            toDate: toController.text,
                            name: empNameController.text,
                            role: roleController.text,
                          ),
                        );
                      } else {
                        getIt<EmployeeCubit>().addEmployee(
                          empNameController.text,
                          roleController.text,
                          fromController.text,
                          toController.text,
                        );
                      }
                    }
                  },
                  child: Text(context.t.core.buttons.save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _form(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            controller: empNameController,
            hint: context.t.employee.form.emp_name,
            svgName: R.svg.employee,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter employee name";
              }
              return null;
            },
          ),
          SizedBox(height: Adaptive.dp(20)),
          AppDropDown<String>(
            hint: context.t.employee.form.select_role,
            svgName: R.svg.select_role,
            selected:
                roleController.text.isNotEmpty ? roleController.text : null,
            entries: $constants.employeeRole.roles,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select role";
              }
              return null;
            },
            onChanged: (value) => roleController.text = value!,
          ),
          SizedBox(height: Adaptive.dp(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getSize(context).width * 0.4,
                child: AppTextField(
                  controller: fromController,
                  hint: context.t.employee.form.no_date,
                  svgName: R.svg.calendar,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select start date";
                    }
                    return null;
                  },
                  onTap: () => _selectDate(context).then((value) {
                    if (value != null) {
                      fromController.text = dateTime.formatDate(value);
                    }
                  }),
                ),
              ),
              SvgPicture.asset(R.svg.arrow_forward),
              SizedBox(
                width: getSize(context).width * 0.4,
                child: AppTextField(
                  controller: toController,
                  hint: context.t.employee.form.no_date,
                  svgName: R.svg.calendar,
                  readOnly: true,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (dateTime
                          .toDateTime(value)
                          .isBefore(dateTime.toDateTime(fromController.text))) {
                        return "End date must be after start date";
                      }
                      return null;
                    }
                    return null;
                  },
                  onTap: () =>
                      _selectDate(context, isEndDate: true).then((value) {
                    toController.text =
                        value != null ? dateTime.formatDate(value) : '';
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context,
      {bool isEndDate = false}) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Adaptive.dp(20),
            vertical: Adaptive.dp(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: AppDatePickerDialog(
            isEndDate,
            firstDate: isEndDate ? fromController.text : "",
            date: isEndDate ? toController.text : fromController.text,
          ),
        );
      },
    );
  }
}
