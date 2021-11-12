const String tableRecord = 'Record';

class RecordFields {
  static final List<String> values = [
    /// Add all fields
    id, model, status, service, user, time
  ];

  static const String id = '_id';
  static const String model = 'model';
  static const String status = 'status';
  static const String service = 'service';
  static const String user = 'user';
  static const String time = 'time';
  static const String timeOfServices = 'timeServices';
}

class Record {
  final int? id;
  final String? model;
  final String? status;
  final String? service;
  final String? user;
  final DateTime time;
  final DateTime timeServices;

  const Record(
      {this.id,
      required this.model,
      required this.status,
      required this.service,
      required this.user,
      required this.time,
      required this.timeServices});

  Record copy({
    int? id,
    String? model,
    String? status,
    String? service,
    String? user,
    DateTime? time,
    DateTime? timeServices,
  }) =>
      Record(
          id: id ?? this.id,
          model: model ?? this.model,
          status: status ?? this.status,
          service: service ?? this.service,
          user: user ?? this.user,
          time: time ?? this.time,
          timeServices: timeServices ?? this.timeServices);

  static Record fromJson(Map<String, Object?> json) => Record(
        id: json[RecordFields.id] as int?,
        model: json[RecordFields.model] as String,
        status: json[RecordFields.status] as String,
        service: json[RecordFields.service] as String,
        user: json[RecordFields.user] as String?,
        time: DateTime.parse(json[RecordFields.time] as String),
        timeServices:
            DateTime.parse(json[RecordFields.timeOfServices] as String),
      );

  Map<String, Object?> toJson() => {
        RecordFields.id: id,
        RecordFields.model: model,
        RecordFields.status: status,
        RecordFields.service: service,
        RecordFields.user: user,
        RecordFields.time: time.toIso8601String(),
        RecordFields.timeOfServices: timeServices.toIso8601String(),
      };
}
