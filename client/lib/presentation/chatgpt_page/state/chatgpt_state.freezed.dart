// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatgpt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatgptState {
  List<ChatGPTDrawerResponse> get chatgptDrawerData =>
      throw _privateConstructorUsedError;
  List<ChatGPTChatModel> get chatGPTChatModelList =>
      throw _privateConstructorUsedError;
  String? get chatGptChatId => throw _privateConstructorUsedError;
  String get emailId => throw _privateConstructorUsedError;
  bool get canSendMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatgptStateCopyWith<ChatgptState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatgptStateCopyWith<$Res> {
  factory $ChatgptStateCopyWith(
          ChatgptState value, $Res Function(ChatgptState) then) =
      _$ChatgptStateCopyWithImpl<$Res, ChatgptState>;
  @useResult
  $Res call(
      {List<ChatGPTDrawerResponse> chatgptDrawerData,
      List<ChatGPTChatModel> chatGPTChatModelList,
      String? chatGptChatId,
      String emailId,
      bool canSendMessage});
}

/// @nodoc
class _$ChatgptStateCopyWithImpl<$Res, $Val extends ChatgptState>
    implements $ChatgptStateCopyWith<$Res> {
  _$ChatgptStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatgptDrawerData = null,
    Object? chatGPTChatModelList = null,
    Object? chatGptChatId = freezed,
    Object? emailId = null,
    Object? canSendMessage = null,
  }) {
    return _then(_value.copyWith(
      chatgptDrawerData: null == chatgptDrawerData
          ? _value.chatgptDrawerData
          : chatgptDrawerData // ignore: cast_nullable_to_non_nullable
              as List<ChatGPTDrawerResponse>,
      chatGPTChatModelList: null == chatGPTChatModelList
          ? _value.chatGPTChatModelList
          : chatGPTChatModelList // ignore: cast_nullable_to_non_nullable
              as List<ChatGPTChatModel>,
      chatGptChatId: freezed == chatGptChatId
          ? _value.chatGptChatId
          : chatGptChatId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ChatgptStateImplCopyWith<$Res>
    implements $ChatgptStateCopyWith<$Res> {
  factory _$$ChatgptStateImplCopyWith(
          _$ChatgptStateImpl value, $Res Function(_$ChatgptStateImpl) then) =
      __$$ChatgptStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ChatGPTDrawerResponse> chatgptDrawerData,
      List<ChatGPTChatModel> chatGPTChatModelList,
      String? chatGptChatId,
      String emailId,
      bool canSendMessage});
}

/// @nodoc
class __$$ChatgptStateImplCopyWithImpl<$Res>
    extends _$ChatgptStateCopyWithImpl<$Res, _$ChatgptStateImpl>
    implements _$$ChatgptStateImplCopyWith<$Res> {
  __$$ChatgptStateImplCopyWithImpl(
      _$ChatgptStateImpl _value, $Res Function(_$ChatgptStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatgptDrawerData = null,
    Object? chatGPTChatModelList = null,
    Object? chatGptChatId = freezed,
    Object? emailId = null,
    Object? canSendMessage = null,
  }) {
    return _then(_$ChatgptStateImpl(
      chatgptDrawerData: null == chatgptDrawerData
          ? _value._chatgptDrawerData
          : chatgptDrawerData // ignore: cast_nullable_to_non_nullable
              as List<ChatGPTDrawerResponse>,
      chatGPTChatModelList: null == chatGPTChatModelList
          ? _value._chatGPTChatModelList
          : chatGPTChatModelList // ignore: cast_nullable_to_non_nullable
              as List<ChatGPTChatModel>,
      chatGptChatId: freezed == chatGptChatId
          ? _value.chatGptChatId
          : chatGptChatId // ignore: cast_nullable_to_non_nullable
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

class _$ChatgptStateImpl implements _ChatgptState {
  _$ChatgptStateImpl(
      {final List<ChatGPTDrawerResponse> chatgptDrawerData = const [],
      final List<ChatGPTChatModel> chatGPTChatModelList = const [],
      this.chatGptChatId,
      this.emailId = "",
      this.canSendMessage = true})
      : _chatgptDrawerData = chatgptDrawerData,
        _chatGPTChatModelList = chatGPTChatModelList;

  final List<ChatGPTDrawerResponse> _chatgptDrawerData;
  @override
  @JsonKey()
  List<ChatGPTDrawerResponse> get chatgptDrawerData {
    if (_chatgptDrawerData is EqualUnmodifiableListView)
      return _chatgptDrawerData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatgptDrawerData);
  }

  final List<ChatGPTChatModel> _chatGPTChatModelList;
  @override
  @JsonKey()
  List<ChatGPTChatModel> get chatGPTChatModelList {
    if (_chatGPTChatModelList is EqualUnmodifiableListView)
      return _chatGPTChatModelList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatGPTChatModelList);
  }

  @override
  final String? chatGptChatId;
  @override
  @JsonKey()
  final String emailId;
  @override
  @JsonKey()
  final bool canSendMessage;

  @override
  String toString() {
    return 'ChatgptState(chatgptDrawerData: $chatgptDrawerData, chatGPTChatModelList: $chatGPTChatModelList, chatGptChatId: $chatGptChatId, emailId: $emailId, canSendMessage: $canSendMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatgptStateImpl &&
            const DeepCollectionEquality()
                .equals(other._chatgptDrawerData, _chatgptDrawerData) &&
            const DeepCollectionEquality()
                .equals(other._chatGPTChatModelList, _chatGPTChatModelList) &&
            (identical(other.chatGptChatId, chatGptChatId) ||
                other.chatGptChatId == chatGptChatId) &&
            (identical(other.emailId, emailId) || other.emailId == emailId) &&
            (identical(other.canSendMessage, canSendMessage) ||
                other.canSendMessage == canSendMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chatgptDrawerData),
      const DeepCollectionEquality().hash(_chatGPTChatModelList),
      chatGptChatId,
      emailId,
      canSendMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatgptStateImplCopyWith<_$ChatgptStateImpl> get copyWith =>
      __$$ChatgptStateImplCopyWithImpl<_$ChatgptStateImpl>(this, _$identity);
}

abstract class _ChatgptState implements ChatgptState {
  factory _ChatgptState(
      {final List<ChatGPTDrawerResponse> chatgptDrawerData,
      final List<ChatGPTChatModel> chatGPTChatModelList,
      final String? chatGptChatId,
      final String emailId,
      final bool canSendMessage}) = _$ChatgptStateImpl;

  @override
  List<ChatGPTDrawerResponse> get chatgptDrawerData;
  @override
  List<ChatGPTChatModel> get chatGPTChatModelList;
  @override
  String? get chatGptChatId;
  @override
  String get emailId;
  @override
  bool get canSendMessage;
  @override
  @JsonKey(ignore: true)
  _$$ChatgptStateImplCopyWith<_$ChatgptStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
