enum TypeModel {
  mangatrix,
  recibo,
  dashboard,
  github,
  certificados;

  @override
  String toString() => {
        TypeModel.mangatrix: "MangaTrix",
        TypeModel.recibo: "Recibo Online",
        TypeModel.dashboard: "Dashboard",
        TypeModel.github: "GitHub",
        TypeModel.certificados: "Certificados",
      }[this]!;

  String get url => switch (this) {
        TypeModel.mangatrix => "https://leitor.mangatrix.net",
        TypeModel.recibo => "https://recibo.mangatrix.net",
        TypeModel.dashboard => "https://google.com",
        TypeModel.github => "https://github.com/josemoura212",
        _ => "",
      };

  String get icon => switch (this) {
        TypeModel.mangatrix => "assets/icons/mangatrix.png",
        TypeModel.recibo => "assets/icons/recibo-online.png",
        TypeModel.dashboard => "assets/icons/dashboard.png",
        TypeModel.github => "assets/icons/github.png",
        TypeModel.certificados => "assets/icons/certificate.png",
      };
}
