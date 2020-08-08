import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'sidebar-navigation.dart';
import 'package:demo/src/common/progressbar.dart';
import 'package:demo/src/utils/common-service.dart';
import 'package:demo/src/utils/network-utils.dart';
import 'package:intl/intl.dart';

class ScreenArguments {
  final dynamic pic;
  final String name;
  final String date;

  ScreenArguments(this.pic, this.name, this.date);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Network Service
  NetworkUtil _netUtil = new NetworkUtil();
  // Common Service
  CommonService _commonService = new CommonService();
  //handler that we will use to show and hide widget
  ProgressBarHandler _handler;

  List<dynamic> listItems = [];

  @override
  Widget build(BuildContext context) {
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
                    body: body(context),
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

  // A Separate Function called from itemBuilder
  Widget buildBody(BuildContext context, int index) {
    String name = isNotEmpty(listItems[index]["Khabar_Title"]) ? listItems[index]["Khabar_Title"]: "";
    dynamic pic = isNotEmpty(listItems[index]["Pic"]) ? new Image.network(listItems[index]["Pic"], fit: BoxFit.fill,): new Image.asset('assets/images/avatar.png', fit: BoxFit.fill,);
    String date = isNotEmpty(listItems[index]["Khabar_Date"]) ? DateFormat("yyyy-MM-dd").format(DateTime.parse(listItems[index]["Khabar_Date"])): "";
    return new Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Container(
                  alignment: Alignment.topCenter,
                  child: pic,
                  width: 80.0,
                  height: 80.0,
                ),
                title: Text(name),
                subtitle: Text(date),
                onTap: () {
                  // Redirect to item details        
                  Navigator.pushNamed(context, '/item-details', arguments: ScreenArguments(pic, name, date));
                },
              ),
            ],
          ),
        ),
      );
  }

  // Body Widget
  Widget body(context) {
    return new Container(
      child: new ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (BuildContext context, int index) => buildBody(context, index)
      )
    );
  }

}