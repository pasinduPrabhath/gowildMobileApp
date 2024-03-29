class ServiceProvider {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? birthday;
  String? country;
  String? town;
  String? district;
  String? mobileNumber;
  String? gender;
  String? nicNumber;
  String? userImageFront;
  String? userImageRear;
  String? isApproved;
  String? profPicUrl;
  String? timestamp;

  ServiceProvider({
    this.firstName,
    this.lastName,
    this.birthday,
    this.country,
    this.town,
    this.district,
    this.email,
    this.password,
    this.mobileNumber,
    this.gender,
    this.nicNumber,
    this.userImageFront,
    this.userImageRear,
    this.isApproved,
    this.profPicUrl,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthday': birthday,
      'country': country,
      'town': town,
      'district': district,
      'email': email,
      'password': password,
      'mobileNumber': mobileNumber,
      'gender': gender,
      'nicNumber': nicNumber,
      'userImageFront': userImageFront,
      'userImageRear': userImageRear,
      'isApproved': isApproved,
      'profPicUrl': profPicUrl,
      'timestamp': timestamp,
    };
  }
}
