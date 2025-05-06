import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllTasksPopup extends GetView<CalendarController> {
  const ShowAllTasksPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Dialog(
        child: GetBuilder<CalendarController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('All tasks'),
                      Flexible(
                        child: Column(
                          children: List.generate(controller.tasks.length,
                              (int index) {
                            String date =
                                '${controller.tasks[index].date.day}/${controller.tasks[index].date.month}';
                            return Row(
                              children: [
                                Text(controller.tasks[index].title),
                                Spacer(),
                                Text(date)
                              ],
                            );
                          }),
                        ),
                      ),
                      ElevatedButton(onPressed: Get.back, child: Text('Close'))
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }
}
