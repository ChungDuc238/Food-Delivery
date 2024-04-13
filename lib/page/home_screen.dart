import 'package:flutter/material.dart';
import 'package:food_apps/assets/const.dart';

import '../model/salad_model.dart';
import '../ui_widget/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;
  String? nameOfBuyer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the tab controller
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      nameOfBuyer = args.toString();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Add GlobalKey

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey, // Assign GlobalKey to Scaffold

        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          title: const Text(
            'Food Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $nameOfBuyer, What fruit salad \ncombo do you want today?",
                  style: Const.headerText,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  Const.recommend,
                  style: Const.h1HeaderText,
                ),
                Container(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  height: 200,
                  child: _buildAllProduct(),
                ),
                SizedBox(
                  height: 50,
                  child: Container(
                    color: Colors.blueGrey,
                    child: TabBar(
                      controller: _tabController,
                      labelStyle: const TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle:
                          const TextStyle(fontSize: 15, color: Colors.grey),
                      indicatorColor: Const.hexToColor(Const.appColor),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(
                          text: 'Hot',
                        ),
                        Tab(text: 'New'),
                        Tab(text: 'Pop'),
                        Tab(text: 'Top'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        color: Colors.orangeAccent,
                        child: _buildAllProductTabs(),
                      ),
                      Container(
                        color: Colors.green.shade400,
                        child: _buildAllProductTabs(),
                      ),
                      Container(
                        color: Colors.red.shade400,
                        child: _buildAllProductTabs(),
                      ),
                      Container(
                        color: Colors.blue.shade400,
                        child: _buildAllProductTabs(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ]),
        ),
      ),
    );
  }
}

//Products
_buildAllProduct() => GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: MySaladModel.myInfoAllList.length,
      itemBuilder: (context, index) {
        final allItem = MySaladModel.myInfoAllList[index];

        return CardWidget(infoModel: allItem);
      },
      scrollDirection: Axis.horizontal,
    );

// Tab Products
_buildAllProductTabs() => GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: MySaladModel.myInfoAllList.length,
      itemBuilder: (context, index) {
        final allItem = MySaladModel.myInfoAllList[index];

        return CardWidget(infoModel: allItem);
      },
      scrollDirection: Axis.vertical,
    );

_navigationDrawerItem(BuildContext context, String? nameOfBuyer) =>
    ListView(children: [
      Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              child: Image.asset(
                Const.profilePic,
              ),
            ),
          ),
          Text(
            nameOfBuyer!,
            style: Const.h11HeaderText,
          ),
        ],
      ),
      const NaviGationButton(
        page: '/trackOrder',
        icons: Const.checked,
        text: 'Track Order',
        width: 30,
        height: 30,
      ),
      const NaviGationButton(
        page: '',
        icons: Const.favoriteFull,
        text: 'Favorite Salad',
        width: 30,
        height: 30,
      ),
      const NaviGationButton(
        page: '',
        icons: Const.checked,
        text: 'Track Order',
        width: 30,
        height: 30,
      ),
    ]);

class NaviGationButton extends StatelessWidget {
  final String text;
  final String icons;
  final double width, height;
  final String page;

  const NaviGationButton(
      {super.key,
      required this.text,
      required this.icons,
      required this.width,
      required this.height,
      required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, page);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: ListTile(
          leading: Image.asset(
            icons,
            width: width,
            height: height,
          ),
          title: Text(
            text,
            style: Const.navTextStyle,
          ),
        ),
      ),
    );
  }
}
