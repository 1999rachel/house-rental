import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/add_contract_to_renter.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../account/account.dart';
import '../dashboard.dart';

class contract_view extends StatefulWidget {
  String renter_id;
  DateTime start_date;

  contract_view({Key? key, required this.renter_id, required this.start_date})
      : super(key: key);

  @override
  State<contract_view> createState() => _contract_viewState();
}

class _contract_viewState extends State<contract_view> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final CardColor = const Color(0xffFBFBFB);
  String formatedDate = '';
  bool Containervisibility = false;

  String renterFullname = '';
  String renterPhoneNumber = '';
  String houseOwnerFullname = '';
  String houseNumber = '';
  String houseRent = '';
  bool showContainer = false;

  bool renterHasSigned = false;
  Uint8List renterSignature = Uint8List.fromList([]);

  bool houseOwnerHasSigned = false;
  Uint8List houseOwnerSignature = Uint8List.fromList([]);

  SignatureController renter_signature_controller = SignatureController(
      exportBackgroundColor: Colors.white, exportPenColor: Colors.black);
  SignatureController house_owner_signature_controller = SignatureController(
      exportBackgroundColor: Colors.white, exportPenColor: Colors.black);

  //
  // @override
  // void initState() {
  //   fetch_state_date();
  //   super.initState();
  // }

  // void fetch_state_date() {
  //   FirebaseFirestore.instance
  //       .collection("contract_db")
  //       .where('renter_id', isEqualTo: widget.renter_id)
  //       .get().then((QuerySnapshot querySnapshot) => {
  //         querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
  //           Timestamp startDateTimestamp = documentSnapshot.get('start_date');
  //           // DateTime start_date = startDateTimestamp.toDate();
  //            DateTime startDate = startDateTimestamp.toDate();
  //           extractDateAndMonth(startDate as Timestamp);
  //         })
  //
  //   });
  //
  // }
  // void extractDateAndMonth(Timestamp startDate){
  //   setState(() {
  //
  //     formatedDate = DateFormat('dd-mm-yyyy').format(startDate as DateTime);    });
  //
  //
  // }

  void fetchRenterDetails() {
    Future<DocumentSnapshot> renter = FirebaseFirestore.instance
        .collection('renters_db')
        .doc(widget.renter_id)
        .get();
    renter.then((value) => {
          setState(() {
            renterFullname = value['full_name'];
            renterPhoneNumber = value['primary_phone_number'];
          }),
          fetchHouseOwnerDetails(value['house_owner_id']),
          fetchHouseDetails(value['house_id']),
        });
  }

  void fetchHouseOwnerDetails(String house_owner_id) {
    Future<DocumentSnapshot> houseOwner = FirebaseFirestore.instance
        .collection('house_owner_db')
        .doc(house_owner_id)
        .get();
    houseOwner.then((value) => {
          setState(() {
            houseOwnerFullname = value['full_name'];
          }),
        });
  }

  void fetchHouseDetails(String house_id) {
    Future<DocumentSnapshot> house =
        FirebaseFirestore.instance.collection('houses_db').doc(house_id).get();
    house.then((value) => {
          setState(() {
            houseNumber = value['house_no'];
            houseRent = value['rent'];
          }),
        });
  }



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchRenterDetails();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ButtonColor,
        centerTitle: true,
        // leading: Container(),
         leading: IconButton(onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard()));

         }, icon: Icon(Icons.arrow_back_ios_new,size: 24,color: Colors.white,)),
        title: Text(
          "Contract",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        actions: [
          IconButton(
            onPressed: () {

              setState(() {
                showDialog(context: context, builder: (context){
                  return Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 180,
                      width: 300,
                      // width: 150,

                      child: Align(
                        alignment: Alignment.topRight,
                        child: Dialog(
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                      height: 45,
                                      decoration:BoxDecoration(
                                        // color: ButtonColor,
                                        borderRadius: BorderRadius.all(Radius.circular(10))

                                      ) ,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [

                                              Icon(Icons.dashboard,size: 24,color: Colors.black54,),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("back to dashboard",style: TextStyle(color: Colors.black),)
                                            ],
                                          )))),


                              TextButton(
                                  onPressed: () {

                                    FirebaseFirestore.instance.collection("contracts_db").where('renter_id',isEqualTo: widget.renter_id).where('start_date',isEqualTo:widget.start_date).get().then((QuerySnapshot contractdate) {
                                      contractdate.docs.forEach((DocumentSnapshot document) {
                                        document.reference.delete().then((value) =>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add_contract(renter_id: widget.renter_id))));


                                      });


                                    }) .catchError((error) {
                                      print("Error occured while deleting documents: $error");
                                    });

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                      height: 45,
                                      decoration:BoxDecoration(
                                        // color: ButtonColor,
                                        borderRadius: BorderRadius.all(Radius.circular(10))

                                      ) ,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [

                                              Icon(Icons.delete,size: 24,color: Colors.black54,),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("delete contract",style: TextStyle(color: Colors.black),)
                                            ],
                                          )))),


                            ],
                          ),
                        ),
                      )
                    ),
                  );
                });
              });


            },
            icon: Icon(
              Icons.more_horiz,
              size: 24,
              color: Colors.white,
            ),
          )
        ],
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios_new,
        //       size: 24,
        //     )),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext, c) {
            final width = c.maxWidth;
            var fontSize = 16.0;
            if (width <= 480) {
              fontSize = 16.0;
            } else if (width > 480 && width <= 960) {
              fontSize = 22.0;
            } else {
              fontSize = 28.0;
            }

            return Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("contracts_db")
                        .where('renter_id', isEqualTo: widget.renter_id)
                        .where('start_date', isEqualTo: widget.start_date).where('status', isEqualTo:'active')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Dialog(
                                    child: Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  // fontSize: 17
                                                ),
                                                "Something went wrong",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              });
                        });
                      }


                      if (snapshot.hasData) {
                        QueryDocumentSnapshot contractDocument =
                            snapshot.data.docs[0];

                        Timestamp startTimestamp =
                            contractDocument['start_date'];
                        Timestamp endTimestamp = contractDocument['end_date'];

                        DateTime startDate = startTimestamp.toDate();
                        DateTime endDate = endTimestamp.toDate();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "MKATABA WA KUKODISHA CHUMBA CHA MAKAZI.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    wordSpacing: 5,
                                    decoration: TextDecoration.underline,
                                    height: 1.2,
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            SizedBox(height: 10),

                            Container(
                              child: RichText(
                                softWrap: true,
                                text: TextSpan(
                                    style: TextStyle(
                                      wordSpacing: 5,
                                      height: 1.5,
                                      // fontSize: ,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Makubaliano haya yamefanyika siku ya tarehe ',
                                      ),
                                      TextSpan(
                                        text:
                                            '${startDate.day} . ${startDate.month} .${startDate.year}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ]),
                              ),
                              // child: Text("Makubaliano haya yamefanyika siku ya tarehe ${'14 . 5. 2014'}",softWrap: true,),
                            ),


                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                textAlign: TextAlign.center,
                                "BAINA YA",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: RichText(
                                softWrap: true,
                                text: TextSpan(
                                    style: TextStyle(
                                      wordSpacing: 5,
                                      height: 1.5,
                                      // fontSize: ,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Ndugu ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${houseOwnerFullname}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'wa Dodoma ambae ndani ya mkataba huu anajulikana kama mmiliki wa nyumba/chumba na ndugu  ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${renterFullname}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          // wordSpacing: 10,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  Mwenye namba ya simu ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${renterPhoneNumber}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          // wordSpacing: 10,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '  ambae ndani ya mkataba hujulikana kama mpangaji ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'mpangaji',
                                        style: TextStyle(
                                            color: Colors.black,
                                            wordSpacing: 5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '  wa chumba/nyumba (jina la chumba/nyumba) ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${houseNumber}.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            wordSpacing: 5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              // child: Text("Makubaliano haya yamefanyika siku ya tarehe ${'14 . 5. 2014'}",softWrap: true,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: RichText(
                                softWrap: true,
                                text: TextSpan(
                                    style: TextStyle(
                                      wordSpacing: 5,
                                      height: 1.5,
                                      // fontSize: ,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Mkataba huu unatakiwa kulipwa kila mwezi kiasi cha Tzsh ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${houseRent}/=.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ]),
                              ),
                              // child: Text("Makubaliano haya yamefanyika siku ya tarehe ${'14 . 5. 2014'}",softWrap: true,),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: RichText(
                                softWrap: true,
                                text: TextSpan(
                                    style: TextStyle(
                                      wordSpacing: 5,
                                      height: 1.5,
                                      // fontSize: ,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Kodi imelipwa leo tarehe ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${startDate.day}. ${startDate.month}. ${startDate.year} ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Mpaka tarehe  ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${endDate.day}. ${endDate.month}. ${endDate.year}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  Kiasi kilicholipwa ni Tzsh  ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${contractDocument['paid_amount']}/=',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  Kwa masharti yafuatayo  ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                    ]),
                              ),
                              // child: Text("Makubaliano haya yamefanyika siku ya tarehe ${'14 . 5. 2014'}",softWrap: true,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '1. Kodi ilipwe kwa muda muafaka.',
                                    softWrap: true,
                                    style: TextStyle(
                                        height: 1.5,
                                        wordSpacing:
                                            5 // set the height to add space between lines
                                        ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '2. Upangaji baina ya mpangaji na mmiliki  wa nyumba  hautakiwi/ hairuhusiwi.',
                                    softWrap: true,
                                    style: TextStyle(
                                        height: 1.5,
                                        wordSpacing:
                                            5 // set the height to add space between lines
                                        ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '3. Zingatia muda wa kumaliza mkataba.',
                                    softWrap: true,
                                    style: TextStyle(
                                        height: 1.5,
                                        wordSpacing:
                                            5 // set the height to add space between lines
                                        ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '4. Endapo utataka kuhama toa taarifa kabla ya miezi mitatu (3).',
                                    softWrap: true,
                                    style: TextStyle(
                                        height: 1.5,
                                        wordSpacing:
                                            5 // set the height to add space between lines
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: RichText(
                                softWrap: true,
                                text: TextSpan(
                                    style: TextStyle(
                                      wordSpacing: 5,
                                      height: 1.5,
                                      // fontSize: ,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Mimi  ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${renterFullname} ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '  Nimekubali kupanga chumba/ nyumba  kwa kufuata masharti ya mkataba na kodi tuliyokubaliana . Endapo mmoja wetu katika mkataba atayavunja/ kwenda kinyume na masharti  ya makubaliano haya basi mkataba huu utavunjika hata kabla ya mda tajwa hapo juu.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          wordSpacing: 5,
                                        ),
                                      ),
                                    ]),
                              ),
                              // child: Text("Makubaliano haya yamefanyika siku ya tarehe ${'14 . 5. 2014'}",softWrap: true,),
                            ),

                            SizedBox(
                              height: 25,
                            ),

                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MTEJA",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "JINA:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            // fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${renterFullname}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                wordSpacing: 5,
                                                height: 1.5,
                                                fontSize: 15,
                                                // decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "TAREHE:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            // fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${startDate.day}. ${startDate.month}. ${startDate.year}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                wordSpacing: 5,
                                                height: 1.5,
                                                fontSize: 15,
                                                // decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SAHIHI :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                            // fontSize: 17
                                            ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      renterHasSigned
                                          ? Image.memory(
                                        renterSignature,
                                      )
                                          : Expanded(
                                        child: Container(
                                          height: 200,
                                          // padding: EdgeInsets.only(left: 10,right: 10),
                                          width: double.infinity,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  // margin: EdgeInsets.only(bottom: 10),
                                                  color: Colors.black12,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                          onPressed:
                                                              () async {
                                                            setState(
                                                                    () async {
                                                                  renterHasSigned =
                                                                  true;
                                                                  renterSignature = (await renter_signature_controller.toPngBytes(
                                                                      height:
                                                                      150,
                                                                      width:
                                                                      150))!;
                                                                  uploadRenterSignature();
                                                                });
                                                          },
                                                          icon: Icon(
                                                            Icons.done,
                                                            color:
                                                            ButtonColor,
                                                          )),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              renter_signature_controller
                                                                  .clear();
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.clear,
                                                            color: Colors
                                                                .red,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                  // width: 300,
                                                  // width: double.infinity,
                                                  // color: Colors.black12,
                                                    child: Signature(
                                                      height: 160,
                                                      controller:
                                                      renter_signature_controller,
                                                      backgroundColor:
                                                      Colors.black12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 50,
                            ),

                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MMILIKI WA NYUMBA",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "JINA:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            // fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${houseOwnerFullname}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                wordSpacing: 5,
                                                height: 1.5,
                                                fontSize: 15,
                                                // decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "TAREHE:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            // fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${startDate.day}. ${startDate.month}. ${startDate.year}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                wordSpacing: 5,
                                                height: 1.5,
                                                fontSize: 15,
                                                // decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "SAHIHI :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                            // fontSize: 17
                                            ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      houseOwnerHasSigned
                                          ? Image.memory(
                                              houseOwnerSignature,
                                            )
                                          : Expanded(
                                              child: Container(
                                                height: 200,
                                                // padding: EdgeInsets.only(left: 10,right: 10),
                                                width: double.infinity,
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        // margin: EdgeInsets.only(bottom: 10),
                                                        color: Colors.black12,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  setState(
                                                                      () async {
                                                                    houseOwnerHasSigned =
                                                                        true;
                                                                    houseOwnerSignature = (await house_owner_signature_controller.toPngBytes(
                                                                        height:
                                                                            150,
                                                                        width:
                                                                            150))!;
                                                                    Add_house_owner_signature_to_firebase();
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  Icons.done,
                                                                  color:
                                                                      ButtonColor,
                                                                )),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    house_owner_signature_controller
                                                                        .clear();
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  Icons.clear,
                                                                  color: Colors
                                                                      .red,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          // padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                                          // width: 300,
                                                          // width: double.infinity,
                                                          // color: Colors.black12,
                                                          child: Signature(
                                                        height: 160,
                                                        controller:
                                                            house_owner_signature_controller,
                                                        backgroundColor:
                                                            Colors.black12,
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: SpinKitCircle(size: 50, color: ButtonColor),
                      );
                      ;
                    },
                  ),
                ));
          },
        ),
      ),
    );
  }


  Future uploadRenterSignature() async {
    final storageRef = FirebaseStorage.instance.ref().child('renter_signatures');
    final uploadTask = storageRef
        .child('renter_signature.png')
        .putData(
       renterSignature
    );
    final renterDownload = await (await uploadTask).ref.getDownloadURL();
    // Save the download URL to Firestore
    // final firestoreInstance = FirebaseFirestore.instance;

    final querysnapshot = await FirebaseFirestore.instance
        .collection("contracts_db")
        .where('renter_id', isEqualTo: widget.renter_id)
        .where('start_date', isEqualTo: widget.start_date)
        .get();

    if(querysnapshot.docs.isNotEmpty){
      final documentSnapshot = querysnapshot.docs.first;
      final documentId = documentSnapshot.id;
      await FirebaseFirestore.instance
          .collection('contracts_db')
          .doc(documentId)
          .update({'renter_signature': renterDownload});

    }
    if(querysnapshot.docs.isEmpty){

      print("Fetched document is invalid/ not found");
    }

    //    try {
    //
    //      // await firestoreInstance.collection('contracts_db').where('renter_id', isEqualTo: widget.renter_id).where('start_date',isEqualTo:widget.start_date).get().
    //    }
    //
    // catch((error)){
    //
    //      Text('error ${;}');
    //   }
  }


  Future Add_house_owner_signature_to_firebase() async {
    final storageRef = FirebaseStorage.instance.ref().child('house_owner_signature');
    final uploadTask = storageRef
        .child('house_owner_signature.jpeg')
        .putData(
        houseOwnerSignature
    );
    final houseOwnerDownload = await (await uploadTask).ref.getDownloadURL();
    // Save the download URL to Firestore
    // final firestoreInstance = FirebaseFirestore.instance;

    final querysnapshot = await FirebaseFirestore.instance
        .collection("contracts_db")
        .where('renter_id', isEqualTo: widget.renter_id)
        .where('start_date', isEqualTo: widget.start_date).where('status',isEqualTo:'active')
        .get();

    if(querysnapshot.docs.isNotEmpty){
      final documentSnapshot = querysnapshot.docs.first;
      final documentId = documentSnapshot.id;
      await FirebaseFirestore.instance
          .collection('contracts_db')
          .doc(documentId)
          .update({'house_owner_Signature': houseOwnerDownload});

    }
    if(querysnapshot.docs.isEmpty){

      print("Fetched document is invalid/ not found");
    }

    //    try {
    //
    //      // await firestoreInstance.collection('contracts_db').where('renter_id', isEqualTo: widget.renter_id).where('start_date',isEqualTo:widget.start_date).get().
    //    }
    //
    // catch((error)){
    //
    //      Text('error ${;}');
    //   }
  }

  // Future Add_house_owner_signature_to_firebase() async {
  //   final storageRef = FirebaseStorage.instance.ref().child('house_owner_signatures');
  //   final uploadTask = storageRef
  //       .child('house_owner_signature.png')
  //       .putData(
  //       houseOwnerSignature);
  //   final downloadURL = await (await uploadTask).ref.getDownloadURL();
  //   // Save the download URL to Firestore
  //   // final firestoreInstance = FirebaseFirestore.instance;
  //
  //   final querysnapshot = await FirebaseFirestore.instance
  //       .collection("contracts_db")
  //       .where('renter_id', isEqualTo: widget.renter_id)
  //       .where('start_date', isEqualTo: widget.start_date).where('status',isEqualTo:'active')
  //       .get();
  //
  //   if(querysnapshot.docs.isNotEmpty){
  //     final documentSnapshot = querysnapshot.docs.first;
  //     final documentId = documentSnapshot.id;
  //     await FirebaseFirestore.instance
  //         .collection('contracts_db')
  //         .doc(documentId)
  //         .update({'house_owner_signature': downloadURL});
  //
  //   }
  //
  //   //    try {
  //   //
  //   //      // await firestoreInstance.collection('contracts_db').where('renter_id', isEqualTo: widget.renter_id).where('start_date',isEqualTo:widget.start_date).get().
  //   //    }
  //   //
  //   // catch((error)){
  //   //
  //   //      Text('error ${;}');
  //   //   }
  // }
}
