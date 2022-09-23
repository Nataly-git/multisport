USE Multisport;

CALL usp_addUniqueKey('user_contacts', 'AK_user_contacts_user_id', 'user_id');

CALL usp_AddForeignKey('user_contacts', 'FK_user_contacts_user', 'user_id',
                       'user', 'user_id');