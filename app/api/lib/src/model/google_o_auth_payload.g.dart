// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_o_auth_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GoogleOAuthPayload extends GoogleOAuthPayload {
  @override
  final String authuser;
  @override
  final String code;
  @override
  final String deviceId;
  @override
  final String scope;
  @override
  final String state;

  factory _$GoogleOAuthPayload(
          [void Function(GoogleOAuthPayloadBuilder)? updates]) =>
      (new GoogleOAuthPayloadBuilder()..update(updates))._build();

  _$GoogleOAuthPayload._(
      {required this.authuser,
      required this.code,
      required this.deviceId,
      required this.scope,
      required this.state})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        authuser, r'GoogleOAuthPayload', 'authuser');
    BuiltValueNullFieldError.checkNotNull(code, r'GoogleOAuthPayload', 'code');
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'GoogleOAuthPayload', 'deviceId');
    BuiltValueNullFieldError.checkNotNull(
        scope, r'GoogleOAuthPayload', 'scope');
    BuiltValueNullFieldError.checkNotNull(
        state, r'GoogleOAuthPayload', 'state');
  }

  @override
  GoogleOAuthPayload rebuild(
          void Function(GoogleOAuthPayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoogleOAuthPayloadBuilder toBuilder() =>
      new GoogleOAuthPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GoogleOAuthPayload &&
        authuser == other.authuser &&
        code == other.code &&
        deviceId == other.deviceId &&
        scope == other.scope &&
        state == other.state;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authuser.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GoogleOAuthPayload')
          ..add('authuser', authuser)
          ..add('code', code)
          ..add('deviceId', deviceId)
          ..add('scope', scope)
          ..add('state', state))
        .toString();
  }
}

class GoogleOAuthPayloadBuilder
    implements Builder<GoogleOAuthPayload, GoogleOAuthPayloadBuilder> {
  _$GoogleOAuthPayload? _$v;

  String? _authuser;
  String? get authuser => _$this._authuser;
  set authuser(String? authuser) => _$this._authuser = authuser;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _scope;
  String? get scope => _$this._scope;
  set scope(String? scope) => _$this._scope = scope;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  GoogleOAuthPayloadBuilder() {
    GoogleOAuthPayload._defaults(this);
  }

  GoogleOAuthPayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authuser = $v.authuser;
      _code = $v.code;
      _deviceId = $v.deviceId;
      _scope = $v.scope;
      _state = $v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GoogleOAuthPayload other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GoogleOAuthPayload;
  }

  @override
  void update(void Function(GoogleOAuthPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GoogleOAuthPayload build() => _build();

  _$GoogleOAuthPayload _build() {
    final _$result = _$v ??
        new _$GoogleOAuthPayload._(
            authuser: BuiltValueNullFieldError.checkNotNull(
                authuser, r'GoogleOAuthPayload', 'authuser'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'GoogleOAuthPayload', 'code'),
            deviceId: BuiltValueNullFieldError.checkNotNull(
                deviceId, r'GoogleOAuthPayload', 'deviceId'),
            scope: BuiltValueNullFieldError.checkNotNull(
                scope, r'GoogleOAuthPayload', 'scope'),
            state: BuiltValueNullFieldError.checkNotNull(
                state, r'GoogleOAuthPayload', 'state'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
