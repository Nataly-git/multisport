USE Multisport;

CALL usp_addUniqueKey('card', 'AK_card_number', 'number');

CALL usp_addUniqueKey('card', 'AK_card_payment_id', 'payment_id');

CALL usp_AddForeignKey('card', 'FK_card_payment', 'payment_id',
                       'payment', 'payment_id');

CALL usp_AddForeignKey('card', 'FK_card_card_type', 'card_type_id',
                       'card_type', 'card_type_id');