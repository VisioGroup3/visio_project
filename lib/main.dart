import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For camera integration
import 'package:google_ml_kit/google_ml_kit.dart'; // Using Google ML Kit for face detection

class FacerecognitionWidget extends StatefulWidget {
  const FacerecognitionWidget({super.key});

  static String routeName = 'facerecognition';
  static String routePath = '/facerecognition';

  @override
  State<FacerecognitionWidget> createState() => _FacerecognitionWidgetState();
}

class _FacerecognitionWidgetState extends State<FacerecognitionWidget> {
  late String _scanStatus = "Ready to scan";
  late XFile? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  final faceDetector = GoogleMlKit.vision.faceDetector();

  @override
  void dispose() {
    super.dispose();
    faceDetector.close(); // Closing the face detector when disposing the widget
  }

  Future<void> _scanFace() async {
    // Show camera to capture image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _capturedImage = image;
        _scanStatus = "Scanning...";
      });

      // Use a face recognition library (Google ML Kit) to process the captured image
      bool faceMatched = await _performFaceRecognition(image);
      setState(() {
        _scanStatus = faceMatched ? "Face Recognized!" : "Face not recognized. Try again.";
      });
    } else {
      setState(() {
        _scanStatus = "No image captured.";
      });
    }
  }

  // Using Google ML Kit for face recognition (basic face detection)
  Future<bool> _performFaceRecognition(XFile image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);
      final faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        // If faces are detected, return true (simulated result)
        return true;
      } else {
        // No faces detected
        return false;
      }
    } catch (e) {
      print("Error in face recognition: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          automaticallyImplyLeading: true,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pushNamed(DashboardWidget.routeName);
            },
            child: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 250.0,
                            height: 250.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Color(0x19000000),
                                  offset: Offset(0.0, 4.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(125.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).secondary,
                                width: 2.0,
                              ),
                            ),
                            child: Icon(
                              Icons.face_outlined,
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 100.0,
                            ),
                          ),
                        ),
                        Text(
                          'Face Recognition',
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                          child: Text(
                            'Position your face within the frame to scan and verify your identity',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Manrope',
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Container(
                width: double.infinity,
                height: 90.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Color(0x26000000),
                      offset: Offset(0.0, -2.0),
                    )
                  ],
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primaryBackground,
                      FlutterFlowTheme.of(context).primaryBackground
                    ],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: _scanFace,
                        text: 'Scan Face',
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          size: 20.0,
                        ),
                        options: FFButtonOptions(
                          width: 200.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Manrope',
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  _scanStatus,
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
