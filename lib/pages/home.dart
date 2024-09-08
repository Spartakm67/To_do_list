import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? _userToDo;
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll([
      'Call nine-one-one',
      'Launch project',
      'Keep-in-touch',
       'Call home',
    ]);
  }

  void _menuOpen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Menu'),),
            body: Row(
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => true);
                }, child: const Text('To the main page')),
                const Padding(padding: EdgeInsets.only(left: 15)),
                const Text('New menu')
              ],
            )
          );
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: const Text('To do list',
        style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.w700,
          fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _menuOpen,
              icon: const Icon(Icons.menu_outlined))
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                          todoList.removeAt(index);
                            });
                          },
                        icon: Icon(
                          Icons.delete_sweep,
                          color: Colors.cyan[200],
                        )),
                  ),
                ),
              onDismissed: (direction) {
                //  if(direction == DismissDirection.endToStart)
                setState(() {
                  todoList.removeAt(index);
                });
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add element'),
                content: TextField(
                  onChanged: (String? value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todoList.add(_userToDo);
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                  )
                ],
              );
            });
          },
          backgroundColor: Colors.greenAccent,
          shape: const CircleBorder(),
        child: const Icon(
            Icons.add_box,
            color: Colors.white,
        ),
      ),
    );
  }
}