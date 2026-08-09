enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address({required this.street, required this.city, required this.zipCode});
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  Employee(
    this._name,
    this._baseSalary,
    this._skills,
    this._address,
    this._yearsOfExperience,
  );

  Employee.mobileDeveloper({
    required String name,
    required double baseSalary,
    required Address address,
    required int yearsOfExperience,
  }) : _name = name,
       _baseSalary = baseSalary,
       _skills = [Skill.FLUTTER, Skill.DART],
       _address = address,
       _yearsOfExperience = yearsOfExperience;

  double computeSalary() {
    double totalSalary = _baseSalary;

    totalSalary += _yearsOfExperience * 2000;

    for (var skill in _skills) {
      if (skill == Skill.FLUTTER) {
        totalSalary += 5000;
      } else if (skill == Skill.DART) {
        totalSalary += 3000;
      } else if (skill == Skill.OTHER) {
        totalSalary += 1000;
      }
    }

    return totalSalary;
  }

  @override
  String toString() {
    String skillNames = _skills.map((s) => s.name).join(', ');

    return 'Employee Name: $_name\n'
        'Address: ${_address.street}, ${_address.city}, ${_address.zipCode}\n'
        'Years of Experience: $_yearsOfExperience\n'
        'Skills: $skillNames\n'
        'Base Salary: \$$_baseSalary\n'
        'Total Computed Salary: \$${computeSalary()}\n';
  }
}

void main() {
  var sampleAddress = Address(
    street: '123 CADT St',
    city: 'Phnom Penh',
    zipCode: '12000',
  );

  var emp1 = Employee('Sokea', 40000, [Skill.OTHER], sampleAddress, 2);
  print(emp1);

  var emp2 = Employee.mobileDeveloper(
    name: 'Ronan',
    baseSalary: 40000,
    address: sampleAddress,
    yearsOfExperience: 3,
  );
  print(emp2);
}
