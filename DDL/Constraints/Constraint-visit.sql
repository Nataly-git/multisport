USE Multisport;

CALL usp_addUniqueKey('visit', 'AK_visit_card_id_sportclub_activity_id', 'card_id, date_time');

CALL usp_AddForeignKey('visit', 'FK_visit_card', 'card_id',
                       'card', 'card_id');

CALL usp_AddForeignKey('visit', 'FK_visit_sportclub_activity', 'sportclub_activity_id',
                       'sportclub_activity', 'sportclub_activity_id');