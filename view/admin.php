<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>Ingatlanhirdető | Admin</title>
	</head>
	<body>
		<h1>Ingatlanhirdető | Admin</h1>
		<ul>
<?php foreach ($flats as $flat): ?>
			<li>(<?php echo $flat['order']; ?>) <?php echo $flat['address']; ?></li>
<?php endforeach; ?>
		</ul>
	</body>
</html>
