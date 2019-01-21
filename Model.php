<?php

class Model
{
	public static function numberOfFlats(): int
	{
		return Db::query('SELECT COUNT(*) AS `n` FROM `flat`')[0]['n'];
	}
}
