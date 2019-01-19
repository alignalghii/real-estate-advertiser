<?php
require 'controller/overview.php';
require 'controller/details.php';
require 'controller/error.php';

$p = $_GET['p'] ?? 'overview';

switch ($p) {
	case 'overview':
		$n = (int) ($_GET['n'] ?? 1);
		$controller = new OverviewController($n);
		break;
	case 'details':
		$n = (int) ($_GET['n'] ?? 1);
		$i = (int) ($_GET['i'] ?? 1);
		$controller = new DetailsController($n, $i);
		break;
	default:
		$controller = new ErrorController("Error: No such page as [$p]");
}

$controller->index();
