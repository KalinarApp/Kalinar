// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Item _$ItemFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'Item':
      return _Item.fromJson(json);
    case 'Weapon':
      return _Weapon.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Item', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  User get creator => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl)
        $default, {
    required TResult Function(
            String id,
            String title,
            User creator,
            String? description,
            String? imageUrl,
            int dice,
            int diceCount,
            int bonus)
        weapon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String title, User creator,
            String? description, String? imageUrl)?
        $default, {
    TResult? Function(
            String id,
            String title,
            User creator,
            String? description,
            String? imageUrl,
            int dice,
            int diceCount,
            int bonus)?
        weapon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl)?
        $default, {
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl, int dice, int diceCount, int bonus)?
        weapon,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Item value) $default, {
    required TResult Function(_Weapon value) weapon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Item value)? $default, {
    TResult? Function(_Weapon value)? weapon,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Item value)? $default, {
    TResult Function(_Weapon value)? weapon,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String id,
      String title,
      User creator,
      String? description,
      String? imageUrl});

  $UserCopyWith<$Res> get creator;
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? creator = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get creator {
    return $UserCopyWith<$Res>(_value.creator, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$_ItemCopyWith(_$_Item value, $Res Function(_$_Item) then) =
      __$$_ItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      User creator,
      String? description,
      String? imageUrl});

  @override
  $UserCopyWith<$Res> get creator;
}

/// @nodoc
class __$$_ItemCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res, _$_Item>
    implements _$$_ItemCopyWith<$Res> {
  __$$_ItemCopyWithImpl(_$_Item _value, $Res Function(_$_Item) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? creator = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_Item(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Item implements _Item {
  const _$_Item(
      {required this.id,
      required this.title,
      required this.creator,
      this.description,
      this.imageUrl,
      final String? $type})
      : $type = $type ?? 'Item';

  factory _$_Item.fromJson(Map<String, dynamic> json) => _$$_ItemFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final User creator;
  @override
  final String? description;
  @override
  final String? imageUrl;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Item(id: $id, title: $title, creator: $creator, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Item &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, creator, description, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemCopyWith<_$_Item> get copyWith =>
      __$$_ItemCopyWithImpl<_$_Item>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl)
        $default, {
    required TResult Function(
            String id,
            String title,
            User creator,
            String? description,
            String? imageUrl,
            int dice,
            int diceCount,
            int bonus)
        weapon,
  }) {
    return $default(id, title, creator, description, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String title, User creator,
            String? description, String? imageUrl)?
        $default, {
    TResult? Function(
            String id,
            String title,
            User creator,
            String? description,
            String? imageUrl,
            int dice,
            int diceCount,
            int bonus)?
        weapon,
  }) {
    return $default?.call(id, title, creator, description, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl)?
        $default, {
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl, int dice, int diceCount, int bonus)?
        weapon,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, title, creator, description, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Item value) $default, {
    required TResult Function(_Weapon value) weapon,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Item value)? $default, {
    TResult? Function(_Weapon value)? weapon,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Item value)? $default, {
    TResult Function(_Weapon value)? weapon,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {required final String id,
      required final String title,
      required final User creator,
      final String? description,
      final String? imageUrl}) = _$_Item;

  factory _Item.fromJson(Map<String, dynamic> json) = _$_Item.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  User get creator;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ItemCopyWith<_$_Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_WeaponCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$_WeaponCopyWith(_$_Weapon value, $Res Function(_$_Weapon) then) =
      __$$_WeaponCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      User creator,
      String? description,
      String? imageUrl,
      int dice,
      int diceCount,
      int bonus});

  @override
  $UserCopyWith<$Res> get creator;
}

/// @nodoc
class __$$_WeaponCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res, _$_Weapon>
    implements _$$_WeaponCopyWith<$Res> {
  __$$_WeaponCopyWithImpl(_$_Weapon _value, $Res Function(_$_Weapon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? creator = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? dice = null,
    Object? diceCount = null,
    Object? bonus = null,
  }) {
    return _then(_$_Weapon(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dice: null == dice
          ? _value.dice
          : dice // ignore: cast_nullable_to_non_nullable
              as int,
      diceCount: null == diceCount
          ? _value.diceCount
          : diceCount // ignore: cast_nullable_to_non_nullable
              as int,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Weapon implements _Weapon {
  const _$_Weapon(
      {required this.id,
      required this.title,
      required this.creator,
      this.description,
      this.imageUrl,
      required this.dice,
      this.diceCount = 1,
      this.bonus = 0,
      final String? $type})
      : $type = $type ?? 'Weapon';

  factory _$_Weapon.fromJson(Map<String, dynamic> json) =>
      _$$_WeaponFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final User creator;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final int dice;
  @override
  @JsonKey()
  final int diceCount;
  @override
  @JsonKey()
  final int bonus;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Item.weapon(id: $id, title: $title, creator: $creator, description: $description, imageUrl: $imageUrl, dice: $dice, diceCount: $diceCount, bonus: $bonus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Weapon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.dice, dice) || other.dice == dice) &&
            (identical(other.diceCount, diceCount) ||
                other.diceCount == diceCount) &&
            (identical(other.bonus, bonus) || other.bonus == bonus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, creator, description,
      imageUrl, dice, diceCount, bonus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeaponCopyWith<_$_Weapon> get copyWith =>
      __$$_WeaponCopyWithImpl<_$_Weapon>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl)
        $default, {
    required TResult Function(
            String id,
            String title,
            User creator,
            String? description,
            String? imageUrl,
            int dice,
            int diceCount,
            int bonus)
        weapon,
  }) {
    return weapon(
        id, title, creator, description, imageUrl, dice, diceCount, bonus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String title, User creator,
            String? description, String? imageUrl)?
        $default, {
    TResult? Function(
            String id,
            String title,
            User creator,
            String? description,
            String? imageUrl,
            int dice,
            int diceCount,
            int bonus)?
        weapon,
  }) {
    return weapon?.call(
        id, title, creator, description, imageUrl, dice, diceCount, bonus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl)?
        $default, {
    TResult Function(String id, String title, User creator, String? description,
            String? imageUrl, int dice, int diceCount, int bonus)?
        weapon,
    required TResult orElse(),
  }) {
    if (weapon != null) {
      return weapon(
          id, title, creator, description, imageUrl, dice, diceCount, bonus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Item value) $default, {
    required TResult Function(_Weapon value) weapon,
  }) {
    return weapon(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Item value)? $default, {
    TResult? Function(_Weapon value)? weapon,
  }) {
    return weapon?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Item value)? $default, {
    TResult Function(_Weapon value)? weapon,
    required TResult orElse(),
  }) {
    if (weapon != null) {
      return weapon(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeaponToJson(
      this,
    );
  }
}

abstract class _Weapon implements Item, Weapon {
  const factory _Weapon(
      {required final String id,
      required final String title,
      required final User creator,
      final String? description,
      final String? imageUrl,
      required final int dice,
      final int diceCount,
      final int bonus}) = _$_Weapon;

  factory _Weapon.fromJson(Map<String, dynamic> json) = _$_Weapon.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  User get creator;
  @override
  String? get description;
  @override
  String? get imageUrl;
  int get dice;
  int get diceCount;
  int get bonus;
  @override
  @JsonKey(ignore: true)
  _$$_WeaponCopyWith<_$_Weapon> get copyWith =>
      throw _privateConstructorUsedError;
}
