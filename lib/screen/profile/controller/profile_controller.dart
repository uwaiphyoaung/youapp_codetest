import 'package:get/get.dart';
import 'package:youapp_code_challenge/app/services/account_services.dart';
import 'package:youapp_code_challenge/models/profile_entity.dart';

class ProfileController extends GetxController{

  AccountService service = AccountService();

  //Edit About
  final clickEditAbout = false.obs;
  clickEdit(){
    clickEditAbout(!clickEditAbout.value);
  }

  final gender = "".obs;
  changeGender(s){
    gender(s);
  }

  Rxn<DateTime> dob = Rxn<DateTime>();
  changeDob(s){
    dob(s);
  }

  final name = ''.obs;
  changeName(String? data) {
    name(data);
  }

  Rxn<String> height = Rxn<String>();
  changeHeight(String? data) {
    height(data);
  }

  Rxn<String> weight = Rxn<String>();
  changeWeight(String? data) {
    weight(data);
  }

  Rxn<ProfileCreatePayload> localProfile = Rxn<ProfileCreatePayload>();
  syncLocal() async{
    localProfile(await service.loadUserData());
  }

}