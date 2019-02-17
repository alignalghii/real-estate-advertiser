domReady(pager);

function pager()
{
	var modelData = document.getElementById('model').dataset;
	var [n, i] = [modelData.n, modelData.i];

	var [prevNav, nextNav] = [document.getElementById('prev'), document.getElementById('next')];
	if (isEnabled(prevNav)) prevNav.addEventListener('click', goPrev);
	if (isEnabled(nextNav)) nextNav.addEventListener('click', goNext);

	var focusIcon = document.getElementById('icon-'+n+'-'+i),
	    prevIcon, nextIcon;
	updatePrevIcon();
	updateNextIcon();

	var bigImg = document.getElementById('big');

	function updatePrevIcon() {prevIcon  = focusIcon.parentElement.previousElementSibling ? focusIcon.parentElement.previousElementSibling.firstElementChild : null;}
	function updateNextIcon() {nextIcon  = focusIcon.parentElement.nextElementSibling     ? focusIcon.parentElement.nextElementSibling.firstElementChild     : null;}

	function goPrev(evt) {
		evt.preventDefault();

		if (i > 1) {
			i--;
			updateBigImg();
			moveFocus(focusIcon, prevIcon);

			// Recast roles:
			[nextIcon, focusIcon]  = [focusIcon, prevIcon];
			updatePrevIcon();

			enable(nextNav, goNext);
			if (!prevIcon) disable(prevNav, goPrev);
			updateNavs();
		}
	}

	function goNext(evt) {
		evt.preventDefault();

		if (i < numberOfPictures) {
			i++;
			updateBigImg();
			moveFocus(focusIcon, nextIcon);

			// Recast roles:
			[prevIcon, focusIcon]  = [focusIcon, nextIcon];
			updateNextIcon();

			enable(prevNav, goPrev);
			if (!nextIcon) disable(nextNav, goNext);
			updateNavs();
		}
	}

	function isEnabled(navElement) {return navElement.hasAttribute('href');}

	function enable(navElement, handler) {
		navElement.setAttribute('href', buildHref(n, i));
		navElement.removeAttribute('class');
		navElement.addEventListener('click', handler)
	}

	function disable(navElement, handler) {
		navElement.removeAttribute('href');
		navElement.className = 'faint';
		navElement.removeEventListener('click', handler);
	}

	function updateNavs() {
		if (isEnabled(prevNav) && i > 1               ) prevNav.setAttribute('href', buildHref(n, i-1));
		if (isEnabled(nextNav) && i < numberOfPictures) nextNav.setAttribute('href', buildHref(n, i+1));
	}

	function updateBigImg() {bigImg.setAttribute('src', buildSrc(n, i));}
}

function buildHref(n, i) {return 'localhost:8000?p=details&n='+n+'&i='+i;}
function buildSrc (n, i) {
	var icon = document.getElementById('icon-'+n+'-'+i);
	return icon.getAttribute('src');
}

function moveFocus(src, dst) {
	if (dst) {
		src.className="small";
		dst.className="small-focused";
	}
}
