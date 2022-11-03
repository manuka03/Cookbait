import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'utils/vegetables.dart';
import 'utils/fruits.dart';
import 'back_end/ingredients.dart';
import 'package:firebase_core/firebase_core.dart';





class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CookBait", textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        elevation: 1.1,
      ),
      drawer: const Drawer(),
      body: FutureBuilder(
        future: FirestoreDB().getData(),
        builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              !snapshot.hasData) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<MultiSelectItem<dynamic>> list = snapshot.data!.cast<
              MultiSelectItem>();
          final _items3 = ingredients
              .map((ingredient) =>
              MultiSelectItem<String>(ingredient, ingredient))
              .toList();
          List<dynamic> selectedItems=[];
          return Column(
            children: [
              MultiSelectBottomSheetField(
                  title: Text("Choose Your Ingredients"),
                  // backgroundColor: Colors.red,
                  searchable: true,
                  items: _items3,
                  closeSearchIcon: Icon(Icons.close),
                  initialValue: [],
                  onConfirm: (items4) {

                  }),
          // SizedBox(
          //   height : 5.0
          // ),
          // ListView.builder(
          // itemCount: selectedItems.length,
          // itemBuilder: (BuildContext context,int index){
          // return Text(selectedItems[index]);
          // }
          //
          // )
            ],
          );
        }),
    );
  }
}
