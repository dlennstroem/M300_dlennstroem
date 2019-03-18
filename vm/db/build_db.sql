create database webapp;
use webapp;
DROP TABLE IF EXISTS `webapp_users`;
CREATE TABLE `webapp_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_pewname` varchar(30) DEFAULT NULL,
  `user_lastname` varchar(50) DEFAULT NULL,
  `user_category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);
