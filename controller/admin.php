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
				list($status, $message) = [true , 'Sikeresen felcseréltem a két megadott sorszámú lakást!'];
			} else {
				list($status, $message) = [false, 'Két-két egymástól különböző sorszámot adj meg!'];
			}
		} else {
			list($status, $message) = [false, 'Létező sorszámokat adj meg!'];
		}
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'swap';
		require 'view/admin.php';
	}
}
