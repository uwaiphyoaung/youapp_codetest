import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youapp_code_challenge/app/base/base_screen.dart';
import 'package:youapp_code_challenge/app/constants/app.textsize.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/models/auth_entity.dart';
import 'package:youapp_code_challenge/screen/auth/controller/auth_controller.dart';
import 'package:youapp_code_challenge/screen/auth/register_screen.dart';
import 'package:youapp_code_challenge/screen/auth/controller/requesting_authorization.dart';
import 'package:youapp_code_challenge/screen/widget/background_widget.dart';
import 'package:youapp_code_challenge/utils/util_validate.dart';

class LoginScreen extends BaseScreen{
  const LoginScreen({super.key});

  @override
  LoginScreenState createState()=> LoginScreenState();
}

class LoginScreenState extends BaseScreenState<LoginScreen>{
  final loginController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            const BgView(),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 75,),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Login", style: AppTextSize.largeWhite,),
                      ),
                      const SizedBox(height: 55,),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter Username/Email"
                        ),
                        validator: (text) {
                          return UtilValidate.validateBasic(text);
                        },
                        onChanged: (text){
                          loginController.changeLoginEmail(text);
                        },
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter Password"
                        ),
                        validator: (text) {
                          return UtilValidate.validateBasic(text);
                        },
                        onChanged: (text){
                          loginController.changeLoginPassword(text);
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
                              decoration: loginController.loginForm.isTrue?
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
                                  "Login",
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
                          const Text("No account?", style: AppTextSize.smallWhite,),
                          const SizedBox(width: 5,),
                          InkWell(
                            onTap: (){
                              context.next(const RegisterScreen());
                            },
                            child: const Text("Register here",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white
                              ),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 55,),
                    ],
                  )
              ),
            )
          ],
        ),
      )
    );
  }

  void formSubmit(){
    if(loginController.loginForm.isTrue){
      context.loginAccount(
          RegisterPayload(
              loginController.loginEmail.value,
              loginController.loginEmail.value,
              loginController.loginPassword.value
          ),
          (error){
            showErrorMessage(error);
          }
      );
    }
  }
}