class PetModel {
  int? id;
  int? idUser;
  String? name;
  String? race;
  String? location;
  String? description;
  String? age;
  String? petPicture;
  String? firstName;
  String? lastName;
  String? profilePicture;

  PetModel(
      {this.id,
      this.idUser,
      this.name,
      this.race,
      this.location,
      this.description,
      this.age,
      this.petPicture,
      this.firstName,
      this.lastName,
      this.profilePicture});

  PetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    name = json['name'];
    race = json['race'];
    location = json['location'];
    description = json['description'];
    age = json['age'];
    petPicture = json['petPicture'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUser'] = this.idUser;
    data['name'] = this.name;
    data['race'] = this.race;
    data['location'] = this.location;
    data['description'] = this.description;
    data['age'] = this.age;
    data['petPicture'] = this.petPicture;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}