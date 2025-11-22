import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class PlaceholderService {
  static Future<List<UserModel>?> getUsers() async {
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
      debugPrint('Requesting users from: $uri');

      final response = await http.get(uri);
      debugPrint('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);

        debugPrint('JSON decoded successfully. Items: ${decoded.length}');

        final users = decoded.map((item) {
          debugPrint('Parsing user: ${(item as Map)['name']}');
          return UserModel.fromMap(item as Map<String, dynamic>);
        }).toList();

        debugPrint('Finished parsing ${users.length} users.');
        return users;
      } else {
        debugPrint(
          'Request failed. Status: ${response.statusCode}, ${response.body}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('Exception while fetching users: $e');
      return null;
    }
  }
}
