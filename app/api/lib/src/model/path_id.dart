//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'path_id.g.dart';

/// PathId
///
/// Properties:
/// * [id]
@BuiltValue()
abstract class PathId implements Built<PathId, PathIdBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  PathId._();

  factory PathId([void updates(PathIdBuilder b)]) = _$PathId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PathIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PathId> get serializer => _$PathIdSerializer();
}

class _$PathIdSerializer implements PrimitiveSerializer<PathId> {
  @override
  final Iterable<Type> types = const [PathId, _$PathId];

  @override
  final String wireName = r'PathId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PathId object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PathId object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PathIdBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PathId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PathIdBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
