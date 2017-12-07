# dart-fuzz-tester

A tool for testing Dart infrastructure


## To use

Checkout this package to ```~/GitRepos/dart-fuzz-tester```

Navigate to the root of an SDK checkout, run:

```
dart --packages=.packages ~/GitRepos/dart-fuzz-tester/bin/fasta_parser_test.dart PATH_TO_CORPUS PATH_TO_RESULTS
```
