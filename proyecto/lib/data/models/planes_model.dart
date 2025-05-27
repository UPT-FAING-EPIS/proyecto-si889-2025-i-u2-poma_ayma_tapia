import 'package:cloud_firestore/cloud_firestore.dart';
import 'productos_model.dart'; // Asegúrate de importar el modelo de egresos

class CategoriaModel {
  final String nombre;
  final double montoMaximo;

  CategoriaModel({
    required this.nombre,
    required this.montoMaximo,
  });

  factory CategoriaModel.fromMap(Map<String, dynamic> map) {
    return CategoriaModel(
      nombre: map['nombre'] ?? '',
      montoMaximo: (map['montoMaximo'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'montoMaximo': montoMaximo,
    };
  }
}

class PlanMonetarioModel {
  final String id;
  final String uid;
  final double montoTotal;
  final List<CategoriaModel> categorias;
  final List<CompraModel>? egresos; // <-- agregado aquí
  final String? fecha;
  final String? fechaLocal;

  PlanMonetarioModel({
    required this.id,
    required this.uid,
    required this.montoTotal,
    required this.categorias,
    this.egresos, // <-- agregado aquí
    this.fecha,
    this.fechaLocal,
  });

  factory PlanMonetarioModel.fromMap(Map<String, dynamic> map, String id) {
    return PlanMonetarioModel(
      id: id,
      uid: map['uid'] ?? '',
      montoTotal: (map['montoTotal'] as num?)?.toDouble() ?? 0.0,
      categorias: (map['categorias'] as List<dynamic>? ?? [])
          .map((cat) => CategoriaModel.fromMap(cat as Map<String, dynamic>))
          .toList(),
      egresos: (map['egresos'] as List<dynamic>?)
          ?.map((e) => CompraModel.fromMap(e as Map<String, dynamic>))
          .toList(), // <-- agregado aquí
      fecha: map['fecha']?.toString(),
      fechaLocal: map['fechaLocal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'montoTotal': montoTotal,
      'categorias': categorias.map((cat) => cat.toMap()).toList(),
      'egresos': egresos?.map((e) => e.toMap()).toList(), // <-- agregado aquí
      'fecha': fecha,
      'fechaLocal': fechaLocal,
    };
  }
}