<?php

// @TODO Dispatch also by the `OPTIONS` method (see REST API)

$method = empty($_GET['method']) ? $_SERVER['REQUEST_METHOD'] : $_GET['method'];
$page   = $_GET['p'] ?? 'overview';
const PLAIN = 'text/html';
const REST  = 'application/json';
$accept      = $_SERVER['HTTP_ACCEPT'      ] ?? PLAIN;
$contentType = $_SERVER['HTTP_CONTENT_TYPE'] ?? PLAIN;
function isREST (string $mimeType): bool {return (bool) preg_match('~'.REST .'~', $mimeType);}
function isPlain(string $mimeType): bool {return (bool) preg_match('~'.PLAIN.'~', $mimeType);}
function subset(array $as, array $bs): bool {$is = true; foreach ($as as $a) $is = $is && in_array($a, $bs); return $is;}

function retrieve_POST_PUT_OR_PATCH(): array
{
	if ($_POST) {
		$entityArray = $_POST;
	} else {
		$entityData = file_get_contents('php://input');
		parse_str($entityData, $entityArray); // @TODO: Use & character in street address, it confuses `controller/index.php::parse_str`
	}
	return $entityArray;
}

function retrieveJsonArrayIfPossible(): ?array
{
	$rawPostData = file_get_contents('php://input');
	$json        = json_decode($rawPostData, true);
	return         is_array($json) ? $json : null;
}

$missingParams = [];
switch ([$method, $page]) {
	case ['GET', 'overview']:
		require 'controller/overview.php';
		$n = isset($_GET['n']) ? intval($_GET['n']) : null;
		$i = isset($_GET['i']) ? intval($_GET['i']) : null;
		$controller = new OverviewController($n, $i);
		$controller->index();
		break;
	case ['GET', 'details']:
		require 'controller/details.php';
		$n = isset($_GET['n']) ? intval($_GET['n']) : null;
		$i = isset($_GET['i']) ? intval($_GET['i']) : null;
		$controller = new DetailsController($n, $i);
		$controller->index();
		break;
	case ['GET', 'admin']:
		require 'controller/admin.php';
		$controller = new AdminController;
		$controller->index();
		break;
	case ['POST', 'admin']:
		if (isset($_POST['swap']) && isset($_POST['paws']) && intval($_POST['swap']) > 0 && intval($_POST['paws']) > 0) { 
			require 'controller/admin.php';
			$swap = intval($_POST['swap']);
			$paws = intval($_POST['paws']);
			$controller = new AdminController;
			$controller->swap($swap, $paws);
			break;
		} elseif (isset($_GET['resource']) && $_GET['resource'] == 'flats' && isset($_POST['address'])) {
			$missingParams[] = 'POST `swap=<int> paws=<int>`';
			require 'controller/admin.php';
			$address    = $_POST['address'];
			$controller = new AdminController;
			$controller->insertFlat($address);
			break;
		} else {
			$missingParams[] = 'QUERYSTRING `resource=flats` and `POST address=<string>`';
		}
	case ['DELETE', 'admin']:
		if (isset($_GET['resource']) && $_GET['resource'] == 'flats' && isset($_GET['n']) && intval($_GET['n']) > 0) {
			require 'controller/admin.php';
			$n = intval($_GET['n']);
			$controller = new AdminController;
			if (isREST($accept)) {
				$controller->deleteFlat_REST($n);
			} else {
				$controller->deleteFlat_plain($n);
			}
			break;
		} else {
			$missingParams[] = 'DELETE QUERYSTRING `resource=flats n=<int>`';
		}
	case ['PUT', 'admin']:
		if (isset($_GET['resource']) && $_GET['resource'] == 'flats' && !isset($_GET['n']) && isset($_GET['subcommand']) && $_GET['subcommand'] == 'sample-data') {
			require 'controller/admin.php';
			$controller = new AdminController;
			if (isREST($accept)) {
				$controller->reinitDBWithDefaultSampleData_REST ();
			} else {
				$controller->reinitDBWithDefaultSampleData_plain();
			}
			break;
		} else {
			$missingParams[] = 'PUT QUERYSTRING `resource=flats subcommand=sample-data`';
		}
	case ['PATCH', 'admin']:
		if (isset($_GET['resource']) && $_GET['resource'] == 'flats' && isset($_GET['n']) && intval($_GET['n']) > 0) {
			require 'controller/admin.php';
			$isREST     = isREST($contentType);
			$controller = new AdminController;
			$n = intval($_GET['n']);
			if (isREST($contentType)) {
				$jsonArray = retrieveJsonArrayIfPossible();
				$controller->updateFlat_REST ($n, $jsonArray);
			} else {
				$entityArray = retrieve_POST_PUT_OR_PATCH(); // @TODO: Use & character in street address, it confuses `controller/index.php::parse_str`
				$controller->updateFlat_plain($n, $entityArray);
			}
			break;
		} else {
			$missingParams[] = 'PATCH QUERYSTRING `resource=flats n=<int> BODY {address: <string>}`';
		}
	default:
		require 'controller/error.php';
		$missingParams = implode(', OR ', $missingParams);
		$controller = new ErrorController("Error: No such route as [$method $page], or problems with some other parameters [$missingParams]");
		$controller->index();
}
