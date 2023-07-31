class Request {
  final int userId;
  final int postId;
  final String place;
  final String district;
  final DateTime date;
  final String content;
  final String firstName;
  final String lastName;
  final String profilePictureUrl;
  final String timestamp;
  final int noOfParticipants;
  final String email;
  final int isLiked;
  final int approvedCount;

  Request({
    required this.userId,
    required this.postId,
    required this.place,
    required this.district,
    required this.date,
    required this.content,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.noOfParticipants,
    this.isLiked = 0,
    this.timestamp = '',
    this.email = '',
    required this.approvedCount,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userId: json['user_id'],
      postId: json['travel_post_ID'],
      place: json['place'],
      district: json['district'],
      date: DateTime.parse(json['date']),
      content: json['content'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePictureUrl: json['profile_picture_url'],
      email: json['email'],
      noOfParticipants: json['no_of_participants'],
      isLiked: json['isLiked'],
      approvedCount: json['approvedCount'],
      timestamp: json['timestamp'],
    );
  }
}
