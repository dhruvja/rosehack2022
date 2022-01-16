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
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show Date, DateFormat;
import 'dart:async';
import 'dart:io';

class SheNeeds1Widget extends StatefulWidget {
  const SheNeeds1Widget({Key key}) : super(key: key);

  @override
  _SheNeeds1WidgetState createState() => _SheNeeds1WidgetState();
}

class _SheNeeds1WidgetState extends State<SheNeeds1Widget> {
  var _location_message = "";
  String _recorderText = "";

  FlutterSoundRecorder _recorder;
  String filepath = "";
  bool _play = false;
  bool _recordStatus = false;
  String _recordName = "Record";

  void startIt() async {
    filepath = "/Users/Deepak/Documents";

    _recorder = FlutterSoundRecorder();

    // await initializeDateFormatting();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("Microphone permission not granted $status");
    } else
      print("Microphone access granted $status");
    await Permission.storage.request();

    await _recorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);

    await _recorder.setSubscriptionDuration(Duration(milliseconds: 10));
  }

  int x = 0;

  Future<String> getFilePath() async {
    int i = 8;
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.aac";
  }

  Future<void> record() async {
    // Directory dir = Directory(path.dirname(filepath));
    // if(!dir.existsSync()){
    //   dir.createSync();
    // }

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("Microphone permission not granted $status");
    } else {
      print("Microphone access granted $status");
      _recorder.openAudioSession();

      filepath = await getFilePath();

      _recorder.startRecorder(
        toFile: filepath,
      );

      print("Recording $x++");
      setState(() {
        _recordStatus = true;
        _recordName = "Stop Record";
      });

      StreamSubscription _recorderSubscription =
          _recorder.onProgress.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        // initializeDateFormatting();
        setState(() {
          _recorderText = "Recording";
        });
      });
      _recorderSubscription.cancel();
    }
  }

  Future stopIt() async {
    _recorder.closeAudioSession();
    print("Stopped");
    await _recorder.stopRecorder();
    setState(() {
      _recordStatus = false;
      _recordName = "Audio has been uploaded";
    });
    uploadAudio();
  }

  // Future<File> getAudioFile() async{
  //   final path = await getFilePath();
  //   return File(path);
  // }

  void uploadAudio() async {
    var filePath = await getFilePath();
    const url = "http://192.168.0.192:5000/api/uploadAudio";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile('audio',
        File(filePath).readAsBytes().asStream(), File(filepath).lengthSync(),
        filename: filePath.split('/').last));
    var res = await request.send();
  }

  void getLocation() async {
    var file = await getFilePath();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      Position lastPosition = await Geolocator.getLastKnownPosition();
      print(" latitude: " + currentPosition.latitude.toString());
      print(" longitude: " + currentPosition.longitude.toString());
      setState(() {
        _location_message = currentPosition.latitude.toString() +
            ", " +
            currentPosition.longitude.toString();
      });
    }
    print(file);
  }

  // ignore: must_call_super
  void initState() {
    startIt();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xFF010524),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: FFButtonWidget(
              onPressed: () {
                print('Record Button pressed ...');
                if (_recordStatus == false)
                  record();
                else
                  stopIt();
              },
              text: _recordName,
              icon: Icon(
                Icons.record_voice_over,
                size: 15,
              ),
              options: FFButtonOptions(
                width: 300,
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
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: 'Notify my PROTECTORS',
              icon: Icon(
                Icons.location_on,
                size: 15,
              ),
              options: FFButtonOptions(
                width: 300,
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
          ),
        ],
      ),
    );
  }
}
