class infaqModel{
  String? uid;
  String? infaqNumber;
  String? payerName;
  String? payerNumber;
  String? amount;
  String? refId;
  String? time;
  String? status;
  infaqModel({this.status,this.time, this.uid,this.payerNumber, this.amount,this.infaqNumber,this.payerName
  ,this.refId});

  //sending data to the server
  Map <String, dynamic> toMap(){
    return{
      'status': status,
      'time': time,
      'uuid': uid,
      'infaqNumber': infaqNumber,
      'payerName': payerName,
      'payerNumber':payerNumber,
      'amount': amount,
      'refId': refId,
    };
  }

  //receiving data from the backend
  factory infaqModel.fromMap(map){
    return infaqModel(
      uid: map["uuid"],
      status: map["status"],
      time: map["time"],
      infaqNumber: map["infaqNumber"],
      payerName: map["payerName"],
      payerNumber: map["payerName"],
      amount: map["amount"],
      refId: map["refId"]
    );
  }
}