import 'package:flutter/material.dart';


class SidebarNavigation extends StatefulWidget {
  final String currentRoute;

  SidebarNavigation(this.currentRoute);

  @override
  _SidebarNavigationState createState() => new _SidebarNavigationState(this.currentRoute);
}


class _SidebarNavigationState extends State<SidebarNavigation> {
  String currentRoute;

  _SidebarNavigationState(currentRoute);

  void _handleItemSelection() {
    setState(() {
      // var RO = new RouteObserver();
      // RO.subscribe(this, ModalRoute.of(context));
      // debugPrint('RA ${ModalRoute.of(context).settings.name}');
      // debugPrint('RO ${widget.currentRoute}');
      Navigator.of(context).pop();
    });
  }

  Color _selectMenuTextColor(String menu) {
    if (menu == widget.currentRoute) {
      return Colors.white;
    } else {
      return Colors.lightBlueAccent;
    }
  }

  Color _selectMenuBgColor(String menu) {
    if (menu == widget.currentRoute) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.white;
    }
  }

 Widget build(BuildContext context) {
  //  debugPrint('RO ${widget.currentRoute}');
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.lightBlueAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            width: double.maxFinite,
            height: 50.0,
            decoration: const BoxDecoration(
                  color: Colors.white,
                  border: const Border(
                    top: const BorderSide(width: 1.0, color: Colors.black54),
                    bottom: const BorderSide(width: 1.0, color: Colors.black54)
                  )
            ),
          ),
          new Container(
            child: new MaterialButton(
              minWidth: double.maxFinite,
              height: 50.0,
              child: new Text('HOME', style: new TextStyle(color: _selectMenuTextColor('/home'), fontSize: 20.0, fontWeight: FontWeight.bold)),
              color: _selectMenuBgColor('/home'),
              onPressed: () {
                if (widget.currentRoute != '/home') {
                  this._handleItemSelection();
                  Navigator.pushNamed(context, '/home');
                }
              }
            ),
            decoration: const BoxDecoration(
                  border: const Border(
                    // top: const BorderSide(width: 1.0, color: Colors.black54),
                    bottom: const BorderSide(width: 1.0, color: Colors.black54)
                  )
            ),
          ),
        ],
      ));
  }
}