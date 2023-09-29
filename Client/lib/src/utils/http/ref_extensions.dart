import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension RefExtensions on AutoDisposeFutureProviderRef {
  void cacheFor({Duration? duration = const Duration(seconds: 30)}) {
    final link = keepAlive();

    Timer? timer;
    onCancel(() => timer = Timer(const Duration(seconds: 30), () => link.close()));
    onResume(() => timer?.cancel());
  }
}
