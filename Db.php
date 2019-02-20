<?php

require_once 'Config.php';

class Db
{
	public  static function queryOne(string $sql, array $bindings = []): ?array {return self::queryOneOrAll(true , $sql, $bindings);}
	public  static function queryAll(string $sql, array $bindings = []):  array {return self::queryOneOrAll(false, $sql, $bindings);}

	private static function queryOneOrAll(bool $oneOrAll, string $sql, array $bindings = []): ?array
	{
		list ($_, $_, $st) = self::execute($sql, $bindings);
		return $oneOrAll ? ($st->fetch   (PDO::FETCH_ASSOC) ?: null)
		                 :  $st->fetchAll(PDO::FETCH_ASSOC)         ;
	}

	public static function execute(string $sql, array $bindings = []): array
	{
		$dns = sprintf('mysql:host=%s;dbname=%s;charset=utf8', Config::DB_HOST, Config::DB_NAME);
		$pdo = new PDO($dns, Config::DB_USER, Config::DB_PASSWORD);
		$st = $pdo->prepare($sql);
		foreach ($bindings as $marker => list($value, $pdoType)) {
			$st->bindValue($marker, $value, $pdoType);
		}
		$status = $st->execute();
		return [$status, $pdo, $st];
	}
}
