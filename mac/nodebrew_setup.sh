#!/bin/bash


# need path setting
nodebrew install-binary stable
nodebrew list
nodebrew use stable
node -v
npm -v
