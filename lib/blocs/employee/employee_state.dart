part of 'employee_cubit.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState.initial() = EmployeeInitialState;

  const factory EmployeeState.created() = EmployeeCreatedState;

  const factory EmployeeState.updated() = EmployeeUpdatedState;

  const factory EmployeeState.fetched(
    List<Employee> current,
    List<Employee> previous,
  ) = EmployeeFetchedState;
}
