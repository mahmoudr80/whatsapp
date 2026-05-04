import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import 'package:whatsapp/feature/profile/data/repository/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileInitial());
  final ProfileRepo _repo;

  Future<void>signOut() async {
    final response = await _repo.signOut();
    if(response){
      emit(LogoutSuccess());
    }
  }

  Future<void>updateProfile({required UserModel user,String?password})async{
    if (!isClosed){
      emit(ProfileLoading());
    }
    final response=await _repo.updateProfile(user: user,password: password);
    if(response){
      if (!isClosed){
        emit(ProfileSuccess());
      }
    }
    else{
      if (!isClosed){
      emit(ProfileFailed());
    }
    }
    }
}
