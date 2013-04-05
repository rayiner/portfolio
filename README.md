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
It has:
- A GUI written using Swing
- Loading and rendering of airport runway maps (ATL and PDK) stored in vector format
- Use of Dijkstra's algorithm for finding the shortest path to a destination along taxiways
- Simulated communications between the tower and aircraft using the proposed protocol

## AMD64 assembler (amd64_assembler)

This is an assembler for AMD64 machine code that translates from an s-expression representation to assembled binary code. It is written in Common Lisp. It features:
- Novel use of macros to generate encoding functions from declarative instruction specifications
- Use of the instruction specifications to generate randomized testing functions for each type of instruction
- Support for integer and SSE operations in 64-bit mode
- A "jump relaxation" algorithm to minimize the size of compiled jumps
- Simplistic output to Mach-O object files

## Gas turbine simulation (gas_turbine)

This is a simple simulation of a gas turbine (jet engine) written in Matlab. It uses a thermodynamic model to study the impact of various design parameters. 

## Google Summer of Code 2005 project (google_soc_05)

This was my submission for the Google Summer of Code 2005. In order to be selected for the program, I wrote a project proposal describing a tool to generate bindings between C++ and Common Lisp programs. I then implemented this proposal. The program is written in Common Lisp. It features:
- Parsing of a GCC-XML representation of C++ programs
- Various transformations to make bindings more Lisp-like
- Generation of C-FFI declarations to implement the binding

The program is written in Common Lisp. Portions of this code were written by Attila Lendvai, who took over maintainership of the project in 2007. 

## Prototype KDE/Qt implementation of NET_WM_SYNC_REQUEST (kwin_netwm_sync.diff)

I restarted the discussion of implementing a protocol to achieve synchronized window resizing between X11 window managers and client applications by prototyping a KDE/Qt implementation of a protocol proposed a couple of years as METACITY_UPDATE_COUNTER. The discussion lead to the standardization of the NET_WM_SYNC_REQUEST specification, which has been implemented in both KDE/Qt and GTK+. The prototype involved:
- Modifications to Qt to signal when it finishes drawing a frame
- Modifications to Kwin to avoid resizing and redrawing a window frame until Qt can completely redraw the window contents
- The protocol uses the X11 SYNC extension to block the window manager until the client application indicates it is finished drawing a frame

## Lisp interpreter (lisp_interpreter)

A very simple Lisp interpreter along with an Emacs mode for it.

## Mostly-copying garbage collector (mostly_copying)

An implementation of Joel F. Bartlett's "mostly copying" garbage collection algorithm, which mixes conservative root scavenging with precise object copying. The included technical report is Bartlett's original report. As a modification, I experimented with using a copy reserve smaller than the 100% necessary for a traditional semi-space algorithm, and using a fallback compactor for situations where the copying process runs out of room during a collection. 

## Open Dylan (opendylan)

Open Dylan as an implementation of the Dylan language implemented as a commercial project and open-sourced in 2004. A fixed up the C backend, which had been unused for some time, ported it to Mac OS X (i386 and PowerPC), and fixed certain bugs. The directory contains several of my patches to the project. The patches are mine, but the system as a whole was not written by me.

## Rotor blade design (rotor)

This is a simple Matlab program that applies a finite-element model to the task of optimizing the figure of merit of a rotor. 

## SSA analysis (ssa_analysis)

This program takes a simple source language as input (an assembly-level language with virtual registers), and performs various transformations on it as would be done in an optimizing compiler. It features:
- Construction of a control flow graph from a source-level representation
- A generic iterative data-flow solver
- Dominance and dominance frontier analysis using the algorithm of Cooper, Harvey, and Kennedy
- Liveness analysis based on the data-flow solver
- Construction of pruned SSA form using the method outlined in Cooper & Torczon's "Engineering a Compiler" 
- Copy propagation in SSA form
- Correct elimination of SSA form minimizing inserted copies using Sreedhar's algorithm, along with Tarjan's union-find data structure.
- Computation of the interference graph and register allocation using Chaitin's graph coloring algorithm
