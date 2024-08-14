use czyzewska_edu;

-- zad 3
SHOW CREATE TABLE students;
CREATE TABLE `students` (
  `stu_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) COLLATE utf8mb3_unicode_ci NOT NULL,
  `middle_name` varchar(30) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(40) COLLATE utf8mb3_unicode_ci NOT NULL,
  `album_number` varchar(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  
  PRIMARY KEY (`stu_id`),
  UNIQUE KEY `stu_id_UNIQUE` (`stu_id`),
  UNIQUE KEY `album_number_UNIQUE` (`album_number`));

-- zad 4
INSERT INTO `czyzewska_edu`.`students`
(
`first_name`,
`middle_name`,
`last_name`,
`album_number`)
VALUES
('Jan',null,'Nowak','32460'),
('Józef','Jan','Cegła','102654'),
('Marta','Urszula','Biała','98675'),
('Urszula',null,'Nieprószewska','10487');

select * from students;

-- zad 5
CREATE TABLE `czyzewska_edu`.`course_enrollments` (
  `ce_id` INT NOT NULL AUTO_INCREMENT,
  `cou_id` INT NOT NULL,
  `stu_id` INT NOT NULL,
  `enroll_date` DATE NOT NULL,
  PRIMARY KEY (`ce_id`),
  UNIQUE INDEX `ce_id_UNIQUE` (`ce_id` ASC) VISIBLE,
  INDEX `cou_id_idx` (`cou_id` ASC) VISIBLE,
  INDEX `stu_id_idx` (`stu_id` ASC) VISIBLE,
  CONSTRAINT `cou_id`
    FOREIGN KEY (`cou_id`)
    REFERENCES `czyzewska_edu`.`courses` (`cou_id`),
  CONSTRAINT `stu_id`
    FOREIGN KEY (`stu_id`)
    REFERENCES `czyzewska_edu`.`students` (`stu_id`));

ALTER TABLE `czyzewska_edu`.`course_enrollments` 
ADD UNIQUE INDEX `cou_id_UNIQUE` (`cou_id` ASC) VISIBLE;

select * from course_enrollments;

-- zad  6
INSERT INTO `czyzewska_edu`.`teachers`
(`first_name`, `last_name`, `office`, `phone`)
VALUES ('Anna', 'Jeziorak', 'pokój 313 B', '---');

describe teachers;
SHOW CREATE TABLE teachers;
select * from teachers;

INSERT INTO `czyzewska_edu`.`courses`
(
`name`,
`ects`,
`tea_id`)
VALUES
(
'Statystyka',
6,
(select tea_id from teachers where first_name='Anna' and last_name='Jeziorak'));

select * from courses;

-- z zajeć
INSERT INTO `czyzewska_edu`.`courses`
(`name`, `ects`, `tea_id`)
VALUES
('Bazy Danych', 6, (SELECT `tea_id` FROM `teachers` WHERE `last_name` = 'Minge')),
('Mikoroekonomia', 5, (SELECT `tea_id` FROM `teachers` WHERE `last_name` = 'Boczek')),
('Matematyka', 7, 3);

-- zad 7
-- Zarejestruj pierwszego ucznia do dwóch przedmiotów
INSERT INTO `czyzewska_edu`.`course_enrollments` (`stu_id`, `cou_id`, `enroll_date`)
VALUES (1, 1,curdate()), (1, 2,curdate());

-- Zarejestruj drugiego ucznia do trzech przedmiotów
INSERT INTO `czyzewska_edu`.`course_enrollments` (`stu_id`, `cou_id`, `enroll_date`)
VALUES (2, 1,curdate()), (2, 2,curdate()), (2, 3,curdate());

-- Zarejestruj trzeciego ucznia do jednego przedmiotu
INSERT INTO `czyzewska_edu`.`course_enrollments` (`stu_id`, `cou_id`, `enroll_date`)
VALUES (3, 1,curdate());

SELECT * FROM `czyzewska_edu`.`course_enrollments`;

-- zad 9
ALTER TABLE `czyzewska_edu`.`course_enrollments`
DROP FOREIGN KEY `cou_id`;

-- zad 10
ALTER TABLE `czyzewska_edu`.`course_enrollments`
ADD CONSTRAINT `fk_cou_id_courses`
FOREIGN KEY (`cou_id`)
REFERENCES `czyzewska_edu`.`courses` (`cou_id`)
ON DELETE CASCADE;

-- zad 11
select * from course_enrollments;
-- zad 12
DELETE FROM `czyzewska_edu`.`courses`
WHERE `name` = 'Mikroekonomia';
select * from courses;