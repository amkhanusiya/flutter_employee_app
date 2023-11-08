import 'package:employee_app/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class EmployeeDatabase {
  final String boxName = 'employees';
  Box<Employee>? _employeeBox;

  Future<void> initialize() async {
    _employeeBox ??= await Hive.openBox<Employee>(boxName);
  }

  Future<void> addEmployee(Employee employee) async {
    await initialize();
    await _employeeBox!.add(employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    await initialize();
    final int employeeIndex = await _getEmployeeById(employee.id);
    await _employeeBox!.putAt(employeeIndex, employee);
  }

  Future<void> deleteEmployee(Employee employee) async {
    await initialize();
    final int employeeIndex = await _getEmployeeById(employee.id);
    await _employeeBox!.delete(employeeIndex);
  }

  Future<List<Employee>> getEmployees() async {
    await initialize();
    return _employeeBox!.values.toList();
  }

  Future<int> _getEmployeeById(String id) async {
    return _employeeBox!.values
        .toList()
        .indexWhere((element) => element.id == id);
  }
}
