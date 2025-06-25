#!/bin/bash

DEST_IP="172.16.10.3"
SRC_IP="10.60.0.1"
DURATION=120  # 2 minutes
BANDWIDTHS=("100M" "200M" "300M" "400M" "500M" "600M" "700M" "800M" "900M" "1000M")

for BW in "${BANDWIDTHS[@]}"; do
    echo "📡 Starting test with bandwidth $BW ..."

    iperf3 -c "$DEST_IP" -B "$SRC_IP" -b "$BW" -t "$DURATION"
    echo "✅ Finished $BW test. Sleeping 10 seconds before next..."
    sleep 1
done

echo "🚀 All iperf3 tests completed."
