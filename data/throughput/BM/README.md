# Free5GC Benchmarking Raw Data

This repository contains the raw performance measurement logs used for evaluating the Free5GC User Plane Function (UPF) across three deployment models:
- **Bare Metal (BM)**
- **Virtual Machine (VM)**
- **Containerized (CO)**

The data was generated using `iperf3`, `ping`, and energy measurement tools to assess:
- Throughput
- Latency
- Jitter
- Power Consumption

## 📁 Folder Structure

```
.
├── throughput/
│   ├── BM/
│   ├── VM/
│   └── CO/
├── latency/
│   ├── BM/
│   ├── VM/
│   └── CO/
└── power/
    ├── BM/
    ├── VM/
    └── CO/
```
