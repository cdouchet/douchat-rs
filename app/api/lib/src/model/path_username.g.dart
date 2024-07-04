// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_username.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PathUsername extends PathUsername {
  @override
  final String username;

  factory _$PathUsername([void Function(PathUsernameBuilder)? updates]) =>
      (new PathUsernameBuilder()..update(updates))._build();

  _$PathUsername._({required this.username}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        username, r'PathUsername', 'username');
  }

  @override
  PathUsername rebuild(void Function(PathUsernameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PathUsernameBuilder toBuilder() => new PathUsernameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PathUsername && username == other.username;
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
    return (newBuiltValueToStringHelper(r'PathUsername')
          ..add('username', username))
        .toString();
  }
}

class PathUsernameBuilder
    implements Builder<PathUsername, PathUsernameBuilder> {
  _$PathUsername? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  PathUsernameBuilder() {
    PathUsername._defaults(this);
  }

  PathUsernameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PathUsername other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PathUsername;
  }

  @override
  void update(void Function(PathUsernameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PathUsername build() => _build();

  _$PathUsername _build() {
    final _$result = _$v ??
        new _$PathUsername._(
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'PathUsername', 'username'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
