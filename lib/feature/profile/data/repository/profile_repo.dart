import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/feature/profile/data/datasource/profile_remote_datasource.dart';

import '../../../chat/data/models/user_model.dart';

class ProfileRepo {
  final ProfileRemoteDatasource _datasource;

 const ProfileRepo(this._datasource);


  Future<bool> signOut(){
    return _datasource.signOut();
  }
  Future<bool> updateProfile({required UserModel user,
  String?password}){
    return _datasource.updateProfile(user: user,password: password);
  }
}