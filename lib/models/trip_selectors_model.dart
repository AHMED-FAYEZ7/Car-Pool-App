class SelectedTrip {
  String? name;
  double rate = 2.5;
  bool? selected;

  SelectedTrip({
    this.name,
    this.selected,
  });

  SelectedTrip.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    rate = json['rate'] ?? 2.5;
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