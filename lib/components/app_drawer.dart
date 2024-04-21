import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/common_data.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          for (Map<String, dynamic> item in appNavigationData)
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                title: Text(item["title"]),
                titleTextStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, item["route"]);
                },
              ),
            )
        ],
      ),
    );
  }
}
