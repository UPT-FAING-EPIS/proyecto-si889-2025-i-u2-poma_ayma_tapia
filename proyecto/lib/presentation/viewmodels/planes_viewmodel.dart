import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:VanguardMoney/data/models/planes_model.dart';
import 'package:intl/intl.dart';
import 'package:VanguardMoney/data/models/productos_model.dart';

const List<String> categoriasPermitidas = [
  'Alimentos',
  'Hogar',
  'Ropa',
  'Salud',
  'Tecnología',
  'Entretenimiento',
  'Transporte',
  'Mascotas',
  'Otros',
];

class PlanesViewModel extends ChangeNotifier {
  double _montoTotal = 0.0;
  final List<CategoriaModel> _categorias = [];

  // Agrega la lista de egresos aquí
  List<CompraModel> egresos = [];

  double get montoTotal => _montoTotal;
  List<CategoriaModel> get categorias => List.unmodifiable(_categorias);

  void setMontoTotal(double monto) {
    _montoTotal = monto;
    notifyListeners();
  }

  void agregarCategoria(String nombre, double montoMaximo) {
    if (categoriasPermitidas.contains(nombre)) {
      final index = _categorias.indexWhere((c) => c.nombre == nombre);
      if (index >= 0) {
        _categorias[index] = CategoriaModel(nombre: nombre, montoMaximo: montoMaximo);
      } else {
        _categorias.add(CategoriaModel(nombre: nombre, montoMaximo: montoMaximo));
      }
      notifyListeners();
    }
  }

  void eliminarCategoria(int index) {
    _categorias.removeAt(index);
    notifyListeners();
  }

  double get montoCategorias {
    return _categorias.fold(0.0, (suma, cat) => suma + cat.montoMaximo);
  }

  bool validarMontos() {
    return montoCategorias <= _montoTotal;
  }

  /// Guarda o actualiza el plan del usuario
  Future<void> guardarPlanEnFirebase(String uid) async {
    final planData = PlanMonetarioModel(
      id: '', // El id lo asigna Firestore
      uid: uid,
      montoTotal: _montoTotal,
      categorias: _categorias,
      fecha: DateTime.now().toIso8601String(),
      fechaLocal: DateTime.now().toIso8601String(),
      egresos: egresos, // <-- Agregado aquí
    ).toMap();

    // Buscar si ya existe un plan para este usuario
    final snapshot = await FirebaseFirestore.instance
        .collection('planes')
        .where('uid', isEqualTo: uid)
        .orderBy('fecha', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Actualiza el documento existente
      await FirebaseFirestore.instance
          .collection('planes')
          .doc(snapshot.docs.first.id)
          .update(planData);
    } else {
      // Crea uno nuevo
      await FirebaseFirestore.instance.collection('planes').add(planData);
    }
  }

  /// Carga el último plan guardado del usuario
  Future<void> cargarPlanDesdeFirebase(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('planes')
        .where('uid', isEqualTo: uid)
        .orderBy('fecha', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final plan = PlanMonetarioModel.fromMap(doc.data(), doc.id);
      _montoTotal = plan.montoTotal;
      _categorias
        ..clear()
        ..addAll(plan.categorias);
      egresos = plan.egresos ?? []; // <-- Agregado aquí
      notifyListeners();
    }
  }

  /// Suma el total de las facturas (no los productos individuales) de una categoría específica en el mismo mes y año.
  /// Suma el total de la factura si al menos un producto pertenece a la categoría.
  double sumarTotalesFacturasPorCategoriaYMes(
    List<CompraModel> compras,
    String categoria,
    DateTime mesReferencia,
  ) {
    double suma = 0.0;
    final catNormalizada = categoria.trim().toLowerCase();

    for (final compra in compras) {
      // Verifica si la fecha es del mes y año de referencia (soporta dd/MM/yyyy HH:mm:ss e ISO)
      DateTime? fecha;
      try {
        fecha = DateFormat('dd/MM/yyyy HH:mm:ss').parse(compra.fechaEmision);
      } catch (_) {
        fecha = DateTime.tryParse(compra.fechaEmision);
      }
      if (fecha == null) continue;

      if (fecha.year == mesReferencia.year && fecha.month == mesReferencia.month) {
        // Suma el total de la factura si al menos un producto pertenece a la categoría
        final contieneCategoria = compra.productos.any(
          (producto) => producto.categoria.trim().toLowerCase() == catNormalizada,
        );
        if (contieneCategoria) {
          suma += compra.total;
        }
      }
    }
    return suma;
  }
}