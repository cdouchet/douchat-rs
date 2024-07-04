//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'append_user_device_form.g.dart';

/// AppendUserDeviceForm
///
/// Properties:
/// * [deviceId]
/// * [deviceName]
@BuiltValue()
abstract class AppendUserDeviceForm
    implements Built<AppendUserDeviceForm, AppendUserDeviceFormBuilder> {
  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  @BuiltValueField(wireName: r'device_name')
  String get deviceName;

  AppendUserDeviceForm._();

  factory AppendUserDeviceForm([void updates(AppendUserDeviceFormBuilder b)]) =
      _$AppendUserDeviceForm;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppendUserDeviceFormBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppendUserDeviceForm> get serializer =>
      _$AppendUserDeviceFormSerializer();
}

class _$AppendUserDeviceFormSerializer
    implements PrimitiveSerializer<AppendUserDeviceForm> {
  @override
  final Iterable<Type> types = const [
    AppendUserDeviceForm,
    _$AppendUserDeviceForm
  ];

  @override
  final String wireName = r'AppendUserDeviceForm';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppendUserDeviceForm object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
    yield r'device_name';
    yield serializers.serialize(
      object.deviceName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AppendUserDeviceForm object, {
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
    required AppendUserDeviceFormBuilder result,
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
        case r'device_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppendUserDeviceForm deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppendUserDeviceFormBuilder();
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
