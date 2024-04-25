import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splendee/presentation/globalWidgets/reusable_amount.dart';

import '../../../core/constants/color_constants.dart';
import '../../add_details_screen/controller/add_detail_controller.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<StatefulWidget> createState() => ExpenseScreenState();
}

class ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState(); WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddDetailController>(context, listen: false).getalldetails();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  ColorConstants.Greenback,
      body: Consumer<AddDetailController>(

        builder: (BuildContext context, AddDetailController value, Widget? child) {

          return  SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              onRefresh: () async {
                Provider.of<AddDetailController>(context, listen: false)
                    .getalldetails();
              },
              child: Provider.of<AddDetailController>(context, listen: false)
                  .revexpense
                  .isEmpty
                  ? const Center(
                  child: Text(
                    "No recent transations",
                    style: TextStyle(color:ColorConstants.mainBlack,fontSize: 20),
                  ))
                  : Consumer<AddDetailController>(
                builder: (context, controller, child) {
                  return ListView.builder(
                    itemCount: controller.revexpense.length,
                    itemBuilder: (context, index) {
                      // print(
                      //     "length expense = ${controller.revexpense.length}");
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.red[100] ?? ColorConstants.mainRed , ColorConstants.mainRed]),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blueGrey[200] ?? ColorConstants.mainGrey,
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ListTile(
                              leading: const Text("⇗",
                                  style: TextStyle(
                                      color: ColorConstants.mainRed,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              title: Text(
                                  "${controller.revexpense[index].description}",
                                  style: const TextStyle(
                                      color: ColorConstants.mainBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              subtitle: Text(
                                  "${controller.revexpense[index].category}",
                                  style: TextStyle(
                                      color: Colors.grey[850],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              trailing: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    ReusableAmount.formatNumber(int.parse(controller.revexpense[index].amount ?? '0')),
                                    style: const TextStyle(
                                        color: ColorConstants.mainBlack, fontSize: 20),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy ').format(DateTime.parse(controller.revexpense[index].date ?? " ")),
                                    style: const TextStyle(
                                        color: ColorConstants.mainBlack, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },

      ),
    );
  }
}
