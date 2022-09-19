import 'package:flutter/foundation.dart';
import 'package:hero/models/skilltree/node.dart';

class Edge with ChangeNotifier {
  final Node startNode;
  final Node endNode;

  Edge({required this.startNode, required this.endNode});
}
