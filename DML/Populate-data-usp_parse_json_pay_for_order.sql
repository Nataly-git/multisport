USE Multisport;

CALL usp_parse_json_pay_for_order('{
  "card": {
    "number": "Light12345",
    "startDate": "2022-09-01"
  },
  "order": {
    "user": {
      "email": "anton_antonov@gmail.com"
    },
    "date": "2022-08-20",
    "orderStatus": {
      "status": "paid"
    }
  },
  "payment": {
    "date": "2022-08-20",
    "method": "Card"
  }
}');

CALL usp_parse_json_pay_for_order('{
  "card": {
    "number": "Light12346",
    "startDate": "2022-10-01"
  },
  "order": {
    "user": {
      "email": "anton_antonov@gmail.com"
    },
    "date": "2022-09-20",
    "orderStatus": {
      "status": "paid"
    }
  },
  "payment": {
    "date": "2022-09-21",
    "method": "Card"
  }
}');

CALL usp_parse_json_pay_for_order('{
  "card": {
    "number": "Plus12345",
    "startDate": "2022-09-01"
  },
  "order": {
    "user": {
      "email": "ivan_ivanov@gmail.com"
    },
    "date": "2022-08-21",
    "orderStatus": {
      "status": "paid"
    }
  },
  "payment": {
    "date": "2022-09-19",
    "method": "Card"
  }
}');

CALL usp_parse_json_pay_for_order('{
  "card": {
    "number": "Classic12345",
    "startDate": "2022-10-01"
  },
  "order": {
    "user": {
      "email": "petr_petrov@gmail.com"
    },
    "date": "2022-09-15",
    "orderStatus": {
      "status": "paid"
    }
  },
  "payment": {
    "date": "2022-09-16",
    "method": "Card"
  }
}');