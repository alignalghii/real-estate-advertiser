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
			if ($n > 1)              echo '<a href="?n='.($n-1).'">Vissza</a>';
			echo '<br/>';
			if ($n < $numberOfFlats) echo '<a href="?n='.($n+1).'">Tovább</a>';
			echo '<br/>';
			echo '<a href="?n='.($n<$numberOfFlats ? $n+1 : 1).'">15s</a>';
			echo '<br/>';
			$flats = Model::allFlats();
			echo $flats[$n-1]['address'];
		} else {
			echo 'Error: wrong index number for record';
		}
	}
}
