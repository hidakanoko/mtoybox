enum Routes {
  menu(key: '/'),
  selectOne(key: '/selectOne'),

  imageLibraryArticleList(key: '/imageLibrary/articleList'),
  createArticle(key: '/imageLibrary/createArticle');

  const Routes({required this.key});

  final String key;
}
