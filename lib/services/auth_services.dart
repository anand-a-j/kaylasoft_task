import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_management_app/view/phone_auth/otp_screen.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign Up using email and password------------------------------------------
  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String response = "";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // print(cred.user!.uid);

      if (cred.user != null) {
        response = "success";
      }
    } on FirebaseAuthException catch (e) {
      response = e.code;
      return response;
    } catch (e) {
      return '';
    }
    return response;
  }

  /// Login using email and password--------------------------------------------
  Future<String> loginUser(
      {required String email, required String password}) async {
    String response = "";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      response = "success";
    } on FirebaseAuthException catch (e) {
      response = e.code;
      return response;
    } catch (e) {
      // print("Error Email Password Sign In: $e");
      return '';
    }
    return response;
  }

  // Check if the user is signed in with Google
  Future<bool> isGoogleSignedIn() async {
    return _googleSignIn.isSignedIn();
  }

  // Sign out from Google
  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  // Google Sign In-------------------------------------------------------------
  Future<String> signInWithGoogle() async {
    String response = '';
    try {
      bool isSignedIn = await isGoogleSignedIn();

      if (isSignedIn) {
        await signOutGoogle();
      }

      // Initiate Google Sign In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return '';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        response = 'success';
      }
      return response;
    } on FirebaseAuthException catch (e) {
      response = e.code;
      return response;
    } catch (e) {
      // print("Error Google Sign In: $e");
      return '';
    }
  }

  // Phone auth-----------------------------------------------------------------
  Future<String> signInWithPhone(
      BuildContext context, String phoneNumber) async {
    String response = '';
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          response = e.code;
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(context, OtpScreen.routeName,
              arguments: verificationId);
          response = 'success';
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          response = 'timeout';
        },
      );
      return response;
    } on FirebaseAuthException catch (e) {
      response = e.code;
      return response;
    }
  }

// verify phone OTP-------------------------------------------------------------
  Future<String> verifyOTP(
      {required String verificationId, required String userOTP}) async {
    String response = '';
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);

      await _auth.signInWithCredential(credential);

      response = 'success';
      return response;
    } on FirebaseAuthException catch (e) {
      response = e.code;
      return response;
    }
  }

  // sign out-------------------------------------------------------------------
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'success';
    } catch (e) {
      return 'something went wrong';
    }
  }
}
