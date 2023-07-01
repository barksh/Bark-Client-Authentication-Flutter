class BarkInquiryResponse {
  final String exposureKey;
  final String hiddenKey;

  BarkInquiryResponse({
    required this.exposureKey,
    required this.hiddenKey,
  });

  factory BarkInquiryResponse.fromJson(Map<String, dynamic> json) {
    return BarkInquiryResponse(
      exposureKey: json['exposureKey'],
      hiddenKey: json['hiddenKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exposureKey': exposureKey,
      'hiddenKey': hiddenKey,
    };
  }

  @override
  String toString() {
    return 'BarkInquiryResponse{exposureKey: $exposureKey, hiddenKey: $hiddenKey}';
  }
}
