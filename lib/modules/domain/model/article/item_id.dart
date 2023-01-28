import 'package:mtoybox/modules/domain/model/Identity.dart';
import 'package:mtoybox/modules/infrastructure/uuid.dart';

class ItemId extends Identity<UuidValue> {
  ItemId(super.id);
  factory ItemId.generate() {
    return ItemId(UuidValue.generate());
  }
}
