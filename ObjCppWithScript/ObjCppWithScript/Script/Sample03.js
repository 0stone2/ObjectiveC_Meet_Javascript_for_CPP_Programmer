/*
Javascript (Sample03.js)
*/

szWelcomMessage = "Hello World";
szWhoamI = "Sample03.js";

function myfunc_1 () {
	szWhoamI = "myfunc_1";
}

function myfunc_2 () {
	szWhoamI= "myfunc_2";
	return "Success";
}

function myfunc_3 () {
	szWhoamI= "myfunc_3";
	return ["Success", false];
}

function myfunc_4 (szNewMyName) {
	szWhoamI= szNewMyName;
	return ["Success", true];
}

function myfunc_5 (szNewMyName, bReturnValue) {
	szWhoamI = szNewMyName;
	return ["Success", bReturnValue];
}