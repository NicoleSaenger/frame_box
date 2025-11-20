import 'dart:async';

import '../../services/placeholder_service.dart';

class HomeBloc {
  final controller = StreamController<dynamic>.broadcast();

  Sink get input => controller.sink;

  Stream<dynamic> get output => controller.stream;

  Future<void> get() async {
    input.add(true);
    final stream = await PlaceholderService.getUsers();
    if (stream == null) {
      input.add(false);
    } else {
      input.add(stream);
    }
  }
}
