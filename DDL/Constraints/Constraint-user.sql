USE Multisport;

CALL usp_addUniqueKey('user', 'AK_user_email', 'email');

CALL usp_AddForeignKey('user', 'FK_user_guest', 'guest_id',
                       'guest', 'guest_id');