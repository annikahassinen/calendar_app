import 'package:calendar_app/calendar/class/task.dart';
import 'package:calendar_app/calendar/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  List<Task> tasks = [];
  TextEditingController textEditingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  void addTask({String? title, DateTime? date}) {
    tasks.add(Task(title ?? textEditingController.text, date ?? selectedDate));
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
    update();
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDate = selected;
    focusedDate = focused;
    update();
  }

  void showPopup() {
    showDialog(
      context: Get.context!,
      builder: (context) => AddTaskPopup(),
    );
  }
}
