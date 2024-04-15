import '../assets/const.dart';

class SaladModel {
  String saladImage = "";
  String saladName = "";
  String saladPrice = "";

  SaladModel({
    required this.saladImage,
    required this.saladName,
    required this.saladPrice,
  });
}

class MySaladModel {
  static List<SaladModel> myInfoAllList = [
    SaladModel(
        saladImage: Const.salad1,
        saladName: "Honey-Lime Combo",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.salad2,
        saladName: "Berry-Mango Combo",
        saladPrice: '4000'),
    SaladModel(
        saladImage: Const.salad3,
        saladName: "Berry-Mango Combo",
        saladPrice: '500'),
    SaladModel(
        saladImage: Const.salad4,
        saladName: "Berry-Mango Combo",
        saladPrice: '3000'),
    SaladModel(
        saladImage: Const.salad5,
        saladName: "Berry-Mango Combo",
        saladPrice: '200'),
    SaladModel(
        saladImage: Const.salad6,
        saladName: "Berry-Mango Combo",
        saladPrice: '100'),
    SaladModel(
        saladImage: Const.salad7,
        saladName: "Berry-Mango Combo",
        saladPrice: '900'),
    SaladModel(
        saladImage: Const.salad8,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.salad9,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.salad10,
        saladName: "Berry-Mango Combo",
        saladPrice: '2000'),
  ];
  static List<SaladModel> newCombo = [
    SaladModel(
        saladImage: Const.avocado,
        saladName: "Avocado",
        saladPrice: '1000'),
    SaladModel(
        saladImage: Const.banana,
        saladName: "banana",
        saladPrice: '7000'),
    SaladModel(
        saladImage: Const.blueberry,
        saladName: "blueberry",
        saladPrice: '500'),
    SaladModel(
        saladImage: Const.datePalm,
        saladName: "date Palm",
        saladPrice: '3000'),
    SaladModel(
        saladImage: Const.durian,
        saladName: "durian",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.grape,
        saladName: "grape",
        saladPrice: '100'),
    SaladModel(
        saladImage: Const.grapeFuirt,
        saladName: "grape Fuirt",
        saladPrice: '900'),
    SaladModel(
        saladImage: Const.honeydew,
        saladName: "Honeydew",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.oranges,
        saladName: "oranges",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.avocado,
        saladName: "avocado",
        saladPrice: '2000'),
  ];

  static List<SaladModel> popCombo = [
    SaladModel(
        saladImage: Const.Watermelon,
        saladName: "Watermelon",
        saladPrice: '1000'),
    SaladModel(
        saladImage: Const.Strawberry,
        saladName: "Strawberry",
        saladPrice: '7000'),
    SaladModel(
        saladImage: Const.blueberry,
        saladName: "blueberry",
        saladPrice: '500'),
    SaladModel(
        saladImage: Const.Nectarine,
        saladName: "Nectarine",
        saladPrice: '3000'),
    SaladModel(
        saladImage: Const.Mandarin,
        saladName: "Mandarin",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.Pineapple,
        saladName: "Pineapple",
        saladPrice: '100'),
    SaladModel(
        saladImage: Const.Apricot,
        saladName: "Apricot",
        saladPrice: '900'),
    SaladModel(
        saladImage: Const.Coconut,
        saladName: "Coconut",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.oranges,
        saladName: "oranges",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.Lime,
        saladName: "Lime",
        saladPrice: '2000'),
  ];

  static List<SaladModel> topCombo = [
    SaladModel(
        saladImage: Const.Redcurrant,
        saladName: "Redcurrant",
        saladPrice: '1000'),
    SaladModel(
        saladImage: Const.Persimmon,
        saladName: "Persimmon",
        saladPrice: '7000'),
    SaladModel(
        saladImage: Const.Peach,
        saladName: "Peach",
        saladPrice: '500'),
    SaladModel(
        saladImage: Const.Loganberry,
        saladName: "Loganberry",
        saladPrice: '3000'),
    SaladModel(
        saladImage: Const.Keriberry,
        saladName: "Keriberry",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.Kokum,
        saladName: "Kokum",
        saladPrice: '100'),
    SaladModel(
        saladImage: Const.Kedondong,
        saladName: "Kedondong",
        saladPrice: '900'),
    SaladModel(
        saladImage: Const.Kumquat,
        saladName: "Kumquat",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.Jujube,
        saladName: "Jujube",
        saladPrice: '2000'),
    SaladModel(
        saladImage: Const.Jabuticaba,
        saladName: "Jabuticaba",
        saladPrice: '2000'),
  ];
}
