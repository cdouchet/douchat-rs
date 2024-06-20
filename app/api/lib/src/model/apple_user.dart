//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api/src/model/apple_name.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'apple_user.g.dart';

/// AppleUser
///
/// Properties:
/// * [email]
/// * [name]
@BuiltValue()
abstract class AppleUser implements Built<AppleUser, AppleUserBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'name')
  AppleName get name;

  AppleUser._();

  factory AppleUser([void updates(AppleUserBuilder b)]) = _$AppleUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppleUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppleUser> get serializer => _$AppleUserSerializer();
}

class _$AppleUserSerializer implements PrimitiveSerializer<AppleUser> {
  @override
  final Iterable<Type> types = const [AppleUser, _$AppleUser];

  @override
  final String wireName = r'AppleUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppleUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(AppleName),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AppleUser object, {
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
    required AppleUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AppleName),
          ) as AppleName;
          result.name.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppleUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppleUserBuilder();
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
