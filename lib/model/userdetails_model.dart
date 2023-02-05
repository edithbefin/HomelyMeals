class UserDetailsModel {
  final String name;
  final String location;

  UserDetailsModel({required this.name, required this.location});
  Map<String, dynamic> getJson() => {
        "name": name,
        "location": location,
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"], location: json["location"]);
  }
}
