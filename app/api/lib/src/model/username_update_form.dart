//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'username_update_form.g.dart';

/// UsernameUpdateForm
///
/// Properties:
/// * [username]
@BuiltValue()
abstract class UsernameUpdateForm
    implements Built<UsernameUpdateForm, UsernameUpdateFormBuilder> {
  @BuiltValueField(wireName: r'username')
  String get username;

  UsernameUpdateForm._();

  factory UsernameUpdateForm([void updates(UsernameUpdateFormBuilder b)]) =
      _$UsernameUpdateForm;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UsernameUpdateFormBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UsernameUpdateForm> get serializer =>
      _$UsernameUpdateFormSerializer();
}

class _$UsernameUpdateFormSerializer
    implements PrimitiveSerializer<UsernameUpdateForm> {
  @override
  final Iterable<Type> types = const [UsernameUpdateForm, _$UsernameUpdateForm];

  @override
  final String wireName = r'UsernameUpdateForm';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UsernameUpdateForm object, {
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
    UsernameUpdateForm object, {
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
    required UsernameUpdateFormBuilder result,
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
  UsernameUpdateForm deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UsernameUpdateFormBuilder();
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
