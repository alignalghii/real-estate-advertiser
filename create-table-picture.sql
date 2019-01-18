CREATE  TABLE `picture` (
	`flat_id`  INT          NOT NULL,
	`order`    INT          NOT NULL,
	`filename` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`flat_id`, `order`   ),
	UNIQUE KEY  (`flat_id`, `filename`)
);
