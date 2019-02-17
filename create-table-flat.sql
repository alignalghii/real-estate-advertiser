CREATE TABLE `flat` (
	`id`      INT          NOT NULL AUTO_INCREMENT,
	`address` VARCHAR(256) NOT NULL,
	`order`   INT          NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE  KEY (`order`)
);
