class SelectedTripModel {
  String? name;
  double rate = 4;
  bool? selected;
  String? uId;


  SelectedTripModel({
    this.name,
    this.selected,
    this.uId,
  });

  SelectedTripModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    rate = json['rate'] ?? 4;
    selected = json['selected'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rate': rate,
      'selected': selected,
      'uId': uId,
    };
  }
}