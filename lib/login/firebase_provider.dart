import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseProvider with ChangeNotifier {
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser _user;

  String _lastFirebaseResponse = "";

  Stream<FirebaseUser> get onAuthStateChanged => fAuth.onAuthStateChanged;

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

  changeDisplayName(String text) async {
    FirebaseUser user = await fAuth.currentUser();
    UserUpdateInfo newDisplayName = new UserUpdateInfo();
    newDisplayName.displayName = "$text";
    await user.updateProfile(newDisplayName);
    user = await fAuth.currentUser();
    setUser(user);
  }

  changePhotoUrl(String text) async {
    FirebaseUser user = await fAuth.currentUser();
    UserUpdateInfo newPhotoUrl = new UserUpdateInfo();
    newPhotoUrl.photoUrl = "$text";
    await user.updateProfile(newPhotoUrl);
    user = await fAuth.currentUser();
    setUser(user);
  }

  Future<String> signInWithGoogleAccount() async {
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
      return '$user';
    } on Exception catch (e) {
      List<String> result = e.toString().split(", ");
      setLastFBMessage(result[1]);
      return null;
    }
  }

  // ignore: missing_return, non_constant_identifier_names
  Future<bool> signUpWithEmail(
      String email, String password, String name) async {
    try {
      AuthResult result = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = await fAuth.currentUser();

      UserUpdateInfo updateInfo = new UserUpdateInfo();
      updateInfo.displayName = name;
      // updateInfo.photoUrl = 'https://source.unsplash.com/Yui5vfKHuzs/640x404';
      await user.updateProfile(updateInfo);

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

  signOut() async {
    await fAuth.signOut();
    setUser(null);
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
