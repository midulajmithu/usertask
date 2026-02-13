
import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';

abstract class FetchdetailEvent {}

class HomedetailFetchEvent extends FetchdetailEvent {

  HomedetailFetchEvent();
}

class HomeDbFetchEvent extends FetchdetailEvent {
  
}
class HomeDeleteUserEvent extends FetchdetailEvent {
  final int userId;
  HomeDeleteUserEvent(this.userId);
}

class HomeAddUserEvent extends FetchdetailEvent {
  final UserEntity user;
  HomeAddUserEvent(this.user);
}

class HomeUpdateUserEvent extends FetchdetailEvent {
  final UserEntity user;
  HomeUpdateUserEvent(this.user);
}
