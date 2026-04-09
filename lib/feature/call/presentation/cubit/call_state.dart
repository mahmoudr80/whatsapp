part of 'call_cubit.dart';

@immutable
sealed class CallState {
  final int index;
  final List<CallModel>calls;
  const CallState(this.index, {required this.calls});
}

final class CallInitial extends CallState {
  CallInitial():super(0,calls: []);
}
final class CallLoading extends CallState {
  CallLoading():super(0,calls: []);
}
final class CallFetchData extends CallState {

  const CallFetchData({required int index,required List<CallModel>calls}) : super(index,calls: calls);
}
