#!/bin/bash

npx firebase \
  --project $FIREBASE_PROJECT \
  --token $FIREBASE_TOKEN \
  emulators:start
