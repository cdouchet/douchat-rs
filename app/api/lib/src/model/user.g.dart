// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final DateTime createdAt;
  @override
  final bool onboardingCompleted;
  @override
  final String uid;
  @override
  final DateTime updatedAt;
  @override
  final String? description;
  @override
  final String? photoUrl;
  @override
  final String? status;
  @override
  final String? username;
  @override
  final DateTime? verificationDate;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates))._build();

  _$User._(
      {required this.createdAt,
      required this.onboardingCompleted,
      required this.uid,
      required this.updatedAt,
      this.description,
      this.photoUrl,
      this.status,
      this.username,
      this.verificationDate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(createdAt, r'User', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        onboardingCompleted, r'User', 'onboardingCompleted');
    BuiltValueNullFieldError.checkNotNull(uid, r'User', 'uid');
    BuiltValueNullFieldError.checkNotNull(updatedAt, r'User', 'updatedAt');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        createdAt == other.createdAt &&
        onboardingCompleted == other.onboardingCompleted &&
        uid == other.uid &&
        updatedAt == other.updatedAt &&
        description == other.description &&
        photoUrl == other.photoUrl &&
        status == other.status &&
        username == other.username &&
        verificationDate == other.verificationDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, onboardingCompleted.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, verificationDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('createdAt', createdAt)
          ..add('onboardingCompleted', onboardingCompleted)
          ..add('uid', uid)
          ..add('updatedAt', updatedAt)
          ..add('description', description)
          ..add('photoUrl', photoUrl)
          ..add('status', status)
          ..add('username', username)
          ..add('verificationDate', verificationDate))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  bool? _onboardingCompleted;
  bool? get onboardingCompleted => _$this._onboardingCompleted;
  set onboardingCompleted(bool? onboardingCompleted) =>
      _$this._onboardingCompleted = onboardingCompleted;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

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

  DateTime? _verificationDate;
  DateTime? get verificationDate => _$this._verificationDate;
  set verificationDate(DateTime? verificationDate) =>
      _$this._verificationDate = verificationDate;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _onboardingCompleted = $v.onboardingCompleted;
      _uid = $v.uid;
      _updatedAt = $v.updatedAt;
      _description = $v.description;
      _photoUrl = $v.photoUrl;
      _status = $v.status;
      _username = $v.username;
      _verificationDate = $v.verificationDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result = _$v ??
        new _$User._(
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'User', 'createdAt'),
            onboardingCompleted: BuiltValueNullFieldError.checkNotNull(
                onboardingCompleted, r'User', 'onboardingCompleted'),
            uid: BuiltValueNullFieldError.checkNotNull(uid, r'User', 'uid'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'User', 'updatedAt'),
            description: description,
            photoUrl: photoUrl,
            status: status,
            username: username,
            verificationDate: verificationDate);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
