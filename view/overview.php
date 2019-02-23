<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<link rel="stylesheet" type="text/css" href="layout.css"/>
		<script src="util.js"></script>
		<script src="timer.js"></script>
		<title>Ingatlanhirdető | Áttekintés</title>
	</head>
	<body>
		<ul class="navigation">
			<li><a href="?p=admin">⚙ Kezelői felület</a></li>
			<li><a <?php if ($prev): ?>href="?n=<?php echo $prev; ?>"<?php else: ?>class="faint"<?php endif; ?>>← Előző</a></li>
			<li><a <?php if ($next): ?>href="?n=<?php echo $next; ?>"<?php else: ?>class="faint"<?php endif; ?>>→ Következő</a></li>
			<li><a <?php if ($i): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i; ?>"<?php else: ?>class="faint"<?php endif; ?>>🔍 Részletes képgaléria</a></li>
			<li><a class="timer" data-interval="15" href="?n=<?php echo $round; ?>">↻ Körbehalad</a></li>
		</ul>
		<h1>Ingatlanhirdető | Áttekintés</h1>
		<div class="container">
			<div class="column-left" id="flat-record" data-flat-record-index="<?php echo $n; ?>" data-number-of-flats="<?php echo $numberOfFlats; ?>">
				<h2>Adatsor #<?php echo $n; ?></h2>
				<ul>
					<li>Cím: <?php echo $address; ?></li>
				</ul>
			</div>
			<div class="column-center">
				<h2>1. kép</h2>
				<img class="half" src="<?php echo $picture1 ?: 'broken-image-symbol.png'; ?>"/>
			</div>
			<div class="column-right">
				<h2>2. kép</h2>
				<img class="half" src="<?php echo $picture2 ?: 'broken-image-symbol.png'; ?>"/>
			</div>
		</div>
	</body>
</html>
