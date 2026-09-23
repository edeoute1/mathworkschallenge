# Vibration Detection and Rejection from IMU Data
> **MathWorks Excellence in Innovation – Project #231**  
> *A MATLAB & Simulink implementation for removing high-frequency disturbance and sensor drift from Inertial Measurement Unit (IMU) signals.*

---

## 📌 Project Overview

Inertial Measurement Units (IMUs) deployed on drones, autonomous vehicles, and industrial machinery are heavily impacted by mechanical vibrations. High-frequency motor and structural disturbances introduce severe noise into accelerometer and gyroscope channels, degrading state estimation and navigation stability.

This repository provides an end-to-end signal processing and noise rejection framework developed in **MATLAB** to isolate motion signals from high-frequency vibrations and low-frequency sensor drift.

---

## ✨ Key Features

* **3-Axis Signal Simulation:** Synthesizes realistic 6-DOF IMU data (accelerometer + gyroscope) with additive Gaussian noise and low-frequency gyro drift.
* **Zero-Phase Filtering:** Utilizes forward-backward zero-phase digital filtering (`filtfilt`) with Butterworth topologies to eliminate phase delay and group delay distortions.
* **Gyro Drift Rejection:** Combines low-pass noise attenuation with high-pass filtering to isolate baseline gyro bias.
* **Automated Data Metrics:** Computes dynamic time-series statistics across all 3 axes ($X, Y, Z$) simultaneously.

---

## 🛠 Tech Stack & Expertise Gained

* **Software:** MATLAB (R2021a or newer), Signal Processing Toolbox
* **Domains:** Autonomous Vehicles, Drones, Sensor Fusion, Signal Processing, State Estimation

---

## 📁 Repository Structure

```text
.
├── imu_analysis_demo.m   # Main MATLAB demonstration script
├── README.md             # Project documentation
└── LICENSE               # License file

---

## output

>> imu_analysis_demo
=== Raw Accelerometer Summary (X-axis) ===
Mean: -0.0042 | Std: 1.1321 | Min: -2.7041 | Max: 3.0378
