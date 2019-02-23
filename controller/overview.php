<?php

require 'Model.php';
require 'Helper.php';
require 'Icon.php';

class OverviewController
{
	private $n, $i;

	public function __construct(?int $n, ?int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$n = $this->n;
		$i = $this->i;

		$n1 = Model::overviewFirstFlat();
		if (!$n || Model::overviewValidFlat($n)) {
			if (!$n) $n = $n1;
			if ($n) {
				if (!$i) $i = Model::overviewFirstPic($n);
				$match = $i ? Model::overviewMatchPic($n, $i) : true;
				if ($match) {
					$overviewData = Model::overviewData($n);
					extract($overviewData); // $prev, $next, $round, $address, $picture1, $picture2
					require 'view/overview.php';
				} else {
					$errorMsg  = "Error: Mismatch between flat index $n and picture index $i";
					$backlinks = ['⚙ Kezelői felület' => '?p=admin', '⌂ Megadott lakás' => "?p=overview&n=$n"] + ($n != $n1 ? ['⌂₁ Első lakás' => '?p=overview'] : []);
					require 'view/error.php';
				}
			} else {
				$errorMsg  = 'Error: No flats';
				$backlinks = ['⚙ Kezelői felület' => '?p=admin', Icon::USER.' Felhasználói felület' => null];
				require 'view/error.php';
			}
		} else {
			$errorMsg  = "Error: Invalid flat index #$n";
			$backlinks = ['⚙ Kezelői felület' => '?p=admin', '⌂₁ Első lakás' => '?p=overview'];
			require 'view/error.php';
		}
	}
}
