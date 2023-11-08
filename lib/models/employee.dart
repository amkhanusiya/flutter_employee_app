import 'package:employee_app/utils/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@HiveType(typeId: 0)
@freezed
abstract class Employee with _$Employee {
  factory Employee({
    @HiveField(0) required String id, // Primary key
    @HiveField(1) required String name,
    @HiveField(2) required String role,
    @HiveField(3) required String fromDate,
    @HiveField(4) required String toDate,
  }) = _Employee;
}

extension EmployeeExtension on Employee {
  String getActualRole(String role) {
    return $constants.employeeRole.roles
        .firstWhere((element) => element.value == role)
        .label;
  }

  String getRoleFromActual(String actualRole) {
    return $constants.employeeRole.roles
        .firstWhere((element) => element.label == actualRole)
        .value;
  }
}
