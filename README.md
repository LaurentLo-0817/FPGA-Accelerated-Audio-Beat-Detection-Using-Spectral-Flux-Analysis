# Beat the Drum! — FPGA Rhythm Game with Real-Time Beat Detection

## Overview

Beat the Drum! is an FPGA-based rhythm game inspired by *Taiko no Tatsujin*.
The system records arbitrary music input in real time, automatically generates drum beat patterns using hardware-accelerated onset detection, and allows users to play along interactively using physical drum sensors.

The project integrates real-time audio processing, FFT-based signal analysis, SRAM-backed dataflow, VGA graphics, and hardware scheduling into a complete FPGA gaming system.

---

## Key Features

* Real-time audio recording and playback
* Hardware-accelerated onset detection
* FFT-based rhythm extraction pipeline
* SRAM-backed streaming audio processing
* VGA rhythm game visualization
* Drum-hit detection using vibration sensors
* Fully hardware-controlled game scheduling FSM

---

## System Architecture

The system consists of several hardware modules connected through SRAM-based dataflow:

* **Recorder / Speaker Interface**

  * Captures and plays audio through I2C-connected audio peripherals

* **Onset Detection Engine**

  * Detects beat positions from audio energy changes in the frequency domain

* **FFT Accelerator**

  * Implements a hardware FFT pipeline using the Cooley–Tukey algorithm

* **Game Controller**

  * Controls game state transitions, VGA rendering, and score playback

* **SRAM Storage**

  * Stores recorded audio, FFT intermediate values, and generated beat maps

The complete pipeline enables real-time beat extraction and interactive rhythm gameplay directly on FPGA hardware.

---

## Onset Detection Pipeline

Beat generation is implemented using spectral-flux-based onset detection.

### Processing Flow

1. Audio is divided into small windows
2. FFT converts each window into the frequency domain
3. Spectral energy differences between adjacent windows are computed
4. Positive energy changes are accumulated as spectral flux
5. Moving-average thresholding identifies beat locations

This hardware pipeline enables rhythm extraction directly on FPGA without software DSP frameworks such as Librosa.

---

## FFT Hardware Design

The FFT module is implemented using a Cooley–Tukey butterfly architecture.

### Features

* Recursive DFT decomposition
* Butterfly computation stages
* Bit-reversal ordering logic
* SRAM-backed intermediate storage
* FSM-controlled FFT execution pipeline

Because FPGA resources were limited for large-point FFT computation, the design used:

* 8-point FFT computation
* 256 overlapping windows

to approximate long-range rhythm analysis efficiently on hardware.

---

## Hardware Scheduling

The top-level controller is implemented as a hardware FSM managing:

* Recording
* Audio loading
* FFT/onset processing
* Game-ready synchronization
* Real-time gameplay
* Replay/reset flow

The onset-detection pipeline itself also uses a multi-stage FSM including:

* LOAD
* FFT
* REV
* STORE
* DIFF
* AVG
* WRITE

to coordinate streaming audio analysis and SRAM updates.

---

## Hardware Optimization Challenges

### FPGA Resource Constraints

Large FFT register arrays quickly exhausted FPGA resources.
The architecture was redesigned to use:

* smaller FFT blocks
* overlapping windows
* SRAM-assisted buffering

to maintain functionality under hardware limits.

### Audio + Beat Co-Storage

To reduce SRAM usage, beat information was embedded into the least-significant bit (LSB) of 16-bit audio samples, allowing synchronized beat/audio storage without additional memory overhead.

---

## Technologies

* Verilog
* FPGA Design
* FFT / DSP
* SRAM-Based Dataflow
* VGA Controller
* I2C Audio Interface
* FSM Scheduling
* Real-Time Streaming Architecture

---

## Result

The final system successfully:

* recorded arbitrary music input
* generated rhythm maps in hardware
* displayed gameplay through VGA
* supported interactive drum-based rhythm gameplay fully on FPGA hardware
