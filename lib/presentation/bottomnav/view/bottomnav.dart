
import 'package:flutter/material.dart';


import '../../../core/constants/color_constants.dart';
import '../../add_details_screen/view/add_details_screen.dart';
import '../../historyScreen/view/historyScreen.dart';
import '../../homescreen/view/homescreen.dart';
import '../../piechart/view/piechartview.dart';



class BottomNav extends StatefulWidget{
  final String? getuser;
  BottomNav(this.getuser, {super.key});

  @override
  State<StatefulWidget> createState()=> BottomNavState();


}

class BottomNavState extends State<BottomNav> {
  var tapedindex=0;
  late List screens;

  @override
  void initState() {
    screens = [HomeScreen(widget.getuser),PiechartScreen(), const HistoryScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDetailsScreen()));
        },
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: ColorConstants.Greenhead,
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: ColorConstants.Greenhead,

      elevation: 2,
      items: const [
      BottomNavigationBarItem(icon:Icon( Icons.home,),label:"Home"),
        BottomNavigationBarItem(icon:Icon( Icons.bar_chart,),label:"Stats"),
      BottomNavigationBarItem(icon: Icon(Icons.compare_arrows),label: "Transactions")
    ],
      onTap: (index){
      setState(() {
        tapedindex = index;
      });
      },
      currentIndex: tapedindex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,


    ),

      body: screens[tapedindex],
    );
  }


  }
