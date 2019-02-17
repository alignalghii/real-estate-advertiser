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
		<ul class="navigation" id="model" data-n="<?php echo $n?>" data-i="<?php echo $i?>">
			<li><a id="prev" <?php if ($prev): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $prev; ?>"<?php else: ?>class="faint"<?php endif; ?>>← Előző</a></li>
			<li><a id="next" <?php if ($next): ?>href="?p=details&n=<?php echo $n; ?>&i=<?php echo $next; ?>"<?php else: ?>class="faint"<?php endif; ?>>→ Következő</a></li>
			<li><a class="timer" data-interval="60" href="?p=overview&n=<?php echo $n; if ($i != $first) echo "&i=$i"; ?>">↑🌐 Áttekintéshez vissza</a></li>
		</ul>
		<h1>Ingatlanhirdető | Részletek</h1>
		<img class="big" id="big" src="<?php echo "$n/{$pictures[$i]['filename']}"; ?>"/>
		<ul class="icon-line">
<?php foreach ($pictures as $id => $picture): ?>
			<li><img class="<?php echo $id == $i ? 'small-focused' : 'small'; ?>" id="icon-<?php echo $n; ?>-<?php echo $id; ?>" src="<?php echo "$n/{$picture['filename']}"; ?>"/></li>
<?php endforeach; ?>
		</ul>
	</body>
</html>
