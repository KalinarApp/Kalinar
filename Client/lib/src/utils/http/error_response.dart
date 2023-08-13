import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

const String userNotFoundException = "UserNotFoundException";

@freezed
class ErrorResponse with _$ErrorResponse {
  factory ErrorResponse(
    String type,
    List<String> errors,
  ) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}
