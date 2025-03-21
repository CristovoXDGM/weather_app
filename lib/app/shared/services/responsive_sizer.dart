class ResponsiveSizer {
  ScreenType getScreenType(double width) {
    if (width <= 600 || width < 820) {
      return ScreenType.compact;
    }
    if (width <= 820 || width <= 1600) {
      return ScreenType.medium;
    }
    return ScreenType.expanded;
  }
}

enum ScreenType {
  compact,
  medium,
  expanded;
}
