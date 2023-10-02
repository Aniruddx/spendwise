import 'indivisual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;

  BarData ({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndivisualBar> barData = [];

  //initialise bar data
  void initialiseBarData(){
    barData = [
      IndivisualBar(x: 0, y: sunAmount),
      IndivisualBar(x: 1, y: monAmount),
      IndivisualBar(x: 2, y: tueAmount),
      IndivisualBar(x: 3, y: wedAmount),
      IndivisualBar(x: 4, y: thursAmount),
      IndivisualBar(x: 5, y: friAmount),
      IndivisualBar(x: 6, y: satAmount),
    ];
  }
}

