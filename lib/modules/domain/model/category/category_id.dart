import 'package:mtoybox/modules/domain/model/Identity.dart';
import 'package:mtoybox/modules/infrastructure/uuid.dart';

class CategoryId extends Identity<UuidValue> {
  CategoryId(super.id);
  factory CategoryId.generate() {
    return CategoryId(UuidValue.generate());
  }
}
