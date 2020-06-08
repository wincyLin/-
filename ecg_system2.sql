INSERT INTO sex (2,'女',number)
SELECT COUNT(sex) AS number FROM `ecg_info` WHERE sex = '女'
ALTER TABLE sex RENAME TO ecg_sex

DELIMITER ||
CREATE TRIGGER  huan_trige AFTER INSERT
ON ecg_info FOR EACH ROW
BEGIN
UPDATE ecg_huan SET number = (SELECT COUNT(huanzhe) AS number FROM `ecg_info` WHERE huanzhe = '是') WHERE huan = '患者';
UPDATE ecg_huan SET number = (SELECT COUNT(huanzhe) AS number FROM `ecg_info` WHERE huanzhe = '否') WHERE huan = '非患者';
END
||

DELIMITER ||
CREATE TRIGGER  huan_trigetwo AFTER UPDATE
ON ecg_info FOR EACH ROW
BEGIN
UPDATE ecg_huan SET number = (SELECT COUNT(huanzhe) AS number FROM `ecg_info` WHERE huanzhe = '是') WHERE huan = '患者';
UPDATE ecg_huan SET number = (SELECT COUNT(huanzhe) AS number FROM `ecg_info` WHERE huanzhe = '否') WHERE huan = '非患者';
END
||

DELIMITER ||
CREATE TRIGGER  huan_trigethree AFTER DELETE
ON ecg_info FOR EACH ROW
BEGIN
UPDATE ecg_huan SET number = (SELECT COUNT(huanzhe) AS number FROM `ecg_info` WHERE huanzhe = '是') WHERE huan = '患者';
UPDATE ecg_huan SET number = (SELECT COUNT(huanzhe) AS number FROM `ecg_info` WHERE huanzhe = '否') WHERE huan = '非患者';
END
||

CREATE TABLE ecg_huan
(id INT(11) AUTO_INCREMENT PRIMARY KEY,
huan VARCHAR(10),
number INT(11)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8

INSERT INTO ecg_huan VALUES(1,'患者',0),(2,'非患者',0)

DROP TRIGGER huan_trigethree