import 'package:flutter/material.dart';
import 'package:hero/models/skilltree/edge.dart';

import 'node.dart';

class Nodes with ChangeNotifier {
  List<Node> _items = [];
  List<Edge> _edges = [];
  int _gridSize = 20;

  List<Node> get items => [..._items];
  List<Edge> get edges => [..._edges];
  
  int get gridSize => _gridSize;
  set gridSize(value) {
    _gridSize = value;
    notifyListeners();
  }

  void addNode() {
    int id = _items.isEmpty ? 1 : _items.last.id + 1;

    _items.add(Node(id, const Offset(100, 100)));
    notifyListeners();
  }

  void createEdge(Node start, Node end) {
    _edges.add(Edge(startNode: start, endNode: end));
    notifyListeners();
  }
}
