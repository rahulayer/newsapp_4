import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState(blogUrl);
}

class _ArticleViewState extends State<ArticleView> {
  final WebViewController _webViewController = WebViewController();
  final String blogUrl;
  _ArticleViewState(this.blogUrl);
  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(blogUrl));
  }
  final Completer<WebViewController> completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.article, // Replace with the desired icon
              color: Colors.blue, // Adjust icon color as needed
            ),
            SizedBox(width: 5), // Add some spacing between icon and text
            Text(
              "NEWS ",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "24",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16)
                ,child: Icon(Icons.save)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body:
      Container(
        height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        child:  WebViewWidget(
          controller: _webViewController,
        ),
          ),

    );
  }
}
