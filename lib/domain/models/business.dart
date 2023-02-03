import 'package:banipay_pos/domain/models/affiliate.dart';

class Business {
  String id;
  String name;
  List<Affiliate> affiliates;
  Business({
    required this.id,
    required this.name,
    required this.affiliates
});
  factory Business.fromJson(Map<String,dynamic> json)=>
      Business(
          id: json["id"],
          name: json["legalName"],
        affiliates: List.from(json["affiliates"].map((e)=>Affiliate.fromJson(e)))
      );
}