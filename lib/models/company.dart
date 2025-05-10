enum CompanyType { customer, supplier, bilateral }

class Company {
  final String name;
  final CompanyType type;

  Company({
    required this.name,
    required this.type,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      type: CompanyType.values.firstWhere(
            (e) => e.name.toLowerCase() == json['type'].toString().toLowerCase(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.name,
    };
  }
}
