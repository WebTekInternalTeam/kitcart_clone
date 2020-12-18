import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io' show Platform;



class WebViewContainer extends StatefulWidget {
  final url;
  final title;
  WebViewContainer(this.url, this.title);
  @override
  createState() => _WebViewContainerState(this.url, this.title);
}

class _WebViewContainerState extends State<WebViewContainer> {
  int _currentindex = 0;
  bool back = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    OneSignal.shared.init(
        "",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  }
  
  InAppWebViewController webView;
  Future<bool> _onBack() async {
    bool goBack;
    var value = await webView.canGoBack();
    if (value) {
      webView.goBack();
      print('value for goback is $value');
      back=value;
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Confirmation ', style: TextStyle(color: Color.fromRGBO(107, 197, 178,1.0))),
          content: new Text('Do you want exit app ? '),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  goBack = true;
                });
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      );
      if (goBack) SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return goBack;
    }
  }
  var _url;
  var _title;
  final _key = UniqueKey();
  bool platform = Platform.isIOS;
  double progress = 0 ;
  _WebViewContainerState(this._url, this._title);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBack,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromRGBO(107, 197, 178,1.0),
                title : Text(''),
                actions: <Widget>[
                  IconButton(
                      padding: EdgeInsets.all(10.0),
                      icon: Image.asset(''),
                      onPressed: () {
                        setState(() {
                          webView.loadUrl(url:
                          '';
                        });
                      }
                  )
                ],
                leading: Container(
                  padding: EdgeInsets.all(10.0),
                  child :Image.asset(''),
                      )
            ),

            bottomNavigationBar: BottomNavigationBar(
              iconSize: 30,
              currentIndex: _currentindex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromRGBO(107, 197, 178,1.0),
              selectedItemColor: Colors.white,
              showUnselectedLabels: true,
              selectedFontSize: 14,
              items: [
                BottomNavigationBarItem(
                  title: Text(""),
                  icon: Icon(Icons.home)
                ),
                BottomNavigationBarItem(
                  title: Text(""),
                  icon: Icon(Icons.shopping_cart)
                ),
                BottomNavigationBarItem(
                  title: Text(""),
                  icon: Icon(Icons.local_offer)
                ),
                BottomNavigationBarItem(
                  title: Text(""),
                  icon: Icon(Icons.account_circle)
                ),
              ],
              onTap: (int index){
                setState(() {
                  _currentindex = index;
                });
                switch(index){
                    case 0:
                      setState(() {
                        webView.loadUrl(url: '');
                      });
                      break;
                    case 1:
                      setState(() {
                        webView.loadUrl(url: '');
                      });
                      break;
                    case 2:
                      setState(() {
                        webView.loadUrl(url: '');
                      });
                      break;
                    case 3:
                      setState(() {
                        webView.loadUrl(url: '');
                      });
                      break;
                    default :
                      print("case default with index $index");
                      break;
                  }
              },
            ),
            body : Column(
                children: <Widget>[
                  (progress != 1.0)
                      ? LinearProgressIndicator(
                       minHeight: 7,
                       value: progress,
                       backgroundColor: Colors.grey[200],
                       valueColor: AlwaysStoppedAnimation<Color>(Colors.amber))
                      : null,    // Should be removed while showing
                  Expanded(
                    child: Container(
                      child: InAppWebView(
                        initialUrl: _url,
                        initialHeaders: {},
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart: (InAppWebViewController controller, String url) {
                        },
                        onProgressChanged:
                            (InAppWebViewController controller, int progress) {
                          setState(() {
                            this.progress = progress / 100;
                          });
                        },
                      ),
                    ),
                  )
                ].where((Object o) => o != null).toList()
            )
        )
    );
  }
}