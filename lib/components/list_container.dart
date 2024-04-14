import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/app_modal.dart';

class ListContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  Function(bool?, num) onToggle;
  Function(num) onDelete;

  ListContainer(
      {super.key,
      required this.data,
      required this.onToggle,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow.shade700,
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                  value: data["is_completed"],
                  onChanged: (value) {
                    onToggle(value, data["id"]);
                  }),
              Text(
                data["title"],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: data["is_completed"]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              onDelete(data["id"]);
            },
            child: const Icon(
              Icons.delete,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
