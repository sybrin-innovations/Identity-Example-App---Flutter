import 'package:flutter/material.dart';
import 'package:my_test_app/choose_dcoument_page.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: const VerificationCodeBody(),
    );
  }
}

class VerificationCodeBody extends StatefulWidget {
  const VerificationCodeBody({super.key});

  @override
  State<StatefulWidget> createState() => _VerificationCodeBody();

}

class _VerificationCodeBody extends State<VerificationCodeBody> {

  TextEditingController codeTextField = TextEditingController();

  void goToChooseDoc() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseDocumentPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Padding(padding: const EdgeInsets.all(10),
    child: ListView(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text('Sybrin Demo',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 30
            ),),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: const Text('Please provide the code sent to your phone',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 13
            ),),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
            child: TextField(
              controller: codeTextField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Code'
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: TextButton(
              onPressed: goToChooseDoc,
              child: const Text('Verify'),
            ),
          )
      ],
    ),
    ));
  }

}