<?php

use PhpUnit\Framework\TestCase;

require 'Db.php';

class DbTest extends TestCase
{
	const expectedAll = [
		['id' => 1, 'address' => 'Vörös u. 99'],
		['id' => 2, 'address' => 'Őzes út  67'],
	];

	public function testQuery(): void
	{
		$actualAll = Db::query('SELECT * FROM flat');
		$this->assertEquals(self::expectedAll, $actualAll);
	}
}
