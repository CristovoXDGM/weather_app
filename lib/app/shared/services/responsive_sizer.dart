class ResponsiveSizer {
  ScreenType getScreenType(double width) {
    if (width <= 600 || width < 820) {
      return ScreenType.medium;
    }
    if (width <= 820 || width <= 1600) {
      return ScreenType.expanded;
    }

    return ScreenType.compact;
  }
}

enum ScreenType {
  compact,
  medium,
  expanded;
}
