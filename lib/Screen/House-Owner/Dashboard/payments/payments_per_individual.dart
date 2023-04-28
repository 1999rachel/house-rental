import 'package:flutter/material.dart';

import '../Renter_details/resit_view.dart';

class payments_per_individual extends StatefulWidget {
  const payments_per_individual({Key? key}) : super(key: key);

  @override
  State<payments_per_individual> createState() => _payments_per_individualState();
}

class _payments_per_individualState extends State<payments_per_individual> {

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ButtonColor,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

        }, icon: Icon(Icons.arrow_back_ios,size: 24,color: Colors.white,)),
        title: Text("Payments",style: TextStyle(color: Colors.white,fontSize: 17),),
      ),

      body:  Container(
          width: double.infinity,
          height: double.infinity,
          color: BackgroundColor,
          child: Column(
            children: [
              SizedBox(height: 10,),

              Expanded(
                // child:  Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 90,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Date",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 42,
                                  ),
                                  Text(
                                    "13.3.2023",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Account",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "95346772719871771",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 1),
                                    decoration: BoxDecoration(
                                        color: Color(0xff0748A6),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    height: 30,
                                    width: 95,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          resit_view()));
                                            },
                                            child: Text(
                                              "view resits",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 20),
              ),
            ],
          )),
    ));
  }
}
