class Movement{
  int id;
  String nameOrSocialReason;
  String paymentStatus;
  String currency;
  String paymentMethod;
  num paymentAmount;
  DateTime paymentDate;

  Movement(
      {
        required this.id,
        required this.nameOrSocialReason,
        required this.paymentStatus,
        required this.currency,
        required this.paymentMethod,
        required this.paymentAmount,
        required this.paymentDate
}
      );

  factory Movement.fromJson(Map<String,dynamic> json)=>
      Movement(
          id: json["id"]??0,
          nameOrSocialReason: json["nameOrSocialReason"]??"",
          paymentStatus: json["paymentStatus"]??"",
          currency: json["currency"]??"",
          paymentMethod: json["paymentMethod"]??"",
          paymentAmount: json["paymentAmount"]??0,
          paymentDate: json["paymentDate"]!=null?DateTime.fromMillisecondsSinceEpoch(json["paymentDate"]):DateTime.now()
      );
}