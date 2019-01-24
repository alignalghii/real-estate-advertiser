<?php

require 'Model.php';

class OverviewController
{
	private $n, $i;

	public function __construct(int $n, int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$numberOfFlats = Model::numberOfFlats();
		$n = $this->n;
		$i = $this->i;
		if (1 <= $n && $n <= $numberOfFlats) {
			$flats = Model::allFlats();
			$pictures  = Model::picturesOfFlat($n);
			$numberOfPictures = count($pictures);
			if (1 <= $i && $i <= $numberOfPictures) {
				require 'view/overview.php';
			} else {
				echo 'Error: wrong index number for picture';
			}
		} else {
			echo 'Error: wrong index number for flat record';
		}
	}
}
