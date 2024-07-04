//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api/src/model/apple_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'apple_oauth_payload.g.dart';

/// AppleOauthPayload
///
/// Properties:
/// * [deviceId]
/// * [idToken]
/// * [user]
@BuiltValue()
abstract class AppleOauthPayload
    implements Built<AppleOauthPayload, AppleOauthPayloadBuilder> {
  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  @BuiltValueField(wireName: r'id_token')
  String get idToken;

  @BuiltValueField(wireName: r'user')
  AppleUser? get user;

  AppleOauthPayload._();

  factory AppleOauthPayload([void updates(AppleOauthPayloadBuilder b)]) =
      _$AppleOauthPayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppleOauthPayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppleOauthPayload> get serializer =>
      _$AppleOauthPayloadSerializer();
}

class _$AppleOauthPayloadSerializer
    implements PrimitiveSerializer<AppleOauthPayload> {
  @override
  final Iterable<Type> types = const [AppleOauthPayload, _$AppleOauthPayload];

  @override
  final String wireName = r'AppleOauthPayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppleOauthPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
    yield r'id_token';
    yield serializers.serialize(
      object.idToken,
      specifiedType: const FullType(String),
    );
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType.nullable(AppleUser),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppleOauthPayload object, {
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
    required AppleOauthPayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceId = valueDes;
          break;
        case r'id_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idToken = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AppleUser),
          ) as AppleUser?;
          if (valueDes == null) continue;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppleOauthPayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppleOauthPayloadBuilder();
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
