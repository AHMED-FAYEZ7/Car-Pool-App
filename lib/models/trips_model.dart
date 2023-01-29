  class TripsModel {
  String? name;
  String? uId;
  String? dateTime;
  int? numberOfSeats;
  String? pickUpLocation;
  String? dropOffLocation;

    TripsModel({
    this.name,
    this.pickUpLocation,
    this.numberOfSeats,
    this.uId,
    this.dateTime,
    this.dropOffLocation,
  });

    TripsModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    numberOfSeats = json['numberOfSeats'];
    dateTime = json['dateTime'];
    pickUpLocation = json['pickUpLocation'];
    dropOffLocation = json['dropOffLocation'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'numberOfSeats':numberOfSeats,
      'dateTime':dateTime,
      'text':pickUpLocation,
      'postImage':dropOffLocation,
    };
  }
}