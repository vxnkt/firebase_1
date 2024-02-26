import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/reusable_widgets/reusable_widget.dart';
import 'package:test_firebase/screens/home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: textfield("Enter User", Icons.person_outlined, false,
                _userNameController),
          ),
          Container(
            child: textfield("Enter Email", Icons.person_outlined, false,
                _emailTextController),
          ),
          Container(
            child: textfield("Enter password", Icons.lock_outlined, false,
                _passwordTextController),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then(
                (value) {
                  print("Created new account");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
              ).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            },
            child: const Text('SIGNUP'),
          ),
        ],
      ),
    );
  }
}
