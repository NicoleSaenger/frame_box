import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/comment_model.dart';

class CommentService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<CommentModel>?> getCommentsByPhotoId(int photoId) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts/$photoId/comments');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);
        final comments = decoded
            .map((item) => CommentModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return comments;
      } else {
        debugPrint('Comment request failed. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception while fetching comments: $e');
      return null;
    }
  }
}
