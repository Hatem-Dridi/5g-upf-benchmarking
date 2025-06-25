# 5G UPF Benchmarking

This repository contains scripts and tools to benchmark the performance of the 5G User Plane Function (UPF) across different deployment environments — including bare metal, VMs, and containers.

## 📁 Structure

- `scripts/` – Shell scripts for traffic generation (iperf3), power logging, and test automation.
- `analysis/` – Python scripts to process test results and generate charts (e.g. boxplots for power vs throughput).
- `data/` – Collected log files and raw output (e.g., iperf3).
- `plots/` – Generated plots used for reporting.

## 🧪 Example Usage

Run a power benchmarking test:
```bash
sudo ./run_power_test.sh
