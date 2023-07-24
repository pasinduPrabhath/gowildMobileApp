class MarketPlaceAdd {
  String? email;
  String? title;
  String? town;
  String? district;
  int? price;
  String? description;
  int? phoneNum;
  List<String>? imageLinks;
  String? adType;
  String? timestamp;
  MarketPlaceAdd(
      {this.email,
      this.title,
      this.town,
      this.district,
      this.price,
      this.description,
      this.phoneNum,
      this.imageLinks,
      this.adType,
      this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'title': title,
      'price': price,
      'description': description,
      'town': town,
      'district': district,
      'phone_num': phoneNum,
      'imageLinks': imageLinks,
      'adType': adType,
      'timestamp': timestamp,
    };
  }
}
