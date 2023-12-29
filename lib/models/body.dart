enum BodyType { invertedTriangle, oval, triangle, volume, rectangle }

extension BodyTypeExtension on BodyType {
  String get convertToString {
    switch (this) {
      case BodyType.invertedTriangle:
        return '역삼각형';
      case BodyType.oval:
        return '타원형';
      case BodyType.triangle:
        return '삼각형';
      case BodyType.volume:
        return '볼륨형';
      case BodyType.rectangle:
        return '직사각형';
    }
  }

  String get apiID {
    switch (this) {
      case BodyType.invertedTriangle:
        return "1";
      case BodyType.oval:
        return "2";
      case BodyType.triangle:
        return "3";
      case BodyType.volume:
        return "4";
      case BodyType.rectangle:
        return "5";
    }
  }

  String get iconPath {
    switch (this) {
      case BodyType.invertedTriangle:
        return 'assets/icons/inverted_triangle.png';
      case BodyType.oval:
        return 'assets/icons/oval.png';
      case BodyType.triangle:
        return 'assets/icons/triangle.png';
      case BodyType.volume:
        return 'assets/icons/volume.png';
      case BodyType.rectangle:
        return 'assets/icons/rectangle.png';
    }
  }
}

extension IntExtension on int {
  BodyType? get convertToBodyType {
    switch (this) {
      case 1:
        return BodyType.invertedTriangle;
      case 2:
        return BodyType.oval;
      case 3:
        return BodyType.triangle;
      case 4:
        return BodyType.volume;
      case 5:
        return BodyType.rectangle;
      default:
        return null;
    }
  }
}
