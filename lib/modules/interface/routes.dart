enum Routes {
  menu(key: '/'),
  selectOne(key: '/selectOne'),
  imageLibraryArticleList(key: '/imageLibrary/articleList');

  const Routes({required this.key});

  final String key;
}
