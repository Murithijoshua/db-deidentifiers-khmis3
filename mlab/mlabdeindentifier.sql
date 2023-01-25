/**
Author: Joshua Murithi
Github: https://github.com/murithijoshua
Function: Mlab de-identifier script
**/
/** 
randomizing client ID,
reducing the  created_at and Updated_at dates by 5 years


**/
update results
set created_at=created_at - interval '5 years',
updated_at=updated_at-interval '5 years',
client_id=CAST(1000000000 + floor(random() * 9000000000) AS bigint);
