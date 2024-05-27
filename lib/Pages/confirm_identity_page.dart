import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test_app/choose_dcoument_page.dart';

class ConfirmIdentityPage extends StatelessWidget {
  const ConfirmIdentityPage(this.doc, {super.key, required});

  final IdDocument doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm")),
      body: ConfirmIdentityPageBody(doc: doc),
    );
  }
}

class ConfirmIdentityPageBody extends StatefulWidget {
  const ConfirmIdentityPageBody({super.key, required this.doc});

  final IdDocument doc;

  @override
  State<StatefulWidget> createState() => _ConfirmIdentityPageBody();
}

class _ConfirmIdentityPageBody extends State<ConfirmIdentityPageBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          // Full name
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Text(
              "Full Name",
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
            child: Text(widget.doc.fullname,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19)),
          ),

          // ID Number
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Text("ID Number"),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
            child: const Text("123456789",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19)),
          ),

          // Sex
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Text("Sex"),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
            child: const Text("Male",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19)),
          ),

          // Date of Birth
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Text("Date of Birth"),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
            child: const Text("1995/05/18",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19)),
          ),

          // Nationality
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: const Text("Nationality"),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
            child: const Text("South African",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19)),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: TextButton(
              onPressed: scanID,
              child: const Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }

  static const passiveLivenessChanel =
      MethodChannel('com.example.myTestApp/passiveLiveness');

  void goToBiometrics() {}

  Future scanID() async {
    try {
      final String result =
          await passiveLivenessChanel.invokeMethod("passiveLiveness");

      log('data log: $result');
      debugPrint('data debug: $result');
      //gotToConfirmIdentity();
    } catch (e) {
      log('error: $e');
      debugPrint('error: $e');
    }
  }
}
