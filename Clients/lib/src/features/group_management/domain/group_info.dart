import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_info.freezed.dart';
part 'group_info.g.dart';

@freezed
class GroupInfo with _$GroupInfo {
  const factory GroupInfo({
    required String id,
    required String name,
    required String owner,
    String? description,
  }) = _GroupInfo;

  factory GroupInfo.fromJson(Map<String, dynamic> json) => _$GroupInfoFromJson(json);
}
