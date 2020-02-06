import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:canamat8/config.dart';

class BluetoothHandler {

  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothDevice _activeDevice;
  BluetoothConnection _connection;

  static final BluetoothHandler _singleton = BluetoothHandler._internal();

  BluetoothHandler._internal();

  factory BluetoothHandler() {
    return _singleton;
  }

  Future<BluetoothHandler> connectAndListen(Function(String) listener) async {

    bluetoothConnectionState().then((List<BluetoothDevice> devices) async {

      bool found = false;

      print("Number of paired devices: " + devices.length.toString());

      devices.forEach((BluetoothDevice device) async {
        if(device.name == Config.MCU_NAME) {
          found = true;
          _activeDevice = device;
          print('CANAM8 Device found: ' + Config.MCU_NAME);
        }
      });

      if(found) {
        try {
          _connection = await BluetoothConnection.toAddress(_activeDevice.address);
          print('Connected & Listening to the device: ' + _activeDevice.name);

          _connection.input.listen((Uint8List data) {
            print('Data incoming: ${ascii.decode(data)}');
            listener(ascii.decode(data));
          }).onDone(() {
            print('Disconnected by remote request');
            print('Reconnecting in 20 seconds..');
            reconnect(listener);
          });
        }
        catch (exception) {
          print('Cannot connect, exception occured');
          print('Reconnecting in 20 seconds..');
          reconnect(listener);
        }
      } else {
        print("No CANAM8 Device Found. Please Search and Pair first!");
      }
    });

    return this;
  }

  void reconnect(Function(String) listener) {
    new Future.delayed(const Duration(seconds: 20),(){
      connectAndListen(listener);
    });
  }

  Future<List<BluetoothDevice>> bluetoothConnectionState() async {

    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    return devices;
  }

  void switchLedOn(int R, int G, int B) async {
    String data = R.toString() + "," + G.toString() + "," + B.toString();
    _connection.output.add(ascii.encode(data));
  }
}