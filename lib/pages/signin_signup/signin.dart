import 'dart:convert';
import 'dart:developer';

// import 'package:app_deaf/service/couresApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController user_name = TextEditingController();
  final TextEditingController passwords = TextEditingController();

  Future<void> inserrecord() async {
    // String jsondata =
    //     '{"user_name":"${user_name.text}", "passwors":"${passwords.text}"}';
    if (user_name.text != "" || passwords.text != "") {
      try {
        var url =
            Uri.http("10.0.2.2",'/phpapi/registoruser.php', {'q': '{http}'});
        var res = await http.post(url,
            body: {"user_name": user_name.text.toString(), "passwords": passwords.text.toString()});

        var data = jsonDecode(res.body);
        if (data["success"] == "ture") {
          print("Record Inserted");
          user_name.text = "";
          passwords.text = "";
        } else {
          print("some isssue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFD218),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // user_name
              TextFormField(
                controller: user_name,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_circle,
                  ),
                  hintText: 'Username',
                  label: Text("UserName"),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 30,
              ),

              /// Password
              Container(
                child: TextFormField(
                  controller: passwords,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                    hintText: 'Password',
                    label: Text("Password"),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              /// Buttom
              ///
              ElevatedButton(
                onPressed: () {
                  inserrecord();
                },
                child: const Text("Login"),
              ),
            ],
          )),
        ),
      ),
    ));
  }
}
