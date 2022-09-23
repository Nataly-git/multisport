USE Multisport;

CALL usp_AddForeignKey('rating', 'FK_rating_user', 'user_id',
                       'user', 'user_id');

CALL usp_AddForeignKey('rating', 'FK_rating_sportclub', 'sportclub_id',
                       'sportclub', 'sportclub_id');