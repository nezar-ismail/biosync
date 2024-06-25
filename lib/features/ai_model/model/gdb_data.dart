class GDBdata {
  final String content;
  final int gdp;

  GDBdata(this.content, this.gdp);
}

List<GDBdata> getChartData(int percentage) {
  final List<GDBdata> accuracyChartData = [
    GDBdata('Accuracy', 95),
  ];
  final List<GDBdata> precisionChartData = [
    GDBdata('precision', 96),
  ];
  final List<GDBdata> recallChartData = [
    GDBdata('Recall', 97),
  ];

  if (percentage == 95) {
    return accuracyChartData;
  } else if (percentage == 96) {
    return precisionChartData;
  } else {
    return recallChartData;
  }
}
