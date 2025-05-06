import 'package:calendar_app/calendar/class/task.dart';
import 'package:calendar_app/calendar/controller/calendar_controller.dart';
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
                  focusedDay: controller.focusedDay,
                  availableCalendarFormats: {CalendarFormat.month: 'Month'},
                  onDaySelected: (selectedDay, focusedDay) =>
                      controller.onDaySelected(selectedDay, focusedDay),
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay, day);
                  },
                  holidayPredicate: (day) {
                    return controller.dayHasTask(day);
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[200])),
                  calendarStyle: CalendarStyle(
                      weekendDecoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      holidayDecoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      holidayTextStyle: TextStyle(color: Colors.white),
                      defaultDecoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                ),
              ),
              ElevatedButton(
                  onPressed: controller.showTaskPopup, child: Text('Add task')),
              ElevatedButton(
                  onPressed: controller.showAddRewardPopup,
                  child: Text('Add reward')),
              ElevatedButton(
                  onPressed: controller.showAllTasks,
                  child: Text('Show all tasks')),
              Column(
                children: List.generate(
                    controller.selectedDayTasks().length,
                    (int index) =>
                        _taskListEntity(controller.selectedDayTasks()[index])),
              ),
            ],
          );
        }));
  }

  Widget _taskListEntity(Task task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(task.title),
        IconButton(
            onPressed: () => controller.completeTask(task),
            icon: Icon(Icons.check_box,
                color:
                    task.completed == true ? Colors.green : Colors.grey[200]))
      ],
    );
  }
}
