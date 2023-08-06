import 'package:flutter/material.dart';
import 'package:sqlite_t/add_record.dart';
import 'package:sqlite_t/sql_helper.dart';

import 'edit_record.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(



        useMaterial3: true,

        appBarTheme: AppBarTheme(backgroundColor: Colors.red),

      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      color: Colors.red,
    );


  }

}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool _isLoading=false;
  List<Map<String, dynamic>> _journals = [];
  void _refreshJournals()async {

    final data = await SQLHelper.getItems();
    setState(() {
      _journals =data ;
      _isLoading=false;
    });
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted'),
    ));
    _refreshJournals();
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Book Store "),
        backgroundColor: Colors.red,

      ),
      body: _isLoading? Center(

        child: CircularProgressIndicator(),
      ): ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) => Card(
            color: Colors.red,
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(_journals[index]['title']),
              subtitle: Text(_journals[index]['description']),
              trailing: SizedBox(

                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed:  () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>EditRecord(id:_journals[index]['id'].toString()))
                          );
                        },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: ()=>_deleteItem(_journals[index]['id']),
                        icon: const Icon(Icons.delete_forever)
                    ),
                  ],
                ),
              ),

            ),


            ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,

        child: const Icon(Icons.add),
        onPressed: () async{
          String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddRecord(),));
          if(refresh== 'refresh'){
            _refreshJournals();
          }
        },
      ),


    );
  }
}

