<?php

require 'Model.php';
require 'Icon.php';

class AdminController
{
	public function index()
	{
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'get';
		require 'view/admin.php';
	}

	public function swap(int $swap, int $paws)
	{
		$countOfFlats = Model::countOfFlats();
		if ($swap <= $countOfFlats && $paws <= $countOfFlats) {
			if ($swap != $paws) {
				Model::swap('flat', 'order', $swap, $paws);
				list($swapStatus, $swapMessage) = [true , 'Sikeresen felcseréltem a két megadott sorszámú lakást!'];
			} else {
				list($swapStatus, $swapMessage) = [false, 'Két-két egymástól különböző sorszámot adj meg!'];
			}
		} else {
			list($swapStatus, $swapMessage) = [false, 'Létező sorszámokat adj meg!'];
		}
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'swap';
		require 'view/admin.php';
	}

	public function insertFlat(string $address)
	{
		$address = trim($address);
		if ($address) {
			Model::insertFlat($address);
			header('HTTP/1.1 201 Created');
			header('Location: ?p=admin&resource=flats&n=201');
			list ($insertStatus, $insertMessage) = [true, 'Új lakás sikeresen beszúrva!'];
		} else {
			list ($insertStatus, $insertMessage) = [false, 'Nem lehet üres a cím!'];
		}
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'insert';
		require 'view/admin.php';
	}

	public function deleteFlat_plain(int $n): void
	{
		$deleteStatus = Model::deleteFlat($n);
		$deleteMessage = $deleteStatus ? 'Sikeres törlés!' : 'Nincs mit törölni, mert nincs ilyen lakás!';
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'delete';
		require 'view/admin.php';
	}

	public function deleteFlat_REST(int $n): void
	{
		$status = Model::deleteFlat($n);
		header($status ? 'HTTP/1.1 204 No Content' : 'HTTP/1.1 404 Not Found');
	}

	public function reinitDBWithDefaultSampleData_REST (): void
	{
		$status = Model::reinitDBWithSampleData();
		header($status ? 'HTTP/1.1 201 No Content' : 'HTTP/1.1 500 Internal Server Error');
	}

	public function reinitDBWithDefaultSampleData_plain(): void
	{
		$reinitStatus  = Model::reinitDBWithSampleData();
		$reinitMessage = $reinitStatus ? 'Adatbázis mintából sikeresen újraindítva!' : 'Adatbázis mintából való újraindítása meghiúsult!';
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'reinit';
		require 'view/admin.php';
	}


	public function updateFlat_REST(int $id, ?array $entityArray): void
	{
		$isValidId          = Model::overviewValidFlat($id);
		$isValidEntityArray = isset($entityArray);
		if ($isValidId && $isValidEntityArray) {
			$status = Model::updateFlat($id, $entityArray);
			if ($status) {
				header('HTTP/1.1 204 No Content');
				header('Content-type: application/json');
				header_remove('Content-type');
			} else {
				header('HTTP/1.1 400 Bad Request');
				header('Content-type: application/json');
				header_remove('Content-type');
			}
		} else {
			if (!$isValidId         ) header('HTTP/1.1 404 Not Found'  );
			if (!$isValidEntityArray) header('HTTP/1.1 400 Bad Request');
			header('Content-type: application/json');
			header_remove('Content-type');
		}
	}

	public function updateFlat_plain(int $id, array $entityArray): void
	{
		$isValidId  = Model::overviewValidFlat($id);
		if ($isValidId) {
			$status = Model::updateFlat($id, $entityArray);
			list($updateStatus, $updateMessage) = $status ? [true , 'Sikeresen átírva!']
			                                              : [false, 'Érvénytelen az üres lakáscím!'];
		} else {
			list($updateStatus, $updateMessage) =           [false, 'Azonosíthatatlan a módosítandó lakás!'];
		}
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'update';
		require 'view/admin.php';
	}
}
