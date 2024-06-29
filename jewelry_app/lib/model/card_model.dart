class CardModel {
  dynamic id;
  String cardNumber;
  String date;
  String userName;
  String cvv;
  bool isCv;

  CardModel({
    this.id,
    required this.cardNumber,
    required this.date,
    required this.userName,
    required this.cvv,
    required this.isCv,
  });

  factory CardModel.fromMap(Map<String, dynamic> map, {dynamic key}) {
    return CardModel(
      id: key ?? map["id"],
      cardNumber: map["cardNumber"],
      date: map["date"],
      userName: map["userName"],
      cvv: map["cvv"],
      isCv: map["isCv"],
    );
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      "id": key ?? id,
      "cardNumber": cardNumber,
      "date": date,
      "userName": userName,
      "cvv": cvv,
      "isCv": isCv,
    };
  }
}
