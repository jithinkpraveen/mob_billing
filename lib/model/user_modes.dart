const String tableUser = 'users';

class UsersFields {
  static final List<String> values = [
    /// Add all fields
    id, name, address, phone1, phone2, time
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String address = 'address';
  static const String phone1 = 'phone1';
  static const String phone2 = 'phone2';
  static const String time = 'time';
}

class Users {
  final int? id;
  final String? name;
  final String? address;
  final String? phone1;
  final String? phone2;
  final DateTime createdTime;

  const Users({
    this.id,
    required this.name,
    required this.phone1,
    this.phone2,
    required this.address,
    required this.createdTime,
  });

  Users copy({
    int? id,
    String? name,
    String? phone1,
    String? phone2,
    String? address,
    DateTime? createdTime,
  }) =>
      Users(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        phone1: phone1 ?? this.phone1,
        phone2: phone2 ?? this.phone2,
        createdTime: createdTime ?? this.createdTime,
      );

  static Users fromJson(Map<String, Object?> json) => Users(
        id: json[UsersFields.id] as int?,
        name: json[UsersFields.name] as String,
        address: json[UsersFields.address] as String,
        phone1: json[UsersFields.phone1] as String,
        phone2: json[UsersFields.phone2] as String?,
        createdTime: DateTime.parse(json[UsersFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        UsersFields.id: id,
        UsersFields.name: name,
        UsersFields.address: address,
        UsersFields.phone1: phone1,
        UsersFields.phone2: phone2,
        UsersFields.time: createdTime.toIso8601String(),
      };
}
