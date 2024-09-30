class Country {
  String? name;
  String? flag;
  String? iso2;
  String? iso3;

  Country({this.name, this.flag, this.iso2, this.iso3});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    flag = json['flag'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['flag'] = this.flag;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    return data;
  }
}
