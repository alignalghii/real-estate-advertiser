<?php

require_once 'Db.php';

class Model
{
	const SIGNATURE_FLAT   = ['address' => \PDO::PARAM_STR];
	const EQUIVALENCE_FLAT = ['address' => [self::class, 'addressEquivalence']];
	const VALIDATOR_FLAT   = ['address' => [self::class, 'addressValidator'  ]];
	public static function addressValidator  (string $address): bool   {return $address !== '';}
	public static function addressEquivalence(string $address): string {return trim($address) ;} // @TODO also a regexp substituter should remove duplicate whitespaces

	public static function countOfFlats(): int
	{
		return Db::queryOne('SELECT COUNT(*) AS `n` FROM `flat`')['n'];
	}

	public static function allFlats(): array
	{
		return Db::queryAll('SELECT * FROM `flat` ORDER BY `order`');
	}

	public static function allFlatsWithPicsAmount(): array
	{
		return Db::queryAll('
			SELECT
				`f`.*,
				COUNT(`p`.`id`) AS `pics`
			FROM      `flat`    AS `f`
			LEFT JOIN `picture` AS `p` ON `p`.`flat_id` = `f`.`id`
			GROUP BY `f`.`id`
			ORDER BY `f`.`order`
		');
	}

	public static function allFlatsWithPicsAmount_subq(): array
	{
		return Db::queryAll('
			SELECT
				*,
				(
					SELECT COUNT(*)
					FROM `picture` AS `p`
					WHERE `p`.`flat_id` = `flat`.`id`
				) AS `pics`
			FROM `flat`
			ORDER BY `order`
		');
	}


	public static function detailsPicturesOfFlat(int $flatId): array
	{
		$recs = Db::queryAll(
			'
				SELECT *
				FROM `picture`
				WHERE `flat_id` = :flat_id
				ORDER BY `order`
			',
			[':flat_id' => [$flatId, \PDO::PARAM_INT]]
		);
		$assoc = [];
		foreach ($recs as $rec) {
			$key = (int) $rec['id'];
			unset($rec['id']);
			$assoc[$key] = $rec;
		}
		return $assoc;
	}

	public static function flat2pics(int $flatId): array
	{
		return Db::query(
			'
				SELECT *
					FROM `flat`    AS `f`
					JOIN `picture` AS `p` ON `p`.`flat_id` = `f`.`id`
				WHERE `p`.`flat_id`
				ORDER BY `f`.`order`, `p`.`order`
			',
			[':flat_id' => [$flatId, \PDO::PARAM_INT]]
		);
	}

	public static function overviewData(int $flatId): ?array
	{
		return Db::queryOne(
			"
				SELECT
					`f`.*,
					CONCAT(`f`.`id`, '/', `p1`.`filename`) AS `picture1`,
					CONCAT(`f`.`id`, '/', `p2`.`filename`) AS `picture2`,
					`fp`.`id`                              AS `prev`    ,
					`fn`.`id`                              AS `next`    ,
					`f1`.`id`                              AS `first`   ,
					COALESCE(`fn`.`id`, `f1`.`id`)         AS `round`
				FROM `flat` AS `f`
				LEFT JOIN `picture` AS `p1` ON `p1`.`flat_id` = `f`.`id` AND `p1`.`order` = 1
				LEFT JOIN `picture` AS `p2` ON `p2`.`flat_id` = `f`.`id` AND `p2`.`order` = 2
				LEFT JOIN `flat` AS `fp` ON `fp`.`order` = `f`.`order` - 1
				LEFT JOIN `flat` AS `fn` ON `fn`.`order` = `f`.`order` + 1
				LEFT JOIN `flat` AS `f1` ON `f1`.`order` = 1

				WHERE `f`.`id` = :flat_id
				ORDER BY `f`.`order`
			",
			[':flat_id' => [$flatId, \PDO::PARAM_INT]]
		);
	}

	public static function overviewMatchPicGen(int $flatId, ?int $picId): bool
	{
		return $picId ?         self::overviewMatchPic($flatId, $picId)
		              : (bool) !self::overviewFirstPic($flatId);

	}

	public static function overviewMatchPic(int $flatId, int $picId): bool
	{

		$rec = Db::queryOne(
			'
				SELECT `id` FROM `picture`
				WHERE `flat_id` = :flat_id AND `id` = :pic_id
			',
			[
				':flat_id' => [$flatId, \PDO::PARAM_INT],
				':pic_id'  => [$picId , \PDO::PARAM_INT]
			]
		);
		return (bool) $rec;
	}


	public static function overviewFirstPic(int $flatId): ?int
	{

		$rec = Db::queryOne(
			'SELECT `id` FROM `picture` WHERE `flat_id` = :flat_id ORDER BY `order` LIMIT 1',
			[':flat_id' => [$flatId, \PDO::PARAM_INT]]
		);
		return $rec && isset($rec['id']) ? intval($rec['id']) : null;
	}

	public static function overviewFirstFlat(): ?int
	{
		$rec = Db::queryOne('SELECT `id` FROM `flat` ORDER BY `order` LIMIT 1');
		return $rec && isset($rec['id']) ? intval($rec['id']) : null;
	}

	public static function detailsPicNav(int $i): ?array
	{
		return Db::queryOne(
			'
				SELECT
					`p`.*,
					`pp`.`id` AS `prev`,
					`pn`.`id` AS `next`,
					`p1`.`id` AS `first`
				FROM      `picture` AS `p`
				LEFT JOIN `picture` AS `pp` ON `pp`.`flat_id` = `p`.`flat_id` AND `pp`.`order` = `p`.`order` - 1
				LEFT JOIN `picture` AS `pn` ON `pn`.`flat_id` = `p`.`flat_id` AND `pn`.`order` = `p`.`order` + 1
				LEFT JOIN `picture` AS `p1` ON `p1`.`flat_id` = `p`.`flat_id` AND `p1`.`order` = 1
				WHERE `p`.`id` = :id
				ORDER BY `p`.`order`
			',
			[':id' => [$i, \PDO::PARAM_INT]]
		) ?: null;
	}

	public static function overviewValidFlat(int $n): bool
	{
		return (bool) Db::queryOne(
			'SELECT `id` FROM `flat` WHERE `id` = :id',
			[':id' => [$n, \PDO::PARAM_INT]]
		);
	}

	public static function swap(string $tableName, string $fieldName, int $swap, int $paws): bool
	{
		list($status1, $pdo, $st) = Db::execute(
			"
				UPDATE `$tableName`
				SET `$fieldName` = CASE `$fieldName`
				                       WHEN :swap THEN -:paws
				                       WHEN :paws THEN -:swap
				                   END
				WHERE `$fieldName` = :swap OR `$fieldName` = :paws
			",
			[
				':swap' => [$swap, \PDO::PARAM_INT],
				':paws' => [$paws, \PDO::PARAM_INT]
			]
		);
		$status2 = self::absize($tableName, $fieldName);
		return $status1 && $status2;
	}

	private static function absize(string $tableName, string $fieldName): bool
	{
		list($status, $pdo, $st) = Db::execute("UPDATE `$tableName` SET `$fieldName` = -`$fieldName` WHERE `$fieldName` < 0");
		return $status;
	}

	public static function insertFlat(string $address): bool
	{
		$count = self::countOfFlats();
		list($status, $pdo, $st) = Db::execute(
			'INSERT INTO `flat` (`address`, `order`) VALUE (:address, :order)',
			[
				':address' => [$address  , \PDO::PARAM_STR],
				':order'   => [$count + 1, \PDO::PARAM_INT]
			]
		);
		return $status;
	}

	public static function deleteFlat(int $id): bool
	{
		$lostOrder = self::findFlatOrder($id);
		if ($lostOrder) {
			list($status1, $pdo1, $st1) = Db::execute('DELETE FROM `flat` WHERE `id` = :id', [':id' => [$id, \PDO::PARAM_INT]]);
			if ($status1) {
				list($status2, $pdo2, $st2) = Db::execute('UPDATE `flat` SET `order` = `order` - 1 WHERE `order` > :lost_order', [':lost_order' => [$lostOrder, \PDO::PARAM_INT]]);
			}
		}
		return boolval($lostOrder) && $status1 && $status2;
	}

	private static function findFlatOrder(int $id): ?int
	{
		$flat = Db::queryOne(
			'SELECT `order` FROM `flat` WHERE `id` = :id',
			[':id' => [$id, \PDO::PARAM_INT]]
		);
		return $flat ? $flat['order'] : null;
	}

	public static function reinitDBWithSampleData(): bool
	{
		$status1 = self::reinitDB();
		list($status2, $pdo2, $st2) = Db::execute("
			INSERT INTO `flat`
			(`id`, `order`, `address`     ) VALUES
			(100 ,  1     , 'Vörös u. 99' ),
			(200 ,  2     , 'Őzes út  67' )
		");
		list($status3, $pdo3, $st3) = Db::execute("
			INSERT INTO `picture`
			(`id`, `flat_id`, `order`, `filename`     ) VALUES
			( 110,  100     ,  1     , 'kitchen.jpg'  ),
			( 120,  100     ,  2     , 'vestible.jpg' ),
			( 210,  200     ,  1     , 'kitchen.jpg'  ),
			( 220,  200     ,  2     , 'toilet.jpg'   ),
			( 230,  200     ,  3     , 'bedroom.jpg'  )
		");
		return $status1 && $status2 && $status3;
	}

	public static function reinitDB(): bool
	{
		list($status1, $pdo1, $st1) = Db::execute('DROP TABLE `picture`');
		list($status2, $pdo2, $st2) = Db::execute('DROP TABLE `flat`');
		list($status3, $pdo3, $st3) = Db::execute('
			CREATE TABLE `flat` (
				`id`      INT          NOT NULL AUTO_INCREMENT,
				`address` VARCHAR(256) NOT NULL,
				`order`   INT          NOT NULL,
				PRIMARY KEY (`id`),
				UNIQUE  KEY (`order`)
			)
		');
		list($status4, $pdo4, $st4) = Db::execute('
			CREATE  TABLE `picture` (
				`id`       INT          NOT NULL AUTO_INCREMENT,
				`flat_id`  INT          NOT NULL,
				`order`    INT          NOT NULL,
				`filename` VARCHAR(256) NOT NULL,
				PRIMARY KEY (`id`),
				UNIQUE  KEY (`flat_id`, `order`   ),
				UNIQUE  KEY (`flat_id`, `filename`),
				FOREIGN KEY (`flat_id`) REFERENCES `flat` (`id`) ON DELETE CASCADE
			)
		');
		return $status1 && $status2 && $status3 && $status4;
	}


	public static function updateFlat(int $id, array $requestEntityArray): bool
	{
		$requestFieldNames = array_keys($requestEntityArray);
		$tableFieldNames   = array_keys(self::SIGNATURE_FLAT);
		$doable = subset($requestFieldNames, $tableFieldNames);
		if ($doable) {
			$validates = true;
			foreach ($requestEntityArray as $fieldName => $value) {
				$equivalence = self::EQUIVALENCE_FLAT[$fieldName];
				$validator   = self::VALIDATOR_FLAT[$fieldName];
				$pdoType     = self::SIGNATURE_FLAT[$fieldName];
				$value       = $equivalence($value);
				$validates   = $validates && $validator($value);
				if ($validates) {
					list($status, $pdo, $st) = Db::execute(
						"
							UPDATE `flat` SET `$fieldName` = :value
							WHERE `id` = :id
						",
						[
							':id'    => [$id   , \PDO::PARAM_INT],
							':value' => [$value, $pdoType]
						]
					);
					$validates = $validates && $status;
				}
			}
		}
		return $doable && $validates;
	}
}
