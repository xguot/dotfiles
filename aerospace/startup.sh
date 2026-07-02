#!/bin/bash
# AeroSpace startup — workspace-to-monitor-force-assignment now uses
# semantic secondary/built-in patterns so AeroSpace handles routing
# natively. This script just ensures we land on workspace 1.
sleep 1
/opt/homebrew/bin/aerospace workspace 1 2>/dev/null || true
