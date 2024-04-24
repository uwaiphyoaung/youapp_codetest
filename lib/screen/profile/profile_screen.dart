import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:youapp_code_challenge/app/base/base_screen.dart';
import 'package:youapp_code_challenge/app/constants/app.constant.dart';
import 'package:youapp_code_challenge/app/constants/app.textsize.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/extensions/date.extension.dart';
import 'package:youapp_code_challenge/extensions/string_extension.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';
import 'package:youapp_code_challenge/screen/profile/add_interest_screen.dart';
import 'package:youapp_code_challenge/screen/profile/controller/profile_controller.dart';
import 'package:youapp_code_challenge/screen/profile/controller/requesting_profile.dart';
import 'package:youapp_code_challenge/screen/profile/widget/profile_data_list_view.dart';
import 'package:youapp_code_challenge/utils/util_validate.dart';

import 'widget/interest_data_listview.dart';

class ProfileScreen extends BaseScreen{
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState()=> ProfileScreenState();
}

class ProfileScreenState extends BaseScreenState<ProfileScreen>{
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.syncLocal();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.fetchProfile(
              (success){ controller.syncLocal(); },
              (fail){ showErrorMessage(fail); }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09141A),
        centerTitle: true,
        title: Obx(() => Text(controller.localProfile.value.getDefault().name.getProfileName())),
      ),
      backgroundColor: const Color(0xFF09141A),
      body: SafeArea(
        child: Stack(
          children: [
            Visibility(
              visible: false,
              child:
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          context.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.chevron_left),
                              Text("Back")
                            ],
                          ),
                        )
                    ),
                    Text("@johndoe"),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.more_horiz)
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Card(
                        color: const Color(0xFF162329),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: false,
                                child: Positioned(
                                  top: 1,
                                  right: 1,
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: const Icon(Icons.edit)
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                left: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Obx(() => Text(controller.localProfile.value.getDefault().name.getProfileName(), style: AppTextSize.mediumWhite))
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return Card(
                          color: const Color(0xFF0E191F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    child: Text("About,", style: AppTextSize.mediumWhite,),
                                  ),
                                  controller.clickEditAbout.isFalse?
                                  IconButton(
                                      onPressed: (){
                                        controller.clickEdit();
                                      },
                                      icon: const Icon(Icons.edit)
                                  ):
                                  TextButton(
                                      onPressed: formSubmit,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Text("Save & Update", style: TextStyle(color: Color(
                                            0xFFFFE2BE)),),
                                      )
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              controller.localProfile.value?.birthday != null &&
                                  controller.localProfile.value?.birthday?.isNotEmpty == true&&
                                  controller.clickEditAbout.isFalse?
                                  ProfileDataListView()
                              : controller.clickEditAbout.isFalse?
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: Text("Add in your info to help others know you better",),
                              ):
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    InkWell(
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      onTap: pickProfileImage,
                                      child: Row(
                                        children: [
                                          Obx(() {
                                            return Container(
                                              width: 70,
                                              height: 70,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFF09141A),
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: controller.profilePhoto.value == null?
                                              const Center(
                                                child: Text("+", style: TextStyle(color: Colors.white, fontSize: 40),),
                                              ):
                                              Image.file(controller.profilePhoto.value!,
                                                  fit: BoxFit.cover,
                                                  height: 70),
                                            );
                                          }),
                                          const SizedBox(width: 15,),
                                          const Text("Add image")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
                                          flex: 3,
                                          child: Text("Display name:"),
                                        ),
                                        const SizedBox(width: 15,),
                                        Flexible(
                                          flex: 6,
                                          child: SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              textAlign: TextAlign.right,
                                              decoration: const InputDecoration(
                                                hintText: "Enter name"
                                              ),
                                              validator: (text) {
                                                return UtilValidate.validateBasic(text);
                                              },
                                              onChanged: (text){
                                                controller.changeName(text);
                                              },
                                              keyboardType: TextInputType.name,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Obx(() {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            flex: 3,
                                            child: Text("Gender:"),
                                          ),
                                          const SizedBox(width: 15,),
                                          Flexible(
                                            flex: 6,
                                            child: SizedBox(
                                              width: 250,
                                              child: Card(
                                                elevation: 0,
                                                color: const Color(0xFD9D9D9),
                                                shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: Color(0x38FFFFFF)),
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: PopupMenuButton(
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: 17, horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children:  [
                                                          Text(controller.gender.value.isBlank == true? "Select  Gender": controller.gender.value),
                                                          const SizedBox(width: 7,),
                                                          const Icon(Icons.expand_more),
                                                        ],
                                                      ),
                                                    ),
                                                    itemBuilder: (context) {
                                                      return List.generate(AppConstant.genders.length, (index) {
                                                        return PopupMenuItem(
                                                          onTap: (){
                                                            controller.changeGender(AppConstant.genders[index]);
                                                          },
                                                          value: index,
                                                          child: Text(AppConstant.genders[index]),
                                                        );
                                                      });
                                                    }

                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                    const SizedBox(height: 15,),
                                    Obx(() {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            flex: 3,
                                            child: Text("Birthday:"),
                                          ),
                                          const SizedBox(width: 15,),
                                          Flexible(
                                            flex: 6,
                                            child: SizedBox(
                                              width: 250,
                                              child: InkWell(
                                                onTap: () async{
                                                  context.selectDate(controller.dob.value, (e){
                                                    controller.changeDob(e);
                                                  });
                                                },
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(20)),
                                                child: Card(
                                                  elevation: 0,
                                                  color: const Color(0xFD9D9D9),
                                                  shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          color: Color(0x38FFFFFF)),
                                                      borderRadius: BorderRadius.circular(20)),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 17, horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                                                          child: Text(controller.dob.value?.day == null? "DD MM YYYY": controller.dob.value!.toLocal().format()),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                    const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
                                          flex: 3,
                                          child: Text("Horoscope:"),
                                        ),
                                        const SizedBox(width: 15,),
                                        Flexible(
                                          flex: 6,
                                          child: SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              textAlign: TextAlign.right,
                                              decoration: const InputDecoration(
                                                hintText: "--"
                                              ),
                                              validator: (text) {
                                                return UtilValidate.validateBasic(text);
                                              },
                                              onChanged: (text){

                                              },
                                              keyboardType: TextInputType.name,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
                                          flex: 3,
                                          child: Text("Zodiac:"),
                                        ),
                                        const SizedBox(width: 15,),
                                        Flexible(
                                          flex: 6,
                                          child: SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              textAlign: TextAlign.right,
                                              decoration: const InputDecoration(
                                                hintText: "--"
                                              ),
                                              validator: (text) {
                                                return UtilValidate.validateBasic(text);
                                              },
                                              onChanged: (text){

                                              },
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
                                          flex: 3,
                                          child: Text("Height:"),
                                        ),
                                        const SizedBox(width: 15,),
                                        Flexible(
                                          flex: 6,
                                          child: SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: "Add height",
                                                suffix: Text("cm")
                                              ),
                                              validator: (text) {
                                                return UtilValidate.validateBasic(text);
                                              },
                                              onChanged: (text){
                                                controller.changeHeight(text);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
                                          flex: 3,
                                          child: Text("Weight:"),
                                        ),
                                        const SizedBox(width: 15,),
                                        Flexible(
                                          flex: 6,
                                          child: SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              textAlign: TextAlign.right,
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: "Add weight",
                                                  suffix: Text("kg")
                                              ),
                                              validator: (text) {
                                                return UtilValidate.validateBasic(text);
                                              },
                                              onChanged: (text){
                                                controller.changeWeight(text);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 25,),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.clickEdit();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                        backgroundColor: Color(0xFF09141A)
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                        child: const Text('Cancel', style: TextStyle(fontSize: 16),),
                                      ),
                                    ),
                                    const SizedBox(height: 20,)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Card(
                        color: const Color(0xFF0E191F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  child: Text("Interest,", style: AppTextSize.mediumWhite,),
                                ),
                                IconButton(
                                    onPressed: (){
                                      context.next(const AddInterestScreen() , callBack: (val){
                                        if(val == "success"){
                                          controller.syncLocal();
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.edit)
                                )
                              ],
                            ),
                            const SizedBox(height: 15,),
                            InterestDataListView(),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void formSubmit(){
    context.createProfile(
        ProfileCreatePayload(
            controller.name.value.orEmpty(),
            controller.dob.value?.toLocal().format()??"",
            int.parse(controller.height.value.orZeroString()),
            int.parse(controller.weight.value.orZeroString()),
            ["Reading"]
        ),
        (success){
          controller.clickEdit();
          controller.syncLocal();
          showSuccessMessage("Successfully update!");
        },
        (fail){
          showErrorMessage(fail);
        }
    );
  }

  Future pickProfileImage() async {
    context.pickProfileImage(
      (success){
        controller.changeProfile(success);
      },
      (fail){
        showError(fail);
      }
    );
  }


}