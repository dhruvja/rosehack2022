import 'package:mitra/forum_post/forum_post_widget.dart';

import '../components/date_widget.dart';
import '../components/forum1_widget.dart';
import '../components/scroll2_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../api_endpoint.dart';

class ForumWidget extends StatefulWidget {
  const ForumWidget({Key key}) : super(key: key);

  @override
  _ForumWidgetState createState() => _ForumWidgetState();
}

class _ForumWidgetState extends State<ForumWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var messages;
  bool present = false;

  void initState() {
    super.initState();
    getStatus();
  }

  void getStatus() async {
    String endpoint = Endpoint();
    try {
      String url = endpoint + "api/getforum";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        var data = json.decode(response.body);
        print(data);
        setState(() {
          messages = data;
          present = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xC4050E6A),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumPostWidget(),
            ),
          );
        },
        backgroundColor: Color(0xFFFEFEFE),
        elevation: 8,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/No_way_for_Ambulance.png',
                            ).image,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: DateWidget(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Scroll2Widget(),
                                  ),
                                ),
                              ],
                            ),
                            if (present)
                              ...(messages).map((message) {
                                return Forum1Widget(message);
                              })
                          ],
                        ),
                      ),
                    ],
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
