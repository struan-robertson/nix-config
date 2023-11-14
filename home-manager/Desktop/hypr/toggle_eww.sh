#!/usr/bin/env bash

if [[ "$(eww windows)" == *"*sidebar"* ]]; then
    eww close sidebar
else
    eww open sidebar
fi
