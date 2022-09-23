USE Multisport;

CALL usp_addUniqueKey('payment', 'AK_payment_order_id_date', 'order_id, date');

CALL usp_AddForeignKey('payment', 'FK_payment_order', 'order_id',
                       '`order`', 'order_id');