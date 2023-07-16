class Profile {
  final String firstName;
  final String lastName;
  final String dpUrl;
  final int userId;

  // final String? email;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.dpUrl,
    required this.userId,
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
      dpUrl: json['profile_picture_url'],
      userId: json['user_id'],
    );
  }
}
