#!/bin/bash

DEST_IP="172.16.10.3"
SRC_IP="10.60.0.1"
DURATION=30
BANDWIDTHS=("100M" "500M" "1G")
PACKET_SIZES=("64" "128" "512" "1518")
REPEATS=3

for bw in "${BANDWIDTHS[@]}"; do
  for size in "${PACKET_SIZES[@]}"; do
    for run in $(seq 1 $REPEATS); do
      OUTFILE="iperf_${bw}_${size}B_run${run}.json"
      echo "Running: $bw, $size bytes, run $run -> $OUTFILE"
      iperf3 -c $DEST_IP -B $SRC_IP -b $bw -l $size -t $DURATION -J > "$OUTFILE"
      sleep 2
    done
  done
done



