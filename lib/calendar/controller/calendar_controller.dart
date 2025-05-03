import 'package:calendar_app/calendar/class/reward.dart';
import 'package:calendar_app/calendar/class/task.dart';
import 'package:calendar_app/calendar/widgets/add_task.dart';
import 'package:calendar_app/calendar/widgets/get_reward.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  List<Task> tasks = [];
  List<Reward> rewards = [
    Reward('Gift Card', icon: Icons.card_giftcard),
    Reward('Book', icon: Icons.book),
    Reward('Pastry', icon: Icons.bakery_dining),
    Reward('Music', icon: Icons.headphones),
  ];
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

  void showTaskPopup() {
    showDialog(
      context: Get.context!,
      builder: (context) => AddTaskPopup(),
    );
  }

  void showRewardPopup() {
    showDialog(
      context: Get.context!,
      builder: (context) => GetRewardPopup(),
    );
  }

  List<Task> selectedDayTasks() {
    List<Task> selectedTasks =
        tasks.where((task) => task.date == selectedDate).toList();
    return selectedTasks;
  }

  void completeTask(Task task) {
    //if (task.completed == true) return;
    task.completed = true;
    showRewardPopup();
    update();
  }

  Reward randomReward() {
    List<Reward> randomRewards = rewards;
    randomRewards.shuffle();
    return randomRewards.first;
  }
}
