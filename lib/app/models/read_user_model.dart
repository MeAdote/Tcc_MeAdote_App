class ReadUserModel {
  String? firstName;
  String? lastName;
  String? telephone;
  String? email;
  String? userPicture;
  List<PetUsersDto>? petUsersDto;

  ReadUserModel(
      {this.firstName,
      this.lastName,
      this.telephone,
      this.email,
      this.userPicture,
      this.petUsersDto});

  ReadUserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    telephone = json['telephone'];
    email = json['email'];
    userPicture = json['userPicture'];
    if (json['petUsersDto'] != null) {
      petUsersDto = <PetUsersDto>[];
      json['petUsersDto'].forEach((v) {
        petUsersDto!.add(new PetUsersDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lasName'] = this.lastName;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['userPicture'] = this.userPicture;
    if (this.petUsersDto != null) {
      data['petUsersDto'] = this.petUsersDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetUsersDto {
  String? name;
  String? petPicture;

  PetUsersDto({this.name, this.petPicture});

  PetUsersDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    petPicture = json['petPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['petPicture'] = this.petPicture;
    return data;
  }
}