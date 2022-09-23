USE Multisport;

CALL usp_addUniqueKey('sportclub', 'AK_sportclub_email', 'email');

CALL usp_addUniqueKey('sportclub', 'AK_sportclub_name_city_street_building', 'name, city, street, building');

CALL usp_AddForeignKey('sportclub', 'FK_sportclub_guest', 'guest_id',
                       'guest', 'guest_id');