import '../domain/item.dart';

const List<Item> items = [
  Item.weapon(
      id: "",
      title: "Revolver",
      description: "Dies ist ein Revolver - Pew Pew!",
      dice: 10,
      diceCount: 10,
      imageUrl: "https://cdn.discordapp.com/attachments/854749872862265365/1084449443849457725/b08d241536a4c08cdee2cb29a5c4f909.jpg"),
  Item.weapon(
      id: "",
      title: "Schildbogen",
      description: "Ein Bogen, der ein Lichtschild vor sich spannt, um den Nutzer zu beschützen.",
      dice: 15,
      diceCount: 10,
      bonus: 5,
      imageUrl: "https://cdn.discordapp.com/attachments/854749872862265365/1084449443379679354/99bdf4ecd87263743d989676b34655d6.jpg"),
  Item.weapon(
      id: "",
      title: "Sense des Todes",
      description: "Die Sense des Tods höchstpersönlich. Geschmiedet aus den Feuern der Hölle.",
      dice: 5,
      diceCount: 5,
      bonus: 15,
      imageUrl: "https://cdn.discordapp.com/attachments/854749872862265365/1084449384420364298/412783a2ece07b267a2f049b78d60f2f.jpg"),
];
