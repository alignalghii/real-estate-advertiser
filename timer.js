domReady(timer);

function timer()
{
	var timerLinks = document.getElementsByClassName('timer');
	for (let timerLink of timerLinks) {
		var intervalMS = 1000 * timerLink.dataset.interval;
		setInterval(click, intervalMS, timerLink);
	}
}


