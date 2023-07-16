import 'package:mtoybox/modules/domain/model/article/article.dart';

abstract class ArticleGateway {
  /// アーティクルを読み込んでデータをキャッシュする
  /// アーティクルが存在しない場合は初期データを作成する
  Future<void> initialize();

  /// リポジトリにアーティクルを保存してキャッシュを更新する
  Future<void> save(Article article);

  // リポジトリ内にキャッシュされたアーティクルを返す
  List<Article> getAll();
}
