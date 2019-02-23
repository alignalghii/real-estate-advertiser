<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<link rel="stylesheet" href="general.css"/>
		<link rel="stylesheet" href="navigation.css"/>
		<title>Ingatlanhirdető | Admin</title>
	</head>
	<body>
		<ul class="navigation">
			<li>
				<a href="/"><svg viewbox="0 0 150 300"><!-- and also for `svg` in `navigation.css`, credit to [Niels Keurentjes](https://stackoverflow.com/a/33253619) -->
					<circle cx="75" cy="55" r="50" />
					<path d="M75,105 L75,200 L25,300 M75,200 L125,300 M0,150 L150,150"></path>
				</svg>
				Felhasználói felület</a>
			</li>
		</ul>
		<h1>Ingatlanhirdető | Admin</h1>
		<ul>
<?php foreach ($flats as $flat): ?>
			<li>(<?php echo $flat['order']; ?>) #<?php echo $flat['id']; ?>: <?php echo $flat['address']; ?> (Képek száma: <?php echo $flat['pics']; ?> kép)</li>
<?php endforeach; ?>
		</ul>
		<form method="POST" action="?p=admin">
			<select name="swap">
<?php foreach ($flats as $flat): ?>
				<option value="<?php echo $flat['order']; ?>"<?php if($mode == 'swap' && $flat['order'] == $swap): ?> selected<?php endif; ?>>(<?php echo $flat['order']; ?>) #<?php echo $flat['id']; ?>: <?php echo $flat['address']; ?></option>
<?php endforeach; ?>
			</select>
			<select name="paws">
<?php foreach ($flats as $flat): ?>
				<option value="<?php echo $flat['order']; ?>"<?php if($mode == 'swap' && $flat['order'] == $paws): ?> selected<?php endif; ?>>(<?php echo $flat['order']; ?>) #<?php echo $flat['id']; ?>: <?php echo $flat['address']; ?></option>
<?php endforeach; ?>
			</select>
			<a href="?p=admin">Újratölt</a>
			<input type="submit" name="submit_swap" value="Cserélj!"/>
<?php if ($mode == 'swap'): ?>
			<span class="<?php echo $status ? 'OK' : 'error'; ?>"><?php echo $message; ?></span>
<?php endif; ?>
		<form>
	</body>
</html>
