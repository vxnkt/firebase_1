import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/reusable_widgets/reusable_widget.dart';
import 'package:test_firebase/screens/home.dart';
import 'package:test_firebase/screens/signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: textfield("Enter Email", Icons.person_outlined, false,
                _emailTextController),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: textfield("Enter Password", Icons.lock_outlined, true,
                _passwordTextController),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then(
                (value) {
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
            child: const Text('LOGIN'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SignUpPage();
                  },
                ),
              );
            },
            child: const Text('Signup'),
          ),
        ],
      ),
    );
  }
}
