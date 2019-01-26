<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<title>Részletek</title>
	</head>
	<body>
		<ul class="navigation">
			<li><a <?php if ($i > 1                ): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i-1; ?>"<?php else: ?>class="faint"<?php endif; ?>>← Előző</a></li>
			<li><a <?php if ($i < $numberOfPictures): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i+1; ?>"<?php else: ?>class="faint"<?php endif; ?>>→ Következő</a></li>
			<li><a href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">↑🌐 Áttekintéshez vissza</a></li>
			<li><a href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">60s</a></li>
		</ul>
		<h1>Ingatlanhirdető | Részletek</h1>
		<img class="big" src="<?php echo "$n/{$pictures[$i0]['filename']}"; ?>"/>
		<ul class="icon-line">
<?php foreach ($pictures as $running => $picture): $class = $running == $i0 ? 'small-focused' : 'small'; ?>
			<li><img class="<?php echo $class; ?>" src="<?php echo "$n/{$pictures[$running]['filename']}"; ?>"/></li>
<?php endforeach; ?>
		</ul>
	</body>
</html>
