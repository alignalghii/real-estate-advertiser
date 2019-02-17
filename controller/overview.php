<?php

require 'Model.php';
require 'Helper.php';

class OverviewController
{
	private $n, $i;

	public function __construct(?int $n, ?int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$n = $this->n;
		$i = $this->i;

		if (!$n || Model::overviewValidFlat($n)) {
			if (!$n) $n = Model::overviewFirstFlat();
			if ($n) {
				if (!$i) $i = Model::overviewFirstPic($n);
				$match = $i ? Model::overviewMatchPic($n, $i) : true;
				if ($match) {
					$overviewData = Model::overviewData($n);
					extract($overviewData); // $prev, $next, $round, $address, $picture1, $picture2
					require 'view/overview.php';
				} else {
					$errorMsg = "Error: Mismatch between flat index $n and picture index $i";
					require 'view/error.php';
				}
			} else {
				$errorMsg = 'Error: No flats';
				require 'view/error.php';
			}
		} else {
			$errorMsg = "Error: Invalid flat index #$n";
			require 'view/error.php';
		}
	}
}
