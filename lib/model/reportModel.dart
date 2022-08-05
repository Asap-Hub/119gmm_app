class reportModel{
  String? uid;
  String? fullName;
  String? email;
  String? contact;
  String? message;
  String? time;
  reportModel({this.time,this.uid,this.message,this.email,this.contact,this.fullName});

  //sending data to the server
Map<String,dynamic> toMap(){
  return {
    'time':time,
    'uid':uid,
    'fullName': fullName,
    'email': email,
    'contact': contact,
    'message': message,
  };
}
//receiving data from the server
factory reportModel.fromMap(map){
  return reportModel(
    uid: map['uid'],
    time: map['time'],
    fullName: map['fullName'],
    email: map['email'],
    contact:map['contact'],
    message: map['message']
  );
}
}