#!/bin/bash

flutter pub global run dart_style:format -n --set-exit-if-changed . || exit -1;
