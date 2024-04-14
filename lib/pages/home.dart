import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/List_container.dart';
import 'package:flutter_application_1/components/app_modal.dart';

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
    print("The value is clicked $id");
  }

  void handleOpen() {
    showDialog(
        context: context,
        builder: (context) {
          return AppModel();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          backgroundColor: Colors.yellow.shade600,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: handleOpen,
          child: const Icon(
            Icons.add,
            size: 36,
          ),
          backgroundColor: Colors.yellow.shade900,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: myData.length,
            itemBuilder: (context, index) {
              return ListContainer(
                  data: myData[index], onToggle: onToggle, onDelete: onDelete);
            }));
  }
}
