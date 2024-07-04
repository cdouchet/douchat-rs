// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'username_update_form.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UsernameUpdateForm extends UsernameUpdateForm {
  @override
  final String username;

  factory _$UsernameUpdateForm(
          [void Function(UsernameUpdateFormBuilder)? updates]) =>
      (new UsernameUpdateFormBuilder()..update(updates))._build();

  _$UsernameUpdateForm._({required this.username}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        username, r'UsernameUpdateForm', 'username');
  }

  @override
  UsernameUpdateForm rebuild(
          void Function(UsernameUpdateFormBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsernameUpdateFormBuilder toBuilder() =>
      new UsernameUpdateFormBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsernameUpdateForm && username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsernameUpdateForm')
          ..add('username', username))
        .toString();
  }
}

class UsernameUpdateFormBuilder
    implements Builder<UsernameUpdateForm, UsernameUpdateFormBuilder> {
  _$UsernameUpdateForm? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  UsernameUpdateFormBuilder() {
    UsernameUpdateForm._defaults(this);
  }

  UsernameUpdateFormBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsernameUpdateForm other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsernameUpdateForm;
  }

  @override
  void update(void Function(UsernameUpdateFormBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsernameUpdateForm build() => _build();

  _$UsernameUpdateForm _build() {
    final _$result = _$v ??
        new _$UsernameUpdateForm._(
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'UsernameUpdateForm', 'username'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
