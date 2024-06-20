// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'douchat_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DouchatError extends DouchatError {
  @override
  final String error;
  @override
  final String? description;

  factory _$DouchatError([void Function(DouchatErrorBuilder)? updates]) =>
      (new DouchatErrorBuilder()..update(updates))._build();

  _$DouchatError._({required this.error, this.description}) : super._() {
    BuiltValueNullFieldError.checkNotNull(error, r'DouchatError', 'error');
  }

  @override
  DouchatError rebuild(void Function(DouchatErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DouchatErrorBuilder toBuilder() => new DouchatErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DouchatError &&
        error == other.error &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DouchatError')
          ..add('error', error)
          ..add('description', description))
        .toString();
  }
}

class DouchatErrorBuilder
    implements Builder<DouchatError, DouchatErrorBuilder> {
  _$DouchatError? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DouchatErrorBuilder() {
    DouchatError._defaults(this);
  }

  DouchatErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DouchatError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DouchatError;
  }

  @override
  void update(void Function(DouchatErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DouchatError build() => _build();

  _$DouchatError _build() {
    final _$result = _$v ??
        new _$DouchatError._(
            error: BuiltValueNullFieldError.checkNotNull(
                error, r'DouchatError', 'error'),
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
