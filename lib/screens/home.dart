import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/models/house.dart';
import 'package:tracker/screens/add_animal.dart';
import 'package:tracker/screens/add_task.dart';
import 'package:tracker/screens/household_invite.dart';
import 'package:tracker/screens/new_todo.dart';
import 'package:tracker/screens/notifications.dart';
import 'package:tracker/services/database.dart';
import 'package:tracker/widgets/custom_button.dart';
import '../services/auth.dart';
import '../constants/tokens/colors.dart';
import '../models/todo.dart';
import '../screens/task_page.dart';
import '../screens/animal_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pagecontroller = PageController();
  final AuthBase _auth = Auth();

  double currentPage = 0;

  //List<Todos> extends TodosState()
  List<Todos> todos = [];
  String _timeString;
  String _dayString;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _toggleTodo(Todos todos, bool isChecked) {
    setState(() {
      todos.isComplete = isChecked;
    });
  }

  _addTodo() async {
    final todo = await showDialog<Todos>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _pagecontroller.addListener(() {
      setState(() {
        currentPage = _pagecontroller.page;
      });
    });
    return StreamProvider<List<House>>.value(
        value: DatabaseService().house,
        child: Scaffold(
          appBar: AppBar(title: Text('Today\'s Tasks')),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Settings'),
                  decoration: BoxDecoration(
                    color: colorCustomOrange,
                  ),
                ),
                ListTile(
                  title: Text('ACCOUNT'),
                  onTap: () {},
                ),
                ListTile(
                    title: Text('HOUSEHOLD'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HouseholdView()));
                    }),
                ListTile(
                  title: Text('NOTIFICATIONS'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NotificationsView()));
                  },
                ),
                ListTile(
                  title: Text('FAQ'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('RESOURCES'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('ARCHIVED'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('SIGN OUT'),
                  onTap: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
          body: _mainContent(),

          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: colorCustomOrange,
              foregroundColor: Colors.white,
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          child: currentPage == 0
                              ? AddTaskPage()
                              : AddAnimalsPage(),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))));
                    });
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //bottomNavigationBar: BottomNavigationDemo(),
        ));
  }

  Widget _mainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(),
        ),
        Expanded(
            child: PageView(
          controller: _pagecontroller,
          children: <Widget>[TodosPage(), AnimalListPage()],
        ))
      ],
    );
  }

  Widget _button() {
    return Row(
      children: <Widget>[
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pagecontroller.previousPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          buttonText: "Tasks",
          color: currentPage < 0.5 ? colorCustomOrange : colorCustomGrey,
          textColor: currentPage < 0.5 ? Colors.white : colorCustomOrange,
          borderColor:
              currentPage < 0.5 ? Colors.transparent : colorCustomOrange,
        )),
        SizedBox(
          width: 32,
        ),
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pagecontroller.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          buttonText: "My Animals",
          color: currentPage > 0.5 ? colorCustomOrange : colorCustomGrey,
          textColor: currentPage > 0.5 ? Colors.white : colorCustomOrange,
          borderColor:
              currentPage > 0.5 ? Colors.transparent : colorCustomOrange,
        ))
      ],
    );
  }
}
