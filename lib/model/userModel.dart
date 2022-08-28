class UserModel {
  String? uid;
  String? url;

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
  String? nameOfPrimarySchool;
  String? nameOfJuniorHighSchool;
  String? nameOfSeniorHighSchool;

  //student info.
  String? nameOfTertiary;
  String? startingYear;
  String? completingYear;
  String? locationOfCampus;
  String? addressOfCampus;
  String? programme;
  String? department;

  //employee staus
  bool? value;
  String? liveAfterSchool;

  //jobType
  String? publicDepartment;
  String? position;
  String? yearsInPosition;
  String? publicAddress;
  String? publicLocation;
  String? nameOfCompany;
  String? role;
  String? privateLocation;
  String? privateAddress;
  String? contact;

  UserModel({
    this.uid,
    this.url,
    this.locationOfCampus,
    this.addressOfCampus,
    this.programme,
    this.department,
    this.email,
    this.password,
    this.confirmPassword,
    this.nameOfPrimarySchool,
    this.nameOfJuniorHighSchool,
    this.nameOfSeniorHighSchool,
    this.number,
    this.nameOfTertiary,
    this.startingYear,
    this.completingYear,
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
    this.maritalStatus,
    this.value,
    this.liveAfterSchool,
    //job
    this.publicDepartment,
    this.position,
    this.yearsInPosition,
    this.publicAddress,
    this.publicLocation,
    this.nameOfCompany,
    this.role,
    this.privateLocation,
    this.privateAddress,
    this.contact,
  });

//receiving data to the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      url: map['url'],
      email: map['email'],
      locationOfCampus: map["locationOfCampus"],
      addressOfCampus: map["addressOfCampus"],
      programme: map["programme"],
      department: map["department"],
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
      maritalStatus: map['maritalStatus'],
      nameOfPrimarySchool: map['nameOfPrimarySchool'],
      nameOfJuniorHighSchool: map['nameOfJuniorHighSchool'],
      nameOfSeniorHighSchool: map['nameOfSeniorHighSchool'],
      nameOfTertiary: map["nameOfTertiary"],
      startingYear: map["startingYear"],
      completingYear: map["completingYear"],
      value: map["value"],
      liveAfterSchool: map["liveAfterSchool"],
      //job
      publicDepartment: map["publicDepartment"],
      position: map["position"],
      yearsInPosition: map["yearsInPosition"],
      publicAddress: map["publicAddress"],
      publicLocation: map["publicLocation"],
      nameOfCompany: map["nameOfCompany"],
      role: map["role"],
      privateLocation: map["privateLocation"],
      privateAddress: map["privateAddress"],
      contact: map["contact"],
    );
  }

//sending data to the server
  Map<String, dynamic> toMap() {
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
      'maritalStatus': maritalStatus,
      'nameOfTertiary': nameOfTertiary,
      'nameOfPrimarySchool': nameOfPrimarySchool,
      'nameOfJuniorHighSchool': nameOfJuniorHighSchool,
      'nameOfSeniorHighSchool': nameOfSeniorHighSchool,
      'startingYear': startingYear,
      'completingYear': completingYear,
      'locationOfCampus': locationOfCampus,
      'addressOfCampus': addressOfCampus,
      'programme': programme,
      'department': department,
      'value': value,
      'liveAfterSchool': liveAfterSchool,
      //job
      'publicDepartment':publicDepartment,
      'position':position,
      'yearsInPosition': yearsInPosition,
      'publicAddress':publicAddress,
      'publicLocation':publicLocation,
      'nameOfCompany':nameOfCompany,
      'role':role,
      'privateLocation':privateLocation,
      'privateAddress':privateAddress,
      'contact':contact,
    };
  }
}
