//Parameters for the coalescence simulation program : fsimcoal2.exe
5 samples to simulate :
//Population effective sizes (number of genes)
NNR
NCNR
NCR
NSER
NSWR
//Samples sizes and samples age 
48
36
108
12
36
//Growth rates	: negative growth implies population expansion
0
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
3
//Migration matrix 0
0 M10 0 0 0
M01 0 M21 0 0
0 M12 0 M32 0
0 0 M23 0 M43
0 0 0 M34 0
//Migration matrix 1
0 0 0 0 0
0 0 0 0 0
0 0 0 M32 0
0 0 M23 0 M43
0 0 0 M34 0
//Migration matrix 2
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
6 historical event
TDIV3 1 0 beta2 1 0 1
TDIV3 1 2 beta1 1 0 1
TDIV2 0 2 1 1 0 1
TDIV1 3 4 alpha1 1 0 2
TDIV1 3 2 alpha2 1 0 2
TDIV0 2 4 1 1 0 2
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ  1   0   1.36e-8 OUTEXP
