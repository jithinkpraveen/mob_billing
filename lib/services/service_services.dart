import 'dart:developer';

import 'package:mob_billing/db/database.dart';
import 'package:mob_billing/model/services_model.dart';

abstract class ServiceRepo {
  Future getService();
  Future addService(Services service);
  Future deleteService(Services userviceser);
}

class ServiceServices implements ServiceRepo {
  @override
  Future addService(Services services) async {
    return await LocalDb.instance.addServices(services);
  }

  @override
  Future getService() async {
    var res = await LocalDb.instance.getAllServices();
    log(res.toString());
    return res;
  }

  @override
  Future deleteService(Services services) async {
    var res = await LocalDb.instance.deleteService(services.id!);
    return res;
  }
}
