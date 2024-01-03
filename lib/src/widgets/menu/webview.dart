import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Síguenos'),
      ),
      body: WebViewPlus(
        initialUrl: widget.url,
      ),
    );
  }
}
