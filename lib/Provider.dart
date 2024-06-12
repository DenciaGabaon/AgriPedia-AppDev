import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CropManager.dart';

final cropDataManagerProvider = ChangeNotifierProvider<CropDataManager>(
  create: (_) => CropDataManager(),
);
