import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voice_pay/components/default_button.dart';
import 'package:voice_pay/test_module/voice_pay.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../size_config.dart';

class Datacart {
  String url;
  Datacart ({this.url});
  Datacart.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class ResultResponseCart {
  Datacart data;
  String msg;
  int status;
  ResultResponseCart({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponseCart.fromJson(Map<String, dynamic> json) {
    return ResultResponseCart(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Datacart.fromJson(json['data']) : null
    );
  }
}

_getUrl(String text) async {
  String token = "jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M";

  var url = "http://tts.interits.com/api/v2/path";
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'token':token, 'text':text,'voiceId':'2'};
  request.bodyFields = body;

  http.Response response = await http.post(Uri.parse(url),body: body);
  if (response.statusCode == 200){
    ResultResponse.fromJson(jsonDecode(response.body));
    print(response.body);
    //myStatus =  ResultResponse.fromJson(jsonDecode(response.body)).status;
    Data dta = ResultResponse.fromJson(jsonDecode(response.body)).data;
    myurl = dta.url;
    print( ResultResponse.fromJson(jsonDecode(response.body)).status);

    print("Success!");

  }else{

    print("Error..................");
    print(response.statusCode);
  }
}

AudioPlayer audioPlayer = new AudioPlayer();

class CheckoutCard extends StatelessWidget {

  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Thêm mã giảm giá"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Tổng:\n",
                    children: [
                      TextSpan(
                        text: "\$64.99",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Thanh Toán",
                    press: () {
                      _onClick();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoicePay(),));

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _onClick() async{
    await _getUrl("Xin chào, Tôi là Smazer Tôi là trợ lý ảo của bạn. Hãy nói Tôi muốn thanh toán để mua hàng!");
    if(myurl!=null){
      audioPlayer.play(myurl,isLocal:true);
      audioPlayer.onPlayerCompletion.listen((event) {

      });
    }


  }

}
