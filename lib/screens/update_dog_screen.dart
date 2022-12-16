import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../db/controlador.dart';
import '../models/dog.dart';

class Actualizar extends StatefulWidget {
  final Bitcoin dog;

  const Actualizar({Key? key, required this.dog}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
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
        title: const Text('Update Dog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.dog.tipo,
                  decoration: const InputDecoration(hintText: 'Dog Name'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Dog Name';
                    }

                    tipo = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.dog.qtyBuy.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Dog Age'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Dog Age';
                    }

                    qtyBuy = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var id = widget.dog.id;
                        var dbHelper = DatabaseHelper.instance;
                        dbHelper.updBTC(id,tipo,qtyBuy,qtySell,comision,fecha);
                        // Dog().id = null;
                        // int result = await dbHelper.updateDog(dog);
                        //
                        // if (result > 0) {
                        //   Fluttertoast.showToast(msg: 'Dog Updated');
                        Navigator.pop(context, 'done');
                        //
                        // }
                      }
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
