USE Multisport;

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-09-14 09:40:25"
  },
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  },
  "activity": {
    "name": "gym"
  },
  "card": {
    "number": "Light12345"
  },
  "user": {
    "email": "anton_antonov@gmail.com"
  }
}');

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-02 10:41:28"
    },
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  },
  "activity": {
    "name": "gym"
  },
  "card": {
    "number": "Plus12345"
  },
  "user": {
    "email": "ivan_ivanov@gmail.com"
  }
}');

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-03 10:41:28"
    },
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  },
  "activity": {
    "name": "aerobics"
  },
  "card": {
    "number": "Plus12345"
  },
  "user": {
    "email": "ivan_ivanov@gmail.com"
  }
}');

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-07 12:00:13"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "sauna"
  },
  "card": {
    "number": "Classic12345"
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  }
}');

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-11-07 15:12:13"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "sauna"
  },
  "card": {
    "number": "Classic12345"
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  }
}');

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-04 08:00:13"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "gym"
  },
  "card": {
    "number": "Classic12345"
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  }
}');

CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-07 12:40:55"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "sauna"
  },
  "card": {
    "number": "Classic12345"
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  }
}');


-- not executed
CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-09 07:23:20"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "aerobics"
  },
  "card": {
    "number": "Classic12345"
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  }
}');


-- not executed
CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-09-15 09:32:20"
  },
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "activity": {
    "name": "gym"
  },
  "card": {
    "number": "Light12345"
  },
  "user": {
    "email": "anton_antonov@gmail.com"
  }
}');


-- not executed
CALL usp_parse_json_visit('{
  "visit": {
    "dateTime": "2022-10-03 12:03:50"
    },
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  },
  "activity": {
    "name": "gym"
  },
  "card": {
    "number": "Plus12345"
  },
  "user": {
    "email": "anton_antonov@gmail.com"
  }
}');