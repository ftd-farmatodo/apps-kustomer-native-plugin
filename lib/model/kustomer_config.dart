class KustomerConfig {
  String brandId;
  String apiKey;

  KustomerConfig({required this.brandId, required this.apiKey});

  Map<String, dynamic> toJson() => {
        'brandId': brandId,
        'apiKey': apiKey,
      };
}
