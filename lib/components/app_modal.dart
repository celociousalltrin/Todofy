import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_input.dart';

class AppModel extends StatefulWidget {
  final List<Map<String, dynamic>> inputPropsData;
  final void Function() handleClose;
  final GlobalKey<FormState> formKey;
  final bool isTrigerValidate;
  final void Function(String?, String) handleSave;
  final String modelTitle;
  final void Function() onCreate;

  const AppModel(
      {super.key,
      required this.handleClose,
      required this.formKey,
      required this.handleSave,
      required this.onCreate,
      required this.inputPropsData,
      required this.modelTitle,
      required this.isTrigerValidate});

  @override
  State<AppModel> createState() => _AppModelState();
}

class _AppModelState extends State<AppModel> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.modelTitle,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
                      Column(
                        children: widget.inputPropsData.map((item) {
                          String capitalizeTitle =
                              item["name"]![0].toUpperCase() +
                                  item["name"]!.substring(1);
                          return AppCustomInput(
                              hintText: "Enter $capitalizeTitle",
                              title: capitalizeTitle,
                              validator: (value) {
                                return item["validation"](value);
                              },
                              obscureText: item["obscureText"],
                              onSave: (value) {
                                widget.handleSave(value, item["name"]!);
                              },
                              isTrigerValidate: widget.isTrigerValidate);
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 5,
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
