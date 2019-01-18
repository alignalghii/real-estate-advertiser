create database real_estate_advertiser default character set = utf8;
grant all privileges on real_estate_advertiser.* to 'REA_admin'@'localhost' identified by 'REA_admin_123';
grant select, insert, update, delete on real_estate_advertiser.* to 'REA_app'@'localhost' identified by 'REA_app_123';
