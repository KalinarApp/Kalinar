import 'package:flutter/animation.dart';
import 'package:json_serializable/builder.dart';

@JsonSerializable
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({required this.id, required this.firstName, required this.lastName, required this.email});
}