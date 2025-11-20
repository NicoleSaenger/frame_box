import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/album_model.dart';

class AlbumService {
  static Future<List<AlbumModel>?> getAlbumsByUser(int userId) async {
    try {
      final uri = Uri.parse(
        'https://jsonplaceholder.typicode.com/users/$userId/albums',
      );

      debugPrint('Requesting albums from: $uri');

      final response = await http.get(uri);
      debugPrint('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);

        debugPrint('JSON decoded successfully. Items: ${decoded.length}');

        final albums = decoded.map((item) {
          debugPrint('Parsing album: ${(item as Map)['title']}');
          return AlbumModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        debugPrint('Finished parsing ${albums.length} albums.');
        return albums;
      } else {
        debugPrint('Request failed. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception while fetching albums: $e');
      return null;
    }
  }
}
