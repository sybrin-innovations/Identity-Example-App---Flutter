import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test_app/Pages/confirm_identity_page.dart';

class ChooseDocumentPage extends StatelessWidget {
  const ChooseDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: const ChooseDocumentPageBody(),
    );
  }
}

class ChooseDocumentPageBody extends StatefulWidget {
  const ChooseDocumentPageBody({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseDocumentBody();
}

class _ChooseDocumentBody extends State<ChooseDocumentPageBody> {
  TextEditingController codeTextField = TextEditingController();

  void goToChooseDoc() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseDocumentPage()),
    );
  }

  void gotToConfirmIdentity(IdDocument doc) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ConfirmIdentityPage(
                doc,
              )),
    );
  }

  static const scanDocChanel =
      MethodChannel('com.example.myTestApp/scanDocument');

  Future scanID() async {
    try {
      final String result = await scanDocChanel.invokeMethod("scanID");

      var dataArray = result.split(";");
      var name = "";
      var identityNumber = "";
      var sex = "";
      var dateOfBirth = "";
      var nationality = "";

      for (var arr in dataArray) {
        if (arr.contains("fullName") == true) {
          var nameArr = arr.split(":");
          name = nameArr[1];
        }

        if (arr.contains("identityNumber") == true) {
          var identityNumberArr = arr.split(":");
          identityNumber = identityNumberArr[1];
        }

        if (arr.contains("sex") == true) {
          var sexArr = arr.split(":");
          sex = sexArr[1];
        }

        if (arr.contains("dateOfBirth") == true) {
          var dateOfBirthArr = arr.split(":");
          dateOfBirth = dateOfBirthArr[1];
        }

        if (arr.contains("nationality") == true) {
          var nationalityArr = arr.split(":");
          nationality = nationalityArr[1];
        }

        debugPrint('data debug: $result');
      }

      IdDocument doc =
          IdDocument(name, sex, identityNumber, nationality, dateOfBirth);
      gotToConfirmIdentity(doc);
    } catch (e) {
      log('error: $e');
      debugPrint('error: $e');
    }
  }

  Future scanPassport() async {
    await scanDocChanel.invokeMethod("scanPassport");
  }

  Future scanDriversLicense() async {
    await scanDocChanel.invokeMethod("scanDriversLicense");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sybrin Demo',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: const Text(
              'Choose Document Type',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 13),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: TextButton(
              onPressed: scanID,
              child: const Text('ID Card'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: TextButton(
              onPressed: scanPassport,
              child: const Text('Passport'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: TextButton(
              onPressed: scanDriversLicense,
              child: const Text('Drivers License'),
            ),
          )
        ],
      ),
    ));
  }
}

class IdDocument {
  late String fullname;
  late String sex;
  late String idNumber;
  late String nationality;
  late String dateOfBirth;

  IdDocument(String fullname, String sex, String idNumber, String nationality,
      String dateOfBirth) {
    fullname = fullname;
    sex = sex;
    idNumber = idNumber;
    nationality = nationality;
    dateOfBirth = dateOfBirth;
  }
}
