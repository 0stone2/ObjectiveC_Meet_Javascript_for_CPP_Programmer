/*
Javascript (Sample06.js)
*/

DbgString("Sample06.js\n");
nStart = 1;
nStop = 10;
[nSum, nAverage] = SumAndAverage(nStart, nStop);
DbgString("SumAndAverage(" + nStart.toString() + ", " + nStop.toString() + ") : 합 = " + nSum.toString() + ",  평균 = "  + nAverage.toString() + "\n");