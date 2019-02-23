<?php

require 'Model.php';
require 'Icon.php';

class DetailsController
{
	private $n;
	private $i;

	public function __construct(?int $n, ?int $i) {$this->n = $n; $this->i = $i;}

	public function index()
	{
		$n = $this->n;
		$i = $this->i;

		$n1 = Model::overviewFirstFlat();
		if (!$n) $n = $n1;
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
					$errorMsg  = "Error: Mismatch between flat index $n and picture index $i";
					$backlinks = ['⚙ Kezelői felület' => '?p=admin', '⌂ Megadott lakás' => "?p=overview&n=$n"] + ($n != $n1 ? ['⌂₁ Első lakás' => '?p=overview'] : []);
					require 'view/error.php';
				}
			} else {
				$errorMsg  = "Error: No pictures for flat index $n";
				$backlinks = ['⚙ Kezelői felület' => '?p=admin', '⌂ Megadott lakás' => "?p=overview&n=$n"] + ($n != $n1 ? ['⌂₁ Első lakás' => '?p=overview'] : []);
				// @TODO add link also for going directly to the image uploader for the affected flat
				require 'view/error.php';
			}
		} else {
			$errorMsg  = 'No flats';
			$backlinks = ['⚙ Kezelői felület' => '?p=admin', Icon::USER.' Felhasználói felület' => null];
			require 'view/error.php';
		}
	}
}
