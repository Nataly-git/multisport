USE Multisport;

CALL usp_parse_json_predefined_activities('[
  {
    "name": "gym"
  },
  {
    "name": "tennis"
  },
  {
    "name": "sauna"
  },
  {
    "name": "swimming pool"
  },
  {
    "name": "aerobics"
  }
]');