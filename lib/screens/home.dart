import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_firebase/screens/signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Enter Name"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Enter Address"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String address = addressController.text;
                  if (name.isNotEmpty && address.isNotEmpty) {
                    setState(() {
                      nameController.text = " ";
                      addressController.text = " ";
                      contacts.add(Contact(name: name, address: address));
                    });
                  }
                },
                child: Text("Save"),
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String address = addressController.text;
                  if (name.isNotEmpty && address.isNotEmpty) {
                    setState(
                      () {
                        nameController.text = " ";
                        addressController.text = " ";
                        contacts[selectedIndex].name = name;
                        contacts[selectedIndex].address = address;
                        selectedIndex = -1;
                      },
                    );
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          contacts.isEmpty
              ? const Text("No contacts")
              : Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("User Signed out");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SignInScreen();
                      },
                    ),
                  );
                });
              },
              child: const Text('logout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    nameController.text = contacts[index].name;
                    addressController.text = contacts[index].address;
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Icon(Icons.edit)),
              InkWell(
                  onTap: () {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  },
                  child: Icon(Icons.delete)),
            ],
          ),
        ),
        title: Column(
          children: [Text(contacts[index].name), Text(contacts[index].address)],
        ),
      ),
    );
  }
}

class Contact {
  String name;
  String address;
  Contact({required this.name, required this.address});
}
