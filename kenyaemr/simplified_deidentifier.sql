drop table if exists random_names;

CREATE TABLE `random_names` (
	`rid` int(11) NOT NULL auto_increment,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY  (`rid`),
	UNIQUE KEY `name` (`name`),
	UNIQUE KEY `rid` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- make the randome names table hold all unique first/middle/last names
insert into random_names (name, rid) select distinct(trim(given_name)) as name, null from person_name where given_name is not null and not exists (select * from random_names where name = trim(given_name));
insert into random_names (name, rid) select distinct(trim(middle_name)) as name, null from person_name where middle_name is not null and not exists (select * from random_names where name = trim(middle_name));
insert into random_names (name, rid) select distinct(trim(family_name)) as name, null from person_name where family_name is not null and not exists (select * from random_names where name = trim(family_name));

drop procedure if exists randomize_names;
delimiter //
create procedure randomize_names()
begin
	set @size = (select max(person_name_id) from person_name);
	set @start = 0;
	-- if stepsize is increased, you should increase "limit 300" below as well
	set @stepsize = 300;
	while @start < @size do
		update
			person_name
		set
			given_name = (select
									name
								from
									(select
										rid
										from
										random_names
										order by
										rand()
										limit 300
									) rid,
									random_names rn
								where
									rid.rid = rn.rid
								order by
									rand()
								limit 1
							),
						middle_name = given_name,
						family_name = middle_name
		where
			person_name_id between @start and (@start + @stepsize);

		set @start = @start + @stepsize +1;
	end while;
end;
//
delimiter ;
call randomize_names();
drop procedure if exists randomize_names;


update
	person_address
set
	address1 = concat(person_id, ' address1')/**
Person_attribute_type_id   Name
------------------------   -----
4                          Mother's Name
8                          Telephone contact
9                          Next of kin contact
10                         Next of kin relationship
11                         Next of kin address
12                         Next of kin name
13                         National Id Number
18                         Guardian First Name
 */
update person_attribute set value=replace(value,'7','1') where  person_attribute_type_id in (8,9,13);
update person_attribute set value=replace(value,'0','9') where  person_attribute_type_id in (8,9,13);
update person_attribute set value=replace(value,'3','0') where  person_attribute_type_id in (8,9,13);
update person_attribute set value=replace(value,'2','8') where  person_attribute_type_id in (8,9,13);
update person_attribute set value=replace(value,'4','6') where  person_attribute_type_id in (8,9,13);
update person_attribute set value=replace(value,'8','3') where  person_attribute_type_id in (8,9,13);
update person_attribute set value='Test' where person_attribute_type_id = 12;

/**
National ID
 */
update person_attribute set value=replace(value,'7','1') where  person_attribute_type_id in (8,15);
update person_attribute set value=replace(value,'0','9') where  person_attribute_type_id in (8,15);
update person_attribute set value=replace(value,'3','0') where  person_attribute_type_id in (8,15);
update person_attribute set value=replace(value,'2','8') where  person_attribute_type_id in (8,15);
update person_attribute set value=replace(value,'4','6') where  person_attribute_type_id in (8,15);
update person_attribute set value=replace(value,'8','3') where  person_attribute_type_id in (8,15);

/**
Patient Phone Number
 */
update patient_identifier set identifier=replace(identifier,'2','5') where identifier_type=5;
update patient_identifier set identifier=replace(identifier,'0','9') where identifier_type=5;
update patient_identifier set identifier=replace(identifier,'4','7') where identifier_type=5;
update patient_identifier set identifier=replace(identifier,'3','0') where identifier_type=5;
update patient_identifier set identifier=replace(identifier,'1','8') where identifier_type=5;
update patient_identifier set identifier=replace(identifier,'5','0') where identifier_type=5;
update 	address2 = concat(person_id, ' address2'),
	latitude = null,
	longitude = null;

update location set name = concat('Location-', location_id);
/* nupi*/
update patient_identifier set identifier=replace(identifier,'2','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'0','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'4','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'3','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'1','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'5','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'6','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'M','X') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'O','X') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'H','X') where identifier_type=9;

# ccc numbers
# Patient Clinic Number
update patient_identifier set identifier= Replace(identifier, Substring(identifier, 1, 2), 'XXX') where identifier_type=4;
# Unique Patient Number
update patient_identifier set identifier= Replace(identifier, Substring(identifier, 1, 2), 'XXX') where identifier_type=6;
# OpenMRS ID
update patient_identifier set identifier= Replace(identifier, Substring(identifier, 1, 2), 'XXX') where identifier_type=3;
