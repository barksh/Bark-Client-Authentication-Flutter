class BarkRedeemResponse {
  final String refreshToken;

  BarkRedeemResponse({
    required this.refreshToken,
  });

  factory BarkRedeemResponse.fromJson(Map<String, dynamic> json) {
    return BarkRedeemResponse(
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return 'BarkRedeemResponse{refreshToken: $refreshToken}';
  }
}
