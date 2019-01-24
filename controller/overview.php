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
			echo '<link rel="stylesheet" type="text/css" href="gallery.css"/>';
			echo '<link rel="stylesheet" type="text/css" href="navigation.css"/>';
			echo $n > 1 ? '<a href="?n='.($n-1).'">Előző</a>' : '<span class="faint">Előző</span>';
			echo '<br/>';
			echo $n < $numberOfFlats ? '<a href="?n='.($n+1).'">Következő</a>' : '<span class="faint">Következő</span>';
			echo '<br/>';
			echo '<a href="?n='.($n<$numberOfFlats ? $n+1 : 1).'">15s</a>';
			echo '<br/>';
			echo sprintf('<a href="?p=details&n=%d&i=1">Click for details!</a>', $n);
			echo '<br/>';
			$flats = Model::allFlats();
			echo $flats[$n-1]['address'];
			$pictures  = Model::picturesOfFlat($n);
			echo '<ul>';
			foreach ($pictures as $i => $picture) {
				if ($i < 2) echo "<li><img class=\"half\" src=\"$n/{$pictures[$i]['filename']}\"/></li>";
			}
			echo '</ul>';
		} else {
			echo 'Error: wrong index number for flat record';
		}
	}
}
