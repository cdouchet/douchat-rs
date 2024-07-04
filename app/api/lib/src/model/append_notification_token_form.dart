//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'append_notification_token_form.g.dart';

/// AppendNotificationTokenForm
///
/// Properties:
/// * [deviceId]
/// * [token]
@BuiltValue()
abstract class AppendNotificationTokenForm
    implements
        Built<AppendNotificationTokenForm, AppendNotificationTokenFormBuilder> {
  @BuiltValueField(wireName: r'device_id')
  int get deviceId;

  @BuiltValueField(wireName: r'token')
  String get token;

  AppendNotificationTokenForm._();

  factory AppendNotificationTokenForm(
          [void updates(AppendNotificationTokenFormBuilder b)]) =
      _$AppendNotificationTokenForm;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppendNotificationTokenFormBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppendNotificationTokenForm> get serializer =>
      _$AppendNotificationTokenFormSerializer();
}

class _$AppendNotificationTokenFormSerializer
    implements PrimitiveSerializer<AppendNotificationTokenForm> {
  @override
  final Iterable<Type> types = const [
    AppendNotificationTokenForm,
    _$AppendNotificationTokenForm
  ];

  @override
  final String wireName = r'AppendNotificationTokenForm';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppendNotificationTokenForm object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(int),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AppendNotificationTokenForm object, {
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
    required AppendNotificationTokenFormBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.deviceId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppendNotificationTokenForm deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppendNotificationTokenFormBuilder();
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
