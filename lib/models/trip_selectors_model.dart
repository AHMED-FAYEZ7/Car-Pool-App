class SelectedTrip {
  String? name;
  String? rate;
  bool? selected;

  SelectedTrip({
    this.name,
    this.rate,
    this.selected,
  });

  SelectedTrip.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    rate = json['rate'];
    selected = json['selected'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rate': rate,
      'selected': selected,
    };
  }
}