<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<script src="util.js"></script>
		<script src="timer.js"></script>
		<script src="pager.js"></script>
		<title>Ingatlanhirdető | Részletek</title>
	</head>
	<body>
		<ul class="navigation" id="model" data-number-of-pictures="<?php echo $numberOfPictures?>" data-n="<?php echo $n?>" data-i="<?php echo $i?>">
			<li><a id="prev" <?php if ($i > 1                ): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i-1; ?>"<?php else: ?>class="faint"<?php endif; ?>>← Előző</a></li>
			<li><a id="next" <?php if ($i < $numberOfPictures): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i+1; ?>"<?php else: ?>class="faint"<?php endif; ?>>→ Következő</a></li>
			<li><a class="timer" data-interval="60" href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">↑🌐 Áttekintéshez vissza</a></li>
		</ul>
		<h1>Ingatlanhirdető | Részletek</h1>
		<img class="big" id="big" src="<?php echo "$n/{$pictures[$i0]['filename']}"; ?>"/>
		<ul class="icon-line">
<?php foreach ($pictures as $running => $picture): $class = $running == $i0 ? 'small-focused' : 'small'; ?>
			<li><img class="<?php echo $class; ?>" id="icon-<?php echo $n; ?>-<?php echo $running+1; ?>" src="<?php echo "$n/{$pictures[$running]['filename']}"; ?>"/></li>
<?php endforeach; ?>
		</ul>
	</body>
</html>
