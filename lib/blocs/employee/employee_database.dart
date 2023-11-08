import 'package:employee_app/models/models.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class EmployeeDatabase {
  final String boxName = 'employees';

  Future<void> addEmployee(Employee employee) async {
    final box = await Hive.openBox<Employee>(boxName);
    List<Employee> allEmployees = await getEmployees();
    employee = employee.copyWith(id: allEmployees.length);
    await box.add(employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    final box = await Hive.openBox<Employee>(boxName);
    await box.put(employee.id, employee);
  }

  Future<List<Employee>> getEmployees() async {
    final box = await Hive.openBox<Employee>(boxName);
    return box.values.toList();
  }
}
