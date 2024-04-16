class DescribeCustomer {
     String? email;
     String? phone;
     Map<String, dynamic>? custom;
          
  DescribeCustomer({this.email,this.phone, this.custom});

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'custom': custom,
      };
}
