class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String role;

  const UserModel(
      {this.id,
      required this.email,
      required this.password,
      required this.fullName,
      required this.phoneNo,
      required this.role});

  toJson() {
    return {
      "Full Name": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "Role": role
    };
  }
}
