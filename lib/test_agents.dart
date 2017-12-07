// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

abstract class TestAgent {
  Future setup();
  Future test(String source, {Duration timeOut = const Duration(seconds:120)});
  Future retestFailedPath(String source, String path, int mutationCount, outPath, {Duration timeOut = const Duration(seconds:120)});
}
