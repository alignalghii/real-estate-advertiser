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
}
