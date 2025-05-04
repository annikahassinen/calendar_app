import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRewardPopup extends GetView<CalendarController> {
  const AddRewardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Dialog(
        child: GetBuilder<CalendarController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.showRewardIcons
                ? _iconSelection()
                : Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Add reward'),
                          Row(
                            children: [
                              Icon(controller.selectedIcon),
                              Flexible(
                                child: SizedBox(
                                  child: TextFormField(
                                    onTapOutside: (PointerDownEvent event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue))),
                                    controller:
                                        controller.textEditingController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: controller.showRewardIconSelection,
                              child: Text('Choose icon')),
                          ElevatedButton(
                              onPressed: () => controller.addReward(),
                              child: Text('Add'))
                        ],
                      ),
                    )),
          );
        }),
      ),
    );
  }

  Widget _iconSelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Choose an icon by clicking it'),
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: List.generate(controller.rewardIcons.length, (int index) {
              IconData icon = controller.rewardIcons[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: IconButton(
                    icon: Icon(icon),
                    onPressed: () => controller.selectIcon(icon),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
