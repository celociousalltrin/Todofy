import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/List_container.dart';
import 'package:flutter_application_1/components/app_modal.dart';
import 'package:flutter_application_1/utils/validation.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> myData = [
    {"id": 1, "title": "#1 todo", "is_completed": false, "is_deleted": false},
    {"id": 2, "title": "#2 todo", "is_completed": true, "is_deleted": false}
  ];

  List<Map<String, dynamic>> inputPropsData = [
    {
      "id": "1",
      "name": "title",
      "validation": (String value) => value.titleValidation,
      "obscureText": false,
    },
    {
      "id": "2",
      "name": "email",
      "validation": (String value) => value.emailValidation,
      "obscureText": false,
    },
    {
      "id": "3",
      "name": "Password",
      "validation": (String value) => value.passwordValidation,
      "obscureText": true,
    },
  ];

  final formkey = GlobalKey<FormState>();
  bool isTrigerValidate = false;
  Map<String, dynamic> result = {"title": "", "email": "", "password": ""};

  void handleSave(String? value, String key) {
    result[key] = value;
  }

  void onToggle(boolean, id) {
    setState(() {
      myData = myData.map((obj) {
        if (obj["id"] == id) {
          return {...obj, "is_completed": boolean};
        } else {
          return obj;
        }
      }).toList();
    });
  }

  void onDelete(id) {
    setState(() {
      myData = myData.where((o) => o["id"] != id).toList();
    });
  }

  void handleClose() {
    Navigator.of(context).pop();
  }

  void handleAddData(value) {
    setState(() {
      myData.add({
        "id": Random().nextInt(1000),
        "title": value,
        "is_completed": false,
        "is_deleted": false
      });
    });
  }

  void onCreate(StateSetter stflbrSetState) {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      handleAddData(result["title"]);
      handleClose();
    } else {
      stflbrSetState(() {
        isTrigerValidate = true;
      });
    }
  }

  void handleOpen() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, StateSetter stflbrSetState) {
              return AppModel(
                  inputPropsData: inputPropsData,
                  handleClose: handleClose,
                  handleAddData: handleAddData,
                  formKey: formkey,
                  isTrigerValidate: isTrigerValidate,
                  handleSave: handleSave,
                  modelTitle: "Add Todo",
                  onCreate: () {
                    onCreate(stflbrSetState);
                  });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.yellow.shade600,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: handleOpen,
          backgroundColor: Colors.yellow.shade900,
          foregroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 36,
          ),
        ),
        body: ListView.builder(
            itemCount: myData.length,
            itemBuilder: (context, index) {
              return ListContainer(
                  data: myData[index], onToggle: onToggle, onDelete: onDelete);
            }));
  }
}
