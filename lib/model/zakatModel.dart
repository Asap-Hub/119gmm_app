class zakatModel{
  String? uid;
  String? zakatNumber;
  String? payerName;
  String? payerNumber;
  String? amount;
  String? tranID;
  String? time;
  String? status;
  String? zakatID;
  zakatModel({this.zakatID,this.status,this.time, this.uid,this.payerNumber, this.amount,this.zakatNumber,this.payerName
    ,this.tranID});

  //sending data to the server
  Map <String, dynamic> toMap(){
    return{
      'status': status,
      'time': time,
      'zakatID': zakatID,
      'uuid': uid,
      'zakatNumber': zakatNumber,
      'payerName': payerName,
      'payerNumber':payerNumber,
      'amount': amount,
      'transactionID': tranID,
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
        tranID: map["transactionID"]
    );
  }
}