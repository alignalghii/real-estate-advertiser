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
}
