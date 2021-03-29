import 'package:country_picker/country_picker.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:mirae/global.dart';
import 'package:mirae/login/firebase_provider.dart';
import 'package:provider/provider.dart';

String countryCodeToEmoji(String countryCode) {
  // 0x41 is Letter A
  // 0x1F1E6 is Regional Indicator Symbol Letter A
  // Example :
  // firstLetter U => 20 + 0x1F1E6
  // secondLetter S => 18 + 0x1F1E6
  // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
  final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}

class EditUserInfo extends StatefulWidget {
  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  FirebaseProvider fp;
  final databaseReference = FirebaseDatabase.instance.reference().child('user');

  String selectedCountry;
  String userEmail = "";
  String userStartDate;
  int challengeDay;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context, listen: true);
    userStartDate =
        fp.getUser().metadata.creationTime.toString().substring(0, 10);
    userEmail = "${fp.getUser().email}";
    challengeDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
                .difference(fp.getUser().metadata.creationTime)
                .inDays +
            1;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: databaseReference.child(Globals.uid).once(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 0.04 * width),
              ),
            );
          } else {
            Map<dynamic, dynamic> values = snapshot.data.value;
            selectedCountry = values["country"];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: 0.67 * width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Country",
                          style: TextStyle(
                              color: Color(0xff47B261),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 0.032 * width,
                        ),
                        InkWell(
                          onTap: () => showCountryPicker(
                            context: context,
                            onSelect: (Country country) async {
                              setState(() {
                                selectedCountry = country.countryCode;
                              });
                              await databaseReference
                                  .child(fp.getUser().uid)
                                  .update({'country': country.countryCode});
                            },
                          ),
                          child: selectedCountry != null
                              ? Text(
                                  countryCodeToEmoji(selectedCountry),
                                  style: TextStyle(fontSize: 0.067 * width),
                                )
                              : Text("Tap to Select",
                                  style: TextStyle(
                                      color: Color(0xff424242),
                                      fontFamily: "GoogleSans",
                                      fontSize: 0.034 * width,
                                      fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "E-Mail",
                          style: TextStyle(
                              color: Color(0xff525252),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 0.01 * height,
                        ),
                        Text(
                          "$userEmail",
                          style: TextStyle(
                              color: Color(0xff42B261),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My challenges",
                          style: TextStyle(
                              color: Color(0xff525252),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 0.01 * height,
                        ),
                        Text(
                          "Day $challengeDay / ${(challengeDay - 1) * 3} challenges",
                          style: TextStyle(
                              color: Color(0xff42B261),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start date",
                          style: TextStyle(
                              color: Color(0xff525252),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 0.01 * height,
                        ),
                        Text(
                          "$userStartDate",
                          style: TextStyle(
                              color: Color(0xff42B261),
                              fontFamily: "GoogleSans",
                              fontSize: 0.042 * width,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
