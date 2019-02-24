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
			<li><a href="/"><?php echo Icon::USER; ?> Felhasználói felület</a></li>
			<li><a href="?p=admin">Teljes űrlap újrakezdése (eddigi gépelések törlése)</a></li>
		</ul>
		<h1>Ingatlanhirdető | Admin</h1>
		<h2>Lakások listája</h2>
		<ul>
<?php foreach ($flats as $flat): ?>
			<li>(<?php echo $flat['order']; ?>) #<?php echo $flat['id']; ?>: <?php echo $flat['address']; ?> (Képek száma: <?php echo $flat['pics']; ?> kép)</li>
<?php endforeach; ?>
		</ul>
		<h2>Sorrendcsereberélés</h2>
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
			<input type="submit" name="submit_swap" value="Cserélj!"/>
<?php if ($mode == 'swap'): ?>
			<span class="<?php echo $swapStatus ? 'OK' : 'error'; ?>"><?php echo $swapMessage; ?></span>
<?php endif; ?>
		</form>
		<h2>Új lakás beszúrása</h2>
		<form method="POST" action="?p=admin&resource=flats">
			Cím:
			<input type="text"   name="address"/>
			<input type="submit" name="submit_insert" value="Szúrd be!"/>
<?php if ($mode == 'insert'): ?>
			<span class="<?php echo $insertStatus ? 'OK' : 'error'; ?>"><?php echo $insertMessage; ?></span>
<?php endif; ?>
		</form>
	</body>
</html>
