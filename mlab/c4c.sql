UPDATE users SET users.msisdn = Replace(msisdn, Substring(msisdn, 1, 4), 'XXXX') where msisdn like '254%';
UPDATE users SET users.email = Replace(email, Substring(email, 1, 4), 'XXX') where email like '%@%';
