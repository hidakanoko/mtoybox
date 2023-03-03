class Photo {
  final String path;
  final bool isBuiltin;
  Photo(this.path, {this.isBuiltin = false});

  Photo clone() {
    return Photo(path, isBuiltin: isBuiltin);
  }
}
