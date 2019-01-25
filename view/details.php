<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<title>Részletek</title>
	</head>
	<body>
		<div class="navigation">
			<ul>
				<li><?php if ($i > 1): ?><a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i-1; ?>">Előző</a><?php else: ?><span class="faint">Előző</span><?php endif; ?></li>
				<li><?php if ($i < $numberOfPictures): ?><a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i+1; ?>">Következő</a><?php else: ?><span class="faint">Következő</span><?php endif; ?></li>
				<li><a href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">Áttekintéshez vissza</a></li>
				<li><a href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">60s</a></li>
			</ul>
		</div>
		<h1>Ingatlanhirdető | Részletek</h1>
		<img class="big" src="<?php echo "$n/{$pictures[$i0]['filename']}"; ?>"/>
		<ul>
<?php foreach ($pictures as $running => $picture): $class = $running == $i0 ? 'small-focused' : 'small'; ?>
			<li><img class="<?php echo $class; ?>" src="<?php echo "$n/{$pictures[$running]['filename']}"; ?>"/></li>
<?php endforeach; ?>
		</ul>
	</body>
</html>
