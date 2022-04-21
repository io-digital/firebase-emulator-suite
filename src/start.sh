#!/bin/bash

function log_errors {

  node -v
  npm -v
  echo
  ls -la
  echo
  env
  echo

  for log in *.log; do
    echo logging $log
    cat $log
  done
}

trap log_errors EXIT

cd functions
npm install || true
cd ..

npx firebase \
  --project $FIREBASE_PROJECT \
  --token $FIREBASE_TOKEN \
  emulators:start
