import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/payments/payments_per_individual.dart';

class renter_payments extends StatefulWidget {
  const renter_payments({Key? key}) : super(key: key);

  @override
  State<renter_payments> createState() => _renter_paymentsState();
}

class _renter_paymentsState extends State<renter_payments> {

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

        }, icon: Icon(Icons.arrow_back_ios,color:Colors.white,size: 24,)),

        title: Text("Payments",style: TextStyle(
          color: Colors.white,fontSize: 17
        ),),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: BackgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              // child:  Padding(padding: EdgeInsets.only(left: 20,right: 20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  payments_per_individual())
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 80,
                          color: Colors.white,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      "assets/profile1.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(50)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Juma Ally Shamba",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text("House no."),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "01",
                                        style: TextStyle(
                                            color: Color(0xffC21F1F)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Expanded(child: Container()),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 10),
            ),
          ],
        )
      ),
    ));
  }
}
