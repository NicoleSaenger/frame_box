import 'dart:async';

import 'package:frame_box/models/user_model.dart';

import '../../services/placeholder_service.dart';

class HomeBloc {
  final controller = StreamController<dynamic>.broadcast();

  List<UserModel> _allUsers = [];

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get() async {
    input.add(true);

    final users = await PlaceholderService.getUsers();

    if (users == null) {
      input.add(false);
    } else {
      _allUsers = users;

      input.add(_allUsers);
    }
  }

  void filter(String query) {
    if (_allUsers.isEmpty) {
      return;
    }

    final lowerCaseQuery = query.toLowerCase();

    if (lowerCaseQuery.isEmpty) {
      input.add(_allUsers);
      return;
    }
    final filteredUsers = _allUsers.where((user) {
      return user.name.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    input.add(filteredUsers);
  }

  void dispose() {
    controller.close();
  }
}
