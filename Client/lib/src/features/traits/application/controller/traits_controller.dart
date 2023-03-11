import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TraitsController {
  Future getById(String id);
  Future<AsyncValue> filter(String? query);
  Future<AsyncValue> create(Map<String, dynamic> data);
  Future<AsyncValue> update(String id, Map<String, dynamic> data);
  Future<AsyncValue> delete(String id);
  Future<AsyncValue> reject(String id, String reason);
}
