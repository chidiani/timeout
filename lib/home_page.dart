import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:timeout3/group_list_model.dart';
import 'package:intl/intl.dart';

List<GroupListModel> _elements = [
  GroupListModel('A. Introduction and roles', 'A. All Team', false),
  GroupListModel('A. Pt Name and procedure', 'B. Surgeon', false),
  GroupListModel('B. Confirm Consent', 'B. Surgeon', false),
  GroupListModel('C. Correct site/side/level', 'B. Surgeon', false),
  GroupListModel('D. Concerns for critical events', 'B. Surgeon', false),
  GroupListModel('B. Antibiotics given', 'C. Anesthesia', false),
  GroupListModel('C. Antibiotics name/route/dose', 'C. Anesthesia', false),
  GroupListModel('D. Antibiotics redosing time', 'C. Anesthesia', false),
  GroupListModel('A. Allergies', 'C. Anesthesia', false),
  GroupListModel('E. Bleeding Risk', 'C. Anesthesia', false),
  GroupListModel('F. Anesthesia Post-op Plan', 'C. Anesthesia', false),
  GroupListModel('G. Anticipated Critical event/Concerns', 'C. Anesthesia', false),
  GroupListModel('A. Medications/Solutions on field labeled', 'D. Scrub Technician', false),
  GroupListModel('A. Equipments/Devices/Implants available', 'E. Circulating Nurse', false),
  GroupListModel('B. Fire Risk Score 1 - 3', 'E. Circulating Nurse', false),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    //await Future.delayed(const Duration(seconds: 1));
    //print('ready in 1...');
    //await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }
  String currdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime current_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(currdate);
    AlertDialog alert = AlertDialog(
      title: Text("Time Out Complete"),
      //content: Text(''),
      content: Text(current_date.hour.toString() + ":" + current_date.minute.toString()),

    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Out App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Procedure TimeOut'),
          backgroundColor: Colors.blue,
        ),
        body: GroupedListView(

          elements: _elements,

          groupBy: (element) => element.group,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) => item2.name.compareTo(item1.name),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {

            return Card(
              elevation: 8.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              color: element.isSelected ? Colors.blue : Colors.white,

              child: ListTile(
                onTap: () {
                  setState(() {
                    element.isSelected = !element.isSelected;
                    for (int i=0; i<_elements.length; i++) {
                      if (_elements[i].isSelected == false){
                        //done = 0;
                        break;
                      }
                      if (i == _elements.length-1){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
    }

                  });

                },
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                title: Text(element.name),
              ),
            );
          },
        ),
      ),
    );
  }
}
