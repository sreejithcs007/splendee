
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:splendee/presentation/globalWidgets/reusable_amount.dart';

import '../../../core/constants/color_constants.dart';
import '../../add_details_screen/controller/add_detail_controller.dart';

class PiechartScreen extends StatefulWidget{
  const PiechartScreen({super.key});

  @override
  State<PiechartScreen> createState() => _PiechartScreenState();
}

class _PiechartScreenState extends State<PiechartScreen> {
  @override
  Widget build(BuildContext context) {

    var totalincome = Hive.box('totalincom');
    var totalexpense = Hive.box('totalexpenss');


    return Scaffold(
      backgroundColor: const Color(0xFFE3FEF7),
      appBar: AppBar(
        title: const Center(
          child: Text("Statitics",style: TextStyle(
              fontSize: 25, color:ColorConstants.mainWhite, fontWeight: FontWeight.bold),),
        ),
        bottom: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.04), child: const Text("")),
        backgroundColor:  ColorConstants.Greenhead,),
      body: Consumer<AddDetailController>(
        
        builder: (BuildContext context, AddDetailController value, Widget? child) {

          double totalExpense = double.parse(value.totalexpense.get('expenss', defaultValue: 0).toString());
          double totalIncome = double.parse(value.totalincome.get('incomes', defaultValue: 0).toString());

          double total = totalIncome + totalExpense;

          double percentage = total != 0 ? (totalExpense * 100) / total : 0;
          double incomeper = total != 0 ? (totalIncome*100)/total : 0 ;




          return  Consumer<AddDetailController>(

            builder: (BuildContext context, AddDetailController value, Widget? child) {
              return  Column(
                children: [
                       SizedBox(
                        height:MediaQuery.of(context).size.height*0.4,
                        width: MediaQuery.of(context).size.width*0.7,
                        child:
                        (value.totalincome.get('incomes') == null && value.totalexpense.get('expenss') == null) ?
                        const Center(child: Text("No recent transaction",style: TextStyle(color: Colors.black),)) :

                        PieChart (
                            swapAnimationDuration: const Duration(milliseconds: 750),
                            swapAnimationCurve: Curves.easeInOutQuint,
                            PieChartData(
                                sections: [
                                  PieChartSectionData(
                                      radius: 80,
                                      value: double.parse(value.totalincome.get('incomes',defaultValue: 0).toString())   ,
                                      color: ColorConstants.mainBlue,
                                      title: "${incomeper.toInt()}%"

                                  ),

                                  PieChartSectionData(
                                      radius: 80,
                                      value: double.parse(value.totalexpense.get('expenss',defaultValue: 0).toString())  ,
                                      color: ColorConstants.mainRed,
                                      title: "${percentage.toInt()}%"
                                  ),

                                ]
                            )

                        ),
                      ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:MediaQuery.of(context).size.height*0.02,
                        width: MediaQuery.of(context).size.width*0.04,
                        decoration: const BoxDecoration(
                          color: ColorConstants.mainBlue
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02),
                        child: const Text("Income",style: TextStyle(fontSize:15,color: ColorConstants.mainBlack),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08),
                        child: Container(
                          height:MediaQuery.of(context).size.height*0.02,
                          width: MediaQuery.of(context).size.width*0.04,
                          color: ColorConstants.mainRed,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02),
                        child: const Text("Expense", style: TextStyle(fontSize:15,color: ColorConstants.mainBlack),),
                      )
                    ],
                  ),


                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.09),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width*.95,
                      decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // CircleAvatar(
                          //   child: Center(
                          //     child: Text("⇙",
                          //         style: TextStyle(
                          //             color: Colors.green[900],
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 25)),
                          //   ),
                          // ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Income",
                                style: TextStyle(
                                    color: ColorConstants.mainBlack, fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.06,
                                width: MediaQuery.of(context).size.width*0.4,
                                child: Center(
                                  child: Text(
                                     "${ ReusableAmount.formatNumber(totalincome.get('incomes') ?? 0)}",
                                      style: const TextStyle(
                                          color: ColorConstants.mainBlack,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin:
                            const EdgeInsets.symmetric(vertical: 10),
                            color: Colors.black.withOpacity(0.4),
                            width: 1,
                          ),
                          // const CircleAvatar(
                          //   child: Text("⇗",
                          //       style: TextStyle(
                          //           color: ColorConstants.mainRed,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 25)),
                          // ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Expense",
                                style: TextStyle(
                                    color: ColorConstants.mainBlack, fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(

                                height: MediaQuery.of(context).size.height*0.06,
                                width: MediaQuery.of(context).size.width*0.4,
                                child: Center(
                                  child: Text(
                                      ReusableAmount.formatNumber(totalexpense.get('expenss') ?? 0),
                                      style: const TextStyle(
                                          color: ColorConstants.mainBlack,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),


                ],
              );
            },

          ) ;
        },
         
      ),
    );
  }
}