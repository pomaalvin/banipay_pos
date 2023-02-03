class QrResponse{
  num amount;
  String currency;
  String image;
  String code;

  QrResponse(
  {
    required this.amount,
    required this.currency,
    required this.image,
    required this.code
});
  factory QrResponse.fromJson(Map<String,dynamic> json)=>
      QrResponse(
          amount: json["amount"],
          currency: json["currency"],
          image: json["image"],
          code: json["code"]
      );
}