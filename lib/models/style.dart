enum Style {
  dandy,
  chic,
  classic,
  minimal,
  business,
  lovely,
  sexy,
  feminine,
  genderless,
  vintage,
  retro,
  street,
  unique,
  hiphop,
  punk,
  goth,
  sporty,
  gopcore,
  normcore,
  amekaji,
  preppy,
  casual,
  cityBoy
}

extension StyleExtension on Style {
  String get converToString {
    switch (this) {
      case Style.dandy:
        return '댄디';
      case Style.chic:
        return '시크';
      case Style.classic:
        return '클래식';
      case Style.minimal:
        return '미니멀';
      case Style.business:
        return '비즈니스';
      case Style.lovely:
        return '러블리';
      case Style.sexy:
        return '섹시';
      case Style.feminine:
        return '페미닌';
      case Style.genderless:
        return '젠더리스';
      case Style.vintage:
        return '빈티지';
      case Style.retro:
        return '레트로';
      case Style.street:
        return '스트릿';
      case Style.unique:
        return '유니크';
      case Style.hiphop:
        return '힙합';
      case Style.punk:
        return '펑크';
      case Style.goth:
        return '고스';
      case Style.sporty:
        return '스포티';
      case Style.gopcore:
        return '코프코어';
      case Style.normcore:
        return '놈코어';
      case Style.amekaji:
        return '아메카지';
      case Style.preppy:
        return '프레피';
      case Style.casual:
        return '캐쥬얼';
      case Style.cityBoy:
        return '시티보이';
    }
  }

  int? get apiIDInt {
    switch (this) {
      case Style.dandy:
        return 1;
      case Style.chic:
        return 2;
      case Style.classic:
        return 3;
      case Style.minimal:
        return 4;
      case Style.business:
        return 5;
      case Style.lovely:
        return 6;
      case Style.sexy:
        return 7;
      case Style.feminine:
        return 8;
      case Style.genderless:
        return 9;
      case Style.vintage:
        return 10;
      case Style.retro:
        return 11;
      case Style.street:
        return 12;
      case Style.unique:
        return 13;
      case Style.hiphop:
        return 14;
      case Style.punk:
        return 15;
      case Style.goth:
        return 16;
      case Style.sporty:
        return 17;
      case Style.gopcore:
        return 18;
      case Style.normcore:
        return 19;
      case Style.amekaji:
        return 20;
      case Style.preppy:
        return 21;
      case Style.casual:
        return 22;
      case Style.cityBoy:
        return 23;
      default:
        return null;
    }
  }

  String? get apiID {
    switch (this) {
      case Style.dandy:
        return '1';
      case Style.chic:
        return '2';
      case Style.classic:
        return '3';
      case Style.minimal:
        return '4';
      case Style.business:
        return '5';
      case Style.lovely:
        return '6';
      case Style.sexy:
        return '7';
      case Style.feminine:
        return '8';
      case Style.genderless:
        return '9';
      case Style.vintage:
        return '10';
      case Style.retro:
        return '11';
      case Style.street:
        return '12';
      case Style.unique:
        return '13';
      case Style.hiphop:
        return '14';
      case Style.punk:
        return '15';
      case Style.goth:
        return '16';
      case Style.sporty:
        return '17';
      case Style.gopcore:
        return '18';
      case Style.normcore:
        return '19';
      case Style.amekaji:
        return '20';
      case Style.preppy:
        return '21';
      case Style.casual:
        return '22';
      case Style.cityBoy:
        return '23';
      default:
        return null;
    }
  }
}

extension IntExtension on int {
  Style? get convertToStyle {
    switch (this) {
      case 1:
        return Style.dandy;
      case 2:
        return Style.chic;
      case 3:
        return Style.classic;
      case 4:
        return Style.minimal;
      case 5:
        return Style.business;
      case 6:
        return Style.lovely;
      case 7:
        return Style.sexy;
      case 8:
        return Style.feminine;
      case 9:
        return Style.genderless;
      case 10:
        return Style.vintage;
      case 11:
        return Style.retro;
      case 12:
        return Style.street;
      case 13:
        return Style.unique;
      case 14:
        return Style.hiphop;
      case 15:
        return Style.punk;
      case 16:
        return Style.goth;
      case 17:
        return Style.sporty;
      case 18:
        return Style.gopcore;
      case 19:
        return Style.normcore;
      case 20:
        return Style.amekaji;
      case 21:
        return Style.preppy;
      case 22:
        return Style.casual;
      case 23:
        return Style.cityBoy;
      default:
        return null;
    }
  }
}
