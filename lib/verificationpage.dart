import 'package:flutter/material.dart';
import 'package:my_test_app/verification_code.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: const VerificationPageBody(),
    );
  }
  
}

class VerificationPageBody extends StatefulWidget {
  const VerificationPageBody({super.key});

  @override
  State<StatefulWidget> createState() => _VerificationPageBody();

}

class _VerificationPageBody extends State<VerificationPageBody> {

  TextEditingController emailTextField = TextEditingController();
  TextEditingController phoneTextField = TextEditingController();

  void goToCode() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerificationCodeBody()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
            padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
            child: TextField(
              controller: emailTextField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email Address'
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: TextField(
              controller: phoneTextField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Numbber'
              ),
            ),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: const Text('We\'ll send you a verification code to the \nprovided information above',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 13
            ),),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: TextButton(
              onPressed: goToCode,
              child: const Text('Send Verification Code'),
            ),
          )
        ],
      ),
    );
  }

}