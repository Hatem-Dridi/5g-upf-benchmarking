#!/bin/bash

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root using: sudo ./run_latency_tests_1G.sh"
  exit
fi

# Interface and destination IP
INTERFACE="uesimtun0"
SOURCE_IP="10.60.0.1"
DEST_IP="172.16.10.3"
COUNT=5000
INTERVAL=0.01  # 10ms

# Array of payload sizes
declare -A PACKET_SIZES
PACKET_SIZES=(
  ["64"]=56
  ["128"]=100
  ["512"]=476
  ["1518"]=1482
)

# Start iperf3 background load at 1 Gbps
echo "🚀 Starting iperf3 1G UDP traffic in background..."
iperf3 -c $DEST_IP -b 1G -t 700 -P 4 --bind $SOURCE_IP > /dev/null 2>&1 &
IPERF_PID=$!

# Wait a few seconds to let iperf3 load start properly
sleep 3

echo "📡 Running ping latency tests with network under 1G load..."

for SIZE in "${!PACKET_SIZES[@]}"; do
  PAYLOAD=${PACKET_SIZES[$SIZE]}
  LOG_FILE="ping_${SIZE}_1G.log"

  echo "---------------------------------------------" | tee -a "$LOG_FILE"
  echo "$(date) - Testing size ${SIZE}B (payload: $PAYLOAD)" | tee -a "$LOG_FILE"
  echo "Saving to $LOG_FILE"

  sudo ping -I $INTERFACE -s $PAYLOAD -c $COUNT -i $INTERVAL $DEST_IP >> "$LOG_FILE"

  echo "$(date) - Finished ${SIZE}B" | tee -a "$LOG_FILE"
  echo "" | tee -a "$LOG_FILE"
done

# Stop iperf3 (just in case)
kill $IPERF_PID 2>/dev/null

echo "✅ All tests completed under 1 Gbps load."
