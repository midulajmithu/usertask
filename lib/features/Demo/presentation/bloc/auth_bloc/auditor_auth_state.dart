// bloc/auditor_auth_state.dart

import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';

abstract class FetchdetailState {}

class HomeFetchInitial extends FetchdetailState {}

class HomefetchLoading extends FetchdetailState {}

class HomefetchSuccess extends FetchdetailState {
  final String message;
  HomefetchSuccess(this.message);
}

class HomefetchFailure extends FetchdetailState {
  final String error;
  HomefetchFailure(this.error);
}

class HomeDbFetchSuccess extends FetchdetailState {
  final List<UserEntity> users;
  HomeDbFetchSuccess(this.users);
}

class HomeDbFetchFailure extends FetchdetailState {
  final String error;
  HomeDbFetchFailure(this.error);
}

class HomeDbFetchLoading extends FetchdetailState {}

class HomeDeleteUserLoading extends FetchdetailState {}

class HomeDeleteUserSuccess extends FetchdetailState {
  final int userId;
  HomeDeleteUserSuccess(this.userId);
}

class HomeDeleteUserFailure extends FetchdetailState {
  final String error;
  HomeDeleteUserFailure(this.error);
}
