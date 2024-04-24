import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:youapp_code_challenge/app/base/base_screen.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';
import 'package:youapp_code_challenge/screen/profile/controller/profile_controller.dart';
import 'package:youapp_code_challenge/screen/profile/controller/requesting_profile.dart';
import 'package:youapp_code_challenge/screen/widget/background_widget.dart';

class AddInterestScreen extends BaseScreen{
  const AddInterestScreen({super.key});

  @override
  AddInterestState createState ()=> AddInterestState();
}

class AddInterestState extends BaseScreenState<AddInterestScreen>{

  final controller = Get.put(ProfileController());
  late double _distanceToField;
  late StringTagController _stringTagController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BgView(),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: ListTile(
              leading: InkWell(
                onTap: (){
                  context.back();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white,),
                    SizedBox(width: 5,),
                    Text("Back", style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
              ),
              trailing: TextButton(
                  onPressed: formSubmit,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15, left: 15),
                    child: Text("Save", style: TextStyle(
                      fontSize: 16, color: Color(0xFFFFE2BE)),),
                  )
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 120),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Tell everyone about yourself", style: TextStyle(fontSize: 16, color: Color(0xFFFFE2BE)),)),
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("What interest you?", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 30,),
                    TextFieldTags<String>(
                      textfieldTagsController: _stringTagController,
                      initialTags: controller.localProfile.value.getDefault().interests,
                      textSeparators: const [' ', ','],
                      letterCase: LetterCase.normal,
                      validator: (String tag) {
                        if (_stringTagController.getTags!.contains(tag)) {
                          return 'You\'ve already entered that';
                        }
                        return null;
                      },
                      inputFieldBuilder: (context, inputFieldValues) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                          child: TextField(
                            onTap: () {
                              _stringTagController.getFocusNode?.requestFocus();
                            },
                            controller: inputFieldValues.textEditingController,
                            focusNode: inputFieldValues.focusNode,
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7))
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                  color: Color(0xFE9E6E6)
                                )
                              ),
                              errorText: inputFieldValues.error,
                              prefixIconConstraints:
                              BoxConstraints(maxWidth: _distanceToField * 0.8),
                              prefixIcon: inputFieldValues.tags.isNotEmpty
                                  ? SingleChildScrollView(
                                controller: inputFieldValues.tagScrollController,
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Wrap(
                                      runSpacing: 4.0,
                                      spacing: 4.0,
                                      children:
                                      inputFieldValues.tags.map((String tag) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            color: Color(0xFE9E6E6),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  tag,
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                                onTap: () { },
                                              ),
                                              const SizedBox(width: 4.0),
                                              InkWell(
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 14.0,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  inputFieldValues
                                                      .onTagRemoved(tag);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                ),
                              )
                                  : null,
                            ),
                            onChanged: inputFieldValues.onTagChanged,
                            onSubmitted: inputFieldValues.onTagSubmitted,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void formSubmit() {
    if(_stringTagController.getTags!.isNotEmpty){
      var data = controller.localProfile.value.getDefault();
      data.interests = _stringTagController.getTags!;
      context.updateProfile(
          data,
          (success){
            context.back(val: "success");
          },
          (fail){
            showErrorMessage(fail);
          }
      );
    }else{
      showError("Please write something what you interested.");
    }
  }
}