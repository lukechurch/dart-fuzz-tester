// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

String stripText(String str) {
  List<int> strippedCodeUnits = [];
  for (var ch in str.codeUnits) {
    if (ch > "A".codeUnitAt(0) && ch < "Z".codeUnitAt(0) ||
        ch > "a".codeUnitAt(0) && ch < "z".codeUnitAt(0)) {
      strippedCodeUnits.add(ch);
    }
  }
  return new String.fromCharCodes(strippedCodeUnits);
}
