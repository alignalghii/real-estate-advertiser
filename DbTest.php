<?php

use PhpUnit\Framework\TestCase;

require 'Db.php';

class DbTest extends TestCase
{
	const expectedAll = [
		['id' => 1, 'address' => 'Vörös u. 99'],
		['id' => 2, 'address' => 'Őzes út  67'],
	];

	public function testCanQueryAllRecords(): void
	{
		$actualAll = Db::query('SELECT * FROM flat');
		$this->assertEquals(self::expectedAll, $actualAll);
	}

	public function testCanQuerySelectedRecords(): void
	{
		$actual   = Db::query('SELECT * FROM flat WHERE id = :id', [':id' => [2, \PDO::PARAM_INT]]);
		$expected = [['id' => 2, 'address' => 'Őzes út  67']];
		$this->assertEquals($expected, $actual);
	}
}
