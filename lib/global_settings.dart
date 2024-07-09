enum UserVariant { internal, external }

class Global {
  static UserVariant name = UserVariant.internal;
  static bool pimpinan = false;
  static bool isExt() {
    return Global.name == UserVariant.external;
  }
}
