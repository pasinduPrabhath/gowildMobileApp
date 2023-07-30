class TravelBuddyModel {
  String? email;
  String? place;
  String? district;
  String? date;
  String? content;
  int? noOfParticipants;
  String? timestamp;
  TravelBuddyModel({
    this.email,
    this.place,
    this.district,
    this.date,
    this.content,
    this.noOfParticipants,
    this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      "place": place,
      "district": district,
      "date": date,
      "content": content,
      "noOfParticipants": noOfParticipants,
      "timestamp": timestamp,
    };
  }
}
