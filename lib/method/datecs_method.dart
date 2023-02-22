
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DatecsPrinter {
  static const MethodChannel _channel = MethodChannel('datecs_printer');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> get bluetoothIsEnable async {
    final bool isEnable = await _channel.invokeMethod('isEnabled');
    return isEnable;
  }
  static Future<dynamic> get bluetoothEnable async {
     var isEnable = await _channel.invokeMethod('enable');
    return isEnable;
  }
  
  static Future<List<dynamic>> get getListBluetoothDevice async {
    final List<dynamic>? list = await _channel.invokeMethod('getListBluetoothDevice');
    return list??[];
  }
  static Future<bool> connectBluetooth(String address) async {
    try{
      final bool result = await _channel.invokeMethod('connectBluetooth',{"address":address});
      return result;
    }catch(e){
      return false;
    }

  }

  static Future<void> get printTest async {
    final bool result = await _channel.invokeMethod('testPrint');
    return Future.value();
  }
  static Future<void> get getInformation async {
    final bool result = await _channel.invokeMethod('getInformation');
    return Future.value();
  }

  static Future<void> get printQrCode async {
    final bool result = await _channel.invokeMethod('printQRCode');
    debugPrint(result.toString());

    return Future.value();
  }

  static Future<bool> printText(List<String> args) async {
    try{
      final bool result = await _channel.invokeMethod('printText',{"args":args});
      print(result.toString() + "Print Text");
      return result;
    }catch(e){
      return false;
    }

  }

  static Future<bool> get disconnect async{
    try{
      final bool result = await _channel.invokeMethod('disconnectBluetooth');
      return Future.value(result);
    }on PlatformException catch (e) {
      print("Failed to write bytes: '${e.message}'.");
      return Future.value(false);
    }
  }
}
