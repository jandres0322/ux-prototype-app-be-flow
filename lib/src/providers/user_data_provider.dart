// ignore_for_file: unnecessary_null_comparison, unused_field

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ux_prototype_app_be_flow/src/models/config_pomodoro.dart';
import 'package:ux_prototype_app_be_flow/src/models/task_model.dart';
import 'package:ux_prototype_app_be_flow/src/models/user_model.dart';

class UserDataProvider extends ChangeNotifier {
  final List<User?> _usersRegistered = [];
  User? _userLogged;
  String _cellphoneLogin = '';
  String _cellphoneRegister = '';
  String _nameRegister = '';
  bool _authGoogle = false;
  String _descriptionNewTask = '';
  bool _disabledButtonCreateTask = false;
  bool _isModeFocus = false;

  String get cellPhoneLogin => _cellphoneLogin;
  String get cellPhoneRegister => _cellphoneRegister;
  bool get authGoogle => _authGoogle;
  String get nameRegister => _nameRegister;
  String get descriptionNewTask => _descriptionNewTask;
  bool get disabledButtonCreateTask => _disabledButtonCreateTask;
  User? get userLogged => _userLogged;
  bool get isModeFocus => _isModeFocus;

  set cellPhoneLogin(String value) {
    _cellphoneLogin = value;
    notifyListeners();
  }

  set cellPhoneRegister(String value) {
    _cellphoneRegister = value;
    notifyListeners();
  }

  set authGoogle(bool value) {
    _authGoogle = value;
    notifyListeners();
  }

  set nameRegister(String value) {
    _nameRegister = value;
    updateUserName();
    notifyListeners();
  }

  set descriptionNewTask(String value) {
    _descriptionNewTask = value;
    notifyListeners();
  }

  set disabledButtonCreateTask(bool value) {
    _disabledButtonCreateTask = value;
    notifyListeners();
  }

  set isModeFocus(bool value) {
    _isModeFocus = value;
  }

  void updateUserName() {
    _userLogged!.name = _nameRegister;
    for (int i = 0; i < _usersRegistered.length; i++) {
      if (_usersRegistered[i]?.cellphone == _cellphoneRegister) {
        _usersRegistered[i] = _usersRegistered[i]!.copyWith(name: _nameRegister);
        break;
      }
    }
  }

  bool validateUserLogin(String cellphone) {
    if( _usersRegistered.isEmpty ) return false;
    return _usersRegistered.any((user) => user!.cellphone == cellphone);
  }

  bool loginUser() {
    if (_usersRegistered.isEmpty) return false;
    for (int i = 0; i < _usersRegistered.length; i++) {
      if (_usersRegistered[i]!.cellphone == _cellphoneLogin) {
        _userLogged = _usersRegistered[i]!;
        break;
      }
    }
    notifyListeners();
    return true;
  }

  void logoutUser() {
    for (int i = 0; i < _usersRegistered.length; i++) {
      if (_usersRegistered[i]!.cellphone == _cellphoneRegister) {
        _usersRegistered[i] = _userLogged;
        break;
      }
    }
    _userLogged = null;
    notifyListeners();
  }

  bool registerUser() {
    if ( _usersRegistered.isNotEmpty ) {
      final user = _usersRegistered.firstWhere((user) => user?.cellphone == _cellphoneRegister, orElse: () => null);
      if ( user != null ) return false;
    }
    User newUser = User(
      name: '',
      cellphone: _cellphoneRegister,
      isAuthGoogle: _authGoogle,
      configPomodoro: null,
      tasks: []
    );
    _usersRegistered.add(newUser);
    _userLogged = newUser;
    notifyListeners();
    return true;
  }

  bool createTask() {
    _disabledButtonCreateTask = true;
    Task newTask = Task(description: _descriptionNewTask);
    for (var user in _usersRegistered) {
      if (user?.cellphone == _userLogged!.cellphone) {
        user?.tasks.add(newTask);
      break;
      }
    }
    _disabledButtonCreateTask = false;
    descriptionNewTask = "";
    notifyListeners();
    return true;
  }

  void createConfigPomodoro(String focusTime, String breakTime, String longBreakTime) {
    final newConfigPomodoro = ConfigPomodoro(
      focus: int.tryParse(focusTime) ?? 0 ,
      configPomodoroBreak: int.tryParse(breakTime) ?? 0,
      longBreak: int.tryParse(longBreakTime) ?? 0
    );
    for (var user in _usersRegistered) {
      if (user!.cellphone == _userLogged!.cellphone) {
        user.configPomodoro = newConfigPomodoro;
      break;
      }
    }
    userLogged!.configPomodoro = newConfigPomodoro;
    notifyListeners();
  }
  
  List<Task> getTaskOnPomodoro() {
    List<Task> tasksOnPomodoro = [];
    for (var task in userLogged!.tasks) {
      if (task.isPomodoroActual) tasksOnPomodoro.add(task);
    }
    return tasksOnPomodoro;
  }

}