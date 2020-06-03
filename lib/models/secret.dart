class Secret {
  final String ethPrivate;
  final String ethAddress;
  const Secret(this.ethPrivate, this.ethAddress);
  Secret.fromJson(Map<String, dynamic> parsedJson)
    : ethPrivate = parsedJson['ethPrivate'],
      ethAddress = parsedJson['ethAddress'];
  Map<String, dynamic> toJson() =>
      {
        'ethPrivate': ethPrivate,
        'ethAddress': ethAddress,
      };
}
