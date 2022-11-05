import 'package:freezed_annotation/freezed_annotation.dart';

import 'node.dart';

part 'edge.freezed.dart';
part 'edge.g.dart';

@freezed
class Edge with _$Edge {
  const factory Edge({
    required Node start,
    required Node end,
  }) = _Edge;

  factory Edge.fromJson(Map<String, dynamic> json) => _$EdgeFromJson(json);
}

extension StringListExtension on List<String> {
  List<String> without(String value) {
    return [...where((element) => element != value)];
  }

  List<String> withoutMultiple(List<String> values) {
    return [...where((element) => !values.contains(element))];
  }
}
