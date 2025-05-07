import 'package:calendar_app/calendar/class/reward.dart';
import 'package:calendar_app/calendar/class/task.dart';
import 'package:calendar_app/calendar/widgets/add_reward.dart';
import 'package:calendar_app/calendar/widgets/add_task.dart';
import 'package:calendar_app/calendar/widgets/get_reward.dart';
import 'package:calendar_app/calendar/widgets/show_all_tasks.dart';
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
  List<IconData> rewardIcons = [
    Icons.book,
    Icons.card_giftcard,
    Icons.bakery_dining,
    Icons.headphones,
    Icons.agriculture,
    Icons.airplane_ticket,
    Icons.album,
    Icons.announcement,
    Icons.attach_money,
    Icons.attractions, //10
    Icons.bathtub,
    Icons.beach_access,
    Icons.bed,
    Icons.brush,
    Icons.toys,
    Icons.cake,
    Icons.cookie,
    Icons.cruelty_free,
    Icons.delivery_dining,
    Icons.diamond, //20
  ];
  TextEditingController textEditingController = TextEditingController();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  bool showRewardIcons = false;
  IconData? selectedIcon;

//ADD THINGS TO LIST
  void addTask({String? title, DateTime? date}) {
    tasks.add(Task(title ?? textEditingController.text, date ?? selectedDay));
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
    update();
  }

  void addReward({String? title, IconData? icon}) {
    rewards.add(Reward(title ?? textEditingController.text,
        icon: icon ?? selectedIcon));
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
    update();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    update();
  }

  //SHOW POPUPS
  void showTaskPopup() {
    textEditingController.clear();
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

  void showAddRewardPopup() {
    textEditingController.clear();
    showDialog(
      context: Get.context!,
      builder: (context) => AddRewardPopup(),
    );
  }

  void showAllTasks() {
    showDialog(
      context: Get.context!,
      builder: (context) => ShowAllTasksPopup(),
    );
  }

  //RETURN ITEM
  List<Task> selectedDayTasks() {
    List<Task> selectedTasks =
        tasks.where((task) => task.date == selectedDay).toList();
    return selectedTasks;
  }

  Reward randomReward() {
    List<Reward> randomRewards = rewards;
    randomRewards.shuffle();
    return randomRewards.first;
  }

  bool dayHasTask(DateTime date) {
    for (Task t in tasks) {
      if (t.date == date) return true;
    }
    return false;
  }

  Color dayHasTaskColor(DateTime date) {
    //add the tasks for the day to the list
    List<Task> todayTasks = [];
    for (Task t in tasks) {
      if (t.date == date) todayTasks.add(t);
    }
    if (todayTasks.isNotEmpty) {
      //check how many tasks are completed from today's tasks
      int completedTasks = 0;
      for (Task t in tasks) {
        if (t.completed == true) {
          completedTasks++;
        }
      }
      //return green if all tasks are done, yellow if some are done and red if none
      if (completedTasks == todayTasks.length) {
        return Colors.green;
      } else if (completedTasks == 0) {
        return Colors.red;
      } else {
        return Colors.yellow;
      }
    }
    return Colors.white;
  }

  //OTHERS
  //CALENDAR
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;

    update();
  }

  void completeTask(Task task) {
    if (task.completed == true) return;
    task.completed = true;
    showRewardPopup();
    update();
  }

  //ADD REWARD
  void showRewardIconSelection() {
    showRewardIcons = !showRewardIcons;
    update();
  }

  void selectIcon(IconData icon) {
    selectedIcon = icon;
    showRewardIconSelection();
  }
}
