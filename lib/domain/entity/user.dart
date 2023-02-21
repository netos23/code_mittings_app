import 'package:code_mittings_app/domain/entity/sex.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String username,
    required String name,
    required String surname,
    required DateTime birthday,
    required Sex sex,
  }) = _User;
}
