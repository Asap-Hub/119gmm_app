class zakatModel{
  String? uid;
  String? zakatNumber;
  String? payerName;
  String? payerNumber;
  String? amount;
  String? refId;
  String? time;
  String? status;
  int? zakatID;
  zakatModel({this.zakatID,this.status,this.time, this.uid,this.payerNumber, this.amount,this.zakatNumber,this.payerName
    ,this.refId});

  //sending data to the server
  Map <String, dynamic> toMap(){
    return{
      'status': status,
      'zakatID': zakatID,
      'uuid': uid,
      'zakatNumber': zakatNumber,
      'payerName': payerName,
      'payerNumber':payerNumber,
      'amount': amount,
      'refId': refId,
    };
  }

  //receiving data from the backend
  factory zakatModel.fromMap(map){
    return zakatModel(
        uid: map["uuid"],
        zakatID: map["zakatID"],
        status: map["status"],
        time: map["time"],
        zakatNumber: map["zakatNumber"],
        payerName: map["payerName"],
        payerNumber: map["payerName"],
        amount: map["amount"],
        refId: map["refId"]
    );
  }
}