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
  Notes._({
    required this.title,
    required this.content,
  });

  factory Notes({
    required String title,
    required String content,
  }) = _NotesImpl;

  factory Notes.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Notes(
      title:
          serializationManager.deserialize<String>(jsonSerialization['title']),
      content: serializationManager
          .deserialize<String>(jsonSerialization['content']),
    );
  }

  String title;

  String content;

  Notes copyWith({
    String? title,
    String? content,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}

class _NotesImpl extends Notes {
  _NotesImpl({
    required String title,
    required String content,
  }) : super._(
          title: title,
          content: content,
        );

  @override
  Notes copyWith({
    String? title,
    String? content,
  }) {
    return Notes(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
