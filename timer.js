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
		function jump() {timerLink.click();}
		setInterval(jump, intervalMS)
	}
}
