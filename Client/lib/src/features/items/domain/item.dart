import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kalinar/src/features/items/domain/weapon.dart';

import '../../group_management/domain/user.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
class Item with _$Item {
  @FreezedUnionValue("Item")
  const factory Item({
    required String id,
    required String title,
    required User creator,
    String? description,
    String? imageUrl,
  }) = _Item;

  @Implements<Weapon>()
  @FreezedUnionValue("Weapon")
  const factory Item.weapon({
    required String id,
    required String title,
    required User creator,
    String? description,
    String? imageUrl,
    required int dice,
    @Default(1) int diceCount,
    @Default(0) int bonus,
  }) = _Weapon;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
