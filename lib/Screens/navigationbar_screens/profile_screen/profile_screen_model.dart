class Profile {
  final String firstName;
  final String lastName;

  // final String? email;

  Profile({
    required this.firstName,
    required this.lastName,
  });

  // Profile fromJson(Map<String, dynamic> json) {
  //   return Profile(
  //     firstName = json['firstName'],
  //     lastName = json['lastName'],
  //   );
  // }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
