class UserModel {
  String name;
  String email;
  String? image;
  String? token;
  String password;
  String? confirmPassword;
  String? phone;
  String? visa;
  String? address;
  bool isAdmin;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.token,
    required this.password,
    this.confirmPassword,
    this.phone,
    this.visa,
    this.address,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "Unknown name",
      email: json["email"] ?? "Unknown email",
      password: json["password"] ?? "Unknown password",
      image: json["image"] ?? "Unknown image",
      token: json["accessToken"] ?? "Unknown token",
      confirmPassword: json["confirmPassword"] ?? "Unknown confirmPassword",
      phone: json["phone"] ?? "Unknown phone",
      visa: json["visa"] ?? "Unknown visa",
      address: json["address"] ?? "Unknown address",
      isAdmin: json["isAdmin"] ?? false,
    );
  }
}
