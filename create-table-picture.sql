CREATE  TABLE `picture` (
	`id`       INT          NOT NULL AUTO_INCREMENT,
	`flat_id`  INT          NOT NULL,
	`order`    INT          NOT NULL,
	`filename` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE  KEY (`flat_id`, `order`   ),
	UNIQUE  KEY (`flat_id`, `filename`),
	FOREIGN KEY (`flat_id`) REFERENCES `flat` (`id`)
);
