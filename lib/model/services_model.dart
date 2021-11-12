const String tableServices = 'Services';

class ServicesFields {
  static final List<String> values = [
    /// Add all fields
    id, name, time, discretion
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String time = 'time';
  static const String discretion = 'discretion';
}

class Services {
  final int? id;
  final String? name;
  final String? discretion;
  final DateTime createdTime;

  const Services({
    this.id,
    required this.name,
    required this.discretion,
    required this.createdTime,
  });

  Services copy({
    int? id,
    String? name,
    String? discretion,
    DateTime? createdTime,
  }) =>
      Services(
        id: id ?? this.id,
        discretion: discretion ?? this.discretion,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
      );

  static Services fromJson(Map<String, Object?> json) => Services(
        id: json[ServicesFields.id] as int?,
        discretion: json[ServicesFields.discretion] as String,
        name: json[ServicesFields.name] as String,
        createdTime: DateTime.parse(json[ServicesFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        ServicesFields.id: id,
        ServicesFields.name: name,
        ServicesFields.discretion: discretion,
        ServicesFields.time: createdTime.toIso8601String(),
      };
}
