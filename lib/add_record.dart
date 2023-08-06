import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sql_helper.dart';

class AddRecord extends StatefulWidget{

  const AddRecord({super.key});

  @override
  State<AddRecord> createState()=> _AddRecordState();




}

class _AddRecordState extends State<AddRecord> {

  final TextEditingController _titleContrller  = TextEditingController();
  final TextEditingController _descraptionContrller  = TextEditingController();




   Future<void> _addItem() async {
    await SQLHelper.createItem(_titleContrller.text, _descraptionContrller.text);


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title:  const Text("Add Book "),

        ),
        body:
      Center(child:

        Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Container(

              margin: const EdgeInsets.all(20.0),
              child: TextField(

                controller: _titleContrller,
                decoration: const InputDecoration(
                  hintText: "title",
                  border: OutlineInputBorder(),
                  labelText: "Title"

                ),

              ),
            ),
            const SizedBox(height: 10,),
            Container(

              margin: const EdgeInsets.all(20.0),
              child: TextField(

                controller: _descraptionContrller,
                decoration: const InputDecoration(
                    hintText: "descraption",
                    border: OutlineInputBorder(),
                    labelText: "Descraption"

                ),

              ),
            ),
            const SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color
                ),


                onPressed: (){
                  _addItem();
                  _titleContrller.text = '';
                  _descraptionContrller.text = '';
                  Navigator.pop(context,'refresh');

                },

                child: const Text('Save'),
              ),
            )
          ],

        ),

        ),
    );
  }
}

