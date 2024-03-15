/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Notes extends _i1.SerializableEntity {
  Notes._({required this.text});

  factory Notes({required String text}) = _NotesImpl;

  factory Notes.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Notes(
        text: serializationManager
            .deserialize<String>(jsonSerialization['text']));
  }

  String text;

  Notes copyWith({String? text});
  @override
  Map<String, dynamic> toJson() {
    return {'text': text};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'text': text};
  }
}

class _NotesImpl extends Notes {
  _NotesImpl({required String text}) : super._(text: text);

  @override
  Notes copyWith({String? text}) {
    return Notes(text: text ?? this.text);
  }
}
