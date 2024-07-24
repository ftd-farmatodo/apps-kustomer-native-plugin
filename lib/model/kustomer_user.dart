class KustomerUser {
    String token;
    String? email;
    String? firstName;
    String? lastName;
    String? phone;
    String? documentNumber;
          
  KustomerUser({
    required this.token,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.documentNumber,
  });

  KustomerUser.annonimousUser({
    this.token = '',
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'token': token,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'documentNumber': documentNumber,
      };
}