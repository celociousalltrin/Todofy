import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_input.dart';
import 'package:flutter_application_1/utils/validation.dart';

class AppModel extends StatefulWidget {
  final void Function() handleClose;
  final void Function(String) handleAddData;
  const AppModel(
      {super.key, required this.handleClose, required this.handleAddData});

  @override
  State<AppModel> createState() => _AppModelState();
}

class _AppModelState extends State<AppModel> {
  final _formkey = GlobalKey<FormState>();

  bool isTrigerValidate = false;
  Map<String, dynamic> result = {"title": "", "email": "", "password": ""};

  void handleSave(String? value, String title) {
    result[title] = value;
  }

  void onPressed() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      widget.handleAddData(result["title"]);
      widget.handleClose();
    } else {
      setState(() {
        isTrigerValidate = true;
      });
    }
  }

  void onClose() {
    widget.handleClose();
  }

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
                        isTrigerValidate: isTrigerValidate,
                        validator: (value) {
                          return value!.titleValidation;
                        },
                        onSave: (value) {
                          handleSave(value, "title");
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppCustomInput(
                        hintText: "email",
                        title: "Email",
                        isTrigerValidate: isTrigerValidate,
                        validator: (value) {
                          return value!.emailValidation;
                        },
                        onSave: (value) {
                          handleSave(value, "email");
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppCustomInput(
                        obscureText: true,
                        hintText: "Enter Password",
                        title: "Password",
                        validator: (value) {
                          return value!.passwordValidation;
                        },
                        isTrigerValidate: isTrigerValidate,
                        onSave: (value) {
                          handleSave(value, "password");
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppButton(
                            onPressed: onPressed,
                            btnName: "Create",
                          ),
                          AppButton(
                            onPressed: onClose,
                            btnName: "Cancel",
                            btnTxtStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                            btnStyle: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 235, 27, 24))),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
