import 'package:employee_app/blocs/employee/employee_database.dart';
import 'package:employee_app/models/models.dart';
import 'package:employee_app/modules/dependency_injection/di.dart';
import 'package:employee_app/utils/methods/aliases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employee_cubit.freezed.dart';

part 'employee_state.dart';

@lazySingleton
class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeDatabase employeeDatabase = getIt<EmployeeDatabase>();

  EmployeeCubit() : super(const EmployeeInitialState()) {
    fetchEmployees();
  }

  Future<void> updateEmployee(Employee employee)async {
    await employeeDatabase.updateEmployee(employee);
    fetchEmployees();
    emit(const EmployeeUpdatedState());
  }

  Future<void> addEmployee(
    String name,
    String role,
    String startDate,
    String endDate,
  ) async {
    await employeeDatabase.addEmployee(
      Employee(
        id: 0,
        name: name,
        role: role,
        fromDate: startDate,
        toDate: endDate,
      ),
    );
    fetchEmployees();
    emit(const EmployeeCreatedState());
  }

  Future<void> fetchEmployees() async {
    List<Employee> allEmployees = await employeeDatabase.getEmployees();

    List<Employee> currentEmployees = allEmployees
        .where(
          (element) => element.toDate.isEmpty,
        )
        .toList();

    List<Employee> previousEmployees = allEmployees
        .where(
          (element) => element.toDate.isNotEmpty,
        )
        .toList();
    logIt.info(allEmployees);
    emit(EmployeeFetchedState(currentEmployees, previousEmployees));
  }
}
