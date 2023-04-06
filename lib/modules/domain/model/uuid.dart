import 'package:uuid/uuid.dart';

class UuidValue {
  final String _value;

  const UuidValue(this._value);

  @override
  String toString() {
    return _value;
  }

  factory UuidValue.generate() {
    return UuidValue(const Uuid().v4().toString());
  }
}
