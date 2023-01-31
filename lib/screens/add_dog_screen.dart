import 'dart:ffi';

import 'package:dogs_db_pseb_bridge/models/modelo.dart';
import 'package:dogs_db_pseb_bridge/screens/dogs_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../db/controlador.dart';
class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}
class _AddState extends State<Add> {

  late String fecha;
  late String tipo;
  late int cantidad;
  late String concepto;
  late String categoria;


  var formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
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
                      hintText: 'Categoria'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Selecciona el tipo compra o venta';
                    }

                    categoria = value;
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

                    cantidad = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Cantidad vendida'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Rellena cantidad';
                    }

                    concepto = value;
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Tipo'
                  ),
                  validator: (String? value){
                    if( value == null || value.isEmpty){
                      return 'Pon una comision';
                    }

                    tipo = value;
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
                    dbHelper.setModel(categoria,tipo,concepto,cantidad,fecha);
                    // if( result > 0 ){
                    //   Fluttertoast.showToast(msg: 'Dog Saved');
                    // }
                  }


                }, child: const Text('Save')),
                ElevatedButton(onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const Lista();
                  }));
                  Model().id = null;
                }, child: const Text('View All')),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
