class PhotoSource {
  final String _imageSource;
  const PhotoSource._(this._imageSource);

  @override
  String toString() => _imageSource;

  static const PhotoSource asset = PhotoSource._('asset');
  static const PhotoSource file = PhotoSource._('file');
  static const PhotoSource memory = PhotoSource._('memory');
  static const PhotoSource network = PhotoSource._('network');
  static const PhotoSource unknown = PhotoSource._('unknown');

  static PhotoSource tryParse(String val) {
    switch (val) {
      case 'asset':
        return PhotoSource.asset;
      case 'file':
        return PhotoSource.file;
      case 'memory':
        return PhotoSource.memory;
      case 'network':
        return PhotoSource.network;
      case '':
        return PhotoSource.unknown;
      default:
        // print('$val is not a valid ImageSource');
        return PhotoSource.unknown;
    }
  }
}
