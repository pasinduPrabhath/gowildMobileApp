class PhotoSellingModel {
  String? adType;
  String? email;
  String? title;
  String? town;
  String? district;
  int? price;
  String? description;
  int? phoneNum;
  List<String>? imageLinks;
  String? timestamp;
  PhotoSellingModel(
      {this.adType,
      this.email,
      this.title,
      this.town,
      this.district,
      this.price,
      this.description,
      this.phoneNum,
      this.imageLinks,
      this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'adType': adType,
      'email': email,
      'title': title,
      'price': price,
      'description': description,
      'town': town,
      'district': district,
      'phone_num': phoneNum,
      'imageLinks': imageLinks,
      'timestamp': timestamp,
    };
  }
}
