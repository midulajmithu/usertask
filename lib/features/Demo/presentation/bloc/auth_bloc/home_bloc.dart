// bloc/auditor_auth_bloc.dart

import 'package:flutter_application_1/features/Demo/domain/repositories/homerepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auditor_auth_event.dart';
import 'auditor_auth_state.dart';

class HomeBloc extends Bloc<FetchdetailEvent, FetchdetailState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeFetchInitial()) {
    on<HomedetailFetchEvent>(_onHomeDetailFetch);
    on<HomeDbFetchEvent>(_onHomeDbFetch);
    on<HomeDeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onHomeDetailFetch(
    HomedetailFetchEvent event,
    Emitter<FetchdetailState> emit,
  ) async {
    emit(HomefetchLoading());

    final result = await repository.fetchHomeDetails();

    result.when(
      (success) => emit(HomefetchSuccess('Home details fetched successfully')),
      (failure) => emit(
        HomefetchFailure(failure.message ?? 'Failed to fetch home details'),
      ),
    );
  }

  Future<void> _onHomeDbFetch(
    HomeDbFetchEvent event,
    Emitter<FetchdetailState> emit,
  ) async {
    emit(HomeDbFetchLoading());

    final result = await repository.fetchUsersFromDb(); // DB fetch

    result.when(
      (users) => emit(HomeDbFetchSuccess(users)),
      (failure) => emit(
        HomeDbFetchFailure(failure.message ?? 'Failed to fetch DB details'),
      ),
    );
  }

  Future<void> _onDeleteUser(
    HomeDeleteUserEvent event,
    Emitter<FetchdetailState> emit,
  ) async {
    emit(HomeDeleteUserLoading());

    final result = await repository.deleteUserFromDb(event.userId);

    result.when(
      (success) => emit(HomeDeleteUserSuccess(event.userId)),
      (failure) => emit(
        HomeDeleteUserFailure(failure.message ?? 'Failed to delete user'),
      ),
    );
  }
}
