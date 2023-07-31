class InterestedUser {
  final int userId;
  final String firstName;
  final String lastName;
  final String profilePictureUrl;
  final String email;
  final String country;
  final String town;

  InterestedUser({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.email,
    required this.country,
    required this.town,
  });

  factory InterestedUser.fromJson(Map<String, dynamic> json) {
    return InterestedUser(
      userId: json['user_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePictureUrl: json['profile_picture_url'],
      email: json['email'],
      country: json['country'],
      town: json['town'],
    );
  }
}
