import 'package:flutter/material.dart';

class add_contract extends StatefulWidget {
  const add_contract({Key? key}) : super(key: key);

  @override
  State<add_contract> createState() => _add_contractState();
}

class _add_contractState extends State<add_contract> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);

  DateTime date1 = DateTime.now();
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
          child: Container(
        color: BackgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 25,
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
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: (context),
                                initialDate: date1,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            // if 'CANCLE '=> null
                            if (newDate == null)
                              return;
                            // if 'OK' = newDate

                            else {
                              setState(() {
                                date1 = newDate;
                              });
                            }
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${date1.day}/ ${date1.month}/ ${date1.year}",
                                style: TextStyle(color: Colors.black),
                              ))),
                    )

                    )
                  ],
                ),
              ),
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
                height: 20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
