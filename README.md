IBERT: FPGA-Based Transformer Accelerator

This project presents an FPGA-based hardware accelerator for Transformer inference, implemented in SystemVerilog. The design targets key computational kernels in Transformer models, including Attention, Layer Normalization, and GELU, and emphasizes architectural scalability and modularity.

At the core of the accelerator is a parameterized systolic array architecture for matrix multiplication, enabling efficient mapping of Transformer GEMM operations with configurable degrees of parallelism. The accelerator adopts a streaming dataflow model using AXI-Stream interfaces, allowing clean composition of compute modules and efficient end-to-end inference execution.

To balance numerical accuracy and hardware efficiency, the design integrates re-quantization modules that manage precision transitions between stages. The complete system has been deployed on a Xilinx PYNQ platform, where functional correctness, inference latency, and numerical consistency were validated against a software reference.

This project provides a flexible foundation for exploring architectural trade-offs in FPGA-based Transformer acceleration, including parallelism scaling, memory bandwidth optimization, and precision–performance trade-offs.
