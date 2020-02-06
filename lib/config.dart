class Config {

  // backend
  static const String API_ENDPOINT = 'http://192.168.22.3/api';
  static const String ACCESS_TOKEN = '9WXsmxtJ9Y1CtfZVJ9gTMxy0Cs2A5eaSQOqYwuvq5uGZ3T5ai5trpQcjeVvBy3Lu6KZtoRqqzCYAb0kH';
  static const int SERVER_PORT = 4046;

  // not used now since we moved to full bluetooth instead of tcp
  // LED Micro controller
  static const String LED_API = 'http://192.168.22.16:4046';
  static const String LED_API_TOKEN = 'sky';

  // Bluetooth Config
  static const String MCU_NAME = "ESP32_CANAM8";
}