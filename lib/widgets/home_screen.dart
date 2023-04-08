import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/models/item_model.dart';
import 'package:todo/styles/colors.dart';
import 'item.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final itemBackgroundColor =dodgerBlue;
  final todoList = ToDoModel.todoList();
  final newItemController = TextEditingController();
  final searchingController = TextEditingController();
  List<ToDoModel> findTodo = [];
  String txtHint ="  اضافة تذكير جديد" ;
  @override
  void initState() {
    findTodo = todoList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: dodgerBlue));
    return Scaffold(
        backgroundColor: navyBlue,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              child: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0)
                    )
                ),
                elevation: 8,
                backgroundColor: itemBackgroundColor,
                centerTitle: true,
                title: Text(
                  'مذكراتي',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        const Center(
                          child: Text(
                            'المذكرات التي تم تسجيلها ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: white,
                            ),
                          ),
                        ),
                        for (ToDoModel todoo in findTodo)
                          Item(
                            todo: todoo,
                            onChanged: checkIfItDone,
                            onDelete: deleteItem,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                    child: ElevatedButton(
                      onPressed: (){
                        addingItem(newItemController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: itemBackgroundColor,
                      ),
                      child: const Text('+',style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(end: 15.0,top: 10.0,bottom: 10.0),
                        decoration: BoxDecoration(
                          color: itemBackgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextField(
                          controller: newItemController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:txtHint,
                            hintStyle: TextStyle(
                              color: white,
                            ),
                            hintTextDirection: TextDirection.rtl,
                            contentPadding: const EdgeInsets.all(10.0),
                          ),
                        ),
                      )
                  ),

                ],
              ),
            )
          ],
        ));
  }
  checkIfItDone(ToDoModel item)
  {
    setState(() {
      item.isDone = !item.isDone !;
    });
  }
  deleteItem(String itemId)
  {
    setState(() {
      todoList.removeWhere((item)=>item.id==itemId);
    });
  }
  addingItem(String text)
  {
    setState(() {
      if( text.isEmpty) {
        txtHint='من فضلك ادخل تذكير جديد';
      }
      else
      {
        todoList.add(ToDoModel(id: DateTime.now().millisecondsSinceEpoch.toString(), txt: text));
        txtHint ="  اضافة تذكير جديد" ;
      }
      newItemController.clear();
    });

  }
  searchForItem(String inputSearchTxt)
  {
    List<ToDoModel> res = [];
    if(inputSearchTxt.isEmpty) {
      res = todoList;
    }
    else
    {
      res = todoList.where((item)=>item.txt!.toLowerCase().contains(inputSearchTxt.toLowerCase()) ).toList();
    }
    setState(() {
      findTodo = res;
    });
  }
  Widget searchBox() => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: itemBackgroundColor,
      ),
      child: TextField(
        decoration: const InputDecoration(
          contentPadding:  EdgeInsetsDirectional.all(0.0),
          prefixIcon: Icon(
            Icons.search,
          ),
          prefixIconConstraints:
          BoxConstraints(maxHeight: 20.0, maxWidth: 15.0),
          hintText: 'بحث',
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: white,
          )
        ),
        textDirection: TextDirection.rtl,
        onChanged: (value)=>searchForItem(value),
      ),
    ),
  );
}