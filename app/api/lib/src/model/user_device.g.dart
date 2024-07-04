// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_device.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserDevice extends UserDevice {
  @override
  final DateTime createdAt;
  @override
  final String deviceId;
  @override
  final String deviceName;
  @override
  final DateTime updatedAt;

  factory _$UserDevice([void Function(UserDeviceBuilder)? updates]) =>
      (new UserDeviceBuilder()..update(updates))._build();

  _$UserDevice._(
      {required this.createdAt,
      required this.deviceId,
      required this.deviceName,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'UserDevice', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(deviceId, r'UserDevice', 'deviceId');
    BuiltValueNullFieldError.checkNotNull(
        deviceName, r'UserDevice', 'deviceName');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'UserDevice', 'updatedAt');
  }

  @override
  UserDevice rebuild(void Function(UserDeviceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserDeviceBuilder toBuilder() => new UserDeviceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDevice &&
        createdAt == other.createdAt &&
        deviceId == other.deviceId &&
        deviceName == other.deviceName &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDevice')
          ..add('createdAt', createdAt)
          ..add('deviceId', deviceId)
          ..add('deviceName', deviceName)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class UserDeviceBuilder implements Builder<UserDevice, UserDeviceBuilder> {
  _$UserDevice? _$v;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  UserDeviceBuilder() {
    UserDevice._defaults(this);
  }

  UserDeviceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _deviceId = $v.deviceId;
      _deviceName = $v.deviceName;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDevice other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserDevice;
  }

  @override
  void update(void Function(UserDeviceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDevice build() => _build();

  _$UserDevice _build() {
    final _$result = _$v ??
        new _$UserDevice._(
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'UserDevice', 'createdAt'),
            deviceId: BuiltValueNullFieldError.checkNotNull(
                deviceId, r'UserDevice', 'deviceId'),
            deviceName: BuiltValueNullFieldError.checkNotNull(
                deviceName, r'UserDevice', 'deviceName'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'UserDevice', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
