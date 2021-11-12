const String tableBrand = 'Brand';

class BrandFields {
  static final List<String> values = [
    /// Add all fields
    id, name, time, discretion
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String time = 'time';
  static const String discretion = 'discretion';
}

class Brand {
  final int? id;
  final String? name;
  final String? discretion;
  final DateTime createdTime;

  const Brand({
    this.id,
    required this.name,
    required this.discretion,
    required this.createdTime,
  });

  Brand copy({
    int? id,
    String? name,
    String? discretion,
    DateTime? createdTime,
  }) =>
      Brand(
        id: id ?? this.id,
        discretion: discretion ?? this.discretion,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
      );

  static Brand fromJson(Map<String, Object?> json) => Brand(
        id: json[BrandFields.id] as int?,
        discretion: json[BrandFields.discretion] as String,
        name: json[BrandFields.name] as String,
        createdTime: DateTime.parse(json[BrandFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        BrandFields.id: id,
        BrandFields.name: name,
        BrandFields.discretion: discretion,
        BrandFields.time: createdTime.toIso8601String(),
      };
}
