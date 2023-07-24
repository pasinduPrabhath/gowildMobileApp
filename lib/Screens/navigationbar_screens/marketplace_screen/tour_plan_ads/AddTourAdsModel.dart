class AddTourAdsModel {
  String? adType;
  String? email;
  String? title;
  String? town;
  String? district;
  int? priceFull;
  int? priceHalf;
  String? description;
  int? phoneNum;
  List<String>? imageLinks;
  String? timestamp;
  AddTourAdsModel(
      {this.adType,
      this.email,
      this.title,
      this.town,
      this.district,
      this.priceFull,
      this.priceHalf,
      this.description,
      this.phoneNum,
      this.imageLinks,
      this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'adType': adType,
      'email': email,
      'title': title,
      'price': priceFull,
      'halfPrice': priceHalf,
      'description': description,
      'town': town,
      'district': district,
      'phone_num': phoneNum,
      'imageLinks': imageLinks,
      'timestamp': timestamp,
    };
  }
}
