import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist= ToDo.todoList();
  List<ToDo> _foundToDo=[];
  final _todoController=TextEditingController();

  @override
  void initState() {
    _foundToDo=todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              children: [
               SearchBar(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child: Text('All ToDos',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                      ),
                      for(ToDo todo in _foundToDo.reversed)
                        ToDoItem(toDo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(margin: EdgeInsets.only(bottom: 20,left: 20,right: 20),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:const [BoxShadow(color: Colors.grey,offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 0)],
                  borderRadius: BorderRadius.circular(10)
                ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new ToDo item',
                      border: InputBorder.none
                    ),
                  ),
                )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: ()  {
                      _addToDoItem(_todoController.text);
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40,),
                      ),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addToDoItem(String toDo){
    setState(() {
      todoslist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runfilter(String enteredKeyword){
    List<ToDo> results=[];
    if(enteredKeyword.isEmpty){
      results= todoslist;
    }
    else{
      results= todoslist.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo=results;
    });
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  accountName: Text("ADG"),
                  accountEmail: Text("adg8503@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/ADGprofile.jpg"),
                  ),
                  decoration: BoxDecoration(color: Colors.grey),
                )
            ),
            ListTile(
              leading: Icon(CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "HOME",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white),
              ),

            ),
            ListTile(
              leading: Icon(CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "PROFILE",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white),
              ),

            ),
            ListTile(
              leading: Icon(CupertinoIcons.mail_solid,
                color: Colors.white,
              ),
              title: Text(
                "EMAIL",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white),
              ),

            ),
          ],
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo toDo){
    setState(() {
      toDo.isDone= !toDo.isDone;
    });

  }

  void _deleteToDoItem(String id){
    setState(() {
      todoslist.removeWhere((item) => item.id==id);
    });
  }

  Widget SearchBar(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value)=>_runfilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color:tdBlack,),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)
        ),

      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/ADGprofile.jpg'),
            ),
          )
        ],

      ),
    );
  }
}
