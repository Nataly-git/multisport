USE Multisport;

CALL usp_parse_json_predefined_card_types('[
  {
    "type": "Multisport plus",
    "price": "500",
    "maxVisitsNumber": "5"
  },
  {
    "type": "Multisport classic",
    "price": "300",
    "maxVisitsNumber": "3"
  },
  {
    "type": "Multisport light",
    "price": "100",
    "maxVisitsNumber": "1"
  }
]');