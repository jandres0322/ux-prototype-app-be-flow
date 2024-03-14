class ConfigPomodoro {
    final int focus;
    final int configPomodoroBreak;
    final int longBreak;

    ConfigPomodoro({
        required this.focus,
        required this.configPomodoroBreak,
        required this.longBreak,
    });

    ConfigPomodoro copyWith({
        int? focus,
        int? configPomodoroBreak,
        int? longBreak,
    }) =>
        ConfigPomodoro(
            focus: focus ?? this.focus,
            configPomodoroBreak: configPomodoroBreak ?? this.configPomodoroBreak,
            longBreak: longBreak ?? this.longBreak,
        );

    factory ConfigPomodoro.fromJson(Map<String, dynamic> json) => ConfigPomodoro(
        focus: json["focus"],
        configPomodoroBreak: json["break"],
        longBreak: json["longBreak"],
    );

    Map<String, dynamic> toJson() => {
        "focus": focus,
        "break": configPomodoroBreak,
        "longBreak": longBreak,
    };
}