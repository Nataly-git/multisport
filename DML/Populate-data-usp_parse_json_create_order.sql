USE Multisport;

CALL usp_parse_json_create_order('{
  "order": {
    "date": "2022-08-20",
    "orderStatus": {
      "status": "created"
    }
  },
  "user": {
    "email": "anton_antonov@gmail.com"
  },
  "cardType": {
    "type": "Multisport light"
  }
}');

CALL usp_parse_json_create_order('{
  "order": {
    "date": "2022-09-20",
    "orderStatus": {
      "status": "created"
    }
  },
  "user": {
    "email": "anton_antonov@gmail.com"
  },
  "cardType": {
    "type": "Multisport light"
  }
}');

CALL usp_parse_json_create_order('{
  "order": {
    "date": "2022-09-19",
    "orderStatus": {
      "status": "created"
    }
  },
  "user": {
    "email": "ivan_ivanov@gmail.com"
  },
  "cardType": {
    "type": "Multisport plus"
  }
}');

CALL usp_parse_json_create_order('{
  "order": {
    "date": "2022-09-15",
    "orderStatus": {
      "status": "created"
    }
  },
  "user": {
    "email": "petr_petrov@gmail.com"
  },
  "cardType": {
    "type": "Multisport classic"
  }
}');