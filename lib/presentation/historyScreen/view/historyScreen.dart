import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import '../../expense/view/expensescreen.dart';
import '../../incomescreen/view/incomescreen.dart';

class HistoryScreen extends StatefulWidget{
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => HistoryScreenState();

}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.Greenhead,
          title: const Center(child: Text("Transactions",style:  TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorConstants.mainWhite),)),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.04),
            child: const TabBar(
              tabs: [
              Text("Expense",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: ColorConstants.mainWhite),),
              Text("Income",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: ColorConstants.mainWhite),)
            ],
            indicatorColor: ColorConstants.mainorange,
            ),
          ),
        ),

      body:TabBarView(children: [ExpenseScreen(),IncomeScreen()],) ,

      ),
    );
  }
}