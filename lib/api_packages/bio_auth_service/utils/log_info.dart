import 'dart:developer';

void logError(String error) {
  log(error, name: "[BioAuth: Error]");
}

void logInfo(String info) {
  log(info, name: "[BioAuth: Info]");
}

void logWarning(String warning) {
  log(warning, name: "[BioAuth: Warning]");
}

void logDebug(String debug) {
  log(debug, name: "[BioAuth: Debug]");
}

extension LogExtension on String {
  void logError() {
    log(this, name: "[BioAuth: Error]");
  }

  void logInfo() {
    log(this, name: "[BioAuth: Info]");
  }

  void logWarning() {
    log(this, name: "[BioAuth: Warning]");
  }

  void logDebug() {
    log(this, name: "[BioAuth: Debug]");
  }
}
