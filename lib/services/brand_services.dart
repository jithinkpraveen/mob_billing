// ignore_for_file: file_names

import 'dart:developer';
import 'package:mob_billing/db/database.dart';
import 'package:mob_billing/model/brand_model.dart';

abstract class BrandRepo {
  Future getBrand();
  Future addBrand(Brand brand);
  Future deleteBrand(Brand brand);
}

class BrandServices implements BrandRepo {
  @override
  Future addBrand(Brand brand) async {
    return await LocalDb.instance.addBrand(brand);
  }

  @override
  Future getBrand() async {
    var res = await LocalDb.instance.getAllBrands();
    log(res.toString());
    return res;
  }

  @override
  Future deleteBrand(Brand brand) async {
    var res = await LocalDb.instance.deleteService(brand.id!);
    return res;
  }
}
