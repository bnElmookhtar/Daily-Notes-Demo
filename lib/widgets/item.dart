import 'package:flutter/material.dart';
import 'package:todo/models/item_model.dart';

class Item extends StatelessWidget {
  final ToDoModel todo;
  final onDelete;
  final onChanged;
  const Item({Key? key, required this.todo, this.onDelete, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        onTap: (){
         onChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
        tileColor: Color(0xff134400),
        leading:  Container(
          margin: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: IconButton(
            onPressed: (){
             onDelete(todo.id);
            },
            icon: const Icon(Icons.delete,color: Color(0xffee6262),),
          ),
        ),
        title: Text(
         todo.txt!,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            decoration:todo.isDone! ? null:TextDecoration.none,
          ),
        ),
        trailing:Icon(
          todo.isDone! ?Icons.check_box:Icons.check_box_outline_blank,
          color: Colors.lightGreen,

        ),
      ),
    );
  }
}

