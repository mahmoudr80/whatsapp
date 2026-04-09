part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState {
  final int index;

  const NavigationState(this.index);
}

final class NavigationInitial extends NavigationState {

  const NavigationInitial():super(0);
}
final class NavigationUpdate extends NavigationState {
  const NavigationUpdate(super.index);

}
