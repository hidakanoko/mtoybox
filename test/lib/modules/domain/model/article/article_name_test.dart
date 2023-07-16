import 'package:flutter_test/flutter_test.dart';
import 'package:mtoybox/modules/domain/model/article/article_name.dart';

void main() {
  test('ArticleName is lower than 100', (() {
    // given
    var nameStr =
        '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';

    // when
    var articleName = ArticleName(nameStr);

    // then
    expect(
        articleName.value,
        equals(
            '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'));
  }));
  test('ArticleName length over 100', (() {
    // given
    var nameStr =
        '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901';
    // when, then
    expect(() => ArticleName(nameStr), throwsArgumentError);
  }));
}
