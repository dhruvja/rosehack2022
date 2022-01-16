import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show Date, DateFormat ;
import 'dart:async';
import 'dart:io';



class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var _location_message = "";
  String _recorderText = "";

  FlutterSoundRecorder _recorder;
  String filepath = "";
  bool _play = false;

  void startIt() async{
    filepath = "/Users/Deepak/Documents";

    _recorder = FlutterSoundRecorder();
    
    
    // await initializeDateFormatting();

    final status = await Permission.microphone.request();
    if(status!= PermissionStatus.granted){
      print("Microphone permission not granted $status");
      AppSettings.openSoundSettings();
    }
    else
      print("Microphone access granted $status");
    await Permission.storage.request();

    await _recorder.openAudioSession(
      focus: AudioFocus.requestFocusAndStopOthers,
      category: SessionCategory.playAndRecord,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker
    );

    await _recorder.setSubscriptionDuration(Duration(milliseconds: 10));


  }

  int x = 0; 

  Future<String> getFilePath() async {
    int i = 4;
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.aac";
  }

  Future<void> record() async{
    // Directory dir = Directory(path.dirname(filepath));
    // if(!dir.existsSync()){
    //   dir.createSync();
    // }

    _recorder.openAudioSession();

    filepath = await getFilePath();

    _recorder.startRecorder(
      toFile: filepath,
    );

    print("Recording $x++");

    StreamSubscription _recorderSubscription = _recorder.onProgress.listen((e){
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,isUtc: true);
      var txt = DateFormat('mm:ss:SS','en_GB').format(date);
      // initializeDateFormatting();
      setState((){
        _recorderText = "Recording" ; 
      });

    });
    _recorderSubscription.cancel();
  }

  Future stopIt() async{
    _recorder.closeAudioSession();
    print("Stopped");
    await _recorder.stopRecorder();
    uploadAudio();
  }

  // Future<File> getAudioFile() async{
  //   final path = await getFilePath();
  //   return File(path);
  // }

  void uploadAudio() async{
    var filePath = await getFilePath();
    const url = "http://localhost:5000/api/uploadAudio";
    var request = http.MultipartRequest('POST',Uri.parse(url));
    request.files.add(
      http.MultipartFile(
        'audio',
        File(filePath).readAsBytes().asStream(),
        File(filepath).lengthSync(),
        filename: filePath.split('/').last
      )
    );
    var res = await request.send();
  }

  



  void getLocation() async{
    final status = await Permission.microphone.request();
    if(status!= PermissionStatus.granted){
      print("Microphone permission not granted $status");
      AppSettings.openSoundSettings();
    }
    else{
      print("Microphone access granted $status");

    }
    var file = await getFilePath();
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      print("Permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    }
    else{
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      Position lastPosition = await Geolocator.getLastKnownPosition();
      print(" latitude: " + currentPosition.latitude.toString());
      print(" longitude: " + currentPosition.longitude.toString());
      setState((){
        _location_message = currentPosition.latitude.toString() + ", " + currentPosition.longitude.toString();
      });

    }
    print(file);
    

  }

  // ignore: must_call_super
  void initState(){
    startIt();
    super.initState();
    // FlutterAudioRecorder2.hasPermissions.then((hasPermision) {
    //   if (hasPermision) {
    //     print("Got Permission");
    //     // _recordingState = RecordingState.Set;
    //     // _recordIcon = Icons.mic;
    //     // _recordText = 'Record';
    //   }
    //   else{
    //     print("No permission");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
                getLocation();
                print(_location_message);
              },
              text: 'Get Coordinates',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
                record();
              },
              text: 'Start Recording',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
                stopIt();
              },
              text: 'Stop Recording',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: _recorderText,
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: FlutterFlowTheme.primaryColor,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
