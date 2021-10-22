import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob_billing/app_config.dart';
import 'package:mob_billing/pages/activationScreen/activation_screen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ActivateApp {
  Future getDevideId();
  Future getDocFromKey(String actKey);
  Future activateDevice(String actKey);
  Future registerDevice(Object object, String id);
  Future checkKey(BuildContext ctx);
}

class ActivateAppServices implements ActivateApp {
  @override
  Future activateDevice(String actKey) async {
    String? devideid = await getDevideId();
    List keyRes = await getDocFromKey(actKey);
    if (keyRes.isEmpty) {
      return {"success": false, "message": Appconfig.invalidKeyMsg};
    } else {
      List regDev = keyRes.first.data()['devices'];
      if (regDev
          .any((element) => element.toString().contains(devideid.toString()))) {
        return {"success": true, "message": Appconfig.registerSuccessMsg};
      } else if (regDev.length >= keyRes.first.data()['maxuser']) {
        return {"success": false, "message": Appconfig.maxUserRegistredMsg};
      } else {
        var object = keyRes.first.data();
        object['devices'].add(devideid);
        var data = await registerDevice(object, keyRes.first.id.toString());
        if (data == true) {
          return {"success": true, "message": Appconfig.registerSuccessMsg};
        } else {
          return {"success": false, "message": Appconfig.sumthingWentWrong};
        }
      }
    }
  }

  @override
  Future getDevideId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    log(deviceId.toString());
    return deviceId;
  }

  @override
  Future getDocFromKey(String actKey) async {
    CollectionReference keys = FirebaseFirestore.instance.collection("key");
    var data = await keys.get();
    var res = data.docs.where((element) => element['key'] == actKey);
    return res.toList();
  }

  @override
  Future registerDevice(Object object, String id) async {
    CollectionReference keys = FirebaseFirestore.instance.collection("key");
    try {
      await keys.doc(id).update(object as Map<String, dynamic>);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future checkKey(BuildContext ctx) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    log(_prefs.getString("key").toString());

    String? date = _prefs.getString("lastCheckDate");
    if (date != null) {
      if (DateTime.parse(date).day != DateTime.now().day) {
        _prefs.setString("lastCheckDate", DateTime.now().toString());
        var res = await activateDevice(_prefs.getString("key").toString());
        if (res['success'] != true) {
          _prefs.setBool("isActivate", false);
          Navigator.pushAndRemoveUntil(
              ctx,
              MaterialPageRoute(builder: (ctx) => const ActivationScreen()),
              (route) => false);
        }
      }
    } else {
      _prefs.setString("lastCheckDate", DateTime.now().toString());
      var res = await activateDevice(_prefs.getString("key").toString());
      if (res['success'] != true) {
        _prefs.remove("lastCheckDate");
        _prefs.setBool("isActivate", false);
        Navigator.pushAndRemoveUntil(
            ctx,
            MaterialPageRoute(builder: (ctx) => const ActivationScreen()),
            (route) => false);
      }
    }
  }
}
