#!/bin/bash

# https://prog.world/boringssl-failed-to-log-metrics/
# __boringssl_log_open_block_invoke libboringssl.dylib thread return
# ____nwlog_connection_log_block_invoke libnetwork.dylib thread return

xcrun simctl spawn booted log config --subsystem com.apple.network --category boringssl --mode level:off
xcrun simctl spawn booted log config --subsystem com.apple.CoreBluetooth --mode level:off
xcrun simctl spawn booted log config --subsystem com.apple.CoreTelephony --mode level:off