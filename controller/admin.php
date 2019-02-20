<?php

require 'Model.php';

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
		if ($swap <= $countOfFlats && $paws <= $countOfFlats && $swap != $paws) {
			Model::swap('flat', 'order', $swap, $paws);
			list($status, $message) = [true , 'Sikeres rendezés'];
		} else {
			list($status, $message) = [false, 'Rendezési hiba'  ];
		}
		$flats = Model::allFlatsWithPicsAmount();
		$mode = 'swap';
		require 'view/admin.php';
	}
}
