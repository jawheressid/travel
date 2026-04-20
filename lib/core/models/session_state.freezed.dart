// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SessionState _$SessionStateFromJson(Map<String, dynamic> json) {
  return _SessionState.fromJson(json);
}

/// @nodoc
mixin _$SessionState {
  @JsonKey(name: 'has_seen_onboarding')
  bool get hasSeenOnboarding => throw _privateConstructorUsedError;
  UserProfile? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_supabase_enabled')
  bool get isSupabaseEnabled => throw _privateConstructorUsedError;

  /// Serializes this SessionState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionStateCopyWith<SessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
    SessionState value,
    $Res Function(SessionState) then,
  ) = _$SessionStateCopyWithImpl<$Res, SessionState>;
  @useResult
  $Res call({
    @JsonKey(name: 'has_seen_onboarding') bool hasSeenOnboarding,
    UserProfile? user,
    @JsonKey(name: 'is_supabase_enabled') bool isSupabaseEnabled,
  });

  $UserProfileCopyWith<$Res>? get user;
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasSeenOnboarding = null,
    Object? user = freezed,
    Object? isSupabaseEnabled = null,
  }) {
    return _then(
      _value.copyWith(
            hasSeenOnboarding: null == hasSeenOnboarding
                ? _value.hasSeenOnboarding
                : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
                      as bool,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserProfile?,
            isSupabaseEnabled: null == isSupabaseEnabled
                ? _value.isSupabaseEnabled
                : isSupabaseEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionStateImplCopyWith<$Res>
    implements $SessionStateCopyWith<$Res> {
  factory _$$SessionStateImplCopyWith(
    _$SessionStateImpl value,
    $Res Function(_$SessionStateImpl) then,
  ) = __$$SessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'has_seen_onboarding') bool hasSeenOnboarding,
    UserProfile? user,
    @JsonKey(name: 'is_supabase_enabled') bool isSupabaseEnabled,
  });

  @override
  $UserProfileCopyWith<$Res>? get user;
}

/// @nodoc
class __$$SessionStateImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionStateImpl>
    implements _$$SessionStateImplCopyWith<$Res> {
  __$$SessionStateImplCopyWithImpl(
    _$SessionStateImpl _value,
    $Res Function(_$SessionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasSeenOnboarding = null,
    Object? user = freezed,
    Object? isSupabaseEnabled = null,
  }) {
    return _then(
      _$SessionStateImpl(
        hasSeenOnboarding: null == hasSeenOnboarding
            ? _value.hasSeenOnboarding
            : hasSeenOnboarding // ignore: cast_nullable_to_non_nullable
                  as bool,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserProfile?,
        isSupabaseEnabled: null == isSupabaseEnabled
            ? _value.isSupabaseEnabled
            : isSupabaseEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionStateImpl implements _SessionState {
  const _$SessionStateImpl({
    @JsonKey(name: 'has_seen_onboarding') this.hasSeenOnboarding = false,
    this.user,
    @JsonKey(name: 'is_supabase_enabled') this.isSupabaseEnabled = false,
  });

  factory _$SessionStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionStateImplFromJson(json);

  @override
  @JsonKey(name: 'has_seen_onboarding')
  final bool hasSeenOnboarding;
  @override
  final UserProfile? user;
  @override
  @JsonKey(name: 'is_supabase_enabled')
  final bool isSupabaseEnabled;

  @override
  String toString() {
    return 'SessionState(hasSeenOnboarding: $hasSeenOnboarding, user: $user, isSupabaseEnabled: $isSupabaseEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionStateImpl &&
            (identical(other.hasSeenOnboarding, hasSeenOnboarding) ||
                other.hasSeenOnboarding == hasSeenOnboarding) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isSupabaseEnabled, isSupabaseEnabled) ||
                other.isSupabaseEnabled == isSupabaseEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hasSeenOnboarding, user, isSupabaseEnabled);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      __$$SessionStateImplCopyWithImpl<_$SessionStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionStateImplToJson(this);
  }
}

abstract class _SessionState implements SessionState {
  const factory _SessionState({
    @JsonKey(name: 'has_seen_onboarding') final bool hasSeenOnboarding,
    final UserProfile? user,
    @JsonKey(name: 'is_supabase_enabled') final bool isSupabaseEnabled,
  }) = _$SessionStateImpl;

  factory _SessionState.fromJson(Map<String, dynamic> json) =
      _$SessionStateImpl.fromJson;

  @override
  @JsonKey(name: 'has_seen_onboarding')
  bool get hasSeenOnboarding;
  @override
  UserProfile? get user;
  @override
  @JsonKey(name: 'is_supabase_enabled')
  bool get isSupabaseEnabled;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
