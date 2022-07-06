
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdm_driving/tabPage/accountTab.dart';
import 'package:jdm_driving/tabPage/earningTab.dart';
import 'package:jdm_driving/tabPage/homeTab.dart';
import 'package:jdm_driving/tabPage/ratingTab.dart';
import 'package:jdm_driving/theme/reusableColor.dart';

class MainPage extends StatefulWidget {
  static const id='/mainpage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int selectedItem=0;
  TabController? tabController;



  onItemClick(int index){
   setState(() {
     selectedItem=index;
     tabController!.index=selectedItem;
   });
  }
  bool? _isCheck =false;
  final formkey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
        HomeTabPage(),
        EarningTabPage(),
        RatingTabPage(),
        AccountTabPage(),
      ]),
bottomNavigationBar: BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
    label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on_outlined),
      label: 'Earning',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star_border),
      label: 'Rating',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Account',
    ),
  ],
  backgroundColor:JColor.secondaryColor ,
  currentIndex: selectedItem,
  onTap: onItemClick,
selectedLabelStyle: TextStyle(fontSize: 15),
  showUnselectedLabels: true,
  unselectedItemColor: Colors.white54,
  selectedItemColor: Colors.white,
  type: BottomNavigationBarType.fixed,
    ));


  }
  }