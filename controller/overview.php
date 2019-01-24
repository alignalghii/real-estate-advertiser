<?php

require 'Model.php';

class OverviewController
{
	private $n;

	public function __construct(int $n) {$this->n = $n;}

	public function index()
	{
		$numberOfFlats = Model::numberOfFlats();
		$n = $this->n;
		if (1 <= $n && $n <= $numberOfFlats) {
			$flats = Model::allFlats();
			$pictures  = Model::picturesOfFlat($n);
			require 'view/overview.php';
		} else {
			echo 'Error: wrong index number for flat record';
		}
	}
}
