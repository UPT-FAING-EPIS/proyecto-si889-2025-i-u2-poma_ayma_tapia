class UserModel {
  final String uid;
  final String nombreCompleto;
  final String email;
  final String telefono;
  final String? photoUrl;
  final double? limiteGastoDiario; // <-- NUEVO
  final double? ahorro; // <-- NUEVO

  UserModel({
    required this.uid,
    required this.nombreCompleto,
    required this.email,
    required this.telefono,
    this.photoUrl,
    this.limiteGastoDiario, // <-- NUEVO
    this.ahorro, // <-- NUEVO
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      nombreCompleto: map['nombreCompleto'] ?? '',
      email: map['email'] ?? '',
      telefono: map['telefono'] ?? '',
      photoUrl: map['photoUrl'],
      limiteGastoDiario:
          map['limiteGastoDiario'] != null
              ? (map['limiteGastoDiario'] as num).toDouble()
              : null, // <-- NUEVO
      ahorro:
          map['ahorro'] != null ? (map['ahorro'] as num).toDouble() : null, // <-- NUEVO
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nombreCompleto': nombreCompleto,
      'email': email,
      'telefono': telefono,
      'photoUrl': photoUrl,
      if (limiteGastoDiario != null)
        'limiteGastoDiario': limiteGastoDiario, // <-- NUEVO
      if (ahorro != null) 'ahorro': ahorro, // <-- NUEVO
    };
  }
}
