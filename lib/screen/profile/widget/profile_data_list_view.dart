import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_code_challenge/screen/profile/controller/profile_controller.dart';

class ProfileDataListView extends StatelessWidget{
  ProfileDataListView({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: controller.localProfile.value?.birthday != null,
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Birthday:",),
                    const SizedBox(width: 5,),
                    Text("08/08/1995 (Age 28)", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Horoscope:",),
                    SizedBox(width: 5,),
                    Text("Virgo", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.localProfile.value?.name != null,
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Zodiac:",),
                    SizedBox(width: 5,),
                    Text("Pig", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.localProfile.value?.height != null,
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Height:",),
                    const SizedBox(width: 5,),
                    Text("${controller.localProfile.value?.height} cm", style: const TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.localProfile.value?.weight != null,
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Weight:",),
                    const SizedBox(width: 5,),
                    Text("${controller.localProfile.value?.weight} kg", style: const TextStyle(fontSize: 16, color: Colors.white),)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

}