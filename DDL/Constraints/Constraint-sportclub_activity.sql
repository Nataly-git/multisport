USE Multisport;

CALL usp_addUniqueKey('sportclub_activity', 'AK_sportclub_id_activity_id', 'sportclub_id, activity_id');

CALL usp_AddForeignKey('sportclub_activity', 'FK_sportclub_activity_sportclub', 'sportclub_id',
                       'sportclub', 'sportclub_id');

CALL usp_AddForeignKey('sportclub_activity', 'FK_sportclub_activity_activity', 'activity_id',
                       'activity', 'activity_id');