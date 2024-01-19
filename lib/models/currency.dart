class CurrencyRate {
  String curAbbreviation;
  double curRate;
  int curScale;

  CurrencyRate({
    required this.curAbbreviation,
    required this.curRate,
    required this.curScale,
  });

  factory CurrencyRate.fromMap(Map<String, Object?> userMap) {
    return CurrencyRate(
      curAbbreviation: userMap['Cur_Abbreviation'] as String,
      curRate: userMap['Cur_OfficialRate'] as double,
      curScale: userMap['Cur_Scale'] as int,
    );
  }
}
