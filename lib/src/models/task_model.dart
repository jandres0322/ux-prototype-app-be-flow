class Task {
  String description;
  bool isPomodoroActual;
  DateTime timestamp;

  Task({
    required this.description,
    this.isPomodoroActual = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Task copyWith({
    String? description,
    bool? isCompleted,
    bool? isPomodoroActual,
    DateTime? timestamp,
  }) =>
    Task(
      description: description ?? this.description,
      isPomodoroActual: isPomodoroActual ?? this.isPomodoroActual,
      timestamp: timestamp ?? this.timestamp,
    );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    description: json["description"],
    isPomodoroActual: json["isPomodoroActual"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "isPomodoroActual": isPomodoroActual,
    "timestamp": timestamp.toIso8601String(),
  };
}
