import 'dart:ffi';

class Bitcoin {
  int? id;
  late String tipo;
  late int qtyBuy;
  late int qtySell;
  late int comision;
  late String fecha;
  late Float valor;


  // Dog({
  //   this.id,
  //   required this.name,
  //   required this.age,
  // });
  static final Bitcoin _modelo = Bitcoin._internal();
  factory Bitcoin(){
    return _modelo;
  }
  Bitcoin._internal();

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'qtyBuy': qtyBuy,
      'qtySell': qtySell,
      'comision': comision,
      'fecha' :fecha ,
    };
  }

  // Convert a Map to a Dog Object
  Bitcoin.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tipo = map['tipo'];
    qtyBuy = map['qtyBuy'];
    qtySell = map['qtySell'];
    comision = map['comision'];
    fecha = map['fecha'];
  }
  void updBTC(int _id,String _tipo,int _qtyBuy,int _qtySell,int _comision,String _fecha){
    id = _id;
    tipo = _tipo;
    qtyBuy = _qtyBuy;
    qtySell = _qtySell;
    comision = _comision;
    fecha = _fecha;
  }
  void setBTC(String _tipo,int _qtyBuy,int _qtySell,int _comision,String _fecha){
    tipo = _tipo;
    qtyBuy = _qtyBuy;
    qtySell = _qtySell;
    comision = _comision;
    fecha = _fecha;
  }
  // calcularPrecio(String _fecha,int _qtyBuy,int _qtySell){
  //
  //   for (_fecha in _portaInfoMap.keys){
  //
  //   }
  //   return _portaInfoMap;
  // }
}
