<?php

require 'Config.php';

class Db
{
	public static function query(string $sql): array
	{
		$dns = sprintf('mysql:host=%s;dbname=%s;charset=utf8', Config::DB_HOST, Config::DB_NAME);
		$pdo = new PDO($dns, Config::DB_USER, Config::DB_PASSWORD);
		$st = $pdo->prepare($sql);
		$status = $st->execute();
		return $st->fetchAll(PDO::FETCH_ASSOC);
	}
}
