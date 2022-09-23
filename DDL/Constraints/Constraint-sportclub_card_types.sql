USE Multisport;

CALL usp_AddForeignKey('sportclub_card_types', 'FK_sportclub_card_types_sportclub', 'sportclub_id',
                       'sportclub', 'sportclub_id');

CALL usp_AddForeignKey('sportclub_card_types', 'FK_sportclub_card_types_card_type', 'card_type_id',
                       'card_type', 'card_type_id');