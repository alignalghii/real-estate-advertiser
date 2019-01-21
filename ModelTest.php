<?php

use PhpUnit\Framework\TestCase;

require 'Model.php';

class ModelTest extends TestCase
{
	public function testCanTellNumberOfFlats(): void
	{
		$actual = \Model::numberOfFlats();
		$this->assertEquals(2, $actual);
	}
}
