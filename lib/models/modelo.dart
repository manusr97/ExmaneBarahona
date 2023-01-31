import 'dart:ffi';

class Model {
  int? id;
  late String categoria;
  late String tipo;
  late String concepto;
  late int cantidad;
  late String fecha;


  // Dog({
  //   this.id,
  //   required this.name,
  //   required this.age,
  // });
  static final Model _modelo = Model._internal();
  factory Model(){
    return _modelo;
  }
  Model._internal();

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoria': categoria,
      'tipo': tipo,
      'concepto': concepto,
      'cantidad': cantidad,
      'fecha' :fecha ,
    };
  }

  // Convert a Map to a Dog Object
  Model.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoria = map['categoria'];
    tipo = map['tipo'];
    concepto = map['concepto'];
    cantidad = map['cantidad'];
    fecha = map['fecha'];
  }
  void updModel(int _id,String _categoria,String _tipo,String _concepto,int _cantidad,String _fecha){
    id = _id;
    categoria = _categoria;
    tipo = _tipo;
    concepto = _concepto;
    cantidad = _cantidad;
    fecha = _fecha;
  }
  void setBTC(String _categoria,String _tipo,String _concepto,int _cantidad,String _fecha){
    tipo = _tipo;
    categoria = _categoria;
    tipo = _tipo;
    concepto = _concepto;
    cantidad = _cantidad;
    fecha = _fecha;
  }
}
