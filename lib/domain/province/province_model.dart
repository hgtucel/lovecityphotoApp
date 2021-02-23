class ProvinceModel {
  int id;
  String key;
  String title;
  String country;

  ProvinceModel({this.id, this.key, this.title, this.country});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    title = json['title'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['title'] = this.title;
    data['country'] = this.country;
    return data;
  }
}
