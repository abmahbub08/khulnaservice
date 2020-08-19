import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webView extends StatefulWidget {
  var Url;

  webView(this.Url);

  @override
  _webViewState createState() => _webViewState();
}

class _webViewState extends State<webView> {
  var isloading = true;
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  bool _isLoadingPage;

  @override
  void initState() {
    super.initState();

    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: '${widget.Url}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _completer.complete(webViewController);
              },
              onPageStarted: (d) {
                print(d);
                setState(() {
                  _isLoadingPage = true;
                });
                if (d.split('/').contains("success") ||
                    d.split('/').contains("cancel") ||
                    d.split('/').contains("fail")) {
                  Navigator.pop(context, d);
                }
              },
              onPageFinished: (finish) {
                setState(() {
                  _isLoadingPage = false;
                });
              },
            ),
            _isLoadingPage
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }
}
