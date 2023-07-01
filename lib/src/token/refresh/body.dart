class BarkRefreshTokenBody {
  final String identifier;
  final String inquiry;

  BarkRefreshTokenBody({
    required this.identifier,
    required this.inquiry,
  });

  factory BarkRefreshTokenBody.fromMap(Map<String, dynamic> map) {
    return BarkRefreshTokenBody(
      identifier: map['identifier'],
      inquiry: map['inquiry'],
    );
  }
}
