#!/bin/bash
flutter test --coverage || exit -1;
echo 'GEN HTML'
genhtml coverage/lcov.info -o coverage/html || exit -1;
open coverage/html/index.html || exit -1;
