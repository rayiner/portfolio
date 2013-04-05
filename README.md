# Programming Portfolio

This is my programming portfolio. These are mostly small programs written to study specific topics. 
These copies are meant to be read, not compiled or executed and may have some bit-rot. They did all work at one point. 
My active projects are available at: http://github.com/rayiner. 
Verrazano is now maintained by Attila Lendvai and is available at: http://common-lisp.net/project/fetter.
All code herein was written by myself, except where otherwise noted. 

## Controller Clearance Broadcast System (air_traffic)

This is a prototype and mockup of the air traffic control system described in the paper: 
Feigh & Bruneau, "Incorporating Controller Intent into a Runway Incursion Prevention System." 
The paper is based on a project submission to the 2007 FAA Airport Design Competition, Runway Safety category.

The prototype is a Java program that simulates the proposed user interface of the air traffic control system. 
It features:
- A GUI written using Swing
- Loading and rendering of airport runway maps (ATL and PDK) stored in vector format
- Use of Dijkstra's algorithm for finding the shortest path to a destination along taxiways
- Simulated communications between the tower and aircraft using the proposed protocol

## AMD64 assembler (amd64_assembler)

This is an assembler that generates AMD64 binary machine code. It is written in Common Lisp. It features:
- Use of macros to generate encoding functions at compile-time from declarative instruction specifications
- Use of macros to generate randomized testing functions from the same specifications that drive the encoder
- A testing framework that checks that the output is bit-for-bit identical with that of YASM
- A "jump relaxation" algorithm to minimize the size of compiled jumps
- Simplistic output to linkable Mach-O object files

## Gas turbine simulation (gas_turbine)

This is a simple simulation of a gas turbine (jet engine) written in Matlab. 
It uses a thermodynamic model to evaluate the performance impact of varying certain design parameters. 

## Google Summer of Code 2005 project (google_soc_05)

This was my project for the Google Summer of Code 2005. 
It is a tool that autoamtically generates foreign function interface (FFI) declarations from C++ headers.
The program is written in Common Lisp. It features:
- Parsing of an XML representation of C++ programs
- Various transformations to generate more Lisp-like bindings, accounting for C++'s elaborate semantics
- Generation of C-FFI declarations compatible with the GCC C++ ABI

Portions of this code were written by Attila Lendvai, who took over maintainership of the project in 2007. 

## Prototype KDE/Qt implementation of synchronized window resizing (kwin_netwm_sync.diff)

I prototyped a KDE/Qt implementation of the METACITY_UPDATE_COUNTER protocol, which had been included in Metacity/GTK+.
I participated in the ensuing discussion, which led to the standardization of the _NET_WM_SYNC_REQUEST protocol.

The prototype involved:
- Modifications to Qt to cause it to signal when it finishes drawing a frame
- Modifications to Kwin to avoid resizing and redrawing a window frame until Qt is finished drawing
- Use of the X11 SYNC extension to block the window manager while waiting for the client to redraw

## Lisp interpreter (lisp_interpreter)

A very simple Lisp interpreter along with an Emacs mode for its syntax.

## Mostly-copying garbage collector (mostly_copying)

An implementation of Joel F. Bartlett's mostly-copying garbage collection algorithm, 
which mixes conservative root scavenging with precise object copying. 
As a modification, I experimented with optimistically allowing the mutator to fill up more than the half of the heap
allowed in a traditional semi-space algorithm, and using a fallback compactor when this resulted in the collector
running out of space before all live objects had been copied. The included technical report is Bartlett's original report.

## Open Dylan (opendylan)

Open Dylan as an implementation of the Dylan language implemented as a commercial project and open-sourced in 2004. 
I fixed-up the C backend, which had been unused for some time, ported it to Mac OS X (i386 and PowerPC), 
and fixed certain bugs. The directory contains several of my patches to the project. 
The changes in the patches are mine, but the system as a whole was not written by me.

## Rotor blade design (rotor)

This is a simple Matlab program that applies a finite-element model to the task of optimizing the figure of merit 
of a helicopter rotor. 

## SSA transformation (ssa_analysis)

This program takes a simple source language as input (an assembly-level language with virtual registers), 
and performs various transformations on it as would be done in an optimizing compiler. It features:
- Construction of a control flow graph from the source-level representation
- A worklist-based iterative data-flow solver
- Dominance analysis using the algorithm of Cooper, Harvey, and Kennedy
- Liveness analysis based on the data-flow solver
- Construction of pruned SSA form using the method outlined in Cooper & Torczon's "Engineering a Compiler" 
- Copy propagation in SSA form
- Elimination of SSA form minimizing inserted copies using Sreedhar's algorithm, along with Tarjan's union-find data structure.
- Computation of the interference graph and register allocation using Chaitin's graph coloring algorithm
