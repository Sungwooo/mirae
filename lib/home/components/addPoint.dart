import 'package:firebase_database/firebase_database.dart';
import 'package:mirae/global.dart';

class AddPoints {
  final databaseReference = FirebaseDatabase.instance.reference();
  int _userPoint;

  void addChallengePoints() async {
    await getUserData();
    await updateUserData();
  }

  Future<void> getUserData() async {
    await databaseReference
        .child('user')
        .child(Globals.uid)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      if (values.isNotEmpty) {
        {
          values.forEach((key, values) {
            if (key == "point") {
              _userPoint = int.parse(values.toString());
            }
          });
        }
      }
    });
  }

  updateUserData() async {
    await getUserData();
    if (_userPoint != null) {
      await databaseReference
          .child('user')
          .child(Globals.uid)
          .update({'point': _userPoint + 20});
    }
  }
}
