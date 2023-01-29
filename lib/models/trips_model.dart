  class TripsModel {
  String? name;
  String? uId;
  String? phone;
  String? dateTime;
  int? numberOfSeats;
  String? pickUpLocation;
  String? dropOffLocation;

    TripsModel({
    this.name,
    this.phone,
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
    phone = json['phone'];
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
      'phone':phone,
      'numberOfSeats':numberOfSeats,
      'dateTime':dateTime,
      'pickUpLocation':pickUpLocation,
      'dropOffLocation':dropOffLocation,
    };
  }
}