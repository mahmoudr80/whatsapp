// Demo

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatsapp/core/services/firebase_services.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';

class ProfileRemoteDatasource {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  ProfileRemoteDatasource();

  Future<bool> signOut() async {
    try{
      await GoogleSignIn.instance.signOut();
      await _firebase.signOut();
      return true;
    }catch(e){
      return false;
    }

  }

  Future<bool> updateProfile({required UserModel user,
    String ?password}) async {
   try{
    await _firebase.currentUser?.updateDisplayName(user.name);
    await _firebase.currentUser?.updatePhotoURL(user.image);
     final authUser = FirebaseAuth.instance.currentUser;
     if(authUser==null){return false;}
    if (password != null && password.isNotEmpty) {
      final credential = EmailAuthProvider.credential(
        email: authUser.email!,
        password: password,
      );

      await authUser.reauthenticateWithCredential(credential);

      await authUser.verifyBeforeUpdateEmail(user.email);
    }

     FirebaseServices.saveUser();
     return true;
   }catch(e){
     print("xxxxxxxxxxxxxxxxxxxxx");
     print(e.toString());
     return false;
   }


  }

}
