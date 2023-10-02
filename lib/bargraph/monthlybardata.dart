import 'indivisual_bar.dart';

class MBarData {
  final double janAmount;
  final double febAmount;
  final double marAmount;
  final double aprAmount;
  final double mayAmount;
  final double junAmount;
  final double julAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;






  MBarData ({
    required this.janAmount,
    required this.febAmount,
    required this.marAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
  });

  List<IndivisualBar> barData = [];

  //initialise bar data
  void initialiseBarData(){
    barData = [
      IndivisualBar(x: 0, y: janAmount),
      IndivisualBar(x: 1, y: febAmount),
      IndivisualBar(x: 2, y: marAmount),
      IndivisualBar(x: 3, y: aprAmount),
      IndivisualBar(x: 4, y: mayAmount),
      IndivisualBar(x: 5, y: junAmount),
      IndivisualBar(x: 6, y: julAmount),
      IndivisualBar(x: 6, y: augAmount),
      IndivisualBar(x: 6, y: sepAmount),
      IndivisualBar(x: 6, y: octAmount),
      IndivisualBar(x: 6, y: novAmount),
      IndivisualBar(x: 6, y: decAmount),
    ];
  }
}

