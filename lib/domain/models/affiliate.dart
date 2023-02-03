
class Affiliate{
  String id;
  String name;
  String country;
  String city;
  String address;
  String idCommercial;

  Affiliate({
    required this.id,
    required this.name,
    required this.country,
    required this.idCommercial,
    required this.city,
    required this.address
  });

  factory Affiliate.fromJson(Map<String,dynamic> json)=>
      Affiliate(
          id: json["id"],
          name: json["legalName"],
          country: json["country"],
          idCommercial: json["idCommercial"],
          city: json["city"],
          address: json["legalAddress"]
      );
}