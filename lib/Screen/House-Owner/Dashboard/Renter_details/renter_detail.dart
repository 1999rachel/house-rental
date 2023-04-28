import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Renter_details/renter_details_account_page.dart';

import '../../../../Utils/PreferenceUtil.dart';
import '../Register_renter/renter_registration_stage1.dart';

class renter_details extends StatefulWidget {
  const renter_details({Key? key}) : super(key: key);

  @override
  State<renter_details> createState() => _renter_detailsState();
}

class _renter_detailsState extends State<renter_details> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Stream<QuerySnapshot> _renters =
      FirebaseFirestore.instance.collection("renters").snapshots();
  @override
  void initState() {
    PreferenceUtil pref = PreferenceUtil();
    pref.getItem("email", "string").then((email) {
      setState(() {
         FirebaseFirestore.instance
            .collection("renters")
            .where("house_owner_id", isEqualTo: email)
            .snapshots();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        mini: true,
        backgroundColor: ButtonColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => renter_registration_stage1()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(Icons.notifications, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: BackgroundColor,
        buttonBackgroundColor: ButtonColor,
        backgroundColor: BackgroundColor,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ))
        ],
        title: Text(
          "Renters details",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: BackgroundColor),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:_renters ,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      // return Text("Something went wrong");
                      return Center(
                        child: CircularProgressIndicator(

                          color: ButtonColor,
                          value: 20,
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ButtonColor,
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.active) {
                      QuerySnapshot querysnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> DocumentSnapshotList =
                          querysnapshot.docs;
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot data =
                                DocumentSnapshotList[index];
                            return Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          renter_details_account_page()));
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
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              // child: Image.network(
                                              //   data['profile1'],
                                              //   fit: BoxFit.cover,
                                              // ),
                                              child: Icon(
                                                Icons.person,
                                                size: 40,
                                                color: Colors.black54,
                                              )),
                                          decoration: BoxDecoration(
                                              color: BackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['full_name'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "House no.",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
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
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 3,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                PreferenceUtil pref =
                                                    PreferenceUtil();
                                                pref.removeItem(index);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.black,
                                              ))
                                        ],
                                      )
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
                          itemCount: DocumentSnapshotList.length);
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: ButtonColor,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
