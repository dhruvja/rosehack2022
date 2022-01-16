import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/result_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../api_endpoint.dart';
import 'package:geolocator/geolocator.dart';

class AmbulanceWidget extends StatefulWidget {
  const AmbulanceWidget({Key key}) : super(key: key);

  get searchText => null;

  @override
  _AmbulanceWidgetState createState() => _AmbulanceWidgetState();
}

class _AmbulanceWidgetState extends State<AmbulanceWidget> {
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  TextEditingController textController;
  String dropDownValue1;
  String dropDownValue2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String latitude;
  String longitude;
  bool _enter = false;
  var results;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getLocation();
  }


  void getPlaces1() async {
    String endpoint = Endpoint();
    try {
      String url = endpoint + "api/gethospitals";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        var data = json.decode(response.body);
        print(data);
        setState(() {
          results = data;
          _enter = true;
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No Interent Found, try again'),
            backgroundColor: Colors.redAccent),
      );
    }
  }

  void getLocation() async {
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
        latitude = currentPosition.latitude.toString();
        longitude = currentPosition.longitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEFEFEF),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 108,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 44, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'MITRA',
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                'Your survivor on time',
                                style: FlutterFlowTheme.bodyText2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0.12),
                    child: Container(
                      width: 400,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: BoxDecoration(),
                      child: FlutterFlowGoogleMap(
                        controller: googleMapsController,
                        onCameraIdle: (latLng) => googleMapsCenter = latLng,
                        initialLocation: googleMapsCenter ??=
                            LatLng(13.34, 77.11),
                        markerColor: GoogleMarkerColor.violet,
                        mapType: MapType.normal,
                        style: GoogleMapStyle.standard,
                        initialZoom: 14,
                        allowInteraction: true,
                        allowZoom: true,
                        showZoomControls: true,
                        showLocation: true,
                        showCompass: false,
                        showMapToolbar: false,
                        showTraffic: false,
                        centerMapOnMarkerTap: true,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!_enter)
                    Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: Container(
                          width: double.infinity,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Color(0xFF161853),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: FlutterFlowDropDown(
                                                initialOption:
                                                    dropDownValue1 ??=
                                                        'Is it Accident',
                                                options: [
                                                  'Is it Accident',
                                                  'Yes',
                                                  'No',
                                                  ''
                                                ].toList(),
                                                onChanged: (val) => setState(
                                                    () => dropDownValue1 = val),
                                                width: 150,
                                                height: 50,
                                                textStyle: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                                fillColor: Color(0xFF161853),
                                                elevation: 2,
                                                borderColor: FlutterFlowTheme
                                                    .tertiaryColor,
                                                borderWidth: 0,
                                                borderRadius: 0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 12, 4),
                                                hidesUnderline: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: FlutterFlowDropDown(
                                                options: [
                                                  'Injury type',
                                                  'Head',
                                                  'Heart attack',
                                                  'Ortho',
                                                  'Other emergency'
                                                ].toList(),
                                                onChanged: (val) => setState(
                                                    () => dropDownValue2 = val),
                                                width: 150,
                                                height: 50,
                                                textStyle: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                                fillColor: Color(0xFF161853),
                                                elevation: 2,
                                                borderColor: FlutterFlowTheme
                                                    .tertiaryColor,
                                                borderWidth: 0,
                                                borderRadius: 0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 12, 4),
                                                hidesUnderline: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Get Current Location',
                                  icon: Icon(
                                    Icons.location_on,
                                    size: 15,
                                  ),
                                  options: FFButtonOptions(
                                    width: 300,
                                    height: 40,
                                    color: FlutterFlowTheme.primaryColor,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      getPlaces1();
                                    },
                                    text: 'Search',
                                    icon: Icon(
                                      Icons.search,
                                      size: 15,
                                    ),
                                    options: FFButtonOptions(
                                      width: 300,
                                      height: 40,
                                      color: FlutterFlowTheme.primaryColor,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
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
                          ),
                        )),
                  if (_enter)
                    Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: Container(
                          width: double.infinity,
                          height: 240,
                          decoration: BoxDecoration(
                            color: Color(0xFF161853),
                          ),
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                ...(results).map((result) {
                                  return ResultWidget(result);
                                })
                              ])),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
