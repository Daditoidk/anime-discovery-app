// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anime_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnimeDto {

 String get id; String get type; AnimeAttributesDto get attributes;
/// Create a copy of AnimeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimeDtoCopyWith<AnimeDto> get copyWith => _$AnimeDtoCopyWithImpl<AnimeDto>(this as AnimeDto, _$identity);

  /// Serializes this AnimeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,attributes);

@override
String toString() {
  return 'AnimeDto(id: $id, type: $type, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $AnimeDtoCopyWith<$Res>  {
  factory $AnimeDtoCopyWith(AnimeDto value, $Res Function(AnimeDto) _then) = _$AnimeDtoCopyWithImpl;
@useResult
$Res call({
 String id, String type, AnimeAttributesDto attributes
});


$AnimeAttributesDtoCopyWith<$Res> get attributes;

}
/// @nodoc
class _$AnimeDtoCopyWithImpl<$Res>
    implements $AnimeDtoCopyWith<$Res> {
  _$AnimeDtoCopyWithImpl(this._self, this._then);

  final AnimeDto _self;
  final $Res Function(AnimeDto) _then;

/// Create a copy of AnimeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? attributes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as AnimeAttributesDto,
  ));
}
/// Create a copy of AnimeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnimeAttributesDtoCopyWith<$Res> get attributes {
  
  return $AnimeAttributesDtoCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnimeDto].
extension AnimeDtoPatterns on AnimeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimeDto value)  $default,){
final _that = this;
switch (_that) {
case _AnimeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimeDto value)?  $default,){
final _that = this;
switch (_that) {
case _AnimeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  AnimeAttributesDto attributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimeDto() when $default != null:
return $default(_that.id,_that.type,_that.attributes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  AnimeAttributesDto attributes)  $default,) {final _that = this;
switch (_that) {
case _AnimeDto():
return $default(_that.id,_that.type,_that.attributes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  AnimeAttributesDto attributes)?  $default,) {final _that = this;
switch (_that) {
case _AnimeDto() when $default != null:
return $default(_that.id,_that.type,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimeDto implements AnimeDto {
  const _AnimeDto({required this.id, required this.type, required this.attributes});
  factory _AnimeDto.fromJson(Map<String, dynamic> json) => _$AnimeDtoFromJson(json);

@override final  String id;
@override final  String type;
@override final  AnimeAttributesDto attributes;

/// Create a copy of AnimeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimeDtoCopyWith<_AnimeDto> get copyWith => __$AnimeDtoCopyWithImpl<_AnimeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,attributes);

@override
String toString() {
  return 'AnimeDto(id: $id, type: $type, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$AnimeDtoCopyWith<$Res> implements $AnimeDtoCopyWith<$Res> {
  factory _$AnimeDtoCopyWith(_AnimeDto value, $Res Function(_AnimeDto) _then) = __$AnimeDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, AnimeAttributesDto attributes
});


@override $AnimeAttributesDtoCopyWith<$Res> get attributes;

}
/// @nodoc
class __$AnimeDtoCopyWithImpl<$Res>
    implements _$AnimeDtoCopyWith<$Res> {
  __$AnimeDtoCopyWithImpl(this._self, this._then);

  final _AnimeDto _self;
  final $Res Function(_AnimeDto) _then;

/// Create a copy of AnimeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? attributes = null,}) {
  return _then(_AnimeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as AnimeAttributesDto,
  ));
}

/// Create a copy of AnimeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnimeAttributesDtoCopyWith<$Res> get attributes {
  
  return $AnimeAttributesDtoCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// @nodoc
mixin _$AnimeAttributesDto {

 String get canonicalTitle; String get synopsis; String? get description; PosterImageDto? get posterImage; CoverImageDto? get coverImage; String? get averageRating; int? get episodeCount; String? get showType; String? get status;
/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimeAttributesDtoCopyWith<AnimeAttributesDto> get copyWith => _$AnimeAttributesDtoCopyWithImpl<AnimeAttributesDto>(this as AnimeAttributesDto, _$identity);

  /// Serializes this AnimeAttributesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimeAttributesDto&&(identical(other.canonicalTitle, canonicalTitle) || other.canonicalTitle == canonicalTitle)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.posterImage, posterImage) || other.posterImage == posterImage)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&(identical(other.showType, showType) || other.showType == showType)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,canonicalTitle,synopsis,description,posterImage,coverImage,averageRating,episodeCount,showType,status);

@override
String toString() {
  return 'AnimeAttributesDto(canonicalTitle: $canonicalTitle, synopsis: $synopsis, description: $description, posterImage: $posterImage, coverImage: $coverImage, averageRating: $averageRating, episodeCount: $episodeCount, showType: $showType, status: $status)';
}


}

/// @nodoc
abstract mixin class $AnimeAttributesDtoCopyWith<$Res>  {
  factory $AnimeAttributesDtoCopyWith(AnimeAttributesDto value, $Res Function(AnimeAttributesDto) _then) = _$AnimeAttributesDtoCopyWithImpl;
@useResult
$Res call({
 String canonicalTitle, String synopsis, String? description, PosterImageDto? posterImage, CoverImageDto? coverImage, String? averageRating, int? episodeCount, String? showType, String? status
});


$PosterImageDtoCopyWith<$Res>? get posterImage;$CoverImageDtoCopyWith<$Res>? get coverImage;

}
/// @nodoc
class _$AnimeAttributesDtoCopyWithImpl<$Res>
    implements $AnimeAttributesDtoCopyWith<$Res> {
  _$AnimeAttributesDtoCopyWithImpl(this._self, this._then);

  final AnimeAttributesDto _self;
  final $Res Function(AnimeAttributesDto) _then;

/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canonicalTitle = null,Object? synopsis = null,Object? description = freezed,Object? posterImage = freezed,Object? coverImage = freezed,Object? averageRating = freezed,Object? episodeCount = freezed,Object? showType = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
canonicalTitle: null == canonicalTitle ? _self.canonicalTitle : canonicalTitle // ignore: cast_nullable_to_non_nullable
as String,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,posterImage: freezed == posterImage ? _self.posterImage : posterImage // ignore: cast_nullable_to_non_nullable
as PosterImageDto?,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as CoverImageDto?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as String?,episodeCount: freezed == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int?,showType: freezed == showType ? _self.showType : showType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PosterImageDtoCopyWith<$Res>? get posterImage {
    if (_self.posterImage == null) {
    return null;
  }

  return $PosterImageDtoCopyWith<$Res>(_self.posterImage!, (value) {
    return _then(_self.copyWith(posterImage: value));
  });
}/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoverImageDtoCopyWith<$Res>? get coverImage {
    if (_self.coverImage == null) {
    return null;
  }

  return $CoverImageDtoCopyWith<$Res>(_self.coverImage!, (value) {
    return _then(_self.copyWith(coverImage: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnimeAttributesDto].
extension AnimeAttributesDtoPatterns on AnimeAttributesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnimeAttributesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnimeAttributesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnimeAttributesDto value)  $default,){
final _that = this;
switch (_that) {
case _AnimeAttributesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnimeAttributesDto value)?  $default,){
final _that = this;
switch (_that) {
case _AnimeAttributesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String canonicalTitle,  String synopsis,  String? description,  PosterImageDto? posterImage,  CoverImageDto? coverImage,  String? averageRating,  int? episodeCount,  String? showType,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnimeAttributesDto() when $default != null:
return $default(_that.canonicalTitle,_that.synopsis,_that.description,_that.posterImage,_that.coverImage,_that.averageRating,_that.episodeCount,_that.showType,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String canonicalTitle,  String synopsis,  String? description,  PosterImageDto? posterImage,  CoverImageDto? coverImage,  String? averageRating,  int? episodeCount,  String? showType,  String? status)  $default,) {final _that = this;
switch (_that) {
case _AnimeAttributesDto():
return $default(_that.canonicalTitle,_that.synopsis,_that.description,_that.posterImage,_that.coverImage,_that.averageRating,_that.episodeCount,_that.showType,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String canonicalTitle,  String synopsis,  String? description,  PosterImageDto? posterImage,  CoverImageDto? coverImage,  String? averageRating,  int? episodeCount,  String? showType,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _AnimeAttributesDto() when $default != null:
return $default(_that.canonicalTitle,_that.synopsis,_that.description,_that.posterImage,_that.coverImage,_that.averageRating,_that.episodeCount,_that.showType,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnimeAttributesDto implements AnimeAttributesDto {
  const _AnimeAttributesDto({required this.canonicalTitle, required this.synopsis, this.description, this.posterImage, this.coverImage, this.averageRating, this.episodeCount, this.showType, this.status});
  factory _AnimeAttributesDto.fromJson(Map<String, dynamic> json) => _$AnimeAttributesDtoFromJson(json);

@override final  String canonicalTitle;
@override final  String synopsis;
@override final  String? description;
@override final  PosterImageDto? posterImage;
@override final  CoverImageDto? coverImage;
@override final  String? averageRating;
@override final  int? episodeCount;
@override final  String? showType;
@override final  String? status;

/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnimeAttributesDtoCopyWith<_AnimeAttributesDto> get copyWith => __$AnimeAttributesDtoCopyWithImpl<_AnimeAttributesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimeAttributesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnimeAttributesDto&&(identical(other.canonicalTitle, canonicalTitle) || other.canonicalTitle == canonicalTitle)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.posterImage, posterImage) || other.posterImage == posterImage)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.episodeCount, episodeCount) || other.episodeCount == episodeCount)&&(identical(other.showType, showType) || other.showType == showType)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,canonicalTitle,synopsis,description,posterImage,coverImage,averageRating,episodeCount,showType,status);

@override
String toString() {
  return 'AnimeAttributesDto(canonicalTitle: $canonicalTitle, synopsis: $synopsis, description: $description, posterImage: $posterImage, coverImage: $coverImage, averageRating: $averageRating, episodeCount: $episodeCount, showType: $showType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AnimeAttributesDtoCopyWith<$Res> implements $AnimeAttributesDtoCopyWith<$Res> {
  factory _$AnimeAttributesDtoCopyWith(_AnimeAttributesDto value, $Res Function(_AnimeAttributesDto) _then) = __$AnimeAttributesDtoCopyWithImpl;
@override @useResult
$Res call({
 String canonicalTitle, String synopsis, String? description, PosterImageDto? posterImage, CoverImageDto? coverImage, String? averageRating, int? episodeCount, String? showType, String? status
});


@override $PosterImageDtoCopyWith<$Res>? get posterImage;@override $CoverImageDtoCopyWith<$Res>? get coverImage;

}
/// @nodoc
class __$AnimeAttributesDtoCopyWithImpl<$Res>
    implements _$AnimeAttributesDtoCopyWith<$Res> {
  __$AnimeAttributesDtoCopyWithImpl(this._self, this._then);

  final _AnimeAttributesDto _self;
  final $Res Function(_AnimeAttributesDto) _then;

/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canonicalTitle = null,Object? synopsis = null,Object? description = freezed,Object? posterImage = freezed,Object? coverImage = freezed,Object? averageRating = freezed,Object? episodeCount = freezed,Object? showType = freezed,Object? status = freezed,}) {
  return _then(_AnimeAttributesDto(
canonicalTitle: null == canonicalTitle ? _self.canonicalTitle : canonicalTitle // ignore: cast_nullable_to_non_nullable
as String,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,posterImage: freezed == posterImage ? _self.posterImage : posterImage // ignore: cast_nullable_to_non_nullable
as PosterImageDto?,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as CoverImageDto?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as String?,episodeCount: freezed == episodeCount ? _self.episodeCount : episodeCount // ignore: cast_nullable_to_non_nullable
as int?,showType: freezed == showType ? _self.showType : showType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PosterImageDtoCopyWith<$Res>? get posterImage {
    if (_self.posterImage == null) {
    return null;
  }

  return $PosterImageDtoCopyWith<$Res>(_self.posterImage!, (value) {
    return _then(_self.copyWith(posterImage: value));
  });
}/// Create a copy of AnimeAttributesDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoverImageDtoCopyWith<$Res>? get coverImage {
    if (_self.coverImage == null) {
    return null;
  }

  return $CoverImageDtoCopyWith<$Res>(_self.coverImage!, (value) {
    return _then(_self.copyWith(coverImage: value));
  });
}
}


/// @nodoc
mixin _$PosterImageDto {

 String? get tiny; String? get small; String? get medium; String? get large; String? get original;
/// Create a copy of PosterImageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterImageDtoCopyWith<PosterImageDto> get copyWith => _$PosterImageDtoCopyWithImpl<PosterImageDto>(this as PosterImageDto, _$identity);

  /// Serializes this PosterImageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterImageDto&&(identical(other.tiny, tiny) || other.tiny == tiny)&&(identical(other.small, small) || other.small == small)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.large, large) || other.large == large)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tiny,small,medium,large,original);

@override
String toString() {
  return 'PosterImageDto(tiny: $tiny, small: $small, medium: $medium, large: $large, original: $original)';
}


}

/// @nodoc
abstract mixin class $PosterImageDtoCopyWith<$Res>  {
  factory $PosterImageDtoCopyWith(PosterImageDto value, $Res Function(PosterImageDto) _then) = _$PosterImageDtoCopyWithImpl;
@useResult
$Res call({
 String? tiny, String? small, String? medium, String? large, String? original
});




}
/// @nodoc
class _$PosterImageDtoCopyWithImpl<$Res>
    implements $PosterImageDtoCopyWith<$Res> {
  _$PosterImageDtoCopyWithImpl(this._self, this._then);

  final PosterImageDto _self;
  final $Res Function(PosterImageDto) _then;

/// Create a copy of PosterImageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tiny = freezed,Object? small = freezed,Object? medium = freezed,Object? large = freezed,Object? original = freezed,}) {
  return _then(_self.copyWith(
tiny: freezed == tiny ? _self.tiny : tiny // ignore: cast_nullable_to_non_nullable
as String?,small: freezed == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String?,medium: freezed == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String?,large: freezed == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PosterImageDto].
extension PosterImageDtoPatterns on PosterImageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterImageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterImageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterImageDto value)  $default,){
final _that = this;
switch (_that) {
case _PosterImageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterImageDto value)?  $default,){
final _that = this;
switch (_that) {
case _PosterImageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tiny,  String? small,  String? medium,  String? large,  String? original)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosterImageDto() when $default != null:
return $default(_that.tiny,_that.small,_that.medium,_that.large,_that.original);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tiny,  String? small,  String? medium,  String? large,  String? original)  $default,) {final _that = this;
switch (_that) {
case _PosterImageDto():
return $default(_that.tiny,_that.small,_that.medium,_that.large,_that.original);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tiny,  String? small,  String? medium,  String? large,  String? original)?  $default,) {final _that = this;
switch (_that) {
case _PosterImageDto() when $default != null:
return $default(_that.tiny,_that.small,_that.medium,_that.large,_that.original);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosterImageDto implements PosterImageDto {
  const _PosterImageDto({this.tiny, this.small, this.medium, this.large, this.original});
  factory _PosterImageDto.fromJson(Map<String, dynamic> json) => _$PosterImageDtoFromJson(json);

@override final  String? tiny;
@override final  String? small;
@override final  String? medium;
@override final  String? large;
@override final  String? original;

/// Create a copy of PosterImageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterImageDtoCopyWith<_PosterImageDto> get copyWith => __$PosterImageDtoCopyWithImpl<_PosterImageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosterImageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterImageDto&&(identical(other.tiny, tiny) || other.tiny == tiny)&&(identical(other.small, small) || other.small == small)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.large, large) || other.large == large)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tiny,small,medium,large,original);

@override
String toString() {
  return 'PosterImageDto(tiny: $tiny, small: $small, medium: $medium, large: $large, original: $original)';
}


}

/// @nodoc
abstract mixin class _$PosterImageDtoCopyWith<$Res> implements $PosterImageDtoCopyWith<$Res> {
  factory _$PosterImageDtoCopyWith(_PosterImageDto value, $Res Function(_PosterImageDto) _then) = __$PosterImageDtoCopyWithImpl;
@override @useResult
$Res call({
 String? tiny, String? small, String? medium, String? large, String? original
});




}
/// @nodoc
class __$PosterImageDtoCopyWithImpl<$Res>
    implements _$PosterImageDtoCopyWith<$Res> {
  __$PosterImageDtoCopyWithImpl(this._self, this._then);

  final _PosterImageDto _self;
  final $Res Function(_PosterImageDto) _then;

/// Create a copy of PosterImageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tiny = freezed,Object? small = freezed,Object? medium = freezed,Object? large = freezed,Object? original = freezed,}) {
  return _then(_PosterImageDto(
tiny: freezed == tiny ? _self.tiny : tiny // ignore: cast_nullable_to_non_nullable
as String?,small: freezed == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String?,medium: freezed == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String?,large: freezed == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CoverImageDto {

 String? get tiny; String? get small; String? get large; String? get original;
/// Create a copy of CoverImageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoverImageDtoCopyWith<CoverImageDto> get copyWith => _$CoverImageDtoCopyWithImpl<CoverImageDto>(this as CoverImageDto, _$identity);

  /// Serializes this CoverImageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoverImageDto&&(identical(other.tiny, tiny) || other.tiny == tiny)&&(identical(other.small, small) || other.small == small)&&(identical(other.large, large) || other.large == large)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tiny,small,large,original);

@override
String toString() {
  return 'CoverImageDto(tiny: $tiny, small: $small, large: $large, original: $original)';
}


}

/// @nodoc
abstract mixin class $CoverImageDtoCopyWith<$Res>  {
  factory $CoverImageDtoCopyWith(CoverImageDto value, $Res Function(CoverImageDto) _then) = _$CoverImageDtoCopyWithImpl;
@useResult
$Res call({
 String? tiny, String? small, String? large, String? original
});




}
/// @nodoc
class _$CoverImageDtoCopyWithImpl<$Res>
    implements $CoverImageDtoCopyWith<$Res> {
  _$CoverImageDtoCopyWithImpl(this._self, this._then);

  final CoverImageDto _self;
  final $Res Function(CoverImageDto) _then;

/// Create a copy of CoverImageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tiny = freezed,Object? small = freezed,Object? large = freezed,Object? original = freezed,}) {
  return _then(_self.copyWith(
tiny: freezed == tiny ? _self.tiny : tiny // ignore: cast_nullable_to_non_nullable
as String?,small: freezed == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String?,large: freezed == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoverImageDto].
extension CoverImageDtoPatterns on CoverImageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoverImageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoverImageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoverImageDto value)  $default,){
final _that = this;
switch (_that) {
case _CoverImageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoverImageDto value)?  $default,){
final _that = this;
switch (_that) {
case _CoverImageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tiny,  String? small,  String? large,  String? original)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoverImageDto() when $default != null:
return $default(_that.tiny,_that.small,_that.large,_that.original);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tiny,  String? small,  String? large,  String? original)  $default,) {final _that = this;
switch (_that) {
case _CoverImageDto():
return $default(_that.tiny,_that.small,_that.large,_that.original);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tiny,  String? small,  String? large,  String? original)?  $default,) {final _that = this;
switch (_that) {
case _CoverImageDto() when $default != null:
return $default(_that.tiny,_that.small,_that.large,_that.original);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoverImageDto implements CoverImageDto {
  const _CoverImageDto({this.tiny, this.small, this.large, this.original});
  factory _CoverImageDto.fromJson(Map<String, dynamic> json) => _$CoverImageDtoFromJson(json);

@override final  String? tiny;
@override final  String? small;
@override final  String? large;
@override final  String? original;

/// Create a copy of CoverImageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoverImageDtoCopyWith<_CoverImageDto> get copyWith => __$CoverImageDtoCopyWithImpl<_CoverImageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoverImageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoverImageDto&&(identical(other.tiny, tiny) || other.tiny == tiny)&&(identical(other.small, small) || other.small == small)&&(identical(other.large, large) || other.large == large)&&(identical(other.original, original) || other.original == original));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tiny,small,large,original);

@override
String toString() {
  return 'CoverImageDto(tiny: $tiny, small: $small, large: $large, original: $original)';
}


}

/// @nodoc
abstract mixin class _$CoverImageDtoCopyWith<$Res> implements $CoverImageDtoCopyWith<$Res> {
  factory _$CoverImageDtoCopyWith(_CoverImageDto value, $Res Function(_CoverImageDto) _then) = __$CoverImageDtoCopyWithImpl;
@override @useResult
$Res call({
 String? tiny, String? small, String? large, String? original
});




}
/// @nodoc
class __$CoverImageDtoCopyWithImpl<$Res>
    implements _$CoverImageDtoCopyWith<$Res> {
  __$CoverImageDtoCopyWithImpl(this._self, this._then);

  final _CoverImageDto _self;
  final $Res Function(_CoverImageDto) _then;

/// Create a copy of CoverImageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tiny = freezed,Object? small = freezed,Object? large = freezed,Object? original = freezed,}) {
  return _then(_CoverImageDto(
tiny: freezed == tiny ? _self.tiny : tiny // ignore: cast_nullable_to_non_nullable
as String?,small: freezed == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String?,large: freezed == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
