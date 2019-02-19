<?php

$p = $_GET['p'] ?? 'overview';

switch ($p) {
	case 'overview':
		require 'controller/overview.php';
		$n = isset($_GET['n']) ? intval($_GET['n']) : null;
		$i = isset($_GET['i']) ? intval($_GET['i']) : null;
		$controller = new OverviewController($n, $i);
		break;
	case 'details':
		require 'controller/details.php';
		$n = isset($_GET['n']) ? intval($_GET['n']) : null;
		$i = isset($_GET['i']) ? intval($_GET['i']) : null;
		$controller = new DetailsController($n, $i);
		break;
	case 'admin':
		require 'controller/admin.php';
		$controller = new AdminController;
		break;
	default:
		require 'controller/error.php';
		$controller = new ErrorController("Error: No such page as [$p]");
}

$controller->index();
