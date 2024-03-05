// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claude_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClaudeState {
  List<ClaudeChatModel> get claudeChatModelList =>
      throw _privateConstructorUsedError;
  List<ClaudeDrawerResponse> get claudeDrawerData =>
      throw _privateConstructorUsedError;
  String get emailId => throw _privateConstructorUsedError;
  String? get claudeChatId => throw _privateConstructorUsedError;
  String? get bookHeading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClaudeStateCopyWith<ClaudeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaudeStateCopyWith<$Res> {
  factory $ClaudeStateCopyWith(
          ClaudeState value, $Res Function(ClaudeState) then) =
      _$ClaudeStateCopyWithImpl<$Res, ClaudeState>;
  @useResult
  $Res call(
      {List<ClaudeChatModel> claudeChatModelList,
      List<ClaudeDrawerResponse> claudeDrawerData,
      String emailId,
      String? claudeChatId,
      String? bookHeading});
}

/// @nodoc
class _$ClaudeStateCopyWithImpl<$Res, $Val extends ClaudeState>
    implements $ClaudeStateCopyWith<$Res> {
  _$ClaudeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claudeChatModelList = null,
    Object? claudeDrawerData = null,
    Object? emailId = null,
    Object? claudeChatId = freezed,
    Object? bookHeading = freezed,
  }) {
    return _then(_value.copyWith(
      claudeChatModelList: null == claudeChatModelList
          ? _value.claudeChatModelList
          : claudeChatModelList // ignore: cast_nullable_to_non_nullable
              as List<ClaudeChatModel>,
      claudeDrawerData: null == claudeDrawerData
          ? _value.claudeDrawerData
          : claudeDrawerData // ignore: cast_nullable_to_non_nullable
              as List<ClaudeDrawerResponse>,
      emailId: null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as String,
      claudeChatId: freezed == claudeChatId
          ? _value.claudeChatId
          : claudeChatId // ignore: cast_nullable_to_non_nullable
              as String?,
      bookHeading: freezed == bookHeading
          ? _value.bookHeading
          : bookHeading // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClaudeStateImplCopyWith<$Res>
    implements $ClaudeStateCopyWith<$Res> {
  factory _$$ClaudeStateImplCopyWith(
          _$ClaudeStateImpl value, $Res Function(_$ClaudeStateImpl) then) =
      __$$ClaudeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ClaudeChatModel> claudeChatModelList,
      List<ClaudeDrawerResponse> claudeDrawerData,
      String emailId,
      String? claudeChatId,
      String? bookHeading});
}

/// @nodoc
class __$$ClaudeStateImplCopyWithImpl<$Res>
    extends _$ClaudeStateCopyWithImpl<$Res, _$ClaudeStateImpl>
    implements _$$ClaudeStateImplCopyWith<$Res> {
  __$$ClaudeStateImplCopyWithImpl(
      _$ClaudeStateImpl _value, $Res Function(_$ClaudeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claudeChatModelList = null,
    Object? claudeDrawerData = null,
    Object? emailId = null,
    Object? claudeChatId = freezed,
    Object? bookHeading = freezed,
  }) {
    return _then(_$ClaudeStateImpl(
      claudeChatModelList: null == claudeChatModelList
          ? _value._claudeChatModelList
          : claudeChatModelList // ignore: cast_nullable_to_non_nullable
              as List<ClaudeChatModel>,
      claudeDrawerData: null == claudeDrawerData
          ? _value._claudeDrawerData
          : claudeDrawerData // ignore: cast_nullable_to_non_nullable
              as List<ClaudeDrawerResponse>,
      emailId: null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as String,
      claudeChatId: freezed == claudeChatId
          ? _value.claudeChatId
          : claudeChatId // ignore: cast_nullable_to_non_nullable
              as String?,
      bookHeading: freezed == bookHeading
          ? _value.bookHeading
          : bookHeading // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ClaudeStateImpl implements _ClaudeState {
  _$ClaudeStateImpl(
      {final List<ClaudeChatModel> claudeChatModelList = const [],
      final List<ClaudeDrawerResponse> claudeDrawerData = const [],
      this.emailId = "",
      this.claudeChatId,
      this.bookHeading})
      : _claudeChatModelList = claudeChatModelList,
        _claudeDrawerData = claudeDrawerData;

  final List<ClaudeChatModel> _claudeChatModelList;
  @override
  @JsonKey()
  List<ClaudeChatModel> get claudeChatModelList {
    if (_claudeChatModelList is EqualUnmodifiableListView)
      return _claudeChatModelList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_claudeChatModelList);
  }

  final List<ClaudeDrawerResponse> _claudeDrawerData;
  @override
  @JsonKey()
  List<ClaudeDrawerResponse> get claudeDrawerData {
    if (_claudeDrawerData is EqualUnmodifiableListView)
      return _claudeDrawerData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_claudeDrawerData);
  }

  @override
  @JsonKey()
  final String emailId;
  @override
  final String? claudeChatId;
  @override
  final String? bookHeading;

  @override
  String toString() {
    return 'ClaudeState(claudeChatModelList: $claudeChatModelList, claudeDrawerData: $claudeDrawerData, emailId: $emailId, claudeChatId: $claudeChatId, bookHeading: $bookHeading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaudeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._claudeChatModelList, _claudeChatModelList) &&
            const DeepCollectionEquality()
                .equals(other._claudeDrawerData, _claudeDrawerData) &&
            (identical(other.emailId, emailId) || other.emailId == emailId) &&
            (identical(other.claudeChatId, claudeChatId) ||
                other.claudeChatId == claudeChatId) &&
            (identical(other.bookHeading, bookHeading) ||
                other.bookHeading == bookHeading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_claudeChatModelList),
      const DeepCollectionEquality().hash(_claudeDrawerData),
      emailId,
      claudeChatId,
      bookHeading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaudeStateImplCopyWith<_$ClaudeStateImpl> get copyWith =>
      __$$ClaudeStateImplCopyWithImpl<_$ClaudeStateImpl>(this, _$identity);
}

abstract class _ClaudeState implements ClaudeState {
  factory _ClaudeState(
      {final List<ClaudeChatModel> claudeChatModelList,
      final List<ClaudeDrawerResponse> claudeDrawerData,
      final String emailId,
      final String? claudeChatId,
      final String? bookHeading}) = _$ClaudeStateImpl;

  @override
  List<ClaudeChatModel> get claudeChatModelList;
  @override
  List<ClaudeDrawerResponse> get claudeDrawerData;
  @override
  String get emailId;
  @override
  String? get claudeChatId;
  @override
  String? get bookHeading;
  @override
  @JsonKey(ignore: true)
  _$$ClaudeStateImplCopyWith<_$ClaudeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
