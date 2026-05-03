part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UserListLoading extends UsersState {}

final class UserListSuccess extends UsersState {
  final List<UserModel> users;
  UserListSuccess(this.users);
}

final class UserListFailure extends UsersState {
  final String error;
  UserListFailure(this.error);
}