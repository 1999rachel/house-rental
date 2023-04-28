// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class more_about_selected_house extends StatefulWidget {
//   const more_about_selected_house({Key? key}) : super(key: key);
//
//   @override
//   State<more_about_selected_house> createState() => _more_about_selected_houseState();
// }
//
// class _more_about_selected_houseState extends State<more_about_selected_house> {
//   final ButtonColor =const Color(0xff0748A6);
//   final BackgroundColor =const Color(0xffEEEEEE);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor:ButtonColor,
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//
//         }, icon: Icon(Icons.arrow_back_ios,size: 24,color: Colors.white,)),
//
//         title: Text("More about house no 1",style: TextStyle(
//             color: Colors.white,fontSize: 18
//         ),),
//
//       ),
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: BackgroundColor,
//           padding: EdgeInsets.only(left: 20,right: 20),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Kitchen :"
//                     ,style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   SizedBox(
//                     width: 75,
//                   ),
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             alignment: Alignment.topLeft,
//                             child: Text("1")),
//
//                         Divider(
//                           color: Colors.black54,
//                         )
//                       ],
//                     ),
//                   )
//
//                 ],
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Dining :"
//                     ,style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   SizedBox(
//                     width: 90,
//                   ),
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             alignment: Alignment.topLeft,
//                             child: Text("1")),
//                         Divider(
//                           color: Colors.black54,
//                         )
//                       ],
//                     ),
//                   )
//
//                 ],
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Rest room :"
//                     ,style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   SizedBox(
//                     width: 65,
//                   ),
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             alignment: Alignment.topLeft,
//                             child: Text("1")),
//                         Divider(
//                           color: Colors.black54,
//                         )
//                       ],
//                     ),
//                   )
//
//                 ],
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Master bed room :"
//                     ,style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   SizedBox(
//                     width: 25,
//                   ),
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             alignment: Alignment.topLeft,
//                             child: Text("1")),
//                         Divider(
//                           color: Colors.black54,
//                         )
//                       ],
//                     ),
//                   )
//
//                 ],
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Cost per month :"
//                     ,style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   SizedBox(
//                     width: 30,
//                   ),
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("180000000000"),
//                                 Text("Tzs/ mo")
//
//                               ],
//                             )
//                         ),
//                         Divider(
//                           color: Colors.black54,
//                         )
//                       ],
//                     ),
//                   )
//
//                 ],
//               ),
//
//             ],
//           ),
//
//         ),
//       ),
//
//
//     ) ;
//   }
// }
