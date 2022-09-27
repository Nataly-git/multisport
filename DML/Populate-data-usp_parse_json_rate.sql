USE Multisport;

CALL usp_parse_json_rate('{
  "rating": {
    "rate": 1,
    "comment": "The worst gym ever!!"
  },
  "user": {
    "email": "anton_antonov@gmail.com"
  },
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  }
}');

CALL usp_parse_json_rate('{
  "rating": {
    "rate": 9,
    "comment": "The best gym!!!"
  },
  "user": {
    "email": "ivan_ivanov@gmail.com"
  },
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  }
}');

CALL usp_parse_json_rate('{
  "rating": {
    "rate": 7
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  }
}');

