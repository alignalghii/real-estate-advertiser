<link rel="stylesheet" type="text/css" href="gallery.css"/>
<link rel="stylesheet" type="text/css" href="navigation.css"/>
<a href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">Áttekintéshez vissza</a>
<br/>
<a href="?p=overview&n=<?php echo $n; if ($i != 1) echo "&i=$i"; ?>">60s</a>
<br/>
<?php if ($i > 1): ?>
	<a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i-1; ?>">Előző</a>
<?php else: ?>
	<span class="faint">Előző</span>
<?php endif; ?>
<br/>
<?php if ($i < $numberOfPictures): ?>
	<a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i+1; ?>">Következő</a>
<?php else: ?>
	<span class="faint">Következő</span>
<?php endif; ?>
<ul>
<?php foreach ($pictures as $running => $picture): 
	$class = $running+1 == $i ? 'big' : 'small'; ?>
	<li><img class="<?php echo $class; ?>" src="<?php echo "$n/{$pictures[$running]['filename']}"; ?>"/></li>
<?php endforeach; ?>
</ul>
