<link rel="stylesheet" type="text/css" href="gallery.css"/>
<link rel="stylesheet" type="text/css" href="navigation.css"/>
<?php if ($n > 1): ?>
	<a href="?n=<?php echo $n-1; ?>">Előző</a>
<?php else: ?>
	<span class="faint">Előző</span>
<?php endif; ?>
<br/>
<?php if ($n < $numberOfFlats): ?>
	<a href="?n=<?php echo $n+1; ?>">Következő</a>
<?php else: ?>
	<span class="faint">Következő</span>
<?php endif; ?>
<br/>
<a href="?n=<?php echo $n<$numberOfFlats ? $n+1 : 1; ?>">15s</a>
<br/>
<a href="?p=details&n=<?php echo $n; ?>&i=<?php echo $i; ?>">Click for details!</a>
<br/>
<?php echo $flats[$n-1]['address']; ?>
<ul>
<?php foreach ($pictures as $i => $picture): ?>
	<?php if ($i < 2): ?><li><img class="half" src="<?php echo "$n/{$pictures[$i]['filename']}"; ?>"/></li><?php endif; ?>
<?php endforeach; ?>
</ul>
