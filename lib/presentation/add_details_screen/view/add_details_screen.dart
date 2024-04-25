import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../repository/model/expensemodel.dart';
import '../../globalWidgets/resuable_alertbox.dart';
import '../controller/add_detail_controller.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddDetailsScreenState();
}

class AddDetailsScreenState extends State<AddDetailsScreen> {



  var formkey = GlobalKey<FormState>();
  var amountController = TextEditingController();
  var descriptionController = TextEditingController();
  var categories = [
    'Food 🍔',
    'Travel 🌍',
    'Bill 📜 ',
    'Rent 🏠',
    'Groceries 🛒',
    "Pharmacy 💊",
    "Shopping 🛍️",
    "Gifts 🎁",
    "Entertainment 🎦",
    "pets 🐕",
  ];
  String? dropdownvalue;

  String? currencyvalue;

  String? transaction;
  var transationtype = ['Income', "Expense"];
  var currencys = [
    'IND',
    'USD',
  ];

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.Greenback,
          appBar: AppBar(
            backgroundColor:  ColorConstants.Greenhead,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,color: ColorConstants.mainWhite,)),
            title: const Text("New Transaction",style: TextStyle(color: ColorConstants.mainWhite,fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
              child: Form(
                key: formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Add new expense",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Enter the details of your expense to help you track your spending ",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          "Enter Amount",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    height:
                                        MediaQuery.of(context).size.height *
                                            .05,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE3FEF7),
                                    ),
                                    child: const Text(
                                      "₹",
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ),
                              border: const OutlineInputBorder()),
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          validator: (amt) {
                            if (amt!.isEmpty) {
                              return "This Field is required";
                            }
                            else if(amt!.length > 16){
                              return "Maximum upto 15 characters can be added";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          validator: (des) {
                            if (des!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          controller: descriptionController,
                          decoration: const InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (value){
                              if(value == null){
                                return "This field is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            isExpanded: true,
                            hint: const Text("Please choose a category"),
                            value: dropdownvalue,
                            items: categories.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Transaction Type",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (typ) {
                            if (typ==null) {
                              return "This field is required";
                            }
                            return null;
                          },
                         // isExpanded: true,
                          hint: const Text("Please choose a Type"),
                          value: transaction,
                          items: transationtype.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              transaction = newValue!;
                            });
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      var picked = await showDatePicker(
                                          context: context,
                                          initialDate: selectedDate,
                                          firstDate: DateTime(2015, 8),
                                          lastDate: DateTime(2101));
                                      if (picked != null &&
                                          picked != selectedDate) {
                                        setState(() {
                                          selectedDate = picked;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month)),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 20),
                        child: MaterialButton(
                            color: ColorConstants.Greenhead,
                            height: MediaQuery.of(context).size.height * 0.06,
                            minWidth: double.infinity,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              var valid = formkey.currentState!.validate();
                              if (valid == true) {
                                var value = ExpenseModel(
                                    amount: amountController.text,
                                    description: descriptionController.text,
                                    category: dropdownvalue,
                                    transactiontype: transaction,
                                    date: selectedDate.toString());
                                Provider.of<AddDetailController>(context,
                                        listen: false)
                                    .expenseList(value);

                                  Provider.of<AddDetailController>(context,
                                      listen: false).totalbalance(value: value);

                                await ReusableAlertBox(title: 'Are you sure')
                                    .showMyDialog(context);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Add Expense",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
