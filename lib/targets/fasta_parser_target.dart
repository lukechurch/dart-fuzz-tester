// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/src/generated/parser.dart';
import 'package:analyzer/src/string_source.dart';
import 'package:front_end/src/fasta/scanner.dart';

import 'dart:math';

import '../string_utils.dart';
import '../mutations.dart';
import '../test_agents.dart';

class FastaParserTarget extends TestAgent {
  setup() {}

  Future test(String content,
      {Duration timeOut = const Duration(seconds: 120)}) {
    var scanner = new StringScanner(content, includeComments: true);
    scanner.scanGenericMethodComments = true;
    var tokens = scanner.tokenize();

    var source = new StringSource(content, 'parser_test_StringSource.dart');
    _ErrorListener listener = new _ErrorListener();
    var parser = new Parser(source, listener, useFasta: true);
    parser.parseGenericMethodComments = true;
    parser.allowNativeClause = true;
    CompilationUnit unit = parser.parseCompilationUnit(tokens);

    return null;
  }

  Future retestFailedPath(String source, String path, int mutationCount, String outPath,
      {Duration timeOut = const Duration(seconds: 120)}) {
    try {
      test(source);
    } catch (e, st) {

      // Group by error message
      String errCodeProc = e.toString().split('\n').first;
      errCodeProc = stripText(errCodeProc);

      String errCode = errCodeProc.hashCode.toString();
      if (!new Directory(outPath + "/$errCode").existsSync()) {
        new Directory(outPath + "/$errCode").createSync();
      }

      var name = path.split("/").last.split(".").first.split('-').first;
      String logPath = outPath + "/$errCode/$name-$mutationCount.log";

      print("Exporting to logPath: $logPath");
      new File(logPath).writeAsStringSync("""
Crash in fasta
@peter-ahe-google
id: $name
```
$source
```

```
$e
$st
```
""");

      // crashes++;
      // print("$i, $crashes");
      return null;
    }

    print("REPRO FAILURE");
    exit(1);

    return null;
  }
}

class _ErrorListener implements AnalysisErrorListener {
  final errors = <AnalysisError>[];

  @override
  void onError(AnalysisError error) {
    errors.add(error);
  }

  void throwIfErrors() {
    if (errors.isNotEmpty) {
      throw new Exception(errors);
    }
  }
}

