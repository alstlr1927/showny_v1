enum MainLandingType {
  home(0),
  feed(1),
  upload(2),
  shop(3),
  profile(4);

  const MainLandingType(this.pageIndex);
  final int pageIndex;
}
