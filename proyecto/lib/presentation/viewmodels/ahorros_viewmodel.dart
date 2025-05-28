import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AhorrosViewModel extends ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;

  String? get userId => _user?.uid;

  double? _ahorro;
  double? get ahorro => _ahorro;

  /// Solo carga la suma de 'ahorro_total' de la colección planes, NO guarda nada en Firebase
  Future<void> cargarAhorroDesdePlanes() async {
    if (_user == null) return;
    final uid = _user!.uid;

    // Sumar todos los ahorro_total de la colección planes de este usuario
    final planesSnap = await FirebaseFirestore.instance
        .collection('planes')
        .where('uid', isEqualTo: uid)
        .get();

    double ahorroPlanes = 0.0;
    for (var doc in planesSnap.docs) {
      final data = doc.data();
      if (data['ahorro_total'] != null) {
        ahorroPlanes += (data['ahorro_total'] as num).toDouble();
      }
    }

    _ahorro = ahorroPlanes;
    notifyListeners();
  }
}