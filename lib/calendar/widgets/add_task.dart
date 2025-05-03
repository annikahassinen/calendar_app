import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPopup extends GetView<CalendarController> {
  const AddTaskPopup({super.key});

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
                      Text('Add task'),
                      SizedBox(
                        child: TextFormField(
                          onTapOutside: (PointerDownEvent event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                          controller: controller.textEditingController,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => controller.addTask(),
                          child: Text('Add'))
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }
}
