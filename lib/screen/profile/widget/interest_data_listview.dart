import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';
import 'package:youapp_code_challenge/screen/profile/controller/profile_controller.dart';

class InterestDataListView extends StatelessWidget{

  final controller = Get.put(ProfileController());

  InterestDataListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.localProfile.value.getDefault().interests!.isNotEmpty?
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            ...controller.localProfile.value.getDefault().interests!.map((e) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Color(0xFE9E6E6),
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: 5.0),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: Text(
                      e,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () { },
                  )
                ],
              ),
            ))
          ],
        ),
      )
      :const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Text("Add in your interest to find a better match",),
      );
    });
  }

}