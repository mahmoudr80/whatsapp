
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  final FirebaseAuth _firebase;

const  AuthRemoteDatasource(this._firebase);

  Future<ConfirmationResult> signIn(String phoneNumber) async {
    return await _firebase.signInWithPhoneNumber(phoneNumber);
  }
}