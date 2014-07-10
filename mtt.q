
trade:([] time:`timespan$(); sym:`$(); market:`$(); price:`float$(); size:`float$(); side:`$());

genTrade:{[n]
	(n?.z.n;n?`2;n?`1;n?1.5;n?15000000.0;n?`b`s)
	}

`trade insert genTrade 10000000;
trade:update `g#sym from `time xasc trade;

genInstrument:{
	update `g#sym from 0!update ric:`$upper string sym from select last market by sym from trade
	}

instrument:genInstrument[];

/ get 100 sample rics
rics:100?instrument`ric;
/ get 10000 sample trades and pretend they are something to aj...
ajsmall:10000?select time, sym, id:i from trade;

tf:{[m;i;f] b:.z.p; do[i;r:f[]]; 0N! `$string[`long$0.000001*`long$.z.p-b]," ",m; r};

0N!"testing...",string[system"s"]," slaves";

tf["vwap";50;{select size wavg price by sym from trade where sym in exec sym from instrument where ric in rics, sym=(last;sym) fby ric}];
sr:tf["aj";500;{aj[`sym`time;ajsmall;trade]}];
fcr:tf[".Q.fc aj";500;{.Q.fc[aj[`sym`time;;trade];ajsmall]}];
if[not sr~fcr;'cheat];

\\
