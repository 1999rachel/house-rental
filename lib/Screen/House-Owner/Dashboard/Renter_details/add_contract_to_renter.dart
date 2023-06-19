import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/contract_view.dart';

import 'check_renter_payments.dart';

class add_contract extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String renter_id;

  add_contract({Key? key, required this.renter_id}) : super(key: key);

  @override
  State<add_contract> createState() => _add_contractState();
}

class _add_contractState extends State<add_contract> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  TextEditingController paid_amount_controller = TextEditingController();
  TextEditingController gabage_amount_controller = TextEditingController();
  TextEditingController security_amount_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime startDate = DateTime.now();
  late DateTime endDate;
  bool _isLoading = false;

  @override
  void dispose() {
    paid_amount_controller.dispose();
    gabage_amount_controller.dispose();
    security_amount_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ButtonColor,
          centerTitle: true,
          title: Text(
            "Add contract",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: Colors.white,
              )),
        ),
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Container(
                    color: BackgroundColor,
                    width: double.infinity,
                    height: double.infinity,
                    child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("renters_db")
                                .doc(widget.renter_id)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot) {
                              // print (widget.renter_id);
                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('houses_db')
                                      .doc(data['house_id'])
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          houseSnapshot) {
                                    if (houseSnapshot.hasError) {
                                      Text("Something went wrong");
                                    }
                                    if (!houseSnapshot.hasData) {
                                      return Center(
                                          child: SpinKitCircle(
                                              color: ButtonColor));
                                    }
                                    if (houseSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: SpinKitCircle(
                                              color: ButtonColor));
                                    }
                                    final data = houseSnapshot.data!.data()
                                        as Map<String, dynamic>;
                                    final rent = data['rent'] as String;

                                    final rentPerMonth =
                                        houseSnapshot.data?['rent'];

                                    return SingleChildScrollView(
                                      child: Column(children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Start date",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(10))),
                                                child: InkWell(
                                                    onTap: () async {
                                                      DateTime? newDate =
                                                          await showDatePicker(
                                                              context: (context),
                                                              initialDate:
                                                                  startDate,
                                                              firstDate:
                                                                  DateTime(1900),
                                                              lastDate:
                                                                  DateTime(2100));

                                                      // if 'CANCLE '=> null
                                                      if (newDate == null)
                                                        return;
                                                      // if 'OK' = newDate

                                                      else {
                                                        setState(() {
                                                          startDate = newDate;
                                                        });
                                                      }
                                                    },
                                                    child: Align(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Text(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          "   ${startDate.day} .  ${startDate.month} .  ${startDate.year}",
                                                        ))),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Rent / mo ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 29,
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        padding: EdgeInsets.only(
                                                            left: 10, right: 20),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10))),
                                                        height: 45,
                                                        width: double.infinity,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${houseSnapshot.data?['rent']}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              Text(
                                                                "Tzs",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 16),
                                                              )
                                                            ],
                                                          ),
                                                        )))
                                              ]),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Paid amount",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                  child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter your Paid rent';
                                                  }
                                                  return null;
                                                },
                                                cursorColor: ButtonColor,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  contentPadding:
                                                      EdgeInsets.only(left: 20),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              width: 0.5,
                                                              color: Colors
                                                                  .black38)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color(0xff0748A6),
                                                            width: 0.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xff0748A6))),
                                                  hintText: "Enter paid rent  mo",
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 15),
                                                  // prefixIcon: Icon(
                                                  //   Icons.lock,
                                                  //   color: Colors.black54,
                                                  // )
                                                ),
                                                controller:
                                                    paid_amount_controller,
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Garbage cost",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                // padding: EdgeInsets.only(left: 10, right: 10),
                                                width: double.infinity,
                                                height: 45,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    contentPadding:
                                                        EdgeInsets.only(left: 20),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            borderSide: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black38)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xff0748A6),
                                                              width: 0.5,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff0748A6))),
                                                    hintText:
                                                        "Enter gabage cost per  mo",
                                                    fillColor: Colors.white,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 15),
                                                    // prefixIcon: Icon(
                                                    //   Icons.lock,
                                                    //   color: Colors.black54,
                                                    // )
                                                  ),
                                                  controller:
                                                      gabage_amount_controller,
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Security cost",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                // padding: EdgeInsets.only(left: 10, right: 10),
                                                width: double.infinity,
                                                height: 45,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    contentPadding:
                                                        EdgeInsets.only(left: 20),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            borderSide: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black38)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xff0748A6),
                                                              width: 0.5,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff0748A6))),
                                                    hintText:
                                                        "Enter security cost per  mo",
                                                    fillColor: Colors.white,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 15),
                                                    // prefixIcon: Icon(
                                                    //   Icons.lock,
                                                    //   color: Colors.black54,
                                                    // )
                                                  ),
                                                  controller:
                                                      security_amount_controller,
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        !_isLoading
                                            ? Container(
                                                width: double.infinity,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: ButtonColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(10))),
                                                child: TextButton(
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        setState(() {
                                                          _isLoading = true;
                                                        });

                                                        final paidamount =
                                                            paid_amount_controller
                                                                .text;
                                                        int paidMonths = (double.parse(
                                                                    paid_amount_controller
                                                                        .text) /
                                                                double.parse(
                                                                    houseSnapshot
                                                                            .data?[
                                                                        'rent']))
                                                            .toInt();
                                                        DateTime endDate =
                                                            DateTime(
                                                                startDate.year,
                                                                startDate.month +
                                                                    paidMonths,
                                                                startDate.day);
                                                        // print(endDate);

                                                        Future<QuerySnapshot>
                                                            renterContract =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "contracts_db")
                                                                .where(
                                                                    'renter_id',
                                                                    isEqualTo: widget
                                                                        .renter_id)
                                                                .where(
                                                                    'start_date',
                                                                    isEqualTo:
                                                                        startDate)
                                                                .get();

                                                        renterContract
                                                            .then((value) => {
                                                                  if (value.docs
                                                                          .length ==
                                                                      0)
                                                                    {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "contracts_db")
                                                                          .doc()
                                                                          .set({
                                                                        "start_date":
                                                                            startDate,
                                                                        "paid_amount":
                                                                            paid_amount_controller
                                                                                .text,
                                                                        "garbage_cost":
                                                                            gabage_amount_controller
                                                                                .text,
                                                                        "security_cost":
                                                                            security_amount_controller
                                                                                .text,
                                                                        "renter_id":
                                                                            widget
                                                                                .renter_id,
                                                                        "renter_contract":
                                                                            "",
                                                                        "end_date":
                                                                            endDate
                                                                                .toLocal(),
                                                                        "status":'active'
                                                                      }).then((value) =>
                                                                              {
                                                                                setState(() {
                                                                                  _isLoading = false;
                                                                                }),
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => contract_view(renter_id: widget.renter_id, start_date: startDate)))
                                                                              })
                                                                    }
                                                                  else
                                                                    {
                                                                      setState(
                                                                          () {
                                                                        _isLoading =
                                                                            false;
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Center(
                                                                                child: Dialog(
                                                                                  child: Container(
                                                                                      height: 130,
                                                                                      width: double.infinity,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Center(
                                                                                            child: Text(
                                                                                              softWrap: true,
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                                // fontSize: 17
                                                                                              ),
                                                                                              "Contract already added",
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 20,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(left: 20, right: 20),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  child: TextButton(
                                                                                                    onPressed: () {
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                    child: Container(
                                                                                                        height: 40,
                                                                                                        width: 150,
                                                                                                        decoration: BoxDecoration(color: ButtonColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                        child: Center(
                                                                                                          child: Text(
                                                                                                            "Ok",
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                              color: Colors.white,
                                                                                                            ),
                                                                                                          ),
                                                                                                        )),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 20,
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: TextButton(
                                                                                                    onPressed: () {

                                                                                                      FirebaseFirestore.instance.collection("contracts_db").where('renter_id',isEqualTo: widget.renter_id).where('start_date',isEqualTo:startDate).get().then((QuerySnapshot contractdate) {
                                                                                                      contractdate.docs.forEach((DocumentSnapshot document) {
                                                                                                        document.reference.delete().then((value) => Navigator.of(context).pop());

                                                                                                      });


                                                                                                      }) .catchError((error) {
                                                                                                        print("Error occured while deleting documents: $error");
                                                                                                      });

                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 40,
                                                                                                      width: 200,
                                                                                                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                          "Delete",
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: TextStyle(color: Colors.white),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                                ),
                                                                              );
                                                                            });
                                                                      })
                                                                    },
                                                                });

                                                        // then((value) => Navigator.of(
                                                        //             context)
                                                        //         .push(MaterialPageRoute(
                                                        //             builder: (context) =>
                                                        //                 check_renter_payments(
                                                        //                   renter_id: widget
                                                        //                       .renter_id,
                                                        //                 ))));
                                                      }
                                                      // final paidamount = paid_amount_controller.text.;
                                                      // int paidMonths = (paidAmount / perMonth).toInt();
                                                      // DateTime endDate = DateTime(startDate.year,
                                                      //     startDate.month + paidMonths, startDate.day);
                                                      // // print(endDate);
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                      "Submit",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ))),
                                              )
                                            : Container(
                                                child: Center(
                                                    child: SpinKitCircle(
                                                      color: ButtonColor,
                                                      size: 50,
                                                    )),
                                              )
                                      ]),
                                    );
                                  });
                            }))))));
  }
}
