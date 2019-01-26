<?php

require 'Model.php';
require 'Helper.php';

class OverviewController
{
	private $n, $i;

	public function __construct(int $n, int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$numberOfFlats = Model::numberOfFlats();
		if ($numberOfFlats > 0) {
			$n = $this->n;
			$i = $this->i;
			if (1 <= $n && $n <= $numberOfFlats) {
				$flats = Model::allFlats();
				$pictures  = Model::picturesOfFlat($n);
				$numberOfPictures = count($pictures);
				if ($numberOfPictures > 0) {
					if (1 <= $i && $i <= $numberOfPictures) {
						require 'view/overview.php';
					} else {
						echo 'Error: wrong index number for picture';
					}
				} else {
					echo sprintf("Error: no images for flat #%d", $n);
				}
			} else {
				echo 'Error: wrong index number for flat record';
			}
		} else {
			echo 'Error: no flat records';
		}
	}
}
