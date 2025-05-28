import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../data/models/productos_model.dart';

class CategoriaDetalleLogic {
  final String categoria;
  final String uid;

  CategoriaDetalleLogic({required this.categoria, required this.uid});

  // Verifica si la fecha es del mes y año actual (formato: dd/MM/yyyy HH:mm:ss)
  bool _esDelMesActual(String fechaEmision) {
    final hoy = DateTime.now();
    try {
      final fecha = DateFormat('dd/MM/yyyy HH:mm:ss').parse(fechaEmision);
      return fecha.year == hoy.year && fecha.month == hoy.month;
    } catch (e) {
      return false;
    }
  }

  /// Devuelve un stream de facturas (egresos) filtradas por usuario, categoría y mes actual
  Stream<List<CompraModel>> getFacturasFiltradas() {
    return FirebaseFirestore.instance
      .collection('egresos')
      .where('id_usuario', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CompraModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((compra) =>
              _esDelMesActual(compra.fechaEmision) &&
              compra.categoriaSuperior == categoria // Filtra por categoría superior
          )
          .toList());
  }

  /// Devuelve un stream con el total gastado SOLO en la categoría seleccionada y mes actual
  /// Suma el total de la factura si al menos un producto pertenece a la categoría
  Stream<double> getTotalGastado() {
     return FirebaseFirestore.instance
        .collection('egresos')
        .where('id_usuario', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompraModel.fromMap(doc.data() as Map<String, dynamic>))
            .where((compra) =>
                _esDelMesActual(compra.fechaEmision) &&
                compra.categoriaSuperior == categoria) // Filtra por categoría superior
            .fold<double>(0.0, (sum, compra) => sum + compra.total));
  }

  /// Devuelve un stream con el total gastado en TODAS las categorías y mes actual
  Stream<double> getTotalGastadoGeneral() {
    return FirebaseFirestore.instance
        .collection('egresos')
        .where('id_usuario', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompraModel.fromMap(doc.data() as Map<String, dynamic>))
            .where((compra) => _esDelMesActual(compra.fechaEmision))
            .fold<double>(0.0, (sum, compra) => sum + compra.total));
  }
}