domReady(pager);

function pager() {
	document.addEventListener('click', clickHandler);

	var big = document.getElementById('big');
	var prevNav = document.getElementById('prev'),
	    nextNav = document.getElementById('next'),
	    overNav = document.getElementById('over');


	function clickHandler(evt) {
		var clickedImg = evt.target;
		if (isUnfocusedIcon(clickedImg)) {
			evt.preventDefault();
			navigateBy(clickedImg);
		} else {
			var [isEnabledVertNav, direction, icon] = inspectEnabledVerticalNavigation(clickedImg);
			if (isEnabledVertNav) {
				evt.preventDefault();
				switch (direction) {
					case 'prev':
						navigateBy(icon);
						break;
					case 'next':
						navigateBy(icon);
						break;
				}
			}
		}
	}

	function navigateBy(icon) {
		updateBigBy(icon);
		fromFocus(icon);
		updateNavButtonsBy(icon);
	}

	function updateBigBy(icon) {
		var src = icon.getAttribute('src');
		big.setAttribute('src', src);
	}

	function updateNavButtonsBy(icon) {
		assignHref('overview', over, icon);
		var [prevIcon, nextIcon] = neighborhood(icon);
		if (prevIcon) {
			assignHref('details', prevIcon, prevNav);
			enableBy(prevNav, prevIcon);
		} else {
			disable(prevNav);
		}
		if (nextIcon) {
			assignHref('details', nextIcon, nextNav);
			enableBy(nextNav, nextIcon);
		} else {
			disable(nextNav);
		}
	}
}

function neighborhood(icon) {return [prevCousin(icon), nextCousin(icon)];}
function prevCousin(icon)         {return safeConjugate2('parentElement', 'firstElementChild', 'previousElementSibling', icon);}
function nextCousin(icon)         {return safeConjugate2('parentElement', 'firstElementChild', 'nextElementSibling'    , icon);}
function safeConjugate2(forward, backward, f, x) {return safeProp(safeProp(x[forward][forward][f], backward), backward);}
function safeProp(ob, prop) {return ob ? ob[prop] : null;}

function isUnfocusedIcon  (elt) {return elt.tagName == 'IMG' && elt.classList.contains('small') && !elt.classList.contains('small-focused');}
function inspectEnabledVerticalNavigation(navLink) {
	var direction = navLink.getAttribute('id');
	var isVertNav = ['prev', 'next'].includes(direction) && navLink.getAttribute('href');
	var focusIcon = document.getElementById('focus');
	var [prevIcon, nextIcon] = neighborhood(focusIcon);
	switch (direction) {
		case 'prev':  icon = prevIcon; break;
		case 'next':  icon = nextIcon; break;
		default:      icon = null;
	}
	return [isVertNav, direction, icon];
}

function fromFocus(dst) {
	var focus = document.getElementById('focus');
	moveFocus(focus, dst);
}

function moveFocus(src, dst) {
	src.removeAttribute('id');
	src.className = 'small';
	dst.setAttribute('id', 'focus');
	dst.className = 'small-focused';
	var dstLink = dst.parentElement;
	var srcLink = src.parentElement;
	dstLink.removeAttribute('href');
	assignHref('details', srcLink, src);
}

function assignHref(page, navLink, icon) {
	var iconLinkData = icon.parentElement.dataset;
	var n = iconLinkData.n,
	    i = iconLinkData.i;
	navLink.setAttribute('href', buildHref(page, n, i));
}
function buildHref(page, n, i) {return '?p='+page+'&n='+n+'&i='+i;}

function enableBy(navLink, icon) {
	assignHref('details', navLink, icon);
	navLink.removeAttribute('class');
}

function disable(navLink) {
	navLink.removeAttribute('href');
	navLink.className = 'faint';
}
