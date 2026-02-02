// bloc/auditor_auth_event.dart

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
