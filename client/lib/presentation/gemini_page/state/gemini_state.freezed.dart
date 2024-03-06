// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gemini_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GeminiState {
  List<GeminiDrawerResponse> get geminiDrawerData =>
      throw _privateConstructorUsedError;
  List<GeminiChatModel> get geminiChatModelList =>
      throw _privateConstructorUsedError;
  String? get geminiChatId => throw _privateConstructorUsedError;
  String get emailId => throw _privateConstructorUsedError;
  bool get canSendMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GeminiStateCopyWith<GeminiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeminiStateCopyWith<$Res> {
  factory $GeminiStateCopyWith(
          GeminiState value, $Res Function(GeminiState) then) =
      _$GeminiStateCopyWithImpl<$Res, GeminiState>;
  @useResult
  $Res call(
      {List<GeminiDrawerResponse> geminiDrawerData,
      List<GeminiChatModel> geminiChatModelList,
      String? geminiChatId,
      String emailId,
      bool canSendMessage});
}

/// @nodoc
class _$GeminiStateCopyWithImpl<$Res, $Val extends GeminiState>
    implements $GeminiStateCopyWith<$Res> {
  _$GeminiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geminiDrawerData = null,
    Object? geminiChatModelList = null,
    Object? geminiChatId = freezed,
    Object? emailId = null,
    Object? canSendMessage = null,
  }) {
    return _then(_value.copyWith(
      geminiDrawerData: null == geminiDrawerData
          ? _value.geminiDrawerData
          : geminiDrawerData // ignore: cast_nullable_to_non_nullable
              as List<GeminiDrawerResponse>,
      geminiChatModelList: null == geminiChatModelList
          ? _value.geminiChatModelList
          : geminiChatModelList // ignore: cast_nullable_to_non_nullable
              as List<GeminiChatModel>,
      geminiChatId: freezed == geminiChatId
          ? _value.geminiChatId
          : geminiChatId // ignore: cast_nullable_to_non_nullable
              as String?,
      emailId: null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as String,
      canSendMessage: null == canSendMessage
          ? _value.canSendMessage
          : canSendMessage // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeminiStateImplCopyWith<$Res>
    implements $GeminiStateCopyWith<$Res> {
  factory _$$GeminiStateImplCopyWith(
          _$GeminiStateImpl value, $Res Function(_$GeminiStateImpl) then) =
      __$$GeminiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<GeminiDrawerResponse> geminiDrawerData,
      List<GeminiChatModel> geminiChatModelList,
      String? geminiChatId,
      String emailId,
      bool canSendMessage});
}

/// @nodoc
class __$$GeminiStateImplCopyWithImpl<$Res>
    extends _$GeminiStateCopyWithImpl<$Res, _$GeminiStateImpl>
    implements _$$GeminiStateImplCopyWith<$Res> {
  __$$GeminiStateImplCopyWithImpl(
      _$GeminiStateImpl _value, $Res Function(_$GeminiStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geminiDrawerData = null,
    Object? geminiChatModelList = null,
    Object? geminiChatId = freezed,
    Object? emailId = null,
    Object? canSendMessage = null,
  }) {
    return _then(_$GeminiStateImpl(
      geminiDrawerData: null == geminiDrawerData
          ? _value._geminiDrawerData
          : geminiDrawerData // ignore: cast_nullable_to_non_nullable
              as List<GeminiDrawerResponse>,
      geminiChatModelList: null == geminiChatModelList
          ? _value._geminiChatModelList
          : geminiChatModelList // ignore: cast_nullable_to_non_nullable
              as List<GeminiChatModel>,
      geminiChatId: freezed == geminiChatId
          ? _value.geminiChatId
          : geminiChatId // ignore: cast_nullable_to_non_nullable
              as String?,
      emailId: null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as String,
      canSendMessage: null == canSendMessage
          ? _value.canSendMessage
          : canSendMessage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GeminiStateImpl implements _GeminiState {
  _$GeminiStateImpl(
      {final List<GeminiDrawerResponse> geminiDrawerData = const [],
      final List<GeminiChatModel> geminiChatModelList = const [],
      this.geminiChatId,
      this.emailId = "",
      this.canSendMessage = true})
      : _geminiDrawerData = geminiDrawerData,
        _geminiChatModelList = geminiChatModelList;

  final List<GeminiDrawerResponse> _geminiDrawerData;
  @override
  @JsonKey()
  List<GeminiDrawerResponse> get geminiDrawerData {
    if (_geminiDrawerData is EqualUnmodifiableListView)
      return _geminiDrawerData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geminiDrawerData);
  }

  final List<GeminiChatModel> _geminiChatModelList;
  @override
  @JsonKey()
  List<GeminiChatModel> get geminiChatModelList {
    if (_geminiChatModelList is EqualUnmodifiableListView)
      return _geminiChatModelList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geminiChatModelList);
  }

  @override
  final String? geminiChatId;
  @override
  @JsonKey()
  final String emailId;
  @override
  @JsonKey()
  final bool canSendMessage;

  @override
  String toString() {
    return 'GeminiState(geminiDrawerData: $geminiDrawerData, geminiChatModelList: $geminiChatModelList, geminiChatId: $geminiChatId, emailId: $emailId, canSendMessage: $canSendMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeminiStateImpl &&
            const DeepCollectionEquality()
                .equals(other._geminiDrawerData, _geminiDrawerData) &&
            const DeepCollectionEquality()
                .equals(other._geminiChatModelList, _geminiChatModelList) &&
            (identical(other.geminiChatId, geminiChatId) ||
                other.geminiChatId == geminiChatId) &&
            (identical(other.emailId, emailId) || other.emailId == emailId) &&
            (identical(other.canSendMessage, canSendMessage) ||
                other.canSendMessage == canSendMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_geminiDrawerData),
      const DeepCollectionEquality().hash(_geminiChatModelList),
      geminiChatId,
      emailId,
      canSendMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeminiStateImplCopyWith<_$GeminiStateImpl> get copyWith =>
      __$$GeminiStateImplCopyWithImpl<_$GeminiStateImpl>(this, _$identity);
}

abstract class _GeminiState implements GeminiState {
  factory _GeminiState(
      {final List<GeminiDrawerResponse> geminiDrawerData,
      final List<GeminiChatModel> geminiChatModelList,
      final String? geminiChatId,
      final String emailId,
      final bool canSendMessage}) = _$GeminiStateImpl;

  @override
  List<GeminiDrawerResponse> get geminiDrawerData;
  @override
  List<GeminiChatModel> get geminiChatModelList;
  @override
  String? get geminiChatId;
  @override
  String get emailId;
  @override
  bool get canSendMessage;
  @override
  @JsonKey(ignore: true)
  _$$GeminiStateImplCopyWith<_$GeminiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
