import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:todo/utils/utils.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(
        save(Item(
          title: newTaskCtrl.text,
          done: false,
        )),
      );
      newTaskCtrl.clear();
    });
    getItems();
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  save(Item item) async {
    var data = json.encode(item);
    http.Response response = await http.post(
        Uri.encodeFull("${Utils.baseURL}/item"),
        headers: {"Content-Type": "application/json"},
        body: data);
    print(response.body);
  }

  getItems() async {
    http.Response response = await http.get(
        Uri.encodeFull("${Utils.baseURL}/item"),
        headers: {"Accept": "application/json"});

    if (response != null) {
      List data = json.decode(response.body);
      List<Item> result = data.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });

      print(response.body);
    }
  }

  _HomePageState() {
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.text,
          controller: newTaskCtrl,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
              labelText: "New task",
              labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.items[index];
          return Dismissible(
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                    //add an update method - PUT
                  });
                },
              ),
              key: Key(item.title),
              background: Container(
                color: Colors.red,
                child: Icon(Icons.delete_sweep),
              ),
              onDismissed: (direction) {
                print(direction);
                remove(index);
              });
        },
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("ToDo List App"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("Reports"),
            onTap: () {
              //implementar business rules para report de tasks
              Navigator.pop(context);
            },
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
