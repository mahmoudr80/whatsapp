import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/feature/call/data/model/call_model.dart';
import 'package:whatsapp/feature/call/domain/repository/calls_repository.dart';
import 'package:whatsapp/feature/call/domain/use_case/get_all_calls.dart';

import '../../domain/use_case/get_missed_calls.dart';

part 'call_state.dart';

enum CallListStatus {all,missed}
class CallCubit extends Cubit<CallState> {
  CallCubit(this._repo) : super(CallInitial());
  final CallsRepository _repo;

  void _getAllCalls(){
    emit(CallFetchData(index: 0,calls: GetAllCallsUseCase(_repo).call()));
  }
  void _getMissedCalls(){
    emit(CallFetchData(index: 1,calls: GetMissedCallsUseCase(_repo).call()));
  }
  void getCalls(int index){
    switch(index){
      case 0:
        _getAllCalls();
      case 1:
        _getMissedCalls();
        default:
          return;
    }
  }
}
