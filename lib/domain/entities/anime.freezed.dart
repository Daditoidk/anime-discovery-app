// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Anime {

 String get id; String get canonicalTitle; String get synopsis; String? get description; String? get posterImageUrl; String? get coverImageUrl; String? get averageRating; int? get episodeCount; String? get showType; String? get status;
/// Create a copy of Anime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimeCopyWith<Anime> get copyWith => _$AnimeCopyWithImpl<Anime>(this as Anime, _$identity);

  /// Serializes this Anime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Anime&&(identical(other.id, id) || other.id == id)&&(identical(other.canonicalTitle, canonicalTitle) || other.canonicalTitle == canonicalTitle)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&(identical(other.showType, showType) || other.showType == showType)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,canonicalTitle,synopsis,description,posterImageUrl,coverImageUrl,averageRating,episodeCount,showType,status);

@override
String toString() {
  return 'Anime(id: $id, canonicalTitle: $canonicalTitle, synopsis: $synopsis, description: $description, posterImageUrl: $posterImageUrl, coverImageUrl: $coverImageUrl, averageRating: $averageRating, episodeCount: $episodeCount, showType: $showType, status: $status)';
}


}

/// @nodoc
abstract mixin class $AnimeCopyWith<$Res>  {
  factory $AnimeCopyWith(Anime value, $Res Function(Anime) _then) = _$AnimeCopyWithImpl;
@useResult
$Res call({
 String id, String canonicalTitle, String synopsis, String? description, String? posterImageUrl, String? coverImageUrl, String? averageRating, int? episodeCount, String? showType, String? status
});




}
/// @nodoc
class _$AnimeCopyWithImpl<$Res>
    implements $AnimeCopyWith<$Res> {
  _$AnimeCopyWithImpl(this._self, this._then);

  final Anime _self;
  final $Res Function(Anime) _then;

/// Create a copy of Anime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? canonicalTitle = null,Object? synopsis = null,Object? description = freezed,Object? posterImageUrl = freezed,Object? coverImageUrl = freezed,Object? averageRating = freezed,Object? episodeCount = freezed,Object? showType = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,canonicalTitle: null == canonicalTitle ? _self.canonicalTitle : canonicalTitle // ignore: cast_nullable_to_non_nullable
as String,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,posterImageUrl: freezed == posterImageUrl ? _self.posterImageUrl : posterImageUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as String?,episodeCount: freezed == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int?,showType: freezed == showType ? _self.showType : showType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Anime].
extension AnimePatterns on Anime {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Anime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Anime() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Anime value)  $default,){
final _that = this;
switch (_that) {
case _Anime():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Anime value)?  $default,){
final _that = this;
switch (_that) {
case _Anime() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String canonicalTitle,  String synopsis,  String? description,  String? posterImageUrl,  String? coverImageUrl,  String? averageRating,  int? episodeCount,  String? showType,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Anime() when $default != null:
return $default(_that.id,_that.canonicalTitle,_that.synopsis,_that.description,_that.posterImageUrl,_that.coverImageUrl,_that.averageRating,_that.episodeCount,_that.showType,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String canonicalTitle,  String synopsis,  String? description,  String? posterImageUrl,  String? coverImageUrl,  String? averageRating,  int? episodeCount,  String? showType,  String? status)  $default,) {final _that = this;
switch (_that) {
case _Anime():
return $default(_that.id,_that.canonicalTitle,_that.synopsis,_that.description,_that.posterImageUrl,_that.coverImageUrl,_that.averageRating,_that.episodeCount,_that.showType,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String canonicalTitle,  String synopsis,  String? description,  String? posterImageUrl,  String? coverImageUrl,  String? averageRating,  int? episodeCount,  String? showType,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _Anime() when $default != null:
return $default(_that.id,_that.canonicalTitle,_that.synopsis,_that.description,_that.posterImageUrl,_that.coverImageUrl,_that.averageRating,_that.episodeCount,_that.showType,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Anime implements Anime {
  const _Anime({required this.id, required this.canonicalTitle, required this.synopsis, this.description, this.posterImageUrl, this.coverImageUrl, this.averageRating, this.episodeCount, this.showType, this.status});
  factory _Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);

@override final  String id;
@override final  String canonicalTitle;
@override final  String synopsis;
@override final  String? description;
@override final  String? posterImageUrl;
@override final  String? coverImageUrl;
@override final  String? averageRating;
@override final  int? episodeCount;
@override final  String? showType;
@override final  String? status;

/// Create a copy of Anime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimeCopyWith<_Anime> get copyWith => __$AnimeCopyWithImpl<_Anime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Anime&&(identical(other.id, id) || other.id == id)&&(identical(other.canonicalTitle, canonicalTitle) || other.canonicalTitle == canonicalTitle)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&(identical(other.showType, showType) || other.showType == showType)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,canonicalTitle,synopsis,description,posterImageUrl,coverImageUrl,averageRating,episodeCount,showType,status);

@override
String toString() {
  return 'Anime(id: $id, canonicalTitle: $canonicalTitle, synopsis: $synopsis, description: $description, posterImageUrl: $posterImageUrl, coverImageUrl: $coverImageUrl, averageRating: $averageRating, episodeCount: $episodeCount, showType: $showType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AnimeCopyWith<$Res> implements $AnimeCopyWith<$Res> {
  factory _$AnimeCopyWith(_Anime value, $Res Function(_Anime) _then) = __$AnimeCopyWithImpl;
@override @useResult
$Res call({
 String id, String canonicalTitle, String synopsis, String? description, String? posterImageUrl, String? coverImageUrl, String? averageRating, int? episodeCount, String? showType, String? status
});




}
/// @nodoc
class __$AnimeCopyWithImpl<$Res>
    implements _$AnimeCopyWith<$Res> {
  __$AnimeCopyWithImpl(this._self, this._then);

  final _Anime _self;
  final $Res Function(_Anime) _then;

/// Create a copy of Anime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? canonicalTitle = null,Object? synopsis = null,Object? description = freezed,Object? posterImageUrl = freezed,Object? coverImageUrl = freezed,Object? averageRating = freezed,Object? episodeCount = freezed,Object? showType = freezed,Object? status = freezed,}) {
  return _then(_Anime(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,canonicalTitle: null == canonicalTitle ? _self.canonicalTitle : canonicalTitle // ignore: cast_nullable_to_non_nullable
as String,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,posterImageUrl: freezed == posterImageUrl ? _self.posterImageUrl : posterImageUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as String?,episodeCount: freezed == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int?,showType: freezed == showType ? _self.showType : showType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
