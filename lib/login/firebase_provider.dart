import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseProvider with ChangeNotifier {
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser _user;

  String _lastFirebaseResponse = "";

  FirebaseProvider() {
    _prepareUser();
  }

  FirebaseUser getUser() {
    return _user;
  }

  void setUser(FirebaseUser value) {
    _user = value;
    notifyListeners();
  }

  _prepareUser() {
    fAuth.currentUser().then((FirebaseUser currentUser) {
      setUser(currentUser);
    });
  }

  // ignore: missing_return
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      AuthResult result = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        signOut();
         return true;
      }
    } on Exception catch (e) {
      List<String> result = e.toString().split(", ");
      setLastFBMessage(result[1]);
      return false;
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      var result = await fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result != null) {
        setUser(result.user);
        return true;
      }
      return false;
    } on Exception catch (e) {
      List<String> result = e.toString().split(", ");
      setLastFBMessage(result[1]);
      return false;
    }
  }

  Future<bool> signInWithGoogleAccount() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final FirebaseUser user =
          (await fAuth.signInWithCredential(credential)).user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await fAuth.currentUser();
      assert(user.uid == currentUser.uid);
      setUser(user);
      return true;
    } on Exception catch (e) {
      List<String> result = e.toString().split(", ");
      setLastFBMessage(result[1]);
      return false;
    }
  }

  signOut() async {
    await fAuth.signOut();
    setUser(null);
  }

  sendPasswordResetEmailByEnglish() async {
    await fAuth.setLanguageCode("en");
    sendPasswordResetEmail();
  }

  sendPasswordResetEmailByKorean() async {
    await fAuth.setLanguageCode("ko");
    sendPasswordResetEmail();
  }

  sendPasswordResetEmail() async {
    fAuth.sendPasswordResetEmail(email: getUser().email);
  }

  withdrawalAccount() async {
    await getUser().delete();
    setUser(null);
  }

  setLastFBMessage(String msg) {
    _lastFirebaseResponse = msg;
  }

  getLastFBMessage() {
    String returnValue = _lastFirebaseResponse;
    _lastFirebaseResponse = null;
    return returnValue;
  }
}