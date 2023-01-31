import 'package:dogs_db_pseb_bridge/db/controlador.dart';
import 'package:dogs_db_pseb_bridge/screens/update_dog_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../db/controlador.dart';
import '../models/modelo.dart';

class Lista extends StatefulWidget {
  const Lista({Key? key}) : super(key: key);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ordenes'),
      ),
      body: FutureBuilder<List<Model>>(
        future: DatabaseHelper.instance.getAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Model>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No se han encontrado ordenes'));
            } else {
              List<Model> btc = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: btc.length,
                    itemBuilder: (context, index) {
                      Model x = btc[index];
                      return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          x.tipo,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Categoria: ${x.categoria}'),
                                        Text('Cantidad: ${x.cantidad} €'),
                                        Text('Concepto: ${x.concepto}'),
                                        Text('Fecha: ${x.fecha}'),

                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            var result =
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) {
                                              return Actualizar(model: x);
                                            }));

                                            if (result == 'done') {
                                              setState(() {});
                                            }
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Confirmation!'),
                                                    content: const Text(
                                                        'Are you sure to delete ?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('No')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            // delete dog

                                                            int result =
                                                                await DatabaseHelper
                                                                    .instance
                                                                    .delete(
                                                                        x.id!);

                                                            if (result > 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          'Dog Deleted');
                                                              setState(() {});
                                                              // build function will be called
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Yes')),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  )
                                ],
                              )));
                    }),
              );
            }
          }
        },
      ),
    );
  }
}
