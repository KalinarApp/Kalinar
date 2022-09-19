import 'package:flutter/material.dart';

class Node with ChangeNotifier {
  final int id;
  Offset position;
  List<int> parents = [];
  List<int> childs = [];

  Node(this.id, this.position);

  void updatePosition(Offset newPosition) {
    position = newPosition;
    notifyListeners();
  }

  void addParentId(int id) {
    parents.add(id);
    notifyListeners();
  }

  void addTargetId(int id) {
    childs.add(id);
    notifyListeners();
  }
}
