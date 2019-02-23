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
			<li><a href="?p=admin">⚙ Kezelői felület</a></li>
			<li>
				<a href="/"><svg viewbox="0 0 150 300">
					<circle cx="75" cy="55" r="50" />
					<path d="M75,105 L75,200 L25,300 M75,200 L125,300 M0,150 L150,150"></path>
				</svg>
				Felhasználói felület</a>
			</li>
		</ul>
		<h1>Ingatlanhirdető | Hiba</h1>
		<p><?php echo $errorMsg; ?></p>
	</body>
</html>
