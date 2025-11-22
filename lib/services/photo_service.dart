import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/photo_model.dart';

class PhotoService {
  static const String _baseUrl =
      'https://my-json-server.typicode.com/NicoleSaenger/frame_box-api';

  static Future<List<PhotoModel>?> getPhotosByAlbum(int albumId) async {
    try {
      final uri = Uri.parse('$_baseUrl/photos?albumId=$albumId');
      debugPrint('Requesting photos from: $uri');

      final response = await http.get(uri);
      debugPrint('Photo Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Sucesso: Decodifica a lista JSON
        final List<dynamic> decoded = json.decode(response.body);

        // Mapeia cada item da lista para o PhotoModel
        final photos = decoded.map((item) {
          return PhotoModel.fromJson(item as Map<String, dynamic>);
        }).toList();

        debugPrint('Successfully parsed ${photos.length} photos.');
        return photos;
      } else {
        // Falha na Requisição
        debugPrint('Photo request failed. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Erro de Exceção (rede, timeout, etc.)
      debugPrint('Exception while fetching photos: $e');
      return null;
    }
  }
}
