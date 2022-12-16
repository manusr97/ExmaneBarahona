import 'package:dogs_db_pseb_bridge/db/database_helper.dart';
import 'package:dogs_db_pseb_bridge/models/dog.dart';
import 'package:dogs_db_pseb_bridge/screens/dogs_list_screen.dart';
import 'package:dogs_db_pseb_bridge/screens/graph.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
class AddBTC extends StatefulWidget {
  const AddBTC({Key? key}) : super(key: key);

  @override
  State<AddBTC> createState() => _AddBTCState();
}

class _AddBTCState extends State<AddBTC> {

  late String fecha;
  late String tipo;
  late int qtyBuy;
  late int qtySell;
  late int comision;


  var formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Tipo compra/venta'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Selecciona el tipo compra o venta';
                    }

                    tipo = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Cantidad comprada'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Rellena cantidad';
                    }

                    qtyBuy = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Cantidad vendida'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Rellena cantidad';
                    }

                    qtySell = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Comision'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Pon una comision';
                    }

                    comision = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextField(
                    controller: dateController, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                    ),
                    readOnly: true,  // when true user cannot edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2101),);
                      if(pickedDate != null ){

                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        setState(() {
                          dateController.text = formattedDate;
                        });
                        //You can format date as per your need

                        fecha = formattedDate;

                      }else{
                        print("Date is not selected");
                      }
                      //when click we have to show the datepicker

                    }
                ),


                ElevatedButton(onPressed: () async {

                  if( formKey.currentState!.validate()){
                    var dbHelper =  DatabaseHelper.instance;
                    // int result = await dbHelper.insertDog(dog);
                    dbHelper.setBTC(tipo,qtyBuy,qtySell,comision,fecha);
                    // if( result > 0 ){
                    //   Fluttertoast.showToast(msg: 'Dog Saved');
                    // }
                  }


                }, child: const Text('Save')),
                ElevatedButton(onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ListaBTC();
                  }));
                  Bitcoin().id = null;
                }, child: const Text('View All')),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Graph();
                  }));
                }, child: const Text('Ver grafico')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
