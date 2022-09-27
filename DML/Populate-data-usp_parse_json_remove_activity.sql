USE Multisport;

CALL usp_parse_json_remove_activity('{
  "sportClub": {
    "name": "xfit_gym@gmail.com"
  },
  "activity": {
    "name": "tennis"
  }
}');

CALL usp_parse_json_remove_activity('{
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "swimming pool"
  }
}');