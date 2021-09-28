// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
//
//
// class MessagesScreen extends StatefulWidget{
//   @override
//     @override
//     _MyHomePageState createState() => _MyHomePageState();
//
//
// }
//
// class _MyHomePageState extends State<MessagesScreen>{
//   final TextEditingController _controller = TextEditingController();
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('wss://dev.interits.com/asr/stream/socket/16k/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)16000,+format=(string)S16LE,+channels=(int)1&token=jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M'),
//   );
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 300,),
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Send a message'),
//               ),
//             ),
//             const SizedBox(height: 24),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: const Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//     }
//   }
//
//   @override
//   void dispose() {
//     _channel.sink.close();
//     super.dispose();
//   }
//
//
//
// }


import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_lite/public/tau.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_pay/test_module/payment_info.dart';
import 'package:voice_pay/test_module/voice_pay.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'ChatMessage.dart';
import 'ChatMessage.dart';
import 'components/body2.dart';
import 'components/chat_input_field.dart';
import 'components/constants.dart';
import 'components/message.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MessagesScreen extends StatefulWidget{
  @override
  _MessagesScreen createState() => _MessagesScreen();

}



String myurl1,myurl2,myurl3,myurl4;
AudioPlayer audioPlayer1 = new AudioPlayer();
AudioPlayer audioPlayer2 = new AudioPlayer();
AudioPlayer audioPlayer3 = new AudioPlayer();
AudioPlayer audioPlayer4 = new AudioPlayer();

class Data1 {
  String url;
  Data1 ({this.url});
  Data1.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Data2 {
  String url;
  Data2 ({this.url});
  Data2.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Data3 {
  String url;
  Data3 ({this.url});
  Data3.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Data4 {
  String url;
  Data4 ({this.url});
  Data4.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}


class ResultResponse1 {
  Data1 data;
  String msg;
  int status;
  ResultResponse1({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponse1.fromJson(Map<String, dynamic> json) {
    return ResultResponse1(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Data1.fromJson(json['data']) : null
    );
  }
}
class ResultResponse2 {
  Data2 data;
  String msg;
  int status;
  ResultResponse2({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponse2.fromJson(Map<String, dynamic> json) {
    return ResultResponse2(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Data2.fromJson(json['data']) : null
    );
  }
}
class ResultResponse3 {
  Data3 data;
  String msg;
  int status;
  ResultResponse3({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponse3.fromJson(Map<String, dynamic> json) {
    return ResultResponse3(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Data3.fromJson(json['data']) : null
    );
  }
}

class ResultResponse4 {
  Data4 data;
  String msg;
  int status;
  ResultResponse4({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponse4.fromJson(Map<String, dynamic> json) {
    return ResultResponse4(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Data4.fromJson(json['data']) : null
    );
  }
}

_getUrl1(String text) async {
  String token = "jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M";

  var url = "http://tts.interits.com/api/v2/path";
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'token':token, 'text':text,'voiceId':'2'};
  request.bodyFields = body;

  http.Response response = await http.post(Uri.parse(url),body: body);
  if (response.statusCode == 200){
    ResultResponse1.fromJson(jsonDecode(response.body));
    print(response.body);
    //myStatus =  ResultResponse.fromJson(jsonDecode(response.body)).status;
    Data1 dta = ResultResponse1.fromJson(jsonDecode(response.body)).data;
    myurl1 = dta.url;
    print( ResultResponse1.fromJson(jsonDecode(response.body)).status);

    print("Success!");

  }else{

    print("Error..................");
    print(response.statusCode);
  }
}

_getUrl2(String text) async {
  String token = "jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M";

  var url = "http://tts.interits.com/api/v2/path";
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'token':token, 'text':text,'voiceId':'2'};
  request.bodyFields = body;

  http.Response response = await http.post(Uri.parse(url),body: body);
  if (response.statusCode == 200){
    ResultResponse2.fromJson(jsonDecode(response.body));
    print(response.body);
    //myStatus =  ResultResponse.fromJson(jsonDecode(response.body)).status;
    Data2 dta = ResultResponse2.fromJson(jsonDecode(response.body)).data;
    myurl2 = dta.url;
    print( ResultResponse2.fromJson(jsonDecode(response.body)).status);

    print("Success!");

  }else{

    print("Error..................");
    print(response.statusCode);
  }
}


_getUrl3(String text) async {
  String token = "jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M";

  var url = "http://tts.interits.com/api/v2/path";
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'token':token, 'text':text,'voiceId':'2'};
  request.bodyFields = body;

  http.Response response = await http.post(Uri.parse(url),body: body);
  if (response.statusCode == 200){
    ResultResponse3.fromJson(jsonDecode(response.body));
    print(response.body);
    //myStatus =  ResultResponse.fromJson(jsonDecode(response.body)).status;
    Data3 dta = ResultResponse3.fromJson(jsonDecode(response.body)).data;
    myurl3 = dta.url;
    print( ResultResponse3.fromJson(jsonDecode(response.body)).status);

    print("Success!");

  }else{

    print("Error..................");
    print(response.statusCode);
  }
}

_getUrl4(String text) async {
  String token = "jDU5tFn8CU9oSGb5cofpUA7ZOwPLAd4M";

  var url = "http://tts.interits.com/api/v2/path";
  var request = new http.Request('POST', Uri.parse(url));
  var body = {'token':token, 'text':text,'voiceId':'2'};
  request.bodyFields = body;

  http.Response response = await http.post(Uri.parse(url),body: body);
  if (response.statusCode == 200){
    ResultResponse4.fromJson(jsonDecode(response.body));
    print(response.body);
    //myStatus =  ResultResponse.fromJson(jsonDecode(response.body)).status;
    Data4 dta = ResultResponse4.fromJson(jsonDecode(response.body)).data;
    myurl4 = dta.url;
    print( ResultResponse4.fromJson(jsonDecode(response.body)).status);

    print("Success!");

  }else{

    print("Error..................");
    print(response.statusCode);
  }
}
// class Data5 {
//   List hypotheses;
//   bool finalStr;
//   Data5 ({this.hypotheses,this.finalStr});
//   Data5.fromJson(Map<String, dynamic> json) {
//     hypotheses = json['hypotheses'];
//     finalStr = json['final'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['hypotheses'] = this.hypotheses;
//     return data;
//   }
// }
String _text = '';

class Data7 {
  List hypotheses;
  bool finalStr;
  Data7 ({this.hypotheses,this.finalStr});
  Data7.fromJson(Map<String, dynamic> json) {
    hypotheses = json['hypotheses'];
    finalStr = json['final'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hypotheses'] = this.hypotheses;
    return data;
  }
}
class ResultResponse7 {
  Data7 data;
  int status;

  ResultResponse7({
    this.data,
    this.status,
  });

  factory ResultResponse7.fromJson(Map<String, dynamic> json) {
    return ResultResponse7(
        status: json['status'],
        data: json['result'] != null ? new Data7.fromJson(json['result']) : null
    );
  }
}

getTranscript(String response){
  ResultResponse5.fromJson(jsonDecode(response));

  List a = ResultResponse5.fromJson(jsonDecode(response)).data.hypotheses;
  List list= a.map((array)=>array['transcript_normed']).toList();
  _text = list.join("");
  print("Text: $_text");
}
class ChatMessage2 {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage2({
    this.text = '',
    this.messageType,
    this.messageStatus,
    this.isSender
  });
}
typedef _Fn = void Function();

class _MessagesScreen extends State<MessagesScreen> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text2='';
  //---------------------------------------------
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String _mPath;
  StreamSubscription _mRecordingDataSubscription;


  AudioPlayer audioPlayer = new AudioPlayer();
  var _channel = WebSocketChannel.connect(
    Uri.parse('wss://dev.interits.com/asr/stream/socket/16k/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)44100,+format=(string)S16LE,+channels=(int)1'),
  );
  Future<void> _openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder.openAudioSession();
    setState(() {
      _mRecorderIsInited = true;
    });
  }
  @override
  void initState() {
    super.initState();
    //_speech = stt.SpeechToText();
    _mPlayerIsInited = true;
    _openRecorder();
  }
  @override
  void dispose() {

    stopRecorder();
    _mRecorder.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> record() async {
    assert(_mRecorderIsInited);
    _isListening=true;
    //  var sinkf = await createFile();
    //var recordingDataController = BehaviorSubject<Food>();
    var recordingDataController = StreamController<Food>();
    //StreamController<Food> recordingDataController = StreamController<Food>.broadcast();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) {
          if (buffer is FoodData) {
            _channel.sink.add(buffer.data);
            _channel.stream.listen(
                  (dynamic message) {
                setState(() {
                  _text2 = message;
                  getTranscript(_text2);
                  if(_text!=null&&_text=="Đúng rồi"){
                    demoChatMessages2.add(
                        ChatMessage2(
                          text: "Đúng rồi",
                          messageType: ChatMessageType.text,
                          messageStatus: MessageStatus.viewed,
                          isSender: true,
                        )
                    );

                    setState((){
                      _isListening=false;
                      stopRecorder();
                      _play2();
                    }
                    );

                  }else if(_text!=null&&_text=="Đúng vậy"){
                    demoChatMessages2.add(
                        ChatMessage2(
                          text: "Đúng vậy",
                          messageType: ChatMessageType.text,
                          messageStatus: MessageStatus.viewed,
                          isSender: true,
                        )
                    );

                    setState((){
                      _isListening=false;
                      stopRecorder();
                      _text="";
                      _play3();
                    }
                    );
                  }else if(_text!=null&&_text=="Mã xác nhận của tôi là 2368"){
                    demoChatMessages2.add(
                        ChatMessage2(
                          text: "Mã xác nhận của tôi là 2368",
                          messageType: ChatMessageType.text,
                          messageStatus: MessageStatus.viewed,
                          isSender: true,
                        )
                    );

                    setState((){
                      _isListening=false;
                      stopRecorder();
                      _text="";
                      _play4();
                    }
                    );
                  }
                });
                debugPrint('message $message');
              },
              onDone: () {
                debugPrint('ws channel closed');



              },
              onError: (error) {
                debugPrint('ws error $error');
              },
            );

          }

        });

    // if(_text=="Đúng rồi"){
    //   demoChatMessages2.add(
    //     ChatMessage2(
    //       text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
    //       messageType: ChatMessageType.text,
    //       messageStatus: MessageStatus.viewed,
    //       isSender: false,
    //     ),
    //   );
    //   setState(() {
    //     _isListening=false;
    //   } );
    //   await _getUrl2("Giá món đồ bạn muốn mua là 64 đô. Bạn muốn thanh toán ngay bây giờ?");
    //   demoChatMessages2.add(
    //       ChatMessage2(
    //         text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
    //         messageType: ChatMessageType.text,
    //         messageStatus: MessageStatus.viewed,
    //         isSender: false,
    //       )
    //   );
    //   if (myurl2 != null) {
    //     audioPlayer2.play(myurl2, isLocal: true);
    //     audioPlayer2.onPlayerCompletion.listen((event) {
    //
    //     });
    //   }
    // }

    await _mRecorder.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
    //setState(() {});
  }
  // --------------------- (it was very simple, wasn't it ?) -------------------

  _play2() async {
    demoChatMessages2.add(
      ChatMessage2(
        text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
      ),
    );
    setState(() {
      _isListening=false;
    } );
    await _getUrl2("Giá món đồ bạn muốn mua là 64 đô. Bạn muốn thanh toán ngay bây giờ?");
    // demoChatMessages2.add(
    //     ChatMessage2(
    //       text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
    //       messageType: ChatMessageType.text,
    //       messageStatus: MessageStatus.viewed,
    //       isSender: false,
    //     )
    // );
    if (myurl2 != null) {
      audioPlayer2.play(myurl2, isLocal: true);
      audioPlayer2.onPlayerCompletion.listen((event) {

      });
    }
  }
  _play3() async {
    demoChatMessages2.add(
      ChatMessage2(
        text: "Đọc câu sau để xác thực thanh \ntoán: \"Mã xác nhận của tôi là 2368",
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
      ),
    );
    setState(() {
      _isListening=false;
    } );
    await _getUrl3("Vui lòng đọc câu sau để xác thực thanh toán: Mã xác nhận của tôi là hai ba sáu tám");
    // demoChatMessages2.add(
    //     ChatMessage2(
    //       text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
    //       messageType: ChatMessageType.text,
    //       messageStatus: MessageStatus.viewed,
    //       isSender: false,
    //     )
    // );
    if (myurl3 != null) {
      audioPlayer3.play(myurl3, isLocal: true);
      audioPlayer3.onPlayerCompletion.listen((event) {

      });
    }
  }
  _play4() async {
    demoChatMessages2.add(
      ChatMessage2(
        text: "Mã xác nhận và nhận dạng giọng \nchính xác với độ khớp giọng 99%.",
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
      ),
    );
    demoChatMessages2.add(
      ChatMessage2(
        text: "Thanh toán thành công",
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
      ),

    );
    demoChatMessages2.add(
      ChatMessage2(
        text: "Cảm ơn đã sử dụng dịch vụ VoicePay",
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.not_view,
        isSender: false,
      ),
    );
    setState(() {
      _isListening=false;
    } );
    await _getUrl4("Mã xác nhận và nhận dạng giọng chính xác với độ khớp giọng 99%. Thanh toán thành công. Cảm ơn bạn vì đã sử dụng dịch vụ của Voice Pay!");
    // demoChatMessages2.add(
    //     ChatMessage2(
    //       text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
    //       messageType: ChatMessageType.text,
    //       messageStatus: MessageStatus.viewed,
    //       isSender: false,
    //     )
    // );
    if (myurl4 != null) {
      audioPlayer4.play(myurl4, isLocal: true);
      audioPlayer4.onPlayerCompletion.listen((event) {

      });
    }
  }


  Future<void> stopRecorder() async {
    await _mRecorder.stopRecorder();

    if (_mRecordingDataSubscription != null) {

      _mRecordingDataSubscription = null;
    }
    _mplaybackReady = true;
  }

  // void _listen() async {
  //   if (!_isListening) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val) => print('onStatus: $val'),
  //       onError: (val) => print('onError: $val'),
  //     );
  //     if (available) {
  //       setState(() => _isListening = true);
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords;
  //           if(_text!=null&&_text=="Tôi muốn thanh toán"){
  //             setState(() => _isListening=false);
  //
  //             Navigator.push(
  //                 context, MaterialPageRoute(builder: (context) => MessagesScreen()));
  //           }
  //         }),
  //       );
  //     }
  //   } else {
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //   }
  // }
  _Fn getRecorderFn() {
    if (!_mRecorderIsInited) {
      return null;
    }
    return _mRecorder.isStopped
        ? record
        : () {
      stopRecorder().then((value) => setState(() {
        _isListening=false;



      }));

    };
  }



  //---------------------------------------------------
  List demoChatMessages2 = [
  ChatMessage2(
  text: "Xin chào Thắng,",
  messageType: ChatMessageType.text,
  messageStatus: MessageStatus.viewed,
  isSender: false,
  ),
  ChatMessage2(
  text: "Có phải bạn muốn mua Tay Cầm PS4?",
  messageType: ChatMessageType.text,
  messageStatus: MessageStatus.viewed,
  isSender: false,
  ),
  ];
  @override
  // void initState() {
  //   super.initState();
  //   _speech = stt.SpeechToText();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ListView.builder(
                      itemCount: demoChatMessages2.length,
                      itemBuilder: (context, index) =>
                          Message(message: demoChatMessages2[index]),
                    ),
                  ),
                ),

                SafeArea(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        // FlatButton(onPressed: _onClick,
                        //   child: SizedBox(
                        //     width: 90,
                        //   ),
                        //   color: Colors.white,
                        //
                        // ),

                        AvatarGlow(
                          animate: _isListening,
                          glowColor: Theme.of(context).primaryColor,
                          endRadius: 75.0,
                          duration: const Duration(milliseconds: 2000),
                          repeatPauseDuration: const Duration(milliseconds: 100),
                          repeat: true,
                          child: FloatingActionButton(
                            onPressed: getRecorderFn(),
                            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                          ),

                        ),
                      ],
                   )
                )

              ],

            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/aiimage.png"),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Smazer",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Smart AI Assistant",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.local_phone),
      //     onPressed: () {},
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.videocam),
      //     onPressed: () {},
      //   ),
      //   SizedBox(width: kDefaultPadding / 2),
      // ],
    );
  }



  void _listen() async {

    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.locales();
        _speech.listen(
          onResult: (val) => setState(() async {
            _text = val.recognizedWords;
            print("Text: " +_text);

            if(_text!=null&&_text=="đúng rồi"||_text=="Đúng rồi") {

              demoChatMessages2.add(
                  ChatMessage2(
                text: "Đúng rồi",
                messageType: ChatMessageType.text,
                messageStatus: MessageStatus.viewed,
                isSender: true,
              )
              );
              setState(() {
                _isListening=false;
              } );
              await _getUrl2("Giá món đồ bạn muốn mua là 64 đô. Bạn muốn thanh toán ngay bây giờ?");
              demoChatMessages2.add(
                  ChatMessage2(
                    text: "Giá món đồ bạn muốn mua là 64.99\$.\nBạn muốn thanh toán ngay bây giờ?",
                    messageType: ChatMessageType.text,
                    messageStatus: MessageStatus.viewed,
                    isSender: false,
                  )
              );
              if (myurl2 != null) {
                audioPlayer2.play(myurl2, isLocal: true);
                audioPlayer2.onPlayerCompletion.listen((event) {

                });
              }
            }else if(_text!=null&&_text=="Đúng vậy"||_text=="đúng vậy") {
              demoChatMessages2.add(
                  ChatMessage2(
                    text: "Đúng vậy",
                    messageType: ChatMessageType.text,
                    messageStatus: MessageStatus.viewed,
                    isSender: true,
                  )
              );
              setState(() => _isListening=false);
              await _getUrl3("Vui lòng đọc câu sau để xác thực thanh toán: Mã xác nhận của tôi là hai ba sáu tám");
              demoChatMessages2.add(
                  ChatMessage2(
                    text: "Đọc câu sau để xác thực thanh \ntoán: \"Mã xác nhận của tôi là 2368",
                    messageType: ChatMessageType.text,
                    messageStatus: MessageStatus.viewed,
                    isSender: false,
                  )
              );

              if (myurl3 != null) {
                audioPlayer3.play(myurl3, isLocal: true);
                audioPlayer3.onPlayerCompletion.listen((event) {

                });
              }
            } else if(_text!=null&&_text=="mã xác nhận của tôi là 23 68"||_text=="mã xác nhận của tôi là 2 3 6 8"||_text=="mã xác nhận của tôi là 2368") {
              demoChatMessages2.add(
                  ChatMessage2(
                    text: "Mã xác nhận của tôi là 2368",
                    messageType: ChatMessageType.text,
                    messageStatus: MessageStatus.viewed,
                    isSender: true,
                  )
              );
              setState(() => _isListening=false);
              await _getUrl4("Mã xác nhận và nhận dạng giọng chính xác với độ khớp giọng 99%. Thanh toán thành công. Cảm ơn bạn vì đã sử dụng dịch vụ của Voice Pay!");
              demoChatMessages2.add(
                  ChatMessage2(
                    text: "Mã xác nhận và nhận dạng giọng \nchính xác với độ khớp giọng 99%.",
                    messageType: ChatMessageType.text,
                    messageStatus: MessageStatus.viewed,
                    isSender: false,
                  ),
              );
              demoChatMessages2.add(
                  ChatMessage2(
                      text: "Thanh toán thành công",
                      messageType: ChatMessageType.text,
                      messageStatus: MessageStatus.viewed,
                      isSender: false,
                    ),

              );
              demoChatMessages2.add(
                ChatMessage2(
                  text: "Cảm ơn đã sử dụng dịch vụ VoicePay",
                  messageType: ChatMessageType.text,
                  messageStatus: MessageStatus.not_view,
                  isSender: false,
                ),
              );
              if (myurl4 != null) {
                audioPlayer4.play(myurl4, isLocal: true);
                audioPlayer4.onPlayerCompletion.listen((event) {

                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => PaymentInfo()));

                });
              }
            }else{

            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
