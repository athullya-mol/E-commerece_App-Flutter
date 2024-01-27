class UserDataModel {
   String? name;
  String? phone;
  String? address;

  UserDataModel({
    this.name,
    this.phone,
    this.address,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
      name: json['name'], phone: json['phone'], address: json['address']);
}