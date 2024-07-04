//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'path_username.g.dart';

/// PathUsername
///
/// Properties:
/// * [username]
@BuiltValue()
abstract class PathUsername
    implements Built<PathUsername, PathUsernameBuilder> {
  @BuiltValueField(wireName: r'username')
  String get username;

  PathUsername._();

  factory PathUsername([void updates(PathUsernameBuilder b)]) = _$PathUsername;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PathUsernameBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PathUsername> get serializer => _$PathUsernameSerializer();
}

class _$PathUsernameSerializer implements PrimitiveSerializer<PathUsername> {
  @override
  final Iterable<Type> types = const [PathUsername, _$PathUsername];

  @override
  final String wireName = r'PathUsername';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PathUsername object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PathUsername object, {
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
    required PathUsernameBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PathUsername deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PathUsernameBuilder();
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
