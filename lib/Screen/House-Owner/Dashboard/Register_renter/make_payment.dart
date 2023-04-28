import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class make_payments extends StatefulWidget {
  const make_payments({Key? key}) : super(key: key);

  @override
  State<make_payments> createState() => _make_paymentsState();
}

class _make_paymentsState extends State<make_payments> {

  DateTime paymentDate = DateTime.now();

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: ButtonColor,
        centerTitle: true,
        title: Text("Payments",style: TextStyle(color: Colors.white,fontSize: 17),),
        
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,size: 24,color:Colors.white,)),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: BackgroundColor,

        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
          children: [

            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    "Date     ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width:60 ,
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
                              DateTime? newDate = await showDatePicker(context: (context), initialDate: paymentDate, firstDate: DateTime(1900), lastDate: DateTime(2100));

                              // if 'CANCLE '=> null
                              if(newDate==null) return;
                              // if 'OK' = newDate

                              else {
                                setState(() {
                                  paymentDate = newDate;
                                });
                              }

                            },child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${paymentDate.day}. ${paymentDate.month}. ${paymentDate.year}",style: TextStyle(color: Colors.black),))),
                      )
                  ),

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
                    "Control number",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    width: 15,
                  ),

                  Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        width: double.infinity,
                        height: 45,
                        child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("99001245789465",style: TextStyle(color: Colors.black),))


                      )
                  ),
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
                    "Resit    ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    width: 65,
                  ),

                  Expanded(
                      child: Container(height: 45,
                      padding: EdgeInsets.only(left: 10,right: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextButton(onPressed: (){}, child: Text("Upload resit",textAlign: TextAlign.start,style: TextStyle(color: Colors.black),)),
                      )
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),



            Container(

              width: double.infinity,
              margin: EdgeInsets.only(bottom: 50,top: 20),
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xff0748A6),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const make_payments()));

                  },
                  // onPressed: signIn,
                  child: (Text(
                    "Submit",
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
