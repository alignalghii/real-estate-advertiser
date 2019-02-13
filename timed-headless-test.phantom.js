var webpage = require('webpage');
var thePage = webpage.create();

thePage.onLoadFinished = function(result) {console.log('[(RE)LOADED]');}

thePage.open('http://localhost:8000', ioWrap2(from12again, 1, 2));

function from12again(i, n) {
	if (i <= n) {
		var [flatRecordIndex, numberOfFlats] = thePage.evaluate(getFlatRecordIndex);
		var i_ = (i-1)%numberOfFlats+1;
		console.log(i_ + ' = ' + flatRecordIndex + "\t| " + (i_ == flatRecordIndex ? '[OK]' : '[WRONG]'));
		if (flatRecordIndex === i_) {
			setTimeout(from12again, 20000, i + 1, n);
		} else {
			msgExit(1, "Wrong");
		}
	} else {
		msgExit(0, "OK"); // trivially OK
	}
}

function getFlatRecordIndex() {
	var flatRecordData = document.getElementById('flat-record').dataset;
	return [flatRecordData.flatRecordIndex, flatRecordData.numberOfFlats].map(Number);
}



function ioWrap2(f, x1, x2) {return ioWrap(function () {f(x1, x2);});}

function ioWrap(f) {
	return function (status) {
		if (status == 'success') f();
		else                     msgExit(1, 'The page cannot be opened'); 
	}
}

function funExit(code, f) {
	f();
	phantom.exit(code);
}

function msgExit(code, msg) {
	console.log(msg);
	phantom.exit(code);
}

function finalAssert(stm, msgOK, msgFail) {
	msgExit((stm ? 0 : 1), (stm ? msgOK : msgFail));
}
