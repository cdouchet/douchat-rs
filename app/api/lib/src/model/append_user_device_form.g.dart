// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'append_user_device_form.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppendUserDeviceForm extends AppendUserDeviceForm {
  @override
  final String deviceId;
  @override
  final String deviceName;

  factory _$AppendUserDeviceForm(
          [void Function(AppendUserDeviceFormBuilder)? updates]) =>
      (new AppendUserDeviceFormBuilder()..update(updates))._build();

  _$AppendUserDeviceForm._({required this.deviceId, required this.deviceName})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'AppendUserDeviceForm', 'deviceId');
    BuiltValueNullFieldError.checkNotNull(
        deviceName, r'AppendUserDeviceForm', 'deviceName');
  }

  @override
  AppendUserDeviceForm rebuild(
          void Function(AppendUserDeviceFormBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppendUserDeviceFormBuilder toBuilder() =>
      new AppendUserDeviceFormBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppendUserDeviceForm &&
        deviceId == other.deviceId &&
        deviceName == other.deviceName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppendUserDeviceForm')
          ..add('deviceId', deviceId)
          ..add('deviceName', deviceName))
        .toString();
  }
}

class AppendUserDeviceFormBuilder
    implements Builder<AppendUserDeviceForm, AppendUserDeviceFormBuilder> {
  _$AppendUserDeviceForm? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  AppendUserDeviceFormBuilder() {
    AppendUserDeviceForm._defaults(this);
  }

  AppendUserDeviceFormBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _deviceName = $v.deviceName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppendUserDeviceForm other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppendUserDeviceForm;
  }

  @override
  void update(void Function(AppendUserDeviceFormBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppendUserDeviceForm build() => _build();

  _$AppendUserDeviceForm _build() {
    final _$result = _$v ??
        new _$AppendUserDeviceForm._(
            deviceId: BuiltValueNullFieldError.checkNotNull(
                deviceId, r'AppendUserDeviceForm', 'deviceId'),
            deviceName: BuiltValueNullFieldError.checkNotNull(
                deviceName, r'AppendUserDeviceForm', 'deviceName'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
