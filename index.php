<?php

$p = $_GET['p'] ?? 'overview';

switch ($p) {
	case 'overview':
		require 'controller/overview.php';
		$n = (int) ($_GET['n'] ?? 1);
		$controller = new OverviewController($n);
		break;
	case 'details':
		require 'controller/details.php';
		$n = (int) ($_GET['n'] ?? 1);
		$i = (int) ($_GET['i'] ?? 1);
		$controller = new DetailsController($n, $i);
		break;
	default:
		require 'controller/error.php';
		$controller = new ErrorController("Error: No such page as [$p]");
}

$controller->index();
