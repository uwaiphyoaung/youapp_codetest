
class ProfileCreatePayload {

  String? name;
  String? birthday;
  int? height;
  int? weight;
  List<String>? interests;

  ProfileCreatePayload(this.name, this.birthday, this.height, this.weight, this.interests);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['birthday'] = birthday;
    data['height'] = height;
    data['weight'] = weight;
    if(interests != null){
      data['interests'] = interests!.map((e)=>e).toList();
    }
    return data;
  }

  ProfileCreatePayload.fromMap(Map<String, dynamic> value){
    name = value['name'];
    birthday = value['birthday'];
    height = value['height'];
    weight = value['weight'];
    interests = value['interests'].cast<String>();
  }

}