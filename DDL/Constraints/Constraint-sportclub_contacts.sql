USE Multisport;

CALL usp_addUniqueKey('sportclub_contacts', 'AK_sportclub_contacts_sportclub_id', 'sportclub_id');

CALL usp_AddForeignKey('sportclub_contacts', 'FK_sportclub_contacts_sportclub', 'sportclub_id',
                       'sportclub', 'sportclub_id');