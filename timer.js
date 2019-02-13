domReady(main);

function domReady(callback)
{
	document.addEventListener('DOMContentLoaded', callback);
	if (document.readyState === 'interactive' || document.readyState === 'complete') {
		callback();
	}
}

function main()
{
	var timerLinks = document.getElementsByClassName('timer');
	for (let timerLink of timerLinks) {
		var intervalMS = 1000 * timerLink.dataset.interval;
		setInterval(click, intervalMS, timerLink);
	}
}

function click(element) { // Portability to PhantomJS?
	element.click();
	//var clickE = new MouseEvent('click', {bubbles: true, cancelable: true, view: window});
	//element.dispatchEvent(clickE);
}
