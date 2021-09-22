// import 'dart:async';
// import 'dart:typed_data';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sound_stream/sound_stream.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:websocket_manager/websocket_manager.dart';
//
// // class VoiceMessage extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// //
// // }
// // class _MyAppState extends State<VoiceMessage> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   final TextEditingController _urlController =
// //   TextEditingController(text: 'ws://103.74.122.136:8085/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)44100,+format=(string)S16LE,+channels=(int)1');
// //   final TextEditingController _messageController = TextEditingController();
// //   WebsocketManager socket;
// //
// //   String _message = '';
// //   String _closeMessage = '';
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Websocket Manager Example'),
// //         ),
// //         body: Column(
// //           children: <Widget>[
// //             TextField(
// //               controller: _urlController,
// //             ),
// //             Wrap(
// //               children: <Widget>[
// //                 RaisedButton(
// //                   child: Text('CONFIG'),
// //                   onPressed: () =>
// //                   socket = WebsocketManager(_urlController.text),
// //                 ),
// //                 RaisedButton(
// //                   child: Text('CONNECT'),
// //                   onPressed: () {
// //                     if (socket != null) {
// //                       socket.connect();
// //                     }
// //                   },
// //                 ),
// //                 RaisedButton(
// //                   child: Text('CLOSE'),
// //                   onPressed: () {
// //                     if (socket != null) {
// //                       socket.close();
// //                     }
// //                   },
// //                 ),
// //                 RaisedButton(
// //                   child: Text('LISTEN MESSAGE'),
// //                   onPressed: () {
// //                     if (socket != null) {
// //                       socket.onMessage((dynamic message) {
// //                         print('New message: $message');
// //                         setState(() {
// //                           _message = message.toString();
// //                         });
// //                       });
// //                     }
// //                   },
// //                 ),
// //                 RaisedButton(
// //                   child: Text('LISTEN DONE'),
// //                   onPressed: () {
// //                     if (socket != null) {
// //                       socket.onClose((dynamic message) {
// //                         print('Close message: $message');
// //                         setState(() {
// //                           _closeMessage = message.toString();
// //                         });
// //                       });
// //                     }
// //                   },
// //                 ),
// //                 RaisedButton(
// //                   child: Text('ECHO TEST'),
// //                   onPressed: () => WebsocketManager.echoTest(),
// //                 ),
// //               ],
// //             ),
// //             TextField(
// //               controller: _messageController,
// //               decoration: InputDecoration(
// //                 suffixIcon: IconButton(
// //                   icon: Icon(Icons.send),
// //                   onPressed: () {
// //                     if (socket != null) {
// //                       socket.send(_messageController.text);
// //                     }
// //                   },
// //                 ),
// //               ),
// //             ),
// //             Text('Received message:'),
// //             Text(_message),
// //             Text('Close message:'),
// //             Text(_closeMessage),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
// // class _MyAppState extends State<VoiceMessage> {
// //
// //
// //   RecorderStream _recorder = RecorderStream();
// //   PlayerStream _player = PlayerStream();
// //   final _channel = WebSocketChannel.connect(
// //     Uri.parse('wss://dev.interits.com/asr/stream/socket/16k/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)44100,+format=(string)S16LE,+channels=(int)1'),
// //   );
// //   List<Uint8List> _micChunks = [];
// //   bool _isRecording = false;
// //   bool _isPlaying = false;
// //
// //   StreamSubscription _recorderStatus;
// //   StreamSubscription _playerStatus;
// //   StreamSubscription _audioStream;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     initPlugin();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _recorderStatus?.cancel();
// //     _playerStatus?.cancel();
// //     _audioStream?.cancel();
// //     super.dispose();
// //   }
// //
// //   // Platform messages are asynchronous, so we initialize in an async method.
// //   Future<void> initPlugin() async {
// //     _recorderStatus = _recorder.status.listen((status) {
// //       if (mounted)
// //         setState(() {
// //           _isRecording = status == SoundStreamStatus.Playing;
// //         });
// //     });
// //
// //     _audioStream = _recorder.audioStream.listen((data) {
// //       if (_isPlaying) {
// //         _player.writeChunk(data);
// //       } else {
// //         _micChunks.add(data);
// //       }
// //     });
// //
// //     _playerStatus = _player.status.listen((status) {
// //       if (mounted)
// //         setState(() {
// //           _isPlaying = status == SoundStreamStatus.Playing;
// //         });
// //     });
// //
// //     await Future.wait([
// //       _recorder.initialize(),
// //       _player.initialize(),
// //     ]);
// //   }
// //
// //   void _play() async {
// //     await _player.start();
// //
// //     if (_micChunks.isNotEmpty) {
// //       for (var chunk in _micChunks) {
// //         await _player.writeChunk(chunk);
// //       }
// //       _micChunks.clear();
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Plugin example app'),
// //         ),
// //         body: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //           children: [
// //             IconButton(
// //               iconSize: 96.0,
// //               icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
// //               onPressed:
// //               //_isRecording ? _recorder.stop : _recorder.start,
// //                   (){
// //                 if(_isRecording){
// //                   _recorder.stop();
// //                 }else{
// //                   _recorder.start();
// //                 }
// //                 _channel.sink.add(_recorder)
// //
// //                 ;},
// //             ),
// //             StreamBuilder(
// //               stream: _channel.stream,
// //               builder: (context, snapshot) {
// //                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
// //               },
// //             ),
// //             IconButton(
// //               iconSize: 96.0,
// //               icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
// //               onPressed: _isPlaying ? _player.stop : _play,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// /*
//  * This is an example showing how to record to a Dart Stream.
//  * It writes all the recorded data from a Stream to a File, which is completely stupid:
//  * if an App wants to record something to a File, it must not use Streams.
//  *
//  * The real interest of recording to a Stream is for example to feed a
//  * Speech-to-Text engine, or for processing the Live data in Dart in real time.
//  *
//  */
//
// ///
// const int tSampleRate = 44000;
// typedef _Fn = void Function();
//
// /// Example app.
// class RecordToStreamExample extends StatefulWidget {
//   @override
//   _RecordToStreamExampleState createState() => _RecordToStreamExampleState();
// }
//
// class _RecordToStreamExampleState extends State<RecordToStreamExample> {
//   String _text = "",_text2 = "";
//   FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
//   FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
//   bool _mPlayerIsInited = false;
//   bool _mRecorderIsInited = false;
//   bool _mplaybackReady = false;
//   String _mPath;
//   StreamSubscription _mRecordingDataSubscription;
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('wss://dev.interits.com/asr/stream/socket/16k/client/ws/speech?content-type=audio/x-raw,+layout=(string)interleaved,+rate=(int)44100,+format=(string)S16LE,+channels=(int)1'),
//   );
//   Future<void> _openRecorder() async {
//     var status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Microphone permission not granted');
//     }
//     await _mRecorder.openAudioSession();
//     setState(() {
//       _mRecorderIsInited = true;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Be careful : openAudioSession return a Future.
//     // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
//     _mPlayer.openAudioSession().then((value) {
//       setState(() {
//         _mPlayerIsInited = true;
//       });
//     });
//     _openRecorder();
//   }
//
//   @override
//   void dispose() {
//     stopPlayer();
//     _mPlayer.closeAudioSession();
//     _mPlayer = null;
//
//     stopRecorder();
//     _mRecorder.closeAudioSession();
//     _mRecorder = null;
//     super.dispose();
//   }
//
//   Future<IOSink> createFile() async {
//     var tempDir = await getTemporaryDirectory();
//     _mPath = '${tempDir.path}/flutter_sound_example.pcm';
//     var outputFile = File(_mPath);
//     if (outputFile.existsSync()) {
//       await outputFile.delete();
//     }
//     return outputFile.openWrite();
//   }
//
//   // ----------------------  Here is the code to record to a Stream ------------
//
//   Future<void> record() async {
//     assert(_mRecorderIsInited && _mPlayer.isStopped);
//
//     var sinkf = await createFile();
//     var recordingDataController = StreamController<Food>();
//     _mRecordingDataSubscription =
//         recordingDataController.stream.listen((buffer) {
//           if (buffer is FoodData) {
//               sinkf.add(buffer.data);
//              _channel.sink.add(buffer.data);
//           }
//         });
//     _channel.stream.listen(
//           (dynamic message) {
//             _text2 = message;
//
//         debugPrint('message $message');
//       },
//       onDone: () {
//         debugPrint('ws channel closed');
//         _channel.sink.close();
//       },
//       onError: (error) {
//         debugPrint('ws error $error');
//       },
//     );
//     await _mRecorder.startRecorder(
//       toStream: recordingDataController.sink,
//       codec: Codec.pcm16,
//       numChannels: 1,
//       sampleRate: tSampleRate,
//     );
//     setState(() {});
//   }
//   // --------------------- (it was very simple, wasn't it ?) -------------------
//
//   Future<void> stopRecorder() async {
//     await _mRecorder.stopRecorder();
//     _channel.sink.close();
//     if (_mRecordingDataSubscription != null) {
//       await _mRecordingDataSubscription.cancel();
//       _mRecordingDataSubscription = null;
//     }
//     _mplaybackReady = true;
//   }
//
//   _Fn getRecorderFn() {
//     if (!_mRecorderIsInited || !_mPlayer.isStopped) {
//       return null;
//     }
//     return _mRecorder.isStopped
//         ? record
//         : () {
//       stopRecorder().then((value) => setState(() {}));
//     };
//   }
//
//   void play() async {
//     assert(_mPlayerIsInited &&
//         _mplaybackReady &&
//         _mRecorder.isStopped &&
//         _mPlayer.isStopped);
//     await _mPlayer.startPlayer(
//         fromURI: _mPath,
//         sampleRate: tSampleRate,
//         codec: Codec.pcm16,
//         numChannels: 1,
//         whenFinished: () {
//           setState(() {});
//         }); // The readability of Dart is very special :-(
//     setState(() {});
//   }
//
//   Future<void> stopPlayer() async {
//     await _mPlayer.stopPlayer();
//   }
//
//   _Fn getPlaybackFn() {
//     if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
//       return null;
//     }
//     return _mPlayer.isStopped
//         ? play
//         : () {
//       stopPlayer().then((value) => setState(() {}));
//     };
//   }
//
//   // ----------------------------------------------------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//     Widget makeBody() {
//       return SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(3),
//               padding: const EdgeInsets.all(3),
//               height: 80,
//               width: double.infinity,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Color(0xFFFAF0E6),
//                 border: Border.all(
//                   color: Colors.indigo,
//                   width: 3,
//                 ),
//               ),
//               child: Row(children: [
//                 ElevatedButton(
//                   onPressed: getRecorderFn(),
//                   //color: Colors.white,
//                   //disabledColor: Colors.grey,
//                   child: Text(_mRecorder.isRecording ? 'Stop' : 'Record'),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text(_mRecorder.isRecording
//                     ? 'Recording in progress'
//                     : 'Recorder is stopped'),
//               ]),
//             ),
//             Container(
//               margin: const EdgeInsets.all(3),
//               padding: const EdgeInsets.all(3),
//               height: 80,
//               width: double.infinity,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Color(0xFFFAF0E6),
//                 border: Border.all(
//                   color: Colors.indigo,
//                   width: 3,
//                 ),
//               ),
//               child: Row(children: [
//                 ElevatedButton(
//                   onPressed: getPlaybackFn(),
//                   //color: Colors.white,
//                   //disabledColor: Colors.grey,
//                   child: Text(_mPlayer.isPlaying ? 'Stop' : 'Play'),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text(_mPlayer.isPlaying
//                     ? 'Playback in progress'
//                     : 'Player is stopped'),
//
//               ]),
//             ),
//             // Padding(
//             //     padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
//             //     child: Text(
//             //       _text,
//             //       textAlign: TextAlign.center,
//             //       style: TextStyle(fontSize: 20,color: Colors.cyan),
//             //     )
//             // ),
//             SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
//                 child: Text(
//                   _text2,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20,color: Colors.cyan),
//                 )
//             ),
//           ],
//         ),
//
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text('ARS.'),
//       ),
//       body: makeBody(),
//     );
//   }
//
// }