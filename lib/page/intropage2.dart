import 'package:flutter/material.dart';

import '../assets/const.dart';
import '../ui_widget/button_widget.dart';

class IntroScreen2 extends StatefulWidget {
  const IntroScreen2({super.key});

  @override
  State<IntroScreen2> createState() => _IntroScreen2State();
}

class _IntroScreen2State extends State<IntroScreen2> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(Const.fruit2),
                ),
                /*  borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ), */
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(child: getIntro(screenSize)),
          )
        ],
      ),
    );
  }

  SizedBox getIntro(Size screenSize) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Text(
            Const.firstName,
            style: Const.headerText,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Const.hexToColor(Const.editTextColor),
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: screenSize.width * .8,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: Const.hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: _textEditingController,
                  onChanged: (value) {
                    if (value.length > 10) {
                      _textEditingController.text = '';
                    }
                  },
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => _inputValidation(context),
          child: Center(
            child: ButtonWidget(
              height: 50,
              width: screenSize.width * .8,
              text: Const.startOrder,
            ),
          ),
        )
      ],
    ));
  }

  void _inputValidation(BuildContext context) {
    var getText = _textEditingController.text;

    if (getText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.pushNamed(context, '/homescreen',
          arguments: getText.toString());
    }
  }
}

SnackBar snackBar = SnackBar(
  backgroundColor: Const.hexToColor(Const.appColor),
  content: const Text(
    'Please Enter Your name',
    style: TextStyle(color: Colors.white),
  ),
);
