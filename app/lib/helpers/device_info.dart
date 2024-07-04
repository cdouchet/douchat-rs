import 'dart:io';

import 'package:api/api.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static final DeviceInfo instance = DeviceInfo._internal();

  DeviceInfo._internal();

  final deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    if (Platform.isIOS) {
      final id = (await deviceInfoPlugin.iosInfo).identifierForVendor;
      if (id == null) {
        throw Exception("Error getting ios device uuid");
      }
      return id;
    } else if (Platform.isAndroid) {
      return (await deviceInfoPlugin.androidInfo).id;
    }
    throw Exception("getDeviceId is only supported on iOS or Android");
  }

  Future<String> getDeviceName() async {
    assert(Platform.isIOS || Platform.isAndroid);
    if (Platform.isIOS) {
      return (await deviceInfoPlugin.iosInfo).name;
    }
    final data = (await deviceInfoPlugin.androidInfo).data;
    if (data['name'] != null) {
      return data['name'];
    }
    return '${data['brand']} ${data['model']}';
  }

  Future<AppendUserDeviceForm> getDeviceForm() async {
    var builder = AppendUserDeviceFormBuilder();
    builder.deviceId = await getDeviceId();
    builder.deviceName = await getDeviceName();
    return builder.build();
  }
}