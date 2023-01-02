import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class CategoryRepository implements CategoryGateway {
  @override
  List<Category> getAll() {
    return [
      Category('どうぶつ', Colors.red),
      Category('くだもの', Colors.yellow),
      Category('やさい', Colors.green),
      Category('さかな', Colors.blue),
    ];
  }
}
