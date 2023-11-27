abstract class Assets {
  static final images = _Images();
  static final icons = _Icons();
  static final gifs = _Gifs();
  static final lottie = _Lottie();
}

class _Images {
  static const _basePath = 'assets/images';
  String get error => '$_basePath/error.png';
  String get empty => '$_basePath/empty.png';
  String get logo => '$_basePath/logo.png';
}

class _Icons {
  static const _basePath = 'assets/icons';

  //PNG
  String get logo => '$_basePath/logo.png';

  //SVG
  String get arrowDown => '$_basePath/arrow_down.svg';
  String get arrowUp => '$_basePath/arrow_up.svg';
}

class _Gifs {
  static const _basePath = 'assets/gifs';
  String get emptyNotificationGif => '$_basePath/empty_notification_gif.gif';
}

class _Lottie {
  static const _basePath = 'assets/lottie';
  String get flyingPenguin => '$_basePath/flying_penguin.json';
}
