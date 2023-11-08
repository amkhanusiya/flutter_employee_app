import 'package:auto_route/auto_route.dart';
import 'package:employee_app/blocs/blocs.dart';
import 'package:employee_app/i18n/strings.g.dart';
import 'package:employee_app/models/employee.dart';
import 'package:employee_app/modules/dependency_injection/di.dart';
import 'package:employee_app/utils/constants.dart';
import 'package:employee_app/utils/methods/aliases.dart';
import 'package:employee_app/utils/r.dart';
import 'package:employee_app/utils/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class EmployeeList extends StatelessWidget {
  EmployeeList({super.key});

  final EmployeeCubit employeeCubit = getIt<EmployeeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.core.appBar.employee_list,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.push(AddUpdateEmployeeRoute()),
        label: Icon(
          Icons.add,
          size: 24,
          color: $constants.palette.white,
        ),
      ),
      body: BlocConsumer<EmployeeCubit, EmployeeState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => logIt.info("emp list orElse"),
            deleted: () =>
                toast.showToast(context.t.employee.result.delete_success),
          );
        },
        bloc: employeeCubit,
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            fetched: (current, previous) => current.isNotEmpty ||
                    previous.isNotEmpty
                ? ListView(
                    children: [
                      if (current.isNotEmpty)
                        _renderEmployees(context, "Current employees", current),
                      if (previous.isNotEmpty)
                        _renderEmployees(
                            context, "Previous employees", previous)
                    ],
                  )
                : _noEmployeesFound(),
          );
        },
      ),
    );
  }

  Widget _noEmployeesFound() {
    return Center(
      child: SvgPicture.asset(
        R.svg.no_employee_found,
      ),
    );
  }

  Widget _renderEmployees(
    BuildContext context,
    String title,
    List<Employee> employees,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: $constants.palette.grey.withOpacity(0.5),
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: $constants.theme.defaultThemeColor),
            ),
          ),
          ListView.builder(
            itemCount: employees.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Employee employee = employees[index];
              TextTheme textTheme = Theme.of(context).textTheme;
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          _deleteEmployee(context, employee),
                      backgroundColor: $constants.palette.red,
                      foregroundColor: $constants.palette.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () => context.router
                        .push(AddUpdateEmployeeRoute(employee: employee)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            employee.getActualRole(employee.role),
                            style: textTheme.bodySmall,
                          ),
                          Text(
                            employee.toDate.isNotEmpty
                                ? '${employee.fromDate} - ${employee.toDate}'
                                : 'From ${employee.fromDate}',
                            style: textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _deleteEmployee(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.t.core.delete),
        content: Text(ctx.t.core.delete_conformation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(ctx.t.core.buttons.no),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              employeeCubit.deleteEmployee(employee);
            },
            child: Text(ctx.t.core.buttons.yes),
          ),
        ],
      ),
    );
  }
}
