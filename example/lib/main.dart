import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:aeyrium_sensor_plugin/aeyrium_sensor_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _data = "";

  StreamSubscription<dynamic>? _streamSubscriptions;

  @override
  void initState() {
    _streamSubscriptions = AeyriumSensor.sensorEvents?.listen((event) {
      // (180 * roll / Math.PI)  (180 * pitch / Math.PI)
      setState(() {
        _data =
            " Z-Rot: ${180 * event.roll ~/ math.pi} \n X-Rot: ${180 * event.pitch ~/ math.pi}";
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_streamSubscriptions != null) {
      _streamSubscriptions?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(_data),
          ),
        ),
      ),
    );
  }
}
