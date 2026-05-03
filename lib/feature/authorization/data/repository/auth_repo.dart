import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/feature/authorization/data/datasource/auth_remote_datasource.dart';

import '../../../chat/data/models/user_model.dart';

class AuthRepo {
  final AuthRemoteDatasource _datasource;

 const AuthRepo(this._datasource);

  Future<UserCredential?> signInWithGoogle(){
    return _datasource.signInWithGoogle();
  }
  Future<void> signOut(){
    return _datasource.signOut();
  }

  Future<UserCredential?>signInWithEmailAndPassword(String email,String password)async{
    return _datasource.signInWithEmailAndPassword(email, password);
  }
  Future<UserCredential?>signUp(UserModel user,String password) async{
    return _datasource.signUp(user, password);
  }
}