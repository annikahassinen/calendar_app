import 'package:calendar_app/calendar/class/task.dart';
import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:calendar_app/calendar/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends GetView<CalendarController> {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<CalendarController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: TableCalendar(
                  firstDay: DateTime(DateTime.now().year, 1, 1),
                  lastDay: DateTime(DateTime.now().year, 12, 31),
                  focusedDay: controller.focusedDate,
                  onDaySelected: (selectedDay, focusedDay) =>
                      controller.onDaySelected(selectedDay, focusedDay),
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDate, day);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddTaskPopup(),
                    );
                  },
                  child: Text('Add task')),
              Column(
                children: List.generate(
                    controller.selectedDayTasks().length,
                    (int index) =>
                        _taskListEntity(controller.selectedDayTasks()[index])),
              )
            ],
          );
        }));
  }

  Widget _taskListEntity(Task task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(task.title),
            Text(task.date.toString()),
            SizedBox(height: 20)
          ],
        ),
        IconButton(
            onPressed: () => controller.completeTask(task),
            icon: Icon(Icons.check_box,
                color:
                    task.completed == true ? Colors.green : Colors.grey[200]))
      ],
    );
  }
}
