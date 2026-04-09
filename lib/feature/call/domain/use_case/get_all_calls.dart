import 'package:whatsapp/feature/call/data/model/call_model.dart';
import 'package:whatsapp/feature/call/domain/repository/calls_repository.dart';

class GetAllCallsUseCase {
  final CallsRepository _calls;

  GetAllCallsUseCase(this._calls);
  List<CallModel>call(){
    return _calls.getCalls();
  }
}