import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_input.dart';
import 'package:flutter_application_1/utils/validation.dart';

class AppModel extends StatefulWidget {
  final void Function() handleClose;
  final void Function(String) handleAddData;
  final GlobalKey<FormState> formKey;
  final bool isTrigerValidate;
  final void Function(String?, String) handleSave;
  final void Function() onCreate;

  const AppModel(
      {super.key,
      required this.handleClose,
      required this.handleAddData,
      required this.formKey,
      required this.handleSave,
      required this.onCreate,
      required this.isTrigerValidate});

  @override
  State<AppModel> createState() => _AppModelState();
}

class _AppModelState extends State<AppModel> {
  @override
  Widget build(BuildContext context) {
    print("TRhe trigger Validate ${widget.isTrigerValidate}");
    return AlertDialog(
      backgroundColor: Colors.yellow.shade300,
      content: SizedBox(
        height: 420,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: widget.formKey,
                  child: Column(
                    children: [
                      AppCustomInput(
                        hintText: "Enter title",
                        title: "Title",
                        isTrigerValidate: widget.isTrigerValidate,
                        validator: (value) {
                          return value!.titleValidation;
                        },
                        onSave: (value) {
                          widget.handleSave(value, "title");
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppCustomInput(
                        hintText: "email",
                        title: "Email",
                        isTrigerValidate: widget.isTrigerValidate,
                        validator: (value) {
                          return value!.emailValidation;
                        },
                        onSave: (value) {
                          widget.handleSave(value, "email");
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
                        isTrigerValidate: widget.isTrigerValidate,
                        onSave: (value) {
                          widget.handleSave(value, "password");
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppButton(
                            onPressed: widget.onCreate,
                            btnName: "Create",
                          ),
                          AppButton(
                            onPressed: widget.handleClose,
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
