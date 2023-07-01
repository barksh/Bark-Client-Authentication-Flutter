class BarkRefreshResponse {
  final String token;

  BarkRefreshResponse({
    required this.token,
  });

  factory BarkRefreshResponse.fromJson(Map<String, dynamic> json) {
    return BarkRefreshResponse(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  @override
  String toString() {
    return 'BarkRefreshResponse{token: $token}';
  }
}
