import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

// ignore: missing_return
Future<String> signInWithGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount account = await googleSignIn.signIn();
  GoogleSignInAuthentication authentication = await account.authentication;
  AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: authentication.idToken, accessToken: authentication.accessToken);
  AuthResult authResult = await auth.signInWithCredential(credential);

  final FirebaseUser user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}
