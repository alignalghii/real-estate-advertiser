<?php

require_once 'Db.php';

class Model
{
	public static function numberOfFlats(): int
	{
		return Db::query('SELECT COUNT(*) AS `n` FROM `flat`')[0]['n'];
	}

	public static function allFlats(): array
	{
		return Db::query('SELECT * FROM `flat`');
	}

	public static function picturesofFlat(int $flatId): array
	{
		return Db::query('SELECT * FROM `picture` WHERE `flat_id` = :flat_id', [':flat_id' => [$flatId, \PDO::PARAM_INT]]);
	}
}
