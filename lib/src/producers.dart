import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';

class Producers {
  static Producers _instance = Producers._internal();

  factory Producers() {
    return _instance;
  }

  Producers._internal();

  Producer? mic;
  Producer? webcam;
  Producer? screen;
  DataProducer? chatDataProducer;
  DataProducer? botDataProducer;


}