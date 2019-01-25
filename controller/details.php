<?php

require 'Model.php';

class DetailsController
{
	private $n;
	private $i;

	public function __construct(int $n, int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$n = $this->n;
		$i = $this->i;
		$numberOfFlats    = Model::numberOfFlats();
		if (1 <= $n && $n <= $numberOfFlats) {
			$pictures         = Model::picturesOfFlat($n);
			$numberOfPictures = count($pictures);
			if (1 <= $i && $i <= $numberOfPictures) {
				$i0 = $i-1;
				require 'view/details.php';
			} else {
				echo "Error: wrong index for picture";
			}
		} else {
			echo "Error: wrong index for flat record";
		}
	}
}
