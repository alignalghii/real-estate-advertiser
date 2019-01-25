<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<link rel="stylesheet" type="text/css" href="layout.css"/>
		<title>Ingatlanhirdető | Áttekintés</title>
	</head>
	<body>
		<div class="navigation">
			<ul>
				<li><?php if ($n > 1): ?><a href="?n=<?php echo $n-1; ?>">Előző</a><?php else: ?><span class="faint">Előző</span><?php endif; ?></li>
				<li><?php if ($n < $numberOfFlats): ?><a href="?n=<?php echo $n+1; ?>">Következő</a><?php else: ?><span class="faint">Következő</span><?php endif; ?></li>
				<li><a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i; ?>">Click for details!</a></li>
				<li><a href="?n=<?php echo $n<$numberOfFlats ? $n+1 : 1; ?>">15s</a></li>
			</ul>
		</div>
		<h1>Ingatlanhirdető | Áttekintés</h1>
		<div class="container">
			<div class="column-left">
				<h2>Adatok</h2>
				<ul>
					<li><?php echo $flats[$n-1]['address']; ?></li>
				</ul>
			</div>
			<div class="column-center">
				<h2>1. kép</h2>
				<img class="half" src="<?php echo Helper::loadVar("$n/%s", 'broken-image-symbol.png', $pictures[0]['filename']); ?>"/>
			</div>
			<div class="column-right">
				<h2>2. kép</h2>
				<img class="half" src="<?php echo Helper::loadVar("$n/%s", 'broken-image-symbol.png', $pictures[1]['filename']); ?>"/>
			</div>
		</div>
	</body>
</html>
