// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../lib/test_agents.dart';
import 'dart:io';
import 'dart:math';
import 'mutations.dart';

// Configuration
const TIME_OUT = const Duration(seconds: 120);
const MUTATE_MAX = 1;

Random random = new Random(0);

int i = 0;
int crashes = 0;
int count = 0;
String outPath;


testDirectory(String path, TestAgent testAgent) async {
  print("Path: $path");
  print("Results: $outPath");

  testAgent.setup();
  var fses = new Directory(path).listSync(recursive: true, followLinks: false);
  count = fses.length;

  print("${new DateTime.now()}, $count Test files enumerated");

  for (var fse in fses) {
    if (fse is File) {

      if (!fse.path.endsWith(".dart")) continue;
      String src = fse.readAsStringSync();

      for (int j = 0; j < MUTATE_MAX; j++) {
        Stopwatch sw = new Stopwatch()..start();

        bool pass = true;

        int time = -1;

        try {
          await testAgent.test(src);
          time = sw.elapsedMilliseconds;
        } catch (e, st) {
          time = sw.elapsedMilliseconds;
          pass = false;
          testAgent.setup();
          testAgent.retestFailedPath(src, fse.path, j, outPath);
        }

        print(
            "${new DateTime.now()}, ${((100*i)/(count*MUTATE_MAX)).toStringAsFixed(2)}%, $i, $crashes, $pass, $time, ${fse.path}, $j");

        if (!pass) break;

        src = mutate(src, random);
      }
    }
  }
}

fuzz(List<String> args, TestAgent testAgent) {
  String path = args[0];

  switch (args.length) {
    case 1:
      // Test a single path
      String src = new File(path).readAsStringSync();
      testAgent.setup();

      testAgent.test(src);
      break;

    case 2:
      outPath = args[1];

      testDirectory(path, testAgent);
      break;

    default:
      print("""Wrong arg count, use either:
fuzz_driver test_file
fuzz_driver fest_folder out_folder""");
  }
}
