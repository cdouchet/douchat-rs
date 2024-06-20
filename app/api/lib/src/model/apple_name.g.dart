// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apple_name.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppleName extends AppleName {
  @override
  final String firstName;
  @override
  final String lastName;

  factory _$AppleName([void Function(AppleNameBuilder)? updates]) =>
      (new AppleNameBuilder()..update(updates))._build();

  _$AppleName._({required this.firstName, required this.lastName}) : super._() {
    BuiltValueNullFieldError.checkNotNull(firstName, r'AppleName', 'firstName');
    BuiltValueNullFieldError.checkNotNull(lastName, r'AppleName', 'lastName');
  }

  @override
  AppleName rebuild(void Function(AppleNameBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppleNameBuilder toBuilder() => new AppleNameBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppleName &&
        firstName == other.firstName &&
        lastName == other.lastName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppleName')
          ..add('firstName', firstName)
          ..add('lastName', lastName))
        .toString();
  }
}

class AppleNameBuilder implements Builder<AppleName, AppleNameBuilder> {
  _$AppleName? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  AppleNameBuilder() {
    AppleName._defaults(this);
  }

  AppleNameBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppleName other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppleName;
  }

  @override
  void update(void Function(AppleNameBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppleName build() => _build();

  _$AppleName _build() {
    final _$result = _$v ??
        new _$AppleName._(
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'AppleName', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'AppleName', 'lastName'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
