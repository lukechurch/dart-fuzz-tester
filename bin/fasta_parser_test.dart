// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../lib/fuzz_driver.dart';
import '../lib/targets/fasta_parser_target.dart';

main(List<String> args) {
  FastaParserTarget target = new FastaParserTarget();

  fuzz(args, target);
}