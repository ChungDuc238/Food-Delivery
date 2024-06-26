import 'package:flutter/material.dart';
import 'package:food_apps/assets/const.dart';

import '../db/db_helper.dart';
import '../model/salad_basket_sql.dart';
import '../ui_widget/button_widget.dart';

class AddSaladDetails extends StatelessWidget {
  final String saladImage;
  final String saladName;
  final String saladPrice;

  AddSaladDetails(
      {super.key,
      required this.saladImage,
      required this.saladName,
      required this.saladPrice});

  String finalPrice = ''; // Define final price variable

  void handleFinalPriceChanged(String price) {
    finalPrice = price;
  }

  String getPackValue = ''; // Define final price variable

  void handlegetPackValueChanged(String price) {
    getPackValue = price;
  }

  bool isChangesPrice = false;

  void handlePriceChanges(bool isChangesPrices) {
    isChangesPrice = isChangesPrices;
  }

  //Value Changes ---
  bool isChangesPack = false;

  void handlePackChanges(bool isCgVal) {
    isChangesPack = isCgVal;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Const.mContainer,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: ClipOval(
                          child: Image.asset(
                            fit: BoxFit.cover,
                            saladImage,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        saladName,
                        style: Const.h11HeaderText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _RowAddingCard(
                        saladPrice,
                        saladImage,
                        saladName,
                        onFinalPriceChanged: handleFinalPriceChanged,
                        getPackValue: handlegetPackValueChanged,
                        isChangesPrice: handlePriceChanges,
                        isChangeValue: handlePackChanges,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  Const.onePack,
                                  style: Const.h1HeaderText,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Divider(
                                    color: Const.hexToColor(Const.appColor),
                                    height: 5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              Const.onePackDetails,
                              style: Const.headerText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 5,
                            ),
                            const Text(
                              Const.onePackDetails2,
                              style: Const.bodyText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // Open the database

                                    // Create a SaladBasketSqlModel object
                                    final salad = SaladBasketSqlModel(
                                      saladImage: saladImage,
                                      saladName: saladName,
                                      saladPack:
                                          !isChangesPack ? '1' : getPackValue,
                                      // You may want to change this
                                      saladPrice: !isChangesPrice
                                          ? saladPrice
                                          : finalPrice,
                                    );

                                    // Insert the salad into the database
                                    await DBHelper.insertSaladTable(salad);

                                    // Navigate to the basket page
                                    Navigator.pushNamed(context, '/basketPage');
                                  },
                                  child: const ButtonWidget(
                                    height: 60,
                                    width: 200,
                                    text: Const.addToBasket,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowAddingCard extends StatefulWidget {
  final String saladPrices;
  final String saladImage;
  final String saladName;
  final Function(String) onFinalPriceChanged; // Define callback
  final Function(String) getPackValue; // Define callback
  final Function(bool) isChangesPrice; // Define callback
  final Function(bool) isChangeValue; // Define callback

  const _RowAddingCard(this.saladPrices, this.saladImage, this.saladName,
      {required this.onFinalPriceChanged,
      required this.getPackValue,
      required this.isChangesPrice,
      required this.isChangeValue});

  @override
  State<_RowAddingCard> createState() => _RowAddingCardState();
}

class _RowAddingCardState extends State<_RowAddingCard> {
  int value = 1;
  String getPackValue = '1';
  late String finalPrice;
  late bool isChangesPrice;

  String getFinalPrice() {
    return finalPrice;
  }

  @override
  void initState() {
    super.initState();
    // Initialize finalValue with saladPrice
    finalPrice = widget.saladPrices;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      if (value > 1) {
                        value--;
                        getPackValue = value.toString();

                        updateFinalValue();
                      } else {
                        getPackValue = '1';
                      }
                    });
                  },
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                      backgroundColor: Const.hexToColor(Const.editTextColor),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  getPackValue,
                  style: Const.headerText,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      if (value < 5) {
                        value++;
                        getPackValue = value.toString();
                        updateFinalValue();
                      } else {
                        getPackValue = '5';
                      }
                    });
                  },
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                      backgroundColor: Const.hexToColor(Const.addbtnColor),
                      child: const Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 35,
              height: 35,
              child: Icon(
                Icons.money,
                size: 30,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              finalPrice,
              style: Const.headerText,
            ),
          ],
        ),
      ],
    );
  } // Update finalValue based on value and saladPrices

  void updateFinalValue() {
    int fGetValue = int.parse(getPackValue);
    int finalValueInt = fGetValue * int.parse(widget.saladPrices);
    setState(() {
      finalPrice = finalValueInt.toString();
    });
    if (getPackValue != '1') {
      setState(() {
        widget.isChangeValue(true);
      });
    }

    if (widget.saladPrices.isNotEmpty) {
      setState(() {
        widget.isChangesPrice(true);
      });
    }

    // Pass the final price back to the callback function
    widget.onFinalPriceChanged(finalPrice);
    widget.getPackValue(getPackValue);
  }
}
