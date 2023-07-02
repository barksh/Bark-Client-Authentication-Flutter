class BarkAuthenticationTokenBody {
  final String identifier;
  final bool automation;
  final bool administrator;

  BarkAuthenticationTokenBody({
    required this.identifier,
    required this.automation,
    required this.administrator,
  });

  factory BarkAuthenticationTokenBody.fromMap(Map<String, dynamic> map) {
    return BarkAuthenticationTokenBody(
      identifier: map['identifier'],
      automation: map['automation'],
      administrator: map['administrator'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'automation': automation,
      'administrator': administrator,
    };
  }

  @override
  String toString() =>
      'BarkAuthenticationTokenBody(identifier: $identifier, automation: $automation, administrator: $administrator)';
}
