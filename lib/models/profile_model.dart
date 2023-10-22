class ProfileModel {
  String? name;
  String? phoneNumber;
  String? address;
  String? message;

  ProfileModel({this.name, this.phoneNumber, this.address, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    address = json['address'] ?? "";
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['message'] = this.message;
    return data;
  }
}
