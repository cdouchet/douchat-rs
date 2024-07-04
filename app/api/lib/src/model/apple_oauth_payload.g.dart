// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_oauth_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppleOauthPayload extends AppleOauthPayload {
  @override
  final String deviceId;
  @override
  final String idToken;
  @override
  final AppleUser? user;

  factory _$AppleOauthPayload(
          [void Function(AppleOauthPayloadBuilder)? updates]) =>
      (new AppleOauthPayloadBuilder()..update(updates))._build();

  _$AppleOauthPayload._(
      {required this.deviceId, required this.idToken, this.user})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deviceId, r'AppleOauthPayload', 'deviceId');
    BuiltValueNullFieldError.checkNotNull(
        idToken, r'AppleOauthPayload', 'idToken');
  }

  @override
  AppleOauthPayload rebuild(void Function(AppleOauthPayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppleOauthPayloadBuilder toBuilder() =>
      new AppleOauthPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppleOauthPayload &&
        deviceId == other.deviceId &&
        idToken == other.idToken &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppleOauthPayload')
          ..add('deviceId', deviceId)
          ..add('idToken', idToken)
          ..add('user', user))
        .toString();
  }
}

class AppleOauthPayloadBuilder
    implements Builder<AppleOauthPayload, AppleOauthPayloadBuilder> {
  _$AppleOauthPayload? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  AppleUserBuilder? _user;
  AppleUserBuilder get user => _$this._user ??= new AppleUserBuilder();
  set user(AppleUserBuilder? user) => _$this._user = user;

  AppleOauthPayloadBuilder() {
    AppleOauthPayload._defaults(this);
  }

  AppleOauthPayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _idToken = $v.idToken;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppleOauthPayload other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppleOauthPayload;
  }

  @override
  void update(void Function(AppleOauthPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppleOauthPayload build() => _build();

  _$AppleOauthPayload _build() {
    _$AppleOauthPayload _$result;
    try {
      _$result = _$v ??
          new _$AppleOauthPayload._(
              deviceId: BuiltValueNullFieldError.checkNotNull(
                  deviceId, r'AppleOauthPayload', 'deviceId'),
              idToken: BuiltValueNullFieldError.checkNotNull(
                  idToken, r'AppleOauthPayload', 'idToken'),
              user: _user?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppleOauthPayload', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
