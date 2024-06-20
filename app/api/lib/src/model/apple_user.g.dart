// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppleUser extends AppleUser {
  @override
  final String email;
  @override
  final AppleName name;

  factory _$AppleUser([void Function(AppleUserBuilder)? updates]) =>
      (new AppleUserBuilder()..update(updates))._build();

  _$AppleUser._({required this.email, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'AppleUser', 'email');
    BuiltValueNullFieldError.checkNotNull(name, r'AppleUser', 'name');
  }

  @override
  AppleUser rebuild(void Function(AppleUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppleUserBuilder toBuilder() => new AppleUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppleUser && email == other.email && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppleUser')
          ..add('email', email)
          ..add('name', name))
        .toString();
  }
}

class AppleUserBuilder implements Builder<AppleUser, AppleUserBuilder> {
  _$AppleUser? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  AppleNameBuilder? _name;
  AppleNameBuilder get name => _$this._name ??= new AppleNameBuilder();
  set name(AppleNameBuilder? name) => _$this._name = name;

  AppleUserBuilder() {
    AppleUser._defaults(this);
  }

  AppleUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _name = $v.name.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppleUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppleUser;
  }

  @override
  void update(void Function(AppleUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppleUser build() => _build();

  _$AppleUser _build() {
    _$AppleUser _$result;
    try {
      _$result = _$v ??
          new _$AppleUser._(
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'AppleUser', 'email'),
              name: name.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'name';
        name.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppleUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
