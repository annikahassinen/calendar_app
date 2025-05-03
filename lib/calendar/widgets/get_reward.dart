import 'package:calendar_app/calendar/class/reward.dart';
import 'package:calendar_app/calendar/controller/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetRewardPopup extends GetView<CalendarController> {
  const GetRewardPopup({super.key});

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
                      Text('Congratulations',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('You received this reward:'),
                      rewardInfo(),
                      ElevatedButton(onPressed: Get.back, child: Text('Nice!'))
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }

  Widget rewardInfo() {
    Reward randomReward = controller.randomReward();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.blue[200]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [Icon(randomReward.icon), Text(randomReward.name)],
        ),
      ),
    );
  }
}
