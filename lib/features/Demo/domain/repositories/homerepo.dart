import 'package:flutter_application_1/core/failure.dart';

import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class HomeRepository {
  Future<Result<bool, Failure>> fetchHomeDetails();
  Future<Result<List<UserEntity>, Failure>> fetchUsersFromDb();
  Future<Result<bool, Failure>> deleteUserFromDb(int userId);
  Future<Result<bool, Failure>> addUserToDb(UserEntity user);
  Future<Result<bool, Failure>> updateUserInDb(UserEntity user);
}
