// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PathId extends PathId {
  @override
  final String id;

  factory _$PathId([void Function(PathIdBuilder)? updates]) =>
      (new PathIdBuilder()..update(updates))._build();

  _$PathId._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'PathId', 'id');
  }

  @override
  PathId rebuild(void Function(PathIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PathIdBuilder toBuilder() => new PathIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PathId && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PathId')..add('id', id)).toString();
  }
}

class PathIdBuilder implements Builder<PathId, PathIdBuilder> {
  _$PathId? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  PathIdBuilder() {
    PathId._defaults(this);
  }

  PathIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PathId other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PathId;
  }

  @override
  void update(void Function(PathIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PathId build() => _build();

  _$PathId _build() {
    final _$result = _$v ??
        new _$PathId._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'PathId', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
