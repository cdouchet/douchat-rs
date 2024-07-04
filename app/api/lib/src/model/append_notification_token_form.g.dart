// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'append_notification_token_form.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppendNotificationTokenForm extends AppendNotificationTokenForm {
  @override
  final int deviceId;
  @override
  final String token;

  factory _$AppendNotificationTokenForm(
          [void Function(AppendNotificationTokenFormBuilder)? updates]) =>
      (new AppendNotificationTokenFormBuilder()..update(updates))._build();

  _$AppendNotificationTokenForm._({required this.deviceId, required this.token})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'AppendNotificationTokenForm', 'deviceId');
    BuiltValueNullFieldError.checkNotNull(
        token, r'AppendNotificationTokenForm', 'token');
  }

  @override
  AppendNotificationTokenForm rebuild(
          void Function(AppendNotificationTokenFormBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppendNotificationTokenFormBuilder toBuilder() =>
      new AppendNotificationTokenFormBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppendNotificationTokenForm &&
        deviceId == other.deviceId &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppendNotificationTokenForm')
          ..add('deviceId', deviceId)
          ..add('token', token))
        .toString();
  }
}

class AppendNotificationTokenFormBuilder
    implements
        Builder<AppendNotificationTokenForm,
            AppendNotificationTokenFormBuilder> {
  _$AppendNotificationTokenForm? _$v;

  int? _deviceId;
  int? get deviceId => _$this._deviceId;
  set deviceId(int? deviceId) => _$this._deviceId = deviceId;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  AppendNotificationTokenFormBuilder() {
    AppendNotificationTokenForm._defaults(this);
  }

  AppendNotificationTokenFormBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppendNotificationTokenForm other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppendNotificationTokenForm;
  }

  @override
  void update(void Function(AppendNotificationTokenFormBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppendNotificationTokenForm build() => _build();

  _$AppendNotificationTokenForm _build() {
    final _$result = _$v ??
        new _$AppendNotificationTokenForm._(
            deviceId: BuiltValueNullFieldError.checkNotNull(
                deviceId, r'AppendNotificationTokenForm', 'deviceId'),
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'AppendNotificationTokenForm', 'token'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
