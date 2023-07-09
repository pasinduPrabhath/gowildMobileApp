class User {
  // int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? birthday;
  String? country;
  String? town;
  String? mobileNumber;
  String? gender;
  String? profPicUrl;
  String? timestamp;

  User({
    // this.id,
    this.firstName,
    this.lastName,
    this.birthday,
    this.country,
    this.town,
    this.mobileNumber,
    this.gender,
    this.email,
    this.password,
    this.profPicUrl,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'birthday': birthday,
      'country': country,
      'town': town,
      'mobileNumber': mobileNumber,
      'gender': gender,
      'email': email,
      'password': password,
      'profPicUrl': profPicUrl,
      'timestamp': timestamp,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      // id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      birthday: map['birthday'],
      country: map['country'],
      town: map['town'],
      mobileNumber: map['mobileNumber'],
      gender: map['gender'],
      email: map['email'],
      password: map['password'],
      profPicUrl: map['profPicUrl'],
      timestamp: DateTime.parse(map['timestamp'])
          .toLocal()
          .add(const Duration(hours: 5, minutes: 30))
          .toString(),
    );
  }
}
