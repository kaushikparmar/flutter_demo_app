import 'package:flutter/material.dart';
import 'sidebar-navigation.dart';
import 'package:demo/src/common/progressbar.dart';
import 'package:demo/src/utils/common-service.dart';
import 'package:demo/src/utils/network-utils.dart';
import 'package:demo/src/home.dart';

class MyItemDetails extends StatefulWidget {
  MyItemDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyItemDetailsState createState() => new _MyItemDetailsState();
}

class _MyItemDetailsState extends State<MyItemDetails> {

  // Network Service
  NetworkUtil _netUtil = new NetworkUtil();
  // Common Service
  CommonService _commonService = new CommonService();
  //handler that we will use to show and hide widget
  ProgressBarHandler _handler;

  List<dynamic> listItems = [];

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var scaffold = Scaffold(
                    appBar: new AppBar(
                      iconTheme: IconThemeData(color: Colors.lightBlueAccent),
                      title: new Container(
                        margin: EdgeInsets.only(left: 130.0),
                        child: new Image.asset('assets/images/care-logo.png', height: 25.0),
                      ),
                      centerTitle: false,
                      backgroundColor: Colors.white,
                    ),
                    drawer: SidebarNavigation(ModalRoute.of(context).settings.name),
                    body: body(context, args),
                  );
    var progressBar = ModalRoundedProgressBar(
      //getting the handler
      handleCallback: (handler) { _handler = handler;},
    );

    return Stack(
      children: <Widget>[
        scaffold,
        progressBar,
      ],
    ); 
  }

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  void fetchList() {
    // _handler.show();
    _netUtil.get('GetLastXBreakingNews?rowsToReturn=10').then((dynamic res) {
      // Handle Error
      if(res["error"] != null) {
        throw new Exception(res["error_msg"]);
      }
      // Handle Success
      if (res['Data'].length > 0) {
        // Set LoginDetails
        setState(() {
          listItems = res['Data'];
        });
      }
      // Handle Failure
      if (res["Success"] == "false") {
      }
      // _handler.dismiss();
    });
  }

  // Body Widget
  Widget body(context, args) {
    return new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              args.pic,
              new Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(args.name, style: TextStyle(fontSize: 18.0,),),
              ),
              new Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(args.date, style: TextStyle(fontSize: 15.0,),),
              ),
            ],
          ),
        ),
      );
  }

}