import 'package:flutter/material.dart';
import 'package:voice_pay/constants.dart';
import 'package:voice_pay/screens/sign_in/sign_in_screen.dart';
import 'package:voice_pay/size_config.dart';
import 'package:voice_pay/test_module/components/voice_message2.dart';
import 'package:voice_pay/test_module/stt_test.dart';
import 'package:voice_pay/test_module/voice_message.dart';
import 'package:voice_pay/test_module/voice_pay.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Chào mừng tới với VoicePay, Hãy bắt đầu nào!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "VoicePay là ứng dụng thanh toán thông minh \ncó tích hợp trợ giọng nói cùng trợ lý ảo Smazer! ",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Bạn có thể sử dụng VoicePay để thực hiện các thanh toán một cách nhanh chóng, chính xác và bảo mật",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Tiếp Tục",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                        //  Navigator.push(
                        //    context, MaterialPageRoute(builder: (context) => VoicePay()));
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
