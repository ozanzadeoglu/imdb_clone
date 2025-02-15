//Image sizes that'll get used in components
enum ImageSizes {
  //responsiveHeight(0),//generally used in components in homeview
  responsiveWidthMultiplier(0.35),
  detailsHeight(180), //used in detail views
  detailsWidth(120);

  final double value;
  const ImageSizes(this.value);
}
