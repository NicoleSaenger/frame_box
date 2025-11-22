import 'dart:async';

import '../../services/photo_service.dart';

class PhotoBloc {
  final _controller = StreamController<dynamic>();

  Stream<dynamic> get output => _controller.stream;

  void get(int albumId) async {
    _controller.sink.add(true);

    final photos = await PhotoService.getPhotosByAlbum(albumId);

    if (photos != null && photos.isNotEmpty) {
      _controller.sink.add(photos);
    } else {
      _controller.sink.add(false);
    }
  }

  void dispose() {
    _controller.close();
  }
}
