import '../../data/model/call_model.dart';
import '../repository/calls_repository.dart';

class GetMissedCallsUseCase {
  final CallsRepository _calls;

  GetMissedCallsUseCase(this._calls);
  List<CallModel>call(){
    List<CallModel>calls= _calls.getCalls();
    return calls.where((element) => element.status==CallStatus.missed).toList();
  }
}