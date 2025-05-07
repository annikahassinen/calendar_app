import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:calendar_app/calendar/widgets/ui_button.dart';
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
                      Text(
                        'All tasks',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Flexible(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          child: controller.tasks.isEmpty
                              ? const SizedBox(height: 40)
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: List.generate(
                                        controller.tasks.length, (int index) {
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
                        ),
                      ),
                      UiButton(text: 'Close', function: Get.back),
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }
}
