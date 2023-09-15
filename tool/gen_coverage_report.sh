#!/bin/bash

CURRENT=`pwd`
DIR_NAME=`basename "$CURRENT"`
if [ $DIR_NAME == 'tool' ]
then
  cd ..
fi

dart run tool/test_coverage_helper.dart || exit -1;
flutter test --coverage || exit -1;
genhtml coverage/lcov.info -o coverage/html || exit -1;
open coverage/html/index.html || exit -1;
rm test/coverage_helper_test.dart