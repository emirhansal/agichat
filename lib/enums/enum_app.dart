enum ThemeApperance { light, dark, pink, system }

enum ActivityState { isLoading, isLoaded, isError }

enum ActivityErrorActionState { none, gotoBack, logout, directLogout }

enum ResultType { success, warning, error }

enum AppLanguage {
  locale(-1),
  en(0),
  tr(1);

  const AppLanguage(this.id);
  final int id;

  factory AppLanguage.fromId(int id) => values.firstWhere((e) => e.id == id);
}

enum Flavor {
  prod('prod'),
  dev('dev');

  const Flavor(this.value);
  final String value;
}

enum FileType {
  camera,
  gallery,
  videoGallery,
  videoCamera,
  pdf,
  unkown,
}
