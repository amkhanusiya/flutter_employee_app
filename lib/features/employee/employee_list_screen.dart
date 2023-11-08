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
import 'package:flutter_svg/svg.dart';

@RoutePage()
class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

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
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        bloc: getIt<EmployeeCubit>(),
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
              return InkWell(
                onTap: () => context.router.push(AddUpdateEmployeeRoute(employee: employee)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
