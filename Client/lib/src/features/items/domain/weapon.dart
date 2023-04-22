abstract class Weapon {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final int dice;
  final int diceCount;
  final int bonus;

  Weapon({required this.id, required this.title, this.description, this.imageUrl, required this.dice, this.diceCount = 1, this.bonus = 0});
}
