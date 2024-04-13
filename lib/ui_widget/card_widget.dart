import 'package:flutter/material.dart';
import 'package:food_apps/assets/const.dart';

import '../model/salad_model.dart';
import '../page/add_salad_details.dart';

class CardWidget extends StatefulWidget {
  final SaladModel infoModel; // Mark infoModel as final
  const CardWidget({super.key, required this.infoModel});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddSaladDetails(
            saladImage: widget.infoModel.saladImage,
            saladName: widget.infoModel.saladName,
            saladPrice: widget.infoModel.saladPrice,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipOval(
                      child: Image.asset(
                        fit: BoxFit.cover,
                        widget.infoModel.saladImage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.infoModel.saladName),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.money,
                          size: 20,
                          color: Colors.green,
                        ),
                        Text(widget.infoModel.saladPrice),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircleAvatar(
                        backgroundColor: Const.hexToColor(Const.addbtnColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
