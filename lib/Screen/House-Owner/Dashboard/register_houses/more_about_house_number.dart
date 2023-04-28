// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class more_about_house_number extends StatefulWidget {
//   const more_about_house_number({Key? key}) : super(key: key);
//
//   @override
//   State<more_about_house_number> createState() =>
//       _more_about_house_numberState();
// }
//
// class _more_about_house_numberState extends State<more_about_house_number> {
//   final ButtonColor = const Color(0xff0748A6);
//   final BackgroundColor = const Color(0xffEEEEEE);
//
//   final Stream<DocumentSnapshot> _houses = FirebaseFirestore.instance
//       .collection("houses")
//       .doc("0rR002aIKrQh3w5pHomt")
//       .snapshots();
//   late Stream<DocumentSnapshot> _Stream;
//
//   @override
//   void initState() {
//     super.initState();
//     _Stream = _houses;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: ButtonColor,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               size: 24,
//               color: Colors.white,
//             )),
//         title: Text(
//           "More about house no 1",
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: BackgroundColor,
//           padding: EdgeInsets.only(left: 20, right: 20),
//           child: StreamBuilder<DocumentSnapshot>(
//             stream: _Stream,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: ButtonColor,
//                   ),
//                 );
//               }  else if (snapshot.hasData) {
//                 List<QueryDocumentSnapshot> house = snapshot.data!.docs;
//                 // for (int i = 0; i < users.length; i++) {
//                 //   print(users[i].get("fullname"));
//                 // }
//                 return Text(house[0].get("kitchen").toString());
//                 // return ListView(
//                 //   children: snapShot.data!.docs.map((DocumentSnapshot document) {
//                 //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//                 //     return ListTile(
//                 //       title: Text(data['fullname']),
//                 //       // subtitle: Text(data['company']),
//                 //     );
//                 //   }).toList(),
//                 // );
//               }
//
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: ButtonColor,
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
