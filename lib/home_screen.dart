import 'package:flutter/material.dart';
import 'package:tip_calculator_v3/element_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double billAmount = 200;
  double tipPercent = 15;
  double tipAmount = 30;
  double totalAmount = 230;
  int people = 2;
  double eachPersonPays = 115;

  TextEditingController controllerBillAmount = TextEditingController();
  TextEditingController controllerTipPercent = TextEditingController();
  TextEditingController controllerTipAmount = TextEditingController();
  TextEditingController controllerTotalAmount = TextEditingController();
  TextEditingController controllerPeople = TextEditingController();
  TextEditingController controllerEachPersonPays = TextEditingController();

  final FocusNode billFocus = FocusNode();
  final FocusNode tipPercentFocus = FocusNode();
  final FocusNode tipAmountFocus = FocusNode();
  final FocusNode totalAmountFocus = FocusNode();
  final FocusNode peopleFocus = FocusNode();
  final FocusNode eachPersonPaysFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    //BillAmount
    controllerBillAmount.text = formatNumber(billAmount);
    billFocus.addListener(() {
      if (!billFocus.hasFocus) {
        setState(() {
          billAmount = double.tryParse(controllerBillAmount.text) ?? 0;
          calculateTipAmount();
        });
      }
    });

    // tipPercent
    controllerTipPercent.text = formatNumber(tipPercent);
    tipPercentFocus.addListener(() {
      if (!tipPercentFocus.hasFocus) {
        setState(() {
          tipPercent = double.tryParse(controllerTipPercent.text) ?? 0;
          controllerTipPercent.text = formatNumber(tipPercent);
          calculateTipAmount();
        });
      }
    });

    // tipAmount
    controllerTipAmount.text = formatNumber(tipAmount);
    tipAmountFocus.addListener(() {
      if (!tipAmountFocus.hasFocus) {
        // User tapped outside
        setState(() {
          tipAmount = double.tryParse(controllerTipAmount.text) ?? 0;

          controllerTipAmount.text = formatNumber(tipAmount);
          calculateTipPercent();
        });
      }
    });

    // totalAmount
    controllerTotalAmount.text = formatNumber(totalAmount);
    totalAmountFocus.addListener(() {
      if (!totalAmountFocus.hasFocus) {
        setState(() {
          totalAmount = double.tryParse(controllerTotalAmount.text) ?? 0;

          controllerTotalAmount.text = formatNumber(totalAmount);
          reCalculateTip();
        });
      }
    });

    // people
    controllerPeople.text = people.toString();
    peopleFocus.addListener(() {
      if (!peopleFocus.hasFocus) {
        setState(() {
          people = int.tryParse(controllerPeople.text) ?? 0;
          controllerPeople.text = formatNumber(people.toDouble());
          billEachPerson();
        });
      }
    });

    // eachPersonPays
    controllerEachPersonPays.text = formatNumber(eachPersonPays);
    eachPersonPaysFocus.addListener(() {
      if (!eachPersonPaysFocus.hasFocus) {
        eachPersonPays = double.tryParse(controllerEachPersonPays.text) ?? 0;
        controllerEachPersonPays.text = formatNumber(eachPersonPays);
        reCalculateBillEachPerson();
      }
    });
  }

  String formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  double nextWhole(double value) {
    return value == value.roundToDouble() ? value + 1 : value.ceilToDouble();
  }

  double previousWhole(double value) {
    return value == value.roundToDouble() ? value - 1 : value.floorToDouble();
  }

  void calculateTipAmount() {
    tipAmount = billAmount * (tipPercent / 100);
    controllerTipAmount.text = formatNumber(tipAmount);
    calculateTotalAmount();
  }

  void calculateTipPercent() {
    tipPercent = (tipAmount * 100) / billAmount;
    controllerTipPercent.text = formatNumber(tipPercent);
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    totalAmount = billAmount + tipAmount;
    controllerTotalAmount.text = formatNumber(totalAmount);
    billEachPerson();

    tipAmount = totalAmount - billAmount;
    controllerTipAmount.text = formatNumber(tipAmount);
  }

  void reCalculateTip() {
    tipAmount = totalAmount - billAmount;
    controllerTipAmount.text = formatNumber(tipAmount);
    calculateTipPercent();
  }

  void billEachPerson() {
    eachPersonPays = totalAmount / people;
    controllerEachPersonPays.text = formatNumber(eachPersonPays);
  }

  void reCalculateBillEachPerson() {
    tipAmount = (eachPersonPays * people) - billAmount;
    controllerTipAmount.text = formatNumber(tipAmount);
    calculateTipPercent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tip Calc V3",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ElementWidget(
              name: "Bill Amount",
              focusNode: billFocus,
              onTapMinus: () {
                setState(() {
                  if (billAmount > 0) {
                    billAmount = previousWhole(billAmount);
                    controllerBillAmount.text = formatNumber(billAmount);
                    calculateTipAmount();
                  }
                });
              },
              controller: controllerBillAmount,
              onSubmitted: (String value) {
                setState(() {
                  billAmount = double.tryParse(controllerBillAmount.text) ?? 0;
                  // billAmount = double.parse(value);
                  calculateTipAmount();
                });
              },
              onTapPlus: () {
                setState(() {
                  billAmount = nextWhole(billAmount);
                  controllerBillAmount.text = formatNumber(billAmount);
                  calculateTipAmount();
                });
              },
            ),

            ElementWidget(
              name: "Tip Percent (%)",
              focusNode: tipPercentFocus,
              onTapMinus: () {
                setState(() {
                  if (tipPercent > 0) {
                    tipPercent = previousWhole(tipPercent);
                    controllerTipPercent.text = formatNumber(tipPercent);
                    calculateTipAmount();
                  }
                });
              },
              controller: controllerTipPercent,
              onSubmitted: (String value) {
                setState(() {
                  tipPercent = double.tryParse(controllerTipPercent.text) ?? 0;

                  // tipPercent = double.parse(value);
                  controllerTipPercent.text = formatNumber(tipPercent);
                  calculateTipAmount();
                });
              },
              onTapPlus: () {
                setState(() {
                  tipPercent = nextWhole(tipPercent);
                  controllerTipPercent.text = formatNumber(tipPercent);
                  calculateTipAmount();
                });
              },
            ),

            ElementWidget(
              name: "Tip Amount",
              focusNode: tipAmountFocus,
              onTapMinus: () {
                setState(() {
                  if (tipAmount > 0) {
                    tipAmount = previousWhole(tipAmount);
                    controllerTipAmount.text = formatNumber(tipAmount);
                    calculateTipPercent();
                  }
                });
              },
              controller: controllerTipAmount,
              onSubmitted: (String value) {
                setState(() {
                  tipAmount = double.tryParse(controllerTipAmount.text) ?? 0;

                  controllerTipAmount.text = formatNumber(tipAmount);
                  calculateTipPercent();
                });
              },
              onTapPlus: () {
                setState(() {
                  tipAmount = nextWhole(tipAmount);
                  controllerTipAmount.text = formatNumber(tipAmount);
                  calculateTipPercent();
                });
              },
            ),
            ElementWidget(
              name: "Total Amount",
              focusNode: totalAmountFocus,
              onTapMinus: () {
                if (totalAmount > billAmount) {
                  setState(() {
                    totalAmount = previousWhole(totalAmount);
                    reCalculateTip();
                    controllerTotalAmount.text = formatNumber(totalAmount);
                  });
                }
              },
              controller: controllerTotalAmount,
              onSubmitted: (String value) {
                setState(() {
                  totalAmount =
                      double.tryParse(controllerTotalAmount.text) ?? 0;

                  controllerTotalAmount.text = formatNumber(totalAmount);
                  reCalculateTip();
                });
              },
              onTapPlus: () {
                setState(() {
                  totalAmount = nextWhole(totalAmount);
                  controllerTotalAmount.text = formatNumber(totalAmount);
                  reCalculateTip();
                });
              },
            ),
            ElementWidget(
              name: "No. of People",
              focusNode: peopleFocus,
              onTapMinus: () {
                if (people > 2) {
                  setState(() {
                    people = previousWhole(people.toDouble()).toInt();
                    controllerPeople.text = formatNumber(people.toDouble());
                    billEachPerson();
                  });
                }
              },
              controller: controllerPeople,
              onSubmitted: (String value) {
                setState(() {
                  people = int.tryParse(controllerPeople.text) ?? 0;
                  controllerPeople.text = formatNumber(people.toDouble());
                  billEachPerson();
                });
              },
              onTapPlus: () {
                setState(() {
                  people = nextWhole(people.toDouble()).toInt();
                  controllerPeople.text = formatNumber(people.toDouble());
                });
                billEachPerson();
              },
            ),
            ElementWidget(
              name: "Each Person Pays",
              focusNode: eachPersonPaysFocus,
              onTapMinus: () {
                if (eachPersonPays > (billAmount / people)) {
                  eachPersonPays = previousWhole(eachPersonPays);
                  setState(() {
                    controllerEachPersonPays.text = formatNumber(
                      eachPersonPays,
                    );
                    reCalculateBillEachPerson();
                  });
                }
              },
              controller: controllerEachPersonPays,
              onSubmitted: (String value) {
                setState(() {
                  eachPersonPays =
                      double.tryParse(controllerEachPersonPays.text) ?? 0;
                  controllerEachPersonPays.text = formatNumber(eachPersonPays);
                  reCalculateBillEachPerson();
                });
              },
              onTapPlus: () {
                eachPersonPays = nextWhole(eachPersonPays);
                setState(() {
                  controllerEachPersonPays.text = formatNumber(eachPersonPays);
                  reCalculateBillEachPerson();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    controllerBillAmount.dispose();
    controllerTipPercent.dispose();
    controllerTipAmount.dispose();
    controllerTotalAmount.dispose();
    controllerPeople.dispose();
    controllerEachPersonPays.dispose();

    billFocus.dispose();
    tipPercentFocus.dispose();
    tipAmountFocus.dispose();
    totalAmountFocus.dispose();
    peopleFocus.dispose();
    eachPersonPaysFocus.dispose();

    super.dispose();
  }
}
