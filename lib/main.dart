import 'package:flutter/material.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/provider/transaksi_provider.dart';
import 'package:self_service_app/ui/dinein_ta_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BarangProvider>(
          create: (_) => BarangProvider(),
        ),
        ChangeNotifierProvider<TransaksiProvider>(
          create: (_) => TransaksiProvider(),
        ),
      ],
      builder: (context, ch) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: ch!),
      child: const MaterialApp(
          title: 'WAROENG STEAK',
          debugShowCheckedModeBanner: false,
          home: DineinTAScreen()),
    );
  }
}
