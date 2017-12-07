// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

const _INJECTIONS = const [
  "{",
  "}",
  "[",
  "]",
  "<",
  ">",
  "?",
  "?.",
  "|",
  "\"",
  "/",
  "-",
  "=",
  "+",
  "'",
  ",",
  "!",
  "@",
  "#",
  "\$",
  "%",
  "^",
  "&",
  " ",
  "(",
  ")",
  "null ",
  "class ",
  "for ",
  "void ",
  "var ",
  "dynamic ",
  ";",
  "as ",
  "is ",
  ".",
  "import "
];

String mutate(String src, Random random) {
  if (src.length == 0) return src;

  String inject = _INJECTIONS[random.nextInt(_INJECTIONS.length)];
  int i = random.nextInt(src.length);
  if (i == 0) i = 1;

  String newStr = src.substring(0, i - 1) + inject + src.substring(i);
  return newStr;
}
