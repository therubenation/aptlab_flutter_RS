// import 'package:flutter/material.dart';
import 'dart:ffi';

import '../settings/settings_controller.dart';
import 'package:libserialport/libserialport.dart';
// import 'dart:convert' show utf8;
import 'dart:convert'; //show json;

import 'dart:io';
import 'dart:async';

import 'dart:typed_data';

class SelectSerialPort {
  SelectSerialPort({required this.controller});

  static const routeName = '/serial';
  final SettingsController controller;
  final StringBuffer _output = StringBuffer();
  // default port name; call ListPorts to select first Espressif serial port
  // as the device port
  String serialPortSelected = "/dev/ttyACM0";
  var dataReceived = '';
  var isConnected = 0;
  FutureOr<bool> waitReceived = true;

  sendToPort() async {
    try {
      listPorts();
      print('detected device port: $serialPortSelected');
      SerialPort port = SerialPort(serialPortSelected);
      port.openReadWrite();
      // port.flush(SerialPortBuffer.both);
      SerialPortReader reader = SerialPortReader(port, timeout: 10000);
      if (port.isOpen) print('Port open');
      //String source = 'swvlp \n\r';
      String source = '\n\r ${controller.cmdString.toString()} \n\r';
      print('sending:  $source');
      List<int> list = utf8.encode(source);
      Uint8List bytes = Uint8List.fromList(list);
      // port.flush(SerialPortBuffer.both);
      String fullResponse = '';
      // StreamSubscription subscription;
      // Pre-declare variable (can't be final, and with null safety
      // it has to be late).
      late StreamSubscription<Uint8List> subscription;
      // final subscription = Stream.listen(null);
      subscription = reader.stream.listen((data) {
        String decodedResponse = utf8.decode(data);
        fullResponse += decodedResponse;
        // print('Got data chunk ${fullResponse.length}');

        if (fullResponse.contains(']]')) {
          dataReceived = fullResponse.trim();
          var searchString = 'swv=';
          var searchString2 = ']]';
          var index = dataReceived.indexOf(searchString);
          var index2 = dataReceived.indexOf(searchString2);
          var dataStr = dataReceived.substring(index, index2 - 3);
          dataStr = dataStr + ']]';
          dataStr = dataStr.replaceAll("\n", "");
          dataStr = dataStr.replaceAll("\r", "");
          print(dataStr);
          controller.updateDataString(dataStr);
          subscription.cancel();
          port.close();
          port.dispose();
        }
      });
      print('sending ${port.write(bytes)} bytes');
      // Future.delayed(const Duration(milliseconds: 5000), () {
      //   waitReceived = false;
      // });
      // await Future.doWhile(() => waitReceived);
      // print('data received or timeout, closing the port now');
      // port.close();
      // port.dispose();
    } on SerialPortError catch (err, _) {
      print(SerialPort.lastError);
    } on Exception {
      print('Exception'); // only executed if error is of type Exception
    } catch (error) {
      print('error!!'); // executed for errors of all types other than Exception
    }
  }

  listPorts() {
// ignore_for_file: avoid_print
    print('Available ports:');
    var i = 0;
    for (final name in SerialPort.availablePorts) {
      final sp = SerialPort(name);
      print('${++i}) $name');
      print('\tDescription: ${sp.description}');
      print('\tManufacturer: ${sp.manufacturer}');
      print('\tSerial Number: ${sp.serialNumber}');
      // print('\tProduct ID: 0x${sp.productId!.toRadixString(16)}');
      // print('\tVendor ID: 0x${sp.vendorId!.toRadixString(16)}');
      if (sp.manufacturer == "Espressif") {
        serialPortSelected = name;
      }

      sp.dispose();
    }
    // print('detected device port:' + serialPortSelected);
  }
}
