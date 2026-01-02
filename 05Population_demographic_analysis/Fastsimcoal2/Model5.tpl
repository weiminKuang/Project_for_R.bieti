//Parameters for the coalescence simulation program : fsimcoal2.exe
5 samples to simulate :
//Population effective sizes (number of genes)
NNR
NCNR
NCR
NSER
NSWR
//Samples sizes and samples age 
30
30
30
30
30
//Growth rates	: negative growth implies population expansion
0
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0 M01 0 0 0
M10 0 M12 0 0
0 M21 0 M23 0
0 0 M32 0 M34
0 0 0 M43 0 
//Migration matrix 1
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
4 historical event
TDIV0 0 1 1 1 0 1
TDIV0 1 2 1 1 0 1
TDIV0 2 3 1 1 0 1
TDIV0 3 4 1 1 0 1
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ  1   0   1.36e-8 OUTEXP
