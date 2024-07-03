// lib/connectivity_service.dart
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  ConnectivityService._privateConstructor();

  static final ConnectivityService _instance = ConnectivityService._privateConstructor();

  static ConnectivityService get instance => _instance;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void initialize() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _showConnectivitySnackBar(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
    });

    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      _showConnectivitySnackBar(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
    });
  }

  void _showConnectivitySnackBar(bool isConnected) {
    String message = isConnected ? 'Connected to the Internet' : 'No Internet Connection';
    Color bgColor = isConnected ? Colors.green : Colors.red;

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
