import '../components/home_activity_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeComponentWidget extends StatefulWidget {
  const HomeComponentWidget({Key key}) : super(key: key);

  @override
  _HomeComponentWidgetState createState() => _HomeComponentWidgetState();
}

class _HomeComponentWidgetState extends State<HomeComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 320,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/No_way_for_Ambulance.png',
              ).image,
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF1E2429), Color(0x001E2429)],
              stops: [0, 1],
              begin: AlignmentDirectional(0, 1),
              end: AlignmentDirectional(0, -1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Image.asset(
                  'assets/images/logo3.png',
                  width: 230,
                  height: 90,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome!',
                            style: FlutterFlowTheme.title1.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Find your Service in clicks',
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Roboto',
                              color: FlutterFlowTheme.tertiaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: HomeActivityWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
