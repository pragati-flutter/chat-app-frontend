import 'dart:io';

class AppConstants {
  static String get wsUrl {
    if (Platform.isAndroid) {
      // 👇 Detect emulator vs real device automatically
      return 'ws://10.0.2.2:8080'; // fallback for emulator
    }
    return  'ws://192.168.1.46:8080';
     // real device
  }
}