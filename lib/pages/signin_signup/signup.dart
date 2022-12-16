import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController textUsernameController = TextEditingController();
  final TextEditingController textPasswordController = TextEditingController();
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
              // username
              TextFormField(
                controller: textUsernameController,
                decoration: const InputDecoration(
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
                  controller: textPasswordController,
                  decoration: const InputDecoration(
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
                onPressed: () {},
                child: const Text("Login"),
              ),
            ],
          )),
        ),
      ),
    ));
  }
}
// Future RegisterUser() async {
//   // url to api PHP
//   var APIURL = "http://10.0.2.2/phpApi/registoruser.php";

//   var user_name;
//   var passwords;
//   Map mapeddate = {'user_name': user_name.text, 'passwords': passwords.text};

//   // send data useing from post to my api php
//   http.Response reponse = await http.post(APIURL,body:mapeddate);

//   var data = jsonDecode(reponse.body);

//   print("Data: ${data}");
// }