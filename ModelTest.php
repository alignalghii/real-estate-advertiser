<?php

use PhpUnit\Framework\TestCase;

require 'Model.php';

class ModelTest extends TestCase
{
	const expectedAll = [
		['id' => 1, 'address' => 'Vörös u. 99'],
		['id' => 2, 'address' => 'Őzes út  67'],
	];

	public function testCanTellNumberOfFlats(): void
	{
		$actual = \Model::numberOfFlats();
		$this->assertEquals(2, $actual);
	}

	public function testCanQueryAllFlats(): void
	{
		$actualAll = Model::allFlats();
		$this->assertEquals(self::expectedAll, $actualAll);
	}

	public function testCanQueryPicturesOfAFlat(): void
	{
		$images1 = Model::picturesOfFlat(1);
		$this->assertEquals([['flat_id' => 1, 'order' => 1, 'filename' => 'kitchen.jpg'], ['flat_id' => 1, 'order' => 2, 'filename' => 'vestible.jpg']], $images1);
		$images2 = Model::picturesOfFlat(2);
		$this->assertEquals([['flat_id' => 2, 'order' => 1, 'filename' => 'kitchen.jpg'], ['flat_id' => 2, 'order' => 2, 'filename' => 'toilet.jpg'], ['flat_id' => 2, 'order' => 3, 'filename' => 'bedroom.jpg']], $images2);
	}
}
