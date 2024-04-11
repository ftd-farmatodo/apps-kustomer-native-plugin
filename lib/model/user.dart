class User {
  String email;
  String token;
  String? firstName;
  String? lastName;
  String? phone;
  String? documentNumber;
  User(
      {this.firstName,
      this.lastName,
      this.phone,
      this.documentNumber,
      required this.email,
      required this.token});

  Map<String, dynamic> toJson() => {
        'email': email,
        'token': token,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'documentNumber': documentNumber,
      };
}
