/**
Author: Joshua Murithi
Github: https://github.com/murithijoshua
Function: Mlab de-identifier script
**/
--  random client ID, and random created_at and Updated_at
update results
set created_at=created_at - interval '5 years',
updated_at=updated_at-interval '5 years',
client_id=CAST(1000000000 + floor(random() * 9000000000) AS bigint);
