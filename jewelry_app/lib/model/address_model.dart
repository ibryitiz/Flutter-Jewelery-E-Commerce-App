class AddressModel {
  dynamic id;
  String name;
  String surname;
  String city;
  String district;
  String address;

  AddressModel({
    this.id,
    required this.name,
    required this.surname,
    required this.city,
    required this.district,
    required this.address,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map, {dynamic key}) {
    return AddressModel(
      id: key ?? map["id"],
      name: map['name'],
      surname: map['surname'],
      city: map['city'],
      district: map['district'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      "id": key ?? id,
      "name": name,
      "surname": surname,
      "city": city,
      "district": district,
      "address": address,
    };
  }
}
