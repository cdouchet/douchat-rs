// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewUser extends NewUser {
  @override
  final String? description;
  @override
  final String? photoUrl;
  @override
  final String? status;
  @override
  final String? username;

  factory _$NewUser([void Function(NewUserBuilder)? updates]) =>
      (new NewUserBuilder()..update(updates))._build();

  _$NewUser._({this.description, this.photoUrl, this.status, this.username})
      : super._();

  @override
  NewUser rebuild(void Function(NewUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewUserBuilder toBuilder() => new NewUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewUser &&
        description == other.description &&
        photoUrl == other.photoUrl &&
        status == other.status &&
        username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NewUser')
          ..add('description', description)
          ..add('photoUrl', photoUrl)
          ..add('status', status)
          ..add('username', username))
        .toString();
  }
}

class NewUserBuilder implements Builder<NewUser, NewUserBuilder> {
  _$NewUser? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  NewUserBuilder() {
    NewUser._defaults(this);
  }

  NewUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _photoUrl = $v.photoUrl;
      _status = $v.status;
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewUser;
  }

  @override
  void update(void Function(NewUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NewUser build() => _build();

  _$NewUser _build() {
    final _$result = _$v ??
        new _$NewUser._(
            description: description,
            photoUrl: photoUrl,
            status: status,
            username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
