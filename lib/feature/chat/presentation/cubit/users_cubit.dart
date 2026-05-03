import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/feature/chat/data/repository/chat_repo.dart';

import '../../../../core/networking/result.dart';
import '../../data/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final ChatRepo _repo;
  UsersCubit(this._repo) : super(UsersInitial());
  Future<void> getUsers() async {
    if (isClosed) return;
    emit(UserListLoading());
    final response= await _repo.getUsers();
    switch(response){
      case Success(data:final users):
        if (isClosed) return;
        emit(UserListSuccess(users));
      case Failure(message:final error):
        if (isClosed) return;
        emit(UserListFailure(error));
    }

  }
}
