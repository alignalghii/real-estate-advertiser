<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<link rel="stylesheet" type="text/css" href="layout.css"/>
		<script src="timer.js"></script>
		<title>Ingatlanhirdető | Áttekintés</title>
	</head>
	<body>
		<ul class="navigation">
			<li><a <?php if ($n > 1             ): ?>href="?n=<?php echo $n-1; ?>"<?php else: ?>class="faint"<?php endif; ?>>← Előző</a></li>
			<li><a <?php if ($n < $numberOfFlats): ?>href="?n=<?php echo $n+1; ?>"<?php else: ?>class="faint"<?php endif; ?>>→ Következő</a></li>
			<li><a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i; ?>">🔍 Részletes képgaléria</a></li>
			<li><a class="timer" data-interval="15" href="?n=<?php echo $n<$numberOfFlats ? $n+1 : 1; ?>">↻ Körbehalad</a></li>
		</ul>
		<h1>Ingatlanhirdető | Áttekintés</h1>
		<div class="container">
			<div class="column-left">
				<h2>Adatsor #<?php echo $n; ?></h2>
				<ul>
					<li>Cím: <?php echo $flats[$n-1]['address']; ?></li>
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
