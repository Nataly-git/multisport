USE Multisport;

CALL usp_parse_json_predefined_order_statuses('[
  {
    "status": "created"
  },
  {
    "status": "paid"
  }
]');