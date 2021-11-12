const String tableStatus = 'Status';

class StatusFields {
  static final List<String> values = [
    /// Add all fields
    id, name, time, discretion
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String time = 'time';
  static const String discretion = 'discretion';
}

class Status {
  final int? id;
  final String? name;
  final String? discretion;
  final DateTime createdTime;

  const Status({
    this.id,
    required this.name,
    required this.discretion,
    required this.createdTime,
  });

  Status copy({
    int? id,
    String? name,
    String? discretion,
    DateTime? createdTime,
  }) =>
      Status(
        id: id ?? this.id,
        discretion: discretion ?? this.discretion,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
      );

  static Status fromJson(Map<String, Object?> json) => Status(
        id: json[StatusFields.id] as int?,
        discretion: json[StatusFields.discretion] as String,
        name: json[StatusFields.name] as String,
        createdTime: DateTime.parse(json[StatusFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        StatusFields.id: id,
        StatusFields.name: name,
        StatusFields.discretion: discretion,
        StatusFields.time: createdTime.toIso8601String(),
      };
}
