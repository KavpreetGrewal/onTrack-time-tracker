import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ontrack_time_tracker/pages/settings/variables.dart';


class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static var error;

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      SettingsVar.setUser(result.user);
      if (SettingsVar.user != null) {
        SettingsVar.setLoggedIn(true);
        return true;
      } else {
        error = "Failed sing in, please try again later.";
        return false;
      }
    } catch (e) {

      error = e.toString() == null || e.toString() == '' ?
      "Failed sign in, please try again later." : e.toString();
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      SettingsVar.setLoggedIn(false);
    } catch (e) {
      error = error = e.toString() == null || e.toString() == '' ?
      "Error logging out, please try again later." : e.toString();
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      SettingsVar.setGoogleAccount(account);
      if (account == null) {
        error = "Failed sign in with Google, please try again later.";
        return false;
      }
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken));
      if (res.user == null) {
        error = "Failed Sign In, please try again later.";
        return false;
      }
      SettingsVar.setLoggedIn(true);
      return true;
    } catch (e) {
      error = error = e.toString() == null || e.toString() == '' ?
      "Error logging out, please try again later." : e.toString();
      return false;
    }
  }

  Future<bool> signUpWithEmail (String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      SettingsVar.setUser(result.user);
      if (result.user != null) {
        SettingsVar.setLoggedIn(true);
        return true;
      } else {
        error = "Failed sign up, please try again later";
        return false;
      }
    } catch (e) {
      error = e.toString() == null || e.toString() == '' ?
      "Error logging out, please try again later." : e.toString();
      return false;
    }
  }

  Future<bool> signInAnon () async {
    try {
      if (SettingsVar.user == null) {
        AuthResult result = await _auth.signInAnonymously();
        SettingsVar.setUser(result.user);
      }

      if (SettingsVar.user != null) {
        SettingsVar.setLoggedIn(true);
        return true;
      } else {
        error = "Failed sign up, please try again later";
        return false;
      }
    } catch (e) {
      error = e.toString() == null || e.toString() == '' ?
      "Error signing in, please try again later." : e.toString();
      return false;
    }
  }

}

