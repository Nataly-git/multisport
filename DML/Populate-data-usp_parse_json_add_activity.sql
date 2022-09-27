USE Multisport;

CALL usp_parse_json_add_activity('{
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "duration": "1.20",
  "activity": {
    "name": "swimming pool"
  }
}');

CALL usp_parse_json_add_activity('{
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  },
  "duration": "2.00",
  "activity": {
    "name": "aerobics"
  }
}');