import 'package:calendar_app/calendar/class/task.dart';
import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:calendar_app/calendar/widgets/ui_button.dart';
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
          return Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UiButton(
                        text: 'Add task', function: controller.showTaskPopup),
                    UiButton(
                        text: 'Add reward',
                        function: controller.showAddRewardPopup),
                    UiButton(
                        text: 'All tasks', function: controller.showAllTasks),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: List.generate(
                            controller.selectedDayTasks().length,
                            (int index) => _taskListEntity(
                                controller.selectedDayTasks()[index])),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Widget _taskListEntity(Task task) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(task.title),
              Row(
                children: [
                  IconButton(
                      onPressed: () => controller.completeTask(task),
                      icon: Icon(Icons.check_box,
                          color: task.completed == true
                              ? Colors.green
                              : Colors.grey[700])),
                  IconButton(
                      onPressed: () => controller.removeTask(task),
                      icon: Icon(Icons.delete, color: Colors.red)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
