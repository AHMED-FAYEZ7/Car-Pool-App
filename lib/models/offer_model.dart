class OfferModel {
  String? name;
  String? uId;
  String? dateTime;
  String? pickUpLocation;
  String? dropOffLocation;

  OfferModel({
    this.name,
    this.pickUpLocation,
    this.uId,
    this.dateTime,
    this.dropOffLocation,
  });

  OfferModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    pickUpLocation = json['pickUpLocation'];
    dropOffLocation = json['dropOffLocation'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'dateTime':dateTime,
      'text':pickUpLocation,
      'postImage':dropOffLocation,
    };
  }
}