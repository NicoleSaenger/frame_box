import 'dart:async';

import '../../models/comment_model.dart';
import '../../services/comment_service.dart';

class PostBloc {
  final controller = StreamController<List<CommentModel>?>.broadcast();

  Sink get input => controller.sink;

  Stream<List<CommentModel>?> get output => controller.stream;

  Future<void> getComments(int photoId) async {
    final comments = await CommentService.getCommentsByPhotoId(photoId);

    if (comments == null) {
      input.add([]);
    } else {
      input.add(comments);
    }
  }

  void dispose() {
    controller.close();
  }
}
