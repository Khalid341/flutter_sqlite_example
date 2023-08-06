import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sql_helper.dart';

class EditRecord extends StatefulWidget{
  final String id;

  const EditRecord({super.key, required this.id});

  @override
  State<EditRecord> createState()=> _EditRecordState();




}

class _EditRecordState extends State<EditRecord> {

  final TextEditingController _titleContrller  = TextEditingController();
  final TextEditingController _descraptionContrller  = TextEditingController();




  Future<void> _updateItem() async {
    await SQLHelper.updateItem(int.parse(widget.id),_titleContrller.text, _descraptionContrller.text);


  }
  Future<void> _getItem() async {
    var data = await SQLHelper.getItem( int.parse(widget.id) );
    _titleContrller.text = data[0]["title"] as String ;
    _descraptionContrller.text = data[0]["description"] as String  ;
  }


  @override
  void initState(){
    super.initState();
    _getItem();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  const Text("Edit Book "),

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
                  hintText: "title",
                  border: OutlineInputBorder(),
                  labelText: "Title"

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
                _updateItem();
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

