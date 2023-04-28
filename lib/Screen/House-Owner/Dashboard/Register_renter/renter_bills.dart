import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constitution_document_page.dart';
import 'make_payment.dart';

class renter_bills extends StatefulWidget {
  const renter_bills({Key? key}) : super(key: key);

  @override
  State<renter_bills> createState() => _renter_billsState();
}

class _renter_billsState extends State<renter_bills> {

  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ButtonColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            )),
        title: Text(
          "Renter bills",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: BackgroundColor),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "House rent",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "150000",
                            style: TextStyle(color: Colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                "Tzs/",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Mo",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Garbage    ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "150000",
                            style: TextStyle(color: Colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                "Tzs/",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Mo",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cooperative defence",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                 
                    SizedBox(
                      width: 10,
                    ),

                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1500",
                            style: TextStyle(color: Colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                "Tzs/",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Mo",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Start date",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width:10 ,
                    ),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10),

                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: InkWell(

                              onTap: () async {
                                DateTime? newDate = await showDatePicker(context: (context), initialDate: date1, firstDate: DateTime(1900), lastDate: DateTime(2100));

                                // if 'CANCLE '=> null
                                if(newDate==null) return;
                                // if 'OK' = newDate

                                else {
                                  setState(() {
                                    date1 = newDate;
                                  });
                                }

                              },child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${date1.day}. ${date1.month}. ${date1.year}",style: TextStyle(color: Colors.black),))),
                        )
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "End date",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width:10 ,
                    ),
                    Expanded(
                        child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10),

                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: InkWell(

                              onTap: () async {
                                DateTime? newDate = await showDatePicker(context: (context), initialDate: date2, firstDate: DateTime(1900), lastDate: DateTime(2100));

                                // if 'CANCLE '=> null
                                if(newDate==null) return;
                                // if 'OK' = newDate

                                else {
                                  setState(() {
                                    date2 = newDate;
                                  });
                                }

                              },child: Align(
                            alignment: Alignment.centerLeft,
                              child: Text("${date2.day}. ${date2.month}. ${date2.year}",style: TextStyle(color: Colors.black),))),
                        )
                    )
                  ],
                ),
              ),


              Expanded(child: Container()),


              Container(

                width: double.infinity,
                margin: EdgeInsets.only(bottom: 50,top: 20),
                height: 45,
                decoration: BoxDecoration(
                    color: ButtonColor,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: (){

                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const constitution_document()));

                    },
                    // onPressed: signIn,
                    child: (Text(
                      "Save",
                      style:
                      TextStyle(color: Colors.white, fontSize: 17),
                    ))),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
