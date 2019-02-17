function domReady(callback)
{
	document.addEventListener('DOMContentLoaded', callback);
	if (document.readyState === 'interactive' || document.readyState === 'complete') {
		callback();
	}
}

function click(element) { // Portability to PhantomJS?
	element.click();
	//var clickE = new MouseEvent('click', {bubbles: true, cancelable: true, view: window});
	//element.dispatchEvent(clickE);
}
