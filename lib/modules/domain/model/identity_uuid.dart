import 'package:uuid/uuid.dart';

class IdentityUuid {
  final String _value;

  const IdentityUuid(this._value);

  @override
  String toString() {
    return _value;
  }

  factory IdentityUuid.generate() {
    return IdentityUuid(const Uuid().v4().toString());
  }
}
