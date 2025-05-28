import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/models/productos_model.dart';
import 'package:intl/intl.dart';

class AnalysisViewModel extends ChangeNotifier {
  List<CompraModel> compras = [];

  Future<void> fetchCompras(String userId) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('egresos')
            .where('id_usuario', isEqualTo: userId)
            .get();

    compras =
        snapshot.docs.map((doc) => CompraModel.fromMap(doc.data())).toList();
    notifyListeners();
  }

  // Gastos diarios
  Map<String, double> get gastosDiarios {
    final Map<String, double> data = {};
    for (var compra in compras) {
      final fecha = compra.fechaEmision.split(' ').first; // "dd/MM/yyyy"
      data[fecha] = (data[fecha] ?? 0) + compra.total;
    }
    // Ordenar por fecha ascendente
    final sortedKeys =
        data.keys.toList()
          ..sort((a, b) => _parseDate(a).compareTo(_parseDate(b)));
    return {for (var k in sortedKeys) k: data[k]!};
  }

  Map<String, double> getGastosDiarios(List<CompraModel> compras) {
    final Map<String, double> data = {};
    for (var compra in compras) {
      final fecha = compra.fechaEmision.split(' ').first; // "dd/MM/yyyy"
      data[fecha] = (data[fecha] ?? 0) + compra.total;
    }
    // Ordenar por fecha ascendente
    final sortedKeys =
        data.keys.toList()
          ..sort((a, b) => _parseDate(a).compareTo(_parseDate(b)));
    return {for (var k in sortedKeys) k: data[k]!};
  }

  // Gastos semanales
  Map<String, double> get gastosSemanales {
    final Map<String, double> data = {};
    for (var compra in compras) {
      final date = _parseDate(compra.fechaEmision.split(' ').first);
      final week = _weekOfYear(date);
      final year = date.year;
      final key = 'Sem $week/$year';
      data[key] = (data[key] ?? 0) + compra.total;
    }
    // Ordenar por año y semana
    final sortedKeys =
        data.keys.toList()..sort((a, b) {
          final aParts = a.replaceAll('Sem ', '').split('/');
          final bParts = b.replaceAll('Sem ', '').split('/');
          final aYear = int.parse(aParts[1]);
          final bYear = int.parse(bParts[1]);
          final aWeek = int.parse(aParts[0]);
          final bWeek = int.parse(bParts[0]);
          return aYear != bYear
              ? aYear.compareTo(bYear)
              : aWeek.compareTo(bWeek);
        });
    return {for (var k in sortedKeys) k: data[k]!};
  }

  Map<String, double> getGastosSemanales(List<CompraModel> compras) {
    final Map<String, double> data = {};
    for (var compra in compras) {
      final date = _parseDate(compra.fechaEmision.split(' ').first);
      final week = _weekOfYear(date);
      final year = date.year;
      final key = 'Sem $week/$year';
      data[key] = (data[key] ?? 0) + compra.total;
    }
    // Ordenar por año y semana
    final sortedKeys =
        data.keys.toList()..sort((a, b) {
          final aParts = a.replaceAll('Sem ', '').split('/');
          final bParts = b.replaceAll('Sem ', '').split('/');
          final aYear = int.parse(aParts[1]);
          final bYear = int.parse(bParts[1]);
          final aWeek = int.parse(aParts[0]);
          final bWeek = int.parse(bParts[0]);
          return aYear != bYear
              ? aYear.compareTo(bYear)
              : aWeek.compareTo(bWeek);
        });
    return {for (var k in sortedKeys) k: data[k]!};
  }

  // Gastos mensuales
  Map<String, double> get gastosMensuales {
    final Map<String, double> data = {};
    for (var compra in compras) {
      final date = _parseDate(compra.fechaEmision.split(' ').first);
      final key = DateFormat('MM/yyyy').format(date);
      data[key] = (data[key] ?? 0) + compra.total;
    }
    // Ordenar por año y mes
    final sortedKeys =
        data.keys.toList()..sort((a, b) {
          final aParts = a.split('/');
          final bParts = b.split('/');
          final aYear = int.parse(aParts[1]);
          final bYear = int.parse(bParts[1]);
          final aMonth = int.parse(aParts[0]);
          final bMonth = int.parse(bParts[0]);
          return aYear != bYear
              ? aYear.compareTo(bYear)
              : aMonth.compareTo(bMonth);
        });
    return {for (var k in sortedKeys) k: data[k]!};
  }

  Map<String, double> getGastosMensuales(List<CompraModel> compras) {
    final Map<String, double> data = {};
    for (var compra in compras) {
      final date = _parseDate(compra.fechaEmision.split(' ').first);
      final key = DateFormat('MM/yyyy').format(date);
      data[key] = (data[key] ?? 0) + compra.total;
    }
    // Ordenar por año y mes
    final sortedKeys =
        data.keys.toList()..sort((a, b) {
          final aParts = a.split('/');
          final bParts = b.split('/');
          final aYear = int.parse(aParts[1]);
          final bYear = int.parse(bParts[1]);
          final aMonth = int.parse(aParts[0]);
          final bMonth = int.parse(bParts[0]);
          return aYear != bYear
              ? aYear.compareTo(bYear)
              : aMonth.compareTo(bMonth);
        });
    return {for (var k in sortedKeys) k: data[k]!};
  }

  // Gastos por categoría
  Map<String, double> get gastosPorCategoria {
    final Map<String, double> data = {};
    for (var compra in compras) {
      for (var producto in compra.productos) {
        data[producto.categoria] =
            (data[producto.categoria] ?? 0) + producto.importe;
      }
    }
    return data;
  }

  Map<String, double> getGastosPorCategoria(List<CompraModel> compras) {
    final Map<String, double> data = {};
    for (var compra in compras) {
      for (var producto in compra.productos) {
        data[producto.categoria] =
            (data[producto.categoria] ?? 0) + producto.importe;
      }
    }
    return data;
  }

  // Gasto diario por días de la semana para una semana específica
  Map<String, double> getGastoPorDiaSemana(
    List<CompraModel> compras,
    DateTime semanaInicio,
  ) {
    final dias = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];
    final Map<String, double> data = {for (var d in dias) d: 0.0};

    for (var compra in compras) {
      final fecha = _parseDate(compra.fechaEmision.split(' ').first);
      if (fecha.isAfter(semanaInicio.subtract(const Duration(days: 1))) &&
          fecha.isBefore(semanaInicio.add(const Duration(days: 7)))) {
        final dia = dias[fecha.weekday - 1];
        data[dia] = (data[dia] ?? 0) + compra.total;
      }
    }
    return data;
  }

  /// Gasto semanal por semanas del mes para un mes específico (siempre 5 semanas)
  Map<String, double> getGastoPorSemanaMes(
    List<CompraModel> compras,
    int year,
    int month,
  ) {
    final Map<String, double> data = {
      'Semana 1': 0.0,
      'Semana 2': 0.0,
      'Semana 3': 0.0,
      'Semana 4': 0.0,
      'Semana 5': 0.0,
    };

    for (var compra in compras) {
      final fecha = _parseDate(compra.fechaEmision.split(' ').first);
      if (fecha.year == year && fecha.month == month) {
        // Semana del mes: 1-7 = 1, 8-14 = 2, 15-21 = 3, 22-28 = 4, 29-31 = 5
        final semana = ((fecha.day - 1) ~/ 7) + 1;
        data['Semana $semana'] = (data['Semana $semana'] ?? 0) + compra.total;
      }
    }
    return data;
  }

  /// Gasto mensual por meses de un año específico (siempre 12 meses)
  Map<String, double> getGastoPorMes(List<CompraModel> compras, int year) {
    final meses = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    final Map<String, double> data = {for (var m in meses) m: 0.0};

    for (var compra in compras) {
      final fecha = _parseDate(compra.fechaEmision.split(' ').first);
      if (fecha.year == year) {
        final mes = meses[fecha.month - 1];
        data[mes] = (data[mes] ?? 0) + compra.total;
      }
    }
    return data;
  }

  /// Gasto mensual por meses de un año específico con ventana (rangos de meses)
  Map<String, double> getGastoPorMesVentana(
    List<CompraModel> compras,
    int year,
    int mesCentral, // 1-12
    {int ventana = 5}
  ) {
    final meses = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    final mitad = ventana ~/ 2;
    final start = (mesCentral - 1 - mitad).clamp(0, 11);
    final end = (mesCentral - 1 + mitad).clamp(0, 11);

    final Map<String, double> data = {};
    for (int i = start; i <= end; i++) {
      data[meses[i]] = 0.0;
    }
    for (var compra in compras) {
      final fecha = _parseDate(compra.fechaEmision.split(' ').first);
      if (fecha.year == year &&
          fecha.month - 1 >= start &&
          fecha.month - 1 <= end) {
        final mes = meses[fecha.month - 1];
        data[mes] = (data[mes] ?? 0) + compra.total;
      }
    }
    return data;
  }

  // Gasto diario para un rango de fechas específico
  Map<String, double> getGastoPorRangoFechas(
    List<CompraModel> compras,
    DateTime fechaInicio,
    DateTime fechaFin,
  ) {
    final Map<String, double> data = {};
    
    // Crea todas las fechas del rango con valor 0
    for (DateTime fecha = fechaInicio; 
         fecha.isBefore(fechaFin.add(Duration(days: 1))); 
         fecha = fecha.add(Duration(days: 1))) {
      final key = DateFormat('dd/MM').format(fecha);
      data[key] = 0.0;
    }
    
    // Suma los gastos por cada día
    for (var compra in compras) {
      try {
        final fecha = _parseDate(compra.fechaEmision.split(' ').first);
        if (fecha.isAfter(fechaInicio.subtract(Duration(days: 1))) &&
            fecha.isBefore(fechaFin.add(Duration(days: 1)))) {
          final key = DateFormat('dd/MM').format(fecha);
          data[key] = (data[key] ?? 0) + compra.total;
        }
      } catch (e) {
        // Ignora fechas malformadas
      }
    }
    
    return data;
  }

  // Helpers
  DateTime _parseDate(String fecha) {
    // Asume formato "dd/MM/yyyy"
    final parts = fecha.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  int _weekOfYear(DateTime date) {
    // Calcula el número de semana del año
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - 1;
    final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));
    final diff = date.difference(firstMonday).inDays;
    return (diff / 7).ceil();
  }
}
