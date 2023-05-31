class User {
  int? id;
  String? firstName;
  String? lastName;
  String? birthday;
  String? country;
  String? town;
  String? mobileNumber;
  String? gender;
  String? email;
  String? password;
  String? nicNumber;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.birthday,
    this.country,
    this.town,
    this.mobileNumber,
    this.gender,
    this.email,
    this.password,
    this.nicNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'birthday': birthday,
      'country': country,
      'town': town,
      'mobile_number': mobileNumber,
      'gender': gender,
      'email': email,
      'password': password,
      'nic_number': nicNumber,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      birthday: map['birthday'],
      country: map['country'],
      town: map['town'],
      mobileNumber: map['mobile_number'],
      gender: map['gender'],
      email: map['email'],
      password: map['password'],
      nicNumber: map['nic_number'],
    );
  }
}
