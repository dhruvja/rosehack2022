import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedtaskWidget extends StatefulWidget {
  const CompletedtaskWidget({Key key}) : super(key: key);

  @override
  _CompletedtaskWidgetState createState() => _CompletedtaskWidgetState();
}

class _CompletedtaskWidgetState extends State<CompletedtaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Color(0x34000000),
            offset: Offset(-2, 5),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 4,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completed',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF307F07),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Estimated date of complition',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        '15-Jan-2022',
                        style: FlutterFlowTheme.title1.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      'Check in',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Started on',
                    style: FlutterFlowTheme.bodyText1,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                          child: Text(
                            '15-Jan-2022',
                            style: FlutterFlowTheme.title3.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
