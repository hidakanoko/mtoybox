import 'package:mtoybox/modules/domain/model/article/item.dart';

abstract class ArticleGateway {
  /// アーティクルを読み込んでデータをキャッシュする
  /// アーティクルが存在しない場合は初期データを作成する
  Future<void> initialize();

  /// リポジトリにアーティクルを保存してキャッシュを更新する
  Future<void> save(Item article);

  // リポジトリ内にキャッシュされたアーティクルを返す
  List<Item> getAll();
}
