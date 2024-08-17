// ignore_for_file: constant_identifier_names

enum RequestMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

extension RequestMethodExtension on RequestMethod {
  String get value {
    switch (this) {
      case RequestMethod.GET:
        return 'GET';
      case RequestMethod.POST:
        return 'POST';
      case RequestMethod.PUT:
        return 'PUT';
      case RequestMethod.PATCH:
        return 'PATCH';
      case RequestMethod.DELETE:
        return 'DELETE';
      default:
        return "";
    }
  }
}
