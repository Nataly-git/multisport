USE Multisport;

DROP TABLE IF EXISTS user_contacts;

CREATE TABLE user_contacts
(
    user_contacts_id    INT      	   NOT NULL AUTO_INCREMENT,
    user_id				INT 		   NOT NULL,
    apartments  	    VARCHAR(50)    ,
    city       			VARCHAR(30)    NOT NULL,
    street   			VARCHAR(30)    NOT NULL,
    building   			INT		       NOT NULL,
    phone_number  		VARCHAR(17)    NOT NULL,
    
	CONSTRAINT PK_user_contacts PRIMARY KEY
	(
		user_contacts_id
	)
);