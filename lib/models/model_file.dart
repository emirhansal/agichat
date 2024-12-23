import 'package:agichat/enums/enum_app.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart' show jsonSerializable;


@jsonSerializable
class ModelFile {
  ModelFile({required this.path, required this.type, this.isNetwork = false});

  final String path;
  FileType type;
  final bool isNetwork;
}
