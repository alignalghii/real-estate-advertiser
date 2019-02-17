<?php

require 'Model.php';

class DetailsController
{
	private $n;
	private $i;

	public function __construct(?int $n, ?int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$n = $this->n;
		$i = $this->i;

		if (!$n) $n = Model::overviewFirstFlat();
		if ($n) {
			if (!$i) $i = Model::overviewFirstPic($n);
			if ($i) {
				$match = Model::overviewMatchPic($n, $i);
				if ($match) {
					$pictures      = Model::detailsPicturesOfFlat($n, $i);
					$detailsPicNav = Model::detailsPicNav($i);
					extract($detailsPicNav); // $prev, $next, $first
					require 'view/details.php';
				} else {
					$errorMsg = "Error: Mismatch between flat index $n and picture index $i";
					require 'view/error.php';
				}
			} else {
				$errorMsg = "Error: No pictures for flat index $n";
				require 'view/error.php';
			}
		} else {
			$errorMsg = 'No flats';
			require 'view/error.php';
		}
	}
}
