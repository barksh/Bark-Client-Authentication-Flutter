class BarkAuthenticationTokenHeader {
  final String alg;
  final String typ;
  final String aud;
  final int exp;
  final String jti;
  final String kty;
  final int iat;
  final String iss;
  final String purpose;

  BarkAuthenticationTokenHeader({
    required this.alg,
    required this.typ,
    required this.aud,
    required this.exp,
    required this.jti,
    required this.kty,
    required this.iat,
    required this.iss,
    required this.purpose,
  });

  factory BarkAuthenticationTokenHeader.fromMap(Map<String, dynamic> map) {
    return BarkAuthenticationTokenHeader(
      alg: map['alg'],
      typ: map['typ'],
      aud: map['aud'],
      exp: map['exp'],
      jti: map['jti'],
      kty: map['kty'],
      iat: map['iat'],
      iss: map['iss'],
      purpose: map['purpose'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alg': alg,
      'typ': typ,
      'aud': aud,
      'exp': exp,
      'jti': jti,
      'kty': kty,
      'iat': iat,
      'iss': iss,
      'purpose': purpose,
    };
  }

  @override
  String toString() {
    return 'BarkAuthenticationTokenHeader(alg: $alg, typ: $typ, aud: $aud, exp: $exp, jti: $jti, kty: $kty, iat: $iat, iss: $iss, purpose: $purpose)';
  }
}
