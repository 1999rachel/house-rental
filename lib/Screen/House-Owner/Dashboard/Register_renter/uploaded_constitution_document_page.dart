import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class uploaded_constiturion_document_page extends StatefulWidget {
  const uploaded_constiturion_document_page({Key? key}) : super(key: key);

  @override
  State<uploaded_constiturion_document_page> createState() => _uploaded_constiturion_document_pageState();
}

class _uploaded_constiturion_document_pageState extends State<uploaded_constiturion_document_page> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(


      child:Scaffold(
        appBar: AppBar(
          backgroundColor: ButtonColor,
          elevation: 0,
          centerTitle: true,
          actions: [

            IconButton(onPressed: (){

              setState(() {

                showDialog(context: (context), builder: (BuildContext index){
                  return  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      height: 200,
                      width: 150,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: (){
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>renter_bills()));

                            } ,
                            child: Container(
                              width: double.infinity,
                              height: 30,
                              // color: Color(0xffD9D9D9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text("Share",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17
                                  ),),
                                  Icon(Icons.share,color: ButtonColor,),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: (){

                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>renter_bills()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 30,
                              // color: Color(0xffD9D9D9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text("Download",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17
                                  ),),
                                  Icon(Icons.download,color: ButtonColor,),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      color: Colors.white,
                    ),
                  );
                });
              });
            }, icon: Icon(Icons.more_horiz,color: Colors.white,))
          ],
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
            "Constitution document",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        body: Container(
          color: BackgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                    child:Text(

                      "Me ................................ hagdhsnagjxg<scgbnvjscg<vgzsfxcxghgns<chgvshgfvcjhhsg"
                          "vucghfsv< cjhgsughagcdhdsdkjhsbcghmsdcm fnsbdvcgham<dvbmcvs<mcvah<vdcghds"
                          "<cxhnb<sjcbhsh<cvjzm, nxckjjasmd<cghnm<hzkcja<dcg"
                          "sbncdsdjdhcz<,jdcmd sd<,bcvz<mbxckd<cghzbbxckjashb<cmzxbvcjhas"
                          "hcgajschskdchjschjjjjjjjjjjjjj from .............. to ........................."
                          "xgh<sxhdl<kjadchgg<acjdkh<ahbhfdvckjhsz<cfgfa<djsnsxchgartdsgjq<adf"
                          "ahsdghjadkdca<gsdczkxncah<gfcjkah<csvsgcdfaj<scshz,"
                          "bcav<hcnmndbchxzvbcsn,<cv<bkacnhsdvcbnma<bdcvghbvs"
                          "hasgjdh<gvdsagfjxmba<zvxchjahsdafsdgc<vhdcgz"
                          "ahdgahjhdsjhfahgsgbdxhanbsvfcx<bvhj<vsxca<fh"
                          ""
                          "hsghjxgsahdfchhgnad<hasbhdgfag<bngxhg<adch"
                          "adsdgaj<hd<jnadghjg<fcjkjh<dcgasb............."
                          "gdfghajgsdhdha<nscxvfa<zcgakj<bcx<ha<sdcfz"
                          "vgsddxajh<mhsxbhabfvdsjcbs<dcvha<szcbhasjd"
                          "hxdax<uzsgxcasddcuxhagzcghszchga"
                          ""
                          "date............"
                          "signature............."
                          "nxahjmh<sxjb cafsgxajmzsxbghasbzxvahgszs"
                          "ahhgsdmnhsadhgfwhadsgbxnkamnb<xfcvqa<jxa"
                          "shddvajsn<xb<scvhxm<zncxnva<fdxagnbsxnba<zgbbxfvaj<zmxbvfa<zcxvjhaz<"
                          "]"
                          "sgxbnagsxhjafscxja<zbzxnbc<a<zgjgxjk<jaxz"
                          "xhvasjbnbxzhjbac<gsxb<jkanbszv xf<gag<sxz"
                          "xvasbjazxjabsdxg<zgxbasnbvchxfznv"
                      ,
                      style: TextStyle(
                          fontSize: 16

                      ),

                    ),
                  ),
               
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ) ,
    );

  }
}
