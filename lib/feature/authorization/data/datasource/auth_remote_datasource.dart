// Demo
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatsapp/core/services/firebase_services.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';

class AuthRemoteDatasource {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  AuthRemoteDatasource();

// Demo
   signInWithPhoneNumber(String phoneNumber) async {
    await _firebase.verifyPhoneNumber(
        phoneNumber: "+201012075974",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          _firebase.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          print("${error.message} <==============");
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print("Code sent <==============");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: "123456");
        });
   }


// Your login function
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId: "999697171295-cnrs9irp1pd2mhisd9dn7r1bp477amen.apps.googleusercontent.com",
      );
      final GoogleSignInAccount googleUser =
        await GoogleSignIn.instance.authenticate();

      // Get auth details
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;


      if (googleAuth.idToken == null) {
        return null;
      }

      // Create credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential= await FirebaseAuth.instance
          .signInWithCredential(credential);
      await FirebaseServices.saveUser();
      return userCredential;

    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;

    }
  }


  Future<UserCredential?>signUp(UserModel user,String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      await FirebaseServices.saveUser(
        email: user.email,
        name: user.name,
        image: user.image
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  Future<UserCredential?>signInWithEmailAndPassword(String email,String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }




  Future<void> signOut() async {
     await GoogleSignIn.instance.signOut();
     await _firebase.signOut();
  }
  }
