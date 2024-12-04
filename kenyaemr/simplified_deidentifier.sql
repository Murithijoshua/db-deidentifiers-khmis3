use openmrs;
DROP function if exists generate_fname;
DELIMITER $$
CREATE FUNCTION generate_fname () RETURNS varchar(255) DETERMINISTIC
BEGIN
	RETURN ELT(FLOOR(1 + (RAND() * (100-1))), "James","Mary","John","Patricia","Robert","Linda","Michael","Barbara","William","Elizabeth","David","Jennifer","Richard","Maria","Charles","Susan","Joseph","Margaret","Thomas","Dorothy","Christopher","Lisa","Daniel","Nancy","Paul","Karen","Mark","Betty","Donald","Helen","George","Sandra","Kenneth","Donna","Steven","Carol","Edward","Ruth","Brian","Sharon","Ronald","Michelle","Anthony","Laura","Kevin","Sarah","Jason","Kimberly","Matthew","Deborah","Gary","Jessica","Timothy","Shirley","Jose","Cynthia","Larry","Angela","Jeffrey","Melissa","Frank","Brenda","Scott","Amy","Eric","Anna","Stephen","Rebecca","Andrew","Virginia","Raymond","Kathleen","Gregory","Pamela","Joshua","Martha","Jerry","Debra","Dennis","Amanda","Walter","Stephanie","Patrick","Carolyn","Peter","Christine","Harold","Marie","Douglas","Janet","Henry","Catherine","Carl","Frances","Arthur","Ann","Ryan","Joyce","Roger","Diane");
END$$

DELIMITER ;
--
-- middle name generator
--
DROP function if exists generate_mname;
DELIMITER $$
CREATE FUNCTION generate_mname () RETURNS varchar(255) DETERMINISTIC
BEGIN
	RETURN ELT(FLOOR(1 + (RAND() * (100-1))), "James","Mary","John","Patricia","Robert","Linda","Michael","Barbara","William","Elizabeth","David","Jennifer","Richard","Maria","Charles","Susan","Joseph","Margaret","Thomas","Dorothy","Christopher","Lisa","Daniel","Nancy","Paul","Karen","Mark","Betty","Donald","Helen","George","Sandra","Kenneth","Donna","Steven","Carol","Edward","Ruth","Brian","Sharon","Ronald","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes");
END$$
DELIMITER ;

-- lastname generator

DROP function if exists generate_lname;
DELIMITER $$
CREATE FUNCTION generate_lname () RETURNS varchar(255) DETERMINISTIC
BEGIN
	RETURN ELT(FLOOR(1 + (RAND() * (100-1))), "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes");
END$$
DELIMITER ;
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
			given_name =generate_fname(),
            middle_name = generate_mname(),
            family_name = generate_lname()
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
	address1 = concat(person_id, ' address1');
/**
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
update patient_identifier set identifier=replace(identifier,'5','0') where identifier_type=5


/* nupi*/
update patient_identifier set identifier=replace(identifier,'2','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'0','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'4','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'3','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'1','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'5','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'6','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'M','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'O','0') where identifier_type=9;
update patient_identifier set identifier=replace(identifier,'H','0') where identifier_type=9;
# e59c9a6664d7
#  next of kin
update person_attribute set value='test test' where person_attribute_type_id = 11;
# ccc numbers
# Patient Clinic Number
# update patient_identifier set identifier= Replace(identifier, Substring(identifier, 1, 2), '0X') where identifier_type=4;
# Unique Patient Number
# update patient_identifier set identifier= Replace(identifier, Substring(identifier, 1, 2), '0XX') where identifier_type=6;
update patient_identifier set identifier=replace(identifier,'H','ST') where identifier_type=10;
update patient_identifier set identifier=replace(identifier,'M','T') where identifier_type=10;
update patient_identifier set identifier=replace(identifier,'O','E') where identifier_type=10;
update patient_identifier set identifier=replace(identifier,'H','ST') where identifier_type=10;

// csr endpoints
update global_property set property_value = 'partner.test.client' where property =  'kenyaemr.client.registry.oath2.client.id';
update global_property set property_value = 'partnerTestPwd' where property =  'kenyaemr.client.registry.oath2.client.secret';
update global_property set property_value = 'DHP.Gateway DHP.Partners' where property =  'kenyaemr.client.registry.oath2.scope';
update global_property set property_value = 'https://dhpstagingapi.health.go.ke/partners/registry' where property =  'kenyaemr.client.registry.post.api';
update global_property set property_value = 'https://dhpidentitystagingapi.health.go.ke/connect/token' where property =  'kenyaemr.client.registry.token.url';
update global_property set property_value = 'https://dhpstagingapi.health.go.ke/partners/registry/search/upi' where property =  'kenyaemr.client.registry.query.upi.api';
update global_property set property_value = 'https://dhpstagingapi.health.go.ke/partners/registry/search' where property =  'kenyaemr.client.registry.get.api';
update global_property set property_value = '' where property =  'kenyaemril.fhir.server.url';
update global_property set property_value = '' where property =  'interop.system.url.configuration';
drop procedure if exists randomize_name_referral;
create procedure randomize_name_referral()
begin
	set @size = (select max(id) from expected_transfer_ins);
	set @start = 0;
	-- if stepsize is increased, you should increase "limit 300" below as well
	set @stepsize = 300;
	while @start < @size do
		update
			expected_transfer_ins
		set
			first_name = generate_mname(),
            middle_name = generate_lname(),
            last_name = generate_fname()
		where
			id between @start and (@start + @stepsize);

		set @start = @start + @stepsize +1;
	end while;
end;
delimiter ;
call randomize_name_referral();

update expected_transfer_ins set nupi=replace(nupi,'H','ST');
update expected_transfer_ins set nupi=replace(nupi,'M','T');
update expected_transfer_ins set nupi=replace(nupi,'O','E');
update expected_transfer_ins set nupi=replace(nupi,'H','ST');
