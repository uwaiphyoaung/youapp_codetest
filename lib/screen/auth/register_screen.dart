import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_code_challenge/app/base/base_screen.dart';
import 'package:youapp_code_challenge/app/constants/app.textsize.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';
import 'package:youapp_code_challenge/screen/auth/controller/auth_controller.dart';
import 'package:youapp_code_challenge/screen/auth/controller/requesting_authorization.dart';
import 'package:youapp_code_challenge/screen/widget/background_widget.dart';
import 'package:youapp_code_challenge/utils/util_validate.dart';

class RegisterScreen extends BaseScreen{
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState()=> RegisterScreenState();
}

class RegisterScreenState extends BaseScreenState<RegisterScreen>{
  final registerController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            const BgView(),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: InkWell(
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
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 90),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 55,),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Register", style: AppTextSize.largeWhite,),
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter Email"
                            ),
                            validator: (text) {
                              return UtilValidate.validateEmail(text);
                            },
                            onChanged: (text){
                              registerController.changeEmail(text);
                            },
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Create Username"
                            ),
                            validator: (text) {
                              return UtilValidate.validateBasic(text);
                            },
                            onChanged: (text){
                              registerController.changeUserName(text);
                            },
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Create Password"
                            ),
                            onChanged: (text){
                              registerController.changePassword(text);
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter Confirm Password"
                            ),
                            onChanged: (text){
                              registerController.changeConfirmPassword(text);
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 35,),
                          Obx(() {
                            return Card(
                              elevation: 2,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(7)),
                                child: Container(
                                  width: double.infinity,
                                  height: 55.0,
                                  decoration: registerController.fromValid.isTrue?
                                  const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: <Color>[
                                        Color(0xFF6DA0C2),
                                        Color(0xFF13636D),
                                      ],
                                    ),
                                  ):
                                  const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: <Color>[
                                        Color(0xFF416679),
                                        Color(0xFF2F5055),
                                      ],
                                    ),
                                  ),
                                  child: RawMaterialButton(
                                    onPressed: formSubmit,
                                    splashColor: Colors.grey,
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 35,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Have an account?", style: AppTextSize.smallWhite,),
                              const SizedBox(width: 5,),
                              InkWell(
                                onTap: (){
                                  context.back();
                                },
                                child: const Text("Login here",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white
                                  ),),
                              ),
                            ],
                          ),
                          const SizedBox(height: 55,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  void formSubmit(){
    if(registerController.fromValid.isTrue){
      context.registerAccount(
          RegisterPayload(
              registerController.email.value,
              registerController.username.value,
              registerController.password.value
          ),
          (success){
            showSuccessMessage(success);
            Timer.periodic(const Duration(seconds: 2), (timer) {
              timer.cancel();
              context.back();
            });
          },
          (fail){
            showErrorMessage(fail);
          }
      );
    }
  }
}