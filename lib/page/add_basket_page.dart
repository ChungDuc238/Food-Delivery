import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assets/const.dart';
import '../db/db_helper.dart';
import '../model/salad_basket_sql.dart';
import '../ui_widget/button_widget.dart';

class AddBasketItems extends StatefulWidget {
  const AddBasketItems({super.key});

  @override
  State<AddBasketItems> createState() => _AddBasketItemsState();
}

class _AddBasketItemsState extends State<AddBasketItems> {
  late Future<List<SaladBasketSqlModel>> _saladsFuture;
  List<SaladBasketSqlModel> _salads = [];

  late String _totalPriceValue = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _saladsFuture = DBHelper.getSaladItems();
      await _loadData();
    });
  }

  // Function to load salads from the database
  Future<void> _loadSalads() async {
    List<SaladBasketSqlModel> salads = await _saladsFuture;
    setState(() {
      _salads = salads;
    });
  }

  // Function to load data from the database
  Future<void> _loadData() async {
    await _loadSalads();
    if (_salads.isNotEmpty) {
      await _loadTotalPrice();
    }
  }

// Function to load total price value from the database
  Future<void> _loadTotalPrice() async {
    int totalPrice = await DBHelper.getTotalPriceValue();

    setState(() {
      _totalPriceValue = totalPrice.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Const.mContainer,
                      ),
                    ),
                    const Text(
                      Const.myBasket,
                      style: Const.h11HeaderTextWhite,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.popUntil(
                        context,
                        ModalRoute.withName('/homescreen'),
                      ),
                      child: const Icon(
                        Icons.home_sharp,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: _salads.isEmpty
                  ? const EmptyView()
                  : ListView.builder(
                      itemCount: _salads.length,
                      itemBuilder: (context, index) {
                        final salad = _salads[index];
                        return BasketItemWidget(
                          saladImage: salad.saladImage!,
                          saladName: salad.saladName!,
                          saladPack: salad.saladPack!,
                          saladPrice: salad.saladPrice!,
                          id: salad.id!,
                          onDelete: () {
                            setState(() {
                              // Remove the item from the list
                              _salads.removeAt(index);
                            });
                          },
                          onPriceDelete: () {
                            setState(() {
                              // Remove the item from the list
                              _loadTotalPrice();
                            });
                          },
                        );
                      },
                    ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Price",
                          style: Const.h11HeaderText,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee,
                              size: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _salads.isEmpty ? '0' : _totalPriceValue,
                              style: Const.headerText,
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _salads.isNotEmpty ? showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            // <-- SEE HERE
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return const BottomSheetCheckOutOrder(); // Display the bottom sheet
                          },
                        ) : null;
                      },
                      child: ButtonWidget(
                        height: 60,
                        width: 200,
                        bg: _salads.isNotEmpty ? Colors.green : Colors.grey,
                        text: _salads.isNotEmpty ? Const.checkOutOrder : 'Please select product before payment',
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BasketItemWidget extends StatelessWidget {
  final String saladImage;
  final String saladName;
  final String saladPack;
  final String saladPrice;
  final int id;
  final VoidCallback onDelete;
  final VoidCallback onPriceDelete;

  const BasketItemWidget({
    super.key,
    required this.saladImage,
    required this.saladName,
    required this.saladPack,
    required this.saladPrice,
    required this.id,
    required this.onDelete,
    required this.onPriceDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Const.hexToColor(Const.transparentButton2Color),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipOval(
                    child: Image.asset(
                      saladImage,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      saladName,
                      style: Const.headerText,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$saladPack Packs",
                      style: Const.bodyText,
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.money,
                    size: 20,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    saladPrice,
                    style: Const.headerText,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  await DBHelper.deleteSaladItem(id);
                  onDelete();
                  onPriceDelete();
                },
                child: const Icon(
                  Icons.delete_rounded,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 4),
        ],
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            Const.fruit1,
            width: 200,
            height: 200,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Empty Basket",
          style: Const.h11HeaderText,
        )
      ],
    );
  }
}

class BottomSheetCheckOutOrder extends StatefulWidget {
  const BottomSheetCheckOutOrder({super.key});

  @override
  State<BottomSheetCheckOutOrder> createState() =>
      _BottomSheetCheckOutOrderState();
}

class _BottomSheetCheckOutOrderState extends State<BottomSheetCheckOutOrder> {
  final TextEditingController _textEditingControllerDelivery =
      TextEditingController();
  final TextEditingController _textEditingControllerPhoneNumber =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 1.3;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        color: Colors.transparent,
        height: halfScreenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(child: Image.asset(Const.cancelbutton)),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              Const.deliveryAddress,
                              style: Const.h1HeaderText,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _mDeliveryAddressEdiText(
                              screenSize,
                              _textEditingControllerDelivery,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              Const.numbertocall,
                              style: Const.h1HeaderText,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _mDeliveryPhoneNumberEdiText(
                                screenSize, _textEditingControllerPhoneNumber),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_isTextInputNew(
                                    context,
                                    _textEditingControllerDelivery,
                                    _textEditingControllerPhoneNumber,
                                    'Please Enter Delivery Address',
                                    'Please Enter Mobile Number',
                                  )) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/completeorder',
                                    );
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 300, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      Const.payondelivery,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: "jost",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ), // Replace YourContentWidget with your actual content
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Credit Card Bottomnav
class CreditCardBottomSheetCheckOutOrder extends StatefulWidget {
  const CreditCardBottomSheetCheckOutOrder({super.key});

  @override
  State<CreditCardBottomSheetCheckOutOrder> createState() =>
      _CreditCardBottomSheetCheckOutOrderState();
}

class _CreditCardBottomSheetCheckOutOrderState
    extends State<CreditCardBottomSheetCheckOutOrder> {
  final TextEditingController _textContolerCardHolderName =
      TextEditingController();
  final TextEditingController _textContolerCardNumber = TextEditingController();
  final TextEditingController _textContolerDate = TextEditingController();

  final TextEditingController _textEditingControllerCVV =
      TextEditingController();

  late DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Format the selected date to the desired format
        String formattedDate =
            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

        _textContolerDate.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 2;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        color: Colors.transparent,
        height: halfScreenHeight * 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(child: Image.asset(Const.cancelbutton)),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  Const.cardHolderName,
                                  style: Const.h1HeaderText,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Const.hexToColor(Const.editTextColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    width: screenSize.width * .8,
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: Const.cardHolderName,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          controller:
                                              _textContolerCardHolderName,
                                          // onChanged: (value) {
                                          //   if (value.length > 10) {
                                          //     _textEditingController.text = '';
                                          //   }
                                          // },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  Const.cardNumber,
                                  style: Const.h1HeaderText,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Const.hexToColor(Const.editTextColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    width: screenSize.width * .8,
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Center(
                                        child: TextFormField(
                                          maxLength: 10,

                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'),
                                            ),
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                            // Allow only numbers
                                          ],
                                          decoration: const InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            hintText: Const.cardNumber,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          controller: _textContolerCardNumber,
                                          // onChanged: (value) {
                                          //
                                          // },
                                          textCapitalization:
                                              TextCapitalization.characters,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //
                                    SizedBox(
                                      width: screenSize.width * 0.3,
                                      child: const Text(
                                        Const.date,
                                        style: Const.h1HeaderText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.2,
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.3,
                                      child: const Text(
                                        Const.cvv,
                                        style: Const.h1HeaderText,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //Date and CVV Editext
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //
                                    GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Const.hexToColor(
                                                Const.editTextColor),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                          width: screenSize.width * 0.3,
                                          height: 60,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Center(
                                              child: TextFormField(
                                                controller: _textContolerDate,

                                                enabled: false,
                                                // enabled: false,
                                                decoration:
                                                    const InputDecoration(
                                                  counterText: '',
                                                  border: InputBorder.none,
                                                  hintText: Const.dateHintText,
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Const.hexToColor(
                                              Const.editTextColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SizedBox(
                                        width: screenSize.width * 0.3,
                                        height: 60,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Center(
                                            child: TextFormField(
                                              maxLength: 3,
                                              keyboardType: TextInputType.phone,
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none,
                                                hintText: Const.cvvHintText,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              controller:
                                                  _textEditingControllerCVV,
                                              // onChanged: (value) {
                                              //
                                              // },
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Const.hexToColor(Const.appColor),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (_isTextInputCreditCard(
                                  context,
                                  _textContolerCardHolderName,
                                  _textContolerCardNumber,
                                  _textContolerDate,
                                  _textEditingControllerCVV,
                                  'Please Enter Card Holder Name',
                                  'Please Enter Card Number',
                                  'Please Select Date',
                                  'Please Enter your CVV')) {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/completeorder');
                              }
                            },
                            child: Center(
                              child: _mCompleteOrder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // Replace YourContentWidget with your actual content
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Complete  Order Button
Widget _mCompleteOrder() => Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          Const.completeOder,
          style: TextStyle(
            fontSize: 15,
            color: Const.hexToColor(Const.appColor),
            fontFamily: "jost",
          ),
        ),
      ),
    );

////Delivery EditText
Widget _mDeliveryAddressEdiText(
    Size screenSize, TextEditingController textEditingControllerDelivery) {
  return Container(
    decoration: BoxDecoration(
      color: Const.hexToColor(Const.editTextColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SizedBox(
      width: screenSize.width * .8,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Input Name',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            controller: textEditingControllerDelivery,
          ),
        ),
      ),
    ),
  );
}

//Phone Number EditText
_mDeliveryPhoneNumberEdiText(Size screenSize,
        TextEditingController textEditingControllerPhoneNumber) =>
    Container(
      decoration: BoxDecoration(
          color: Const.hexToColor(Const.editTextColor),
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: screenSize.width * .8,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: TextFormField(
              maxLength: 10,

              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
                FilteringTextInputFormatter.digitsOnly // Allow only numbers
              ],
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: 'Input Phone number',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: textEditingControllerPhoneNumber,
              // onChanged: (value) {
              //
              // },
              textCapitalization: TextCapitalization.characters,
            ),
          ),
        ),
      ),
    );

bool _isTextInputNew(
    BuildContext context,
    TextEditingController textEditingController1,
    TextEditingController textEditingController2,
    String message,
    message2) {
  var getText1 = textEditingController1.text;
  var getText2 = textEditingController2.text;
  if (getText1.isEmpty) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Const.hexToColor(Const.appColor),
        textColor: Colors.white,
        fontSize: 16.0);

    return false;
  } else if (getText2.isEmpty) {
    Fluttertoast.showToast(
        msg: message2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Const.hexToColor(Const.appColor),
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  }

  return true;
}

bool _isTextInputCreditCard(
    BuildContext context,
    TextEditingController textEditingController1,
    TextEditingController textEditingController2,
    TextEditingController textEditingControlle3,
    TextEditingController textEditingControlle4,
    String message,
    message2,
    message3,
    message4) {
  var getText1 = textEditingController1.text;
  var getText2 = textEditingController2.text;
  var getText3 = textEditingControlle3.text;
  var getText4 = textEditingControlle4.text;
  if (getText1.isEmpty) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Const.hexToColor(Const.appColor),
        textColor: Colors.white,
        fontSize: 16.0);

    return false;
  } else if (getText2.isEmpty) {
    Fluttertoast.showToast(
        msg: message2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Const.hexToColor(Const.appColor),
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  } else if (getText3.isEmpty) {
    Fluttertoast.showToast(
        msg: message3,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Const.hexToColor(Const.appColor),
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  } else if (getText4.isEmpty) {
    Fluttertoast.showToast(
        msg: message4,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Const.hexToColor(Const.appColor),
        textColor: Colors.white,
        fontSize: 16.0);
    return false;
  }
  return true;
}
