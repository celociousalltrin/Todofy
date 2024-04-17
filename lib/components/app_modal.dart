import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_input.dart';
import 'package:flutter_application_1/utils/validation.dart';

class AppModel extends StatefulWidget {
  const AppModel({super.key});

  @override
  State<AppModel> createState() => _AppModelState();
}

class _AppModelState extends State<AppModel> {
  final _formkey = GlobalKey<FormState>();

  bool isTrigerValidate = false;

  var hanldeChange = (String value, String name) {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade300,
      content: SizedBox(
        height: 420,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      AppCustomInput(
                        hintText: "Enter title",
                        title: "Title",
                        onChange: (value) {
                          hanldeChange(value, "title");
                        },
                        isTrigerValidate: isTrigerValidate,
                        validator: (value) {
                          return value!.titleValidation;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppCustomInput(
                        hintText: "email",
                        title: "Email",
                        onChange: (value) {
                          hanldeChange(value, "email");
                        },
                        isTrigerValidate: isTrigerValidate,
                        validator: (value) {
                          return value!.emailValidation;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppCustomInput(
                        obscureText: true,
                        hintText: "Enter Password",
                        title: "Password",
                        onChange: (value) {
                          hanldeChange(value, "password");
                        },
                        validator: (value) {
                          return value!.passwordValidation;
                        },
                        isTrigerValidate: isTrigerValidate,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              print("Fireee");
                            } else {
                              setState(() {
                                isTrigerValidate = true;
                              });
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black87)),
                          child: const Text(
                            "Create",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
