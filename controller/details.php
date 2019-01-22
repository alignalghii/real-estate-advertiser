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
				echo '<link rel="stylesheet" type="text/css" href="gallery.css"/>';
				echo "<a href=\"?p=overview&n=$n\">Áttekintéshez vissza</a>";
				echo '<br/>';
				echo "<a href=\"?p=overview&n=$n\">60s</a>";
				echo '<ul>';
				foreach ($pictures as $running => $picture) {
					$class = $running+1 == $i ? 'big' : 'small';
					echo "<li><img class=\"$class\" src=\"$n/{$pictures[$running]['filename']}\"/></li>";
				}
				echo '</ul>';
			} else {
				echo "Error: ";
			}
		} else {
			echo "Error: ";
		}
	}
}
