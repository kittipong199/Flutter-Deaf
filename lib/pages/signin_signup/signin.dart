import 'dart:developer';

import 'package:app_deaf/service/couresApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
