import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/core/services/firebase_services.dart';
import 'package:whatsapp/feature/authorization/data/repository/auth_repo.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit(this._repository) : super(AuthorizationInitial());
  final AuthRepo _repository;

Future<void>signInWithGoogle()async{
  emit(AuthorizationLoading());
  final response=await _repository.signInWithGoogle();
  if(response != null){
    final docs =await FirebaseServices.getUser();
    final user=UserModel.fromJson(docs?.data());
    emit(AuthorizationSuccess(user));
  }
  else{
    emit(AuthorizationFailed("Failed to sign in with google"));
  }
}
  Future<void>login({required String email,required String password})async{
    emit(AuthorizationLoading());
    final response=await _repository.signInWithEmailAndPassword(email, password);
    if(response != null){
      final docs =await FirebaseServices.getUser();
      final user=UserModel.fromJson(docs?.data());
      emit(AuthorizationSuccess(user));
    }
    else{
      emit(AuthorizationFailed("Failed to sign in with google"));
    }
  }

  Future<void>register({required UserModel user,
    required String password})async{
    emit(AuthorizationLoading());
    final response=await _repository.signUp(user, password);
    if(response != null){
      final docs =await FirebaseServices.getUser();
      final user=UserModel.fromJson(docs?.data());
      emit(AuthorizationSuccess(user));
    }
    else{
      emit(AuthorizationFailed("Failed to sign in with google"));
    }
  }


}
