//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'google_o_auth_payload.g.dart';

/// GoogleOAuthPayload
///
/// Properties:
/// * [authuser]
/// * [code]
/// * [scope]
/// * [state]
@BuiltValue()
abstract class GoogleOAuthPayload
    implements Built<GoogleOAuthPayload, GoogleOAuthPayloadBuilder> {
  @BuiltValueField(wireName: r'authuser')
  String get authuser;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'scope')
  String get scope;

  @BuiltValueField(wireName: r'state')
  String get state;

  GoogleOAuthPayload._();

  factory GoogleOAuthPayload([void updates(GoogleOAuthPayloadBuilder b)]) =
      _$GoogleOAuthPayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GoogleOAuthPayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GoogleOAuthPayload> get serializer =>
      _$GoogleOAuthPayloadSerializer();
}

class _$GoogleOAuthPayloadSerializer
    implements PrimitiveSerializer<GoogleOAuthPayload> {
  @override
  final Iterable<Type> types = const [GoogleOAuthPayload, _$GoogleOAuthPayload];

  @override
  final String wireName = r'GoogleOAuthPayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GoogleOAuthPayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'authuser';
    yield serializers.serialize(
      object.authuser,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(String),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GoogleOAuthPayload object, {
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
    required GoogleOAuthPayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'authuser':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authuser = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.scope = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GoogleOAuthPayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GoogleOAuthPayloadBuilder();
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
