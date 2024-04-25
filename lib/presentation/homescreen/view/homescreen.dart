import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../add_details_screen/controller/add_detail_controller.dart';
import '../../globalWidgets/reusable_amount.dart';
import '../../historyScreen/view/historyScreen.dart';

class HomeScreen extends StatefulWidget {
  final String? getuser;
  const HomeScreen(this.getuser, {super.key,});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var balanceCont = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<AddDetailController>(context, listen: false).getalldetails();});
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var totalincome = Hive.box('totalincom');
    var totalexpense = Hive.box('totalexpenss');
    var totalbalance = Hive.box('balance');

    return Scaffold(
      backgroundColor: ColorConstants.Greenback,
      appBar: AppBar(

        backgroundColor: ColorConstants.Greenhead,
        title: Text(
          "Welcome ${widget.getuser} ",
          style: const TextStyle(
              fontSize: 25, color: ColorConstants.mainWhite, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.04), child: const Text("")),
      ),
      body: Consumer<AddDetailController>(

        builder: (BuildContext context, AddDetailController value, Widget? child) {

          return  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [


              Padding(
                padding:  const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.99,
                  decoration: BoxDecoration(
                      color: ColorConstants.Greenbox,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Available Balance",
                          style: TextStyle(
                            color: ColorConstants.mainBlack,
                            fontSize: 25,
                            //    fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Consumer<AddDetailController>(
                        builder: (BuildContext context, AddDetailController value,
                            Widget? child) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: InkWell(
                              onTap: () async {
                                return showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(" Enter Avaialable balance"),
                                        content: TextFormField(
                                          controller: balanceCont,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder()),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Provider.of<AddDetailController>(
                                                  context,
                                                  listen: false)
                                                  .Addbalance(
                                                  value: balanceCont.text);
                                              Navigator.pop(context);
                                              balanceCont.clear();
                                            },
                                            child: const Text("Yes"),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No"),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "${totalbalance.get('baln') == null ? "Tap to add balance" : "₹ ${ReusableAmount.formatNumber(totalbalance.get('baln'))}"} ",
                                style: TextStyle(
                                    color: ColorConstants.mainBlack,
                                    fontSize:
                                    totalbalance.get('baln') == null ? 20 : 35,
                                    fontWeight: totalbalance.get('baln') == null
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Consumer<AddDetailController>(
                          builder: (BuildContext context, AddDetailController value,
                              Widget? child) {

                            return Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.13,
                                width: MediaQuery.of(context).size.width * 0.9,
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
                                              color: ColorConstants.mainBlack, fontSize: 20),
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
                                      color: ColorConstants.mainBlack.withOpacity(0.4),
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
                                              color: ColorConstants.mainBlack, fontSize: 20),
                                        ),
                                        SizedBox(

                                          height: MediaQuery.of(context).size.height*0.06,
                                          width: MediaQuery.of(context).size.width*0.4,
                                          child: Center(
                                            child: Text(
                                                ReusableAmount.formatNumber((totalexpense.get('expenss') ?? 0)),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      MaterialButton(
                        shape: const StadiumBorder(),
                        color: const Color(0xFF135D66),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryScreen()));
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Provider.of<AddDetailController>(context, listen: false).rev.isEmpty
                  ? Consumer<AddDetailController>(
                builder: (BuildContext context, AddDetailController value,
                    Widget? child) {
                  return const Expanded(
                      child: Center(
                          child: Text(
                            "No recent transactions",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )));
                },
              )
                  : Consumer<AddDetailController>(
                builder: (BuildContext context, AddDetailController value,
                    Widget? child) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: value.rev.length,
                        itemBuilder: (context, index) {
                          // print(
                          //     "datas ${value.rev.length}");
                          // print(
                          //     "income ${value.totalincome.toString()}");

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                              MediaQuery.of(context).size.height * 0.10,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        value.rev[index].transactiontype ==
                                            "Income"
                                            ? Colors.green
                                            : Colors.red,
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ListTile(
                                  leading: Text(
                                    value.rev[index].transactiontype == "Income" ? "⇙" : "⇗",
                                    style: TextStyle(
                                        color:
                                        value.rev[index].transactiontype ==
                                            "Income"
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  title: Text(
                                      value
                                          .rev[index]
                                          .description
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  subtitle: Text(
                                      value.rev[index].category.toString(),
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  trailing: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(value.rev[index].transactiontype == "Income" ? "+  ${ReusableAmount.formatNumber(int.parse(value.rev[index].amount ?? "0") ?? 0)}" : "- ${ReusableAmount.formatNumber(int.parse(value.rev[index].amount ?? "0") ?? 0)}",
                                          style: TextStyle(
                                              color: Provider.of<AddDetailController>(
                                                  context)
                                                  .rev[index]
                                                  .transactiontype ==
                                                  "Income"
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 20)),
                                      Text(
                                        "${DateFormat('dd-MM-yyyy ').format(DateTime.parse(value.rev[index].date ?? " "))} ",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
              )
            ],
          );
        },

      ),
    );
  }
}
