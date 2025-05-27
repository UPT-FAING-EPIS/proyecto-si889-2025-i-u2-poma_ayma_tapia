import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../viewmodels/ia_scaner_viewmodel.dart';
import '../../viewmodels/editar_json_recibido_viewmodel.dart';
import '../../../core/utils/formato_json.dart';
import '../complementos/editar_json_view.dart';

class IaScanerScreen extends StatelessWidget {
  final String apiKey;

  const IaScanerScreen({super.key, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IaScanerViewModel>(
      create: (context) => IaScanerViewModel(apiKey: apiKey),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escanear Factura'),
          backgroundColor: Colors.teal[700],
          elevation: 0,
        ),
        body: const IaScanerBody(),
      ),
    );
  }
}

class IaScanerBody extends StatefulWidget {
  const IaScanerBody({super.key});

  @override
  State<IaScanerBody> createState() => _IaScanerBodyState();
}

class _IaScanerBodyState extends State<IaScanerBody> {
  bool _hasNavigated = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.watch<IaScanerViewModel>();

    if (!_hasNavigated && viewModel.messages.isNotEmpty) {
      final mensaje = viewModel.messages.last;
      final jsonMap = FileUtils.parseResponseToMap(mensaje);
      if (jsonMap != null) {
        _hasNavigated = true;
        Future.microtask(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) {
                  final vm = EditarJsonRecibidoViewModel();
                  vm.cargarDesdeJson(jsonMap);
                  return vm;
                },
                child: const EditarJsonView(),
              ),
            ),
          ).then((_) {
            setState(() {
              _hasNavigated = false;
            });
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<IaScanerViewModel>();

    return SafeArea(
      child: Container(
        color: Colors.teal[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              // Botones de galería y cámara
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Galería'),
                      onPressed: () async {
                        await viewModel.pickAndAnalyzeImageFromGallery(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal[700],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadowColor: Colors.teal.withOpacity(0.2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Cámara'),
                      onPressed: () async {
                        await viewModel.captureAndAnalyzeImageFromCamera(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal[700],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadowColor: Colors.teal.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sección para analizar factura por texto (sin el texto "Escanear Factura" aquí)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.text_snippet, color: Colors.teal, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            'Analizar Factura por Texto',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _textController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Pega aquí el texto de la factura...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.teal[50],
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.send),
                          label: const Text('Analizar Texto'),
                          onPressed: viewModel.isLoading
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();
                                  if (_textController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Por favor ingresa un texto para analizar.')),
                                    );
                                    return;
                                  }
                                  await viewModel.processTextInvoice(
                                    _textController.text,
                                    context,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Mostrar la imagen escaneada
              if (viewModel.currentImage != null)
                Expanded(
                  child: Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.memory(
                          viewModel.currentImage!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),

              // Mostrar mensaje de error
              if (viewModel.lastError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          viewModel.lastError!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Mostrar símbolo de cargando si está procesando
              if (viewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}