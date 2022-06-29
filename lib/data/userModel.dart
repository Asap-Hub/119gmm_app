class UserModel {
  String? uid;

  //credentials
  String? email;
  String? password;
  String? confirmPassword;
  String? number;

  //personal
  String? firstName;
  String? secondName;
  String? dateOfBirth;
  String? homeTown;
  String? residentialAddress;
  String? region;
  String? district;
  String? branches;
  String? group;

//marital
  String? profession;
  String? numberOfDependent;
  String? nameOfMuslimChildren;
  String? nameOfNonMuslimChildren;
  String? numberOfWive;
  String? numberOfFemaleChildren;
  String? numberOfMaleChildren;
  String? maritalStatus;

  UserModel(
      {this.uid,
      this.email,
      this.password,
      this.confirmPassword,
      this.number,
      this.firstName,
      this.secondName,
      this.dateOfBirth,
      this.homeTown,
      this.residentialAddress,
      this.region,
      this.district,
      this.branches,
      this.group,
      this.profession,
      this.numberOfDependent,
      this.nameOfMuslimChildren,
      this.nameOfNonMuslimChildren,
      this.numberOfWive,
      this.numberOfMaleChildren,
      this.numberOfFemaleChildren,
      this.maritalStatus});

//receiving data to the server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        password: map['password'],
        confirmPassword: map['confirmPassword'],
        number: map['number'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        dateOfBirth: map['dateOfBirth'],
        homeTown: map['homeTown'],
        residentialAddress: map["residentialAddress"],
        region: map['region'],
        district: map['district'],
        branches: map['branches'],
        group: map['group'],
        profession: map['profession'],
        numberOfDependent: map['numberOfDependent'],
        nameOfMuslimChildren: map['nameOfMuslimChildren'],
        nameOfNonMuslimChildren: map['nameOfNonMuslimChildren'],
        numberOfWive: map['numberOfWive'],
        numberOfMaleChildren: map['numberOfMaleChildren'],
        numberOfFemaleChildren: map['numberOfFemaleChildren'],
        maritalStatus: map['maritalStatus']);
  }

//sending data to the server
  Map<String, dynamic>? toMap() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'number': number,
      'firstName': firstName,
      'secondName': secondName,
      'dateOfBirth': dateOfBirth,
      'homeTown': homeTown,
      'residentialAddress': residentialAddress,
      'region': region,
      'district': district,
      'branches': branches,
      'group': group,
      'profession': profession,
      'numberOfDependent': numberOfDependent,
      'nameOfMuslimChildren': nameOfMuslimChildren,
      'nameOfNonMuslimChildren': nameOfNonMuslimChildren,
      'numberOfWive': numberOfWive,
      'numberOfMaleChildren': numberOfMaleChildren,
      'numberOfFemaleChildren': numberOfFemaleChildren,
      'maritalStatus': maritalStatus
    };
  }
}
