part of 'authorization_cubit.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationInitial extends AuthorizationState {}
final class AuthorizationLoading extends AuthorizationState {}
final class AuthorizationSuccess extends AuthorizationState {
  final UserModel user;
  AuthorizationSuccess(this.user);
}
final class AuthorizationFailed extends AuthorizationState {
  final String message;
  AuthorizationFailed(this.message);
}
