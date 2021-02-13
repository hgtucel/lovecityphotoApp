class CityModel {
  String id;
  String title;
  String description;
  String province;
  String county;
  String image;
  String userId;

  CityModel(
      {this.id,
      this.title,
      this.description,
      this.province,
      this.county,
      this.image,
      this.userId});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    province = json['province'];
    county = json['county'];
    image = json['image'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['province'] = this.province;
    data['county'] = this.county;
    data['image'] = this.image;
    data['userId'] = this.userId;
    return data;
  }
}
