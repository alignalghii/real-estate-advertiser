<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" type="text/css" href="gallery.css"/>
		<link rel="stylesheet" type="text/css" href="navigation.css"/>
		<link rel="stylesheet" type="text/css" href="layout.css"/>
		<script src="util.js"></script>
		<script src="timer.js"></script>
		<title>Ingatlanhirdető | Hiba</title>
	</head>
	<body>
		<ul class="navigation">
<?php foreach ($backlinks as $label => $backhref): ?>
			<li><a <?php if ($backhref): ?>href="<?php echo $backhref; ?>"<?php else: ?>class="faint"<?php endif; ?>><?php echo $label; ?></a></li>
<?php endforeach; ?>
		</ul>
		<h1>Ingatlanhirdető | Hiba</h1>
		<p><?php echo $errorMsg; ?></p>
	</body>
</html>
