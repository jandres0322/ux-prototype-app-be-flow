import 'dart:convert';

import 'package:ux_prototype_app_be_flow/src/models/config_pomodoro.dart';
import 'package:ux_prototype_app_be_flow/src/models/task_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String name;
    String cellphone;
    bool isAuthGoogle;
    ConfigPomodoro? configPomodoro;
    List<Task> tasks;

    User({
        required this.name,
        required this.cellphone,
        required this.isAuthGoogle,
        required this.configPomodoro,
        required this.tasks,
    });

    User copyWith({
        String? name,
        String? cellphone,
        bool? isAuthGoogle,
        ConfigPomodoro? configPomodoro,
        List<Task>? tasks,
    }) =>
        User(
            name: name ?? this.name,
            cellphone: cellphone ?? this.cellphone,
            isAuthGoogle: isAuthGoogle ?? this.isAuthGoogle,
            configPomodoro: configPomodoro ?? this.configPomodoro,
            tasks: tasks ?? this.tasks,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        cellphone: json["cellphone"],
        isAuthGoogle: json["isAuthGoogle"],
        configPomodoro: ConfigPomodoro.fromJson(json["configPomodoro"]),
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "cellphone": cellphone,
        "isAuthGoogle": isAuthGoogle,
        "configPomodoro": configPomodoro?.toJson(),
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    };
}