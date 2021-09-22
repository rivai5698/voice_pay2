import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'message_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



class VoicePay extends StatefulWidget {
  //final String phoneStr;
  // final Data data;
  // LoginPage({this.data});
  @override
  _VoicePay createState() => _VoicePay();
}
String myurl;
String myData;


class Data {
  String url;
  Data ({this.url});
  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class ResultResponse {
  Data data;
  String msg;
  int status;
  ResultResponse({
    this.data,
    this.msg,
    this.status,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(
        msg: json['msg'],
        status: json['status'],
        data: json['data'] != null ? new Data.fromJson(json['data']) : null
    );
  }
}

String _text="";

class Data6{

}

class Data5 {
  List hypotheses;
  bool finalStr;
  Data5 ({this.hypotheses,this.finalStr});
  Data5.fromJson(Map<String, dynamic> json) {
    hypotheses = json['hypotheses'];
    finalStr = json['final'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hypotheses'] = this.hypotheses;
    return data;
  }
}

class ResultResponse5 {
  Data5 data;
  int status;

  ResultResponse5({
    this.data,
    this.status,
  });

  factory ResultResponse5.fromJson(Map<String, dynamic> json) {
    return ResultResponse5(
        status: json['status'],
        data: json['result'] != null ? new Data5.fromJson(json['result']) : null
    );
  }
}

getTranscript(String response){
    ResultResponse5.fromJson(jsonDecode(response));

    List a = ResultResponse5.fromJson(jsonDecode(response)).data.hypotheses;
    List list= a.map((array)=>array['transcript_normed']).toList();
    _text = list.join("");
    print(_text);
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



typedef _Fn = void Function();
const int tSampleRate = 44000;
class _VoicePay extends State<VoicePay>{
  String _text2 = "";
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String _mPath;
  StreamSubscription _mRecordingDataSubscription;


 AudioPlayer audioPlayer = new AudioPlayer();
 stt.SpeechToText _speech;
 bool _isListening = false;
 //String _text = '';
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
            _channel.stream.asBroadcastStream().listen(
                  (dynamic message) {
                _text2 = message;
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


    await _mRecorder.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
    setState(() {});
  }
  // --------------------- (it was very simple, wasn't it ?) -------------------

  Future<void> stopRecorder() async {
    await _mRecorder.stopRecorder();

    if (_mRecordingDataSubscription != null) {

      _mRecordingDataSubscription = null;
    }
    _mplaybackReady = true;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if(_text!=null&&_text=="Tôi muốn thanh toán"){
              setState(() => _isListening=false);

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MessagesScreen()));
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  _Fn getRecorderFn() {

    // if (!_mRecorderIsInited) {
    //   return null;
    // }
    return _mRecorder.isStopped
        ? record
        : () {
      stopRecorder().then((value) => setState(() {

        getTranscript(_text2);

        if(_text!=null&&_text=="Tôi muốn thanh toán"){

          setState(() => _isListening=false);
          Timer(Duration(seconds: 2), () {
            _onClick();
            // 5 seconds over, navigate to Page2.
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MessagesScreen()));
          });

        }
      }));

    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.cyan),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(
              //   constraints: BoxConstraints.loose(Size(double.infinity,40)),
              //   alignment: AlignmentDirectional.topStart,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              //     child: Text(
              //       "Trang Đăng Nhập",
              //       style: TextStyle(fontSize: 18,color: Colors.blue),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 20,
              ),

              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black26,
                backgroundImage: AssetImage("assets/images/aiimage.png"),
                // child: RaisedButton(
                //   color: Colors.transparent,
                //   onPressed: _onClick,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  "Xin chào, Tôi là Smazer\n Tôi là trợ lý ảo của bạn.\nHãy nói \"Tôi muốn thanh toán\" để mua hàng!",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                child: Text(
                  _text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,color: Colors.cyan),
                ),

              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child:
                  AvatarGlow(
                  animate: _isListening,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 75.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: FloatingActionButton(
                    onPressed: getRecorderFn(),
                    child: Icon(_mRecorder.isRecording ? Icons.mic : Icons.mic_none),
                  ),
                ),

                  // child: RawMaterialButton(
                  //   onPressed: () async {
                  //     onClick();
                  //
                  //     // Navigator.push(
                  //     //   context, MaterialPageRoute(builder: (context) => MessagesScreen()));
                  //
                  //   },
                  //   elevation: 2.0,
                  //   fillColor: Colors.cyan,
                  //   child: Icon(
                  //     Icons.mic,
                  //     size: 45.0,
                  //     color: Colors.white,
                  //   ),
                  //   padding: EdgeInsets.all(15.0),
                  //   shape: CircleBorder(
                  //
                  //   ),
                  // ),

                  // child: RaisedButton(
                  //   //   {
                  //   //   Navigator.push(context,
                  //   //       MaterialPageRoute(builder: (context) => OtpPage()));
                  //   // },
                  //   child: Text(
                  //     "Đăng nhập",
                  //     style: TextStyle(color: Colors.white, fontSize: 18),
                  //   ),
                  //   color: Color(0xff3277D8),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(6))),
                  // ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              //   child: RichText(
              //     text: TextSpan(
              //         text: "Bạn chưa có tài khoản?",
              //         style: TextStyle(color: Color(0xff606470), fontSize: 16),
              //         children: <TextSpan>[
              //           TextSpan(
              //               recognizer: TapGestureRecognizer()
              //                 ..onTap = () {
              //
              //
              //                 },
              //               text: "Đăng ký tài khoản mới",
              //               style: TextStyle(
              //                   color: Color(0xff3277D8), fontSize: 16))
              //         ]),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  void _onClick() async{
  await _getUrl("Xin chào thắng, Có phải bạn muốn mua Tay cầm PS4?");
  if(myurl!=null){
    audioPlayer.play(myurl,isLocal:true);
    audioPlayer.onPlayerCompletion.listen((event) {

    });
  }

  setState(()  {

    }
);


  }



}