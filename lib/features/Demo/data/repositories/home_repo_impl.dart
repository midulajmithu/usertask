import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/failure.dart';
import 'package:flutter_application_1/features/Demo/data/models/User_model.dart';
import 'package:flutter_application_1/features/Demo/data/services/api_services.dart';
import 'package:flutter_application_1/features/Demo/data/services/database_helper.dart';
import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';
import 'package:flutter_application_1/features/Demo/domain/repositories/homerepo.dart';
import 'package:multiple_result/multiple_result.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiServices apiServices;

  HomeRepositoryImpl({required this.apiServices});

  @override
  Future<Result<bool, Failure>> fetchHomeDetails() async {
    try {
      final response = await apiServices.get('users');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data;

        // Convert list of JSON to list of UserEntities
        final users = dataList
            .map((item) => UserModel.fromMap(item).toEntity())
            .toList();

        final dbHelper = DatabaseHelper();
        await dbHelper.createUserTable();

        // Insert all users in a batch
        await dbHelper.insertItems(users);

        return Success(true);
      } else if (response.statusCode == 401) {
        return Error(
          LoginFailure('Token expired or unauthorized. Please login again.'),
        );
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return Error(ClientFailure('Client error: ${response.statusCode}'));
      } else if (response.statusCode! >= 500) {
        return Error(ServerFailure('Server error: ${response.statusCode}'));
      } else {
        debugPrint(
          'Unexpected status code: ${response.statusCode} ${response.data}',
        );
        return Error(
          OtherFailureNon200('Unexpected error: ${response.statusCode}'),
        );
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout ||
          dioError.type == DioExceptionType.connectionError) {
        return Error(
          NetworkFailure('No internet connection. Please try again.'),
        );
      }

      if (dioError.response?.statusCode == 401) {
        return Error(LoginFailure('Session expired. Please login again.'));
      }

      return Error(ServerFailure('Dio error: ${dioError.message}'));
    } catch (e) {
      return Error(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Result<List<UserEntity>, Failure>> fetchUsersFromDb() async {
    try {
      final dbHelper = DatabaseHelper();
      final users = await dbHelper.getItems(); // returns List<UserEntity>

      if (users.isEmpty) {
        return Error(ServerFailure('No users found in database.'));
      }

      return Success(users);
    } catch (e) {
      return Error(ServerFailure('Failed to fetch users from DB: $e'));
    }
  }

  @override
  Future<Result<bool, Failure>> deleteUserFromDb(int userId) async {
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.deleteUser(userId);
      return Success(true);
    } catch (e) {
      return Error(ServerFailure('Failed to delete user: $e'));
    }
  }

  @override
  Future<Result<bool, Failure>> addUserToDb(UserEntity user) async {
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.insertUser(user);
      return Success(true);
    } catch (e) {
      return Error(ServerFailure('Failed to add user: $e'));
    }
  }
  @override
  Future<Result<bool, Failure>> updateUserInDb(UserEntity user) async {
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.updateUser(user);
      return Success(true);
    } catch (e) {
      return Error(ServerFailure('Failed to update user: $e'));
    }
  }
}
