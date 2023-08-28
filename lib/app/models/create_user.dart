class CreateUser {
  User? user;
  UserAdress? userAdress;
  UserLogin? userLogin;

  CreateUser({this.user, this.userAdress, this.userLogin});

  CreateUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userAdress = json['userAdress'] != null
        ? new UserAdress.fromJson(json['userAdress'])
        : null;
    userLogin = json['userLogin'] != null
        ? new UserLogin.fromJson(json['userLogin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.userAdress != null) {
      data['userAdress'] = this.userAdress!.toJson();
    }
    if (this.userLogin != null) {
      data['userLogin'] = this.userLogin!.toJson();
    }
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? birthDate;
  String? telephone;
  String? profilePicture;

  User(
      {this.firstName,
      this.lastName,
      this.birthDate,
      this.telephone,
      this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthDate = json['birthDate'];
    telephone = json['telephone'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['birthDate'] = this.birthDate;
    data['telephone'] = this.telephone;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}

class UserAdress {
  String? streetName;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  UserAdress(
      {this.streetName, this.city, this.state, this.postalCode, this.country});

  UserAdress.fromJson(Map<String, dynamic> json) {
    streetName = json['streetName'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetName'] = this.streetName;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}

class UserLogin {
  String? email;
  String? password;

  UserLogin({this.email, this.password});

  UserLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
