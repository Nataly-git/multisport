USE Multisport;

CALL usp_addUniqueKey('`order`', 'AK_order_date_user', 'date, user_id');

CALL usp_AddForeignKey('`order`', 'FK_order_user', 'user_id',
                       'user', 'user_id');

CALL usp_AddForeignKey('`order`', 'FK_order_status', 'status_id',
                       'order_status', 'status_id');

CALL usp_AddForeignKey('`order`', 'FK_order_card_type', 'card_type_id',
                       'card_type', 'card_type_id');