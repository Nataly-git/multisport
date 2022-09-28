USE Multisport;

CALL usp_parse_json_register_sportclub('{
  "guest": {
    "time": "2021-04-05 09:34:21",
    "browser": "Google Chrome",
    "ipAddress": "162.201.0.6",
    "device": "Iphone 14 pro"
  },
  "sportclub": {
    "email": "gym24@gmail.com",
    "name": "gym24",
    "password": "GymPassword24",
    "city": "Minsk",
    "street": "Pobediteley",
    "building": "7"
  },
  "contacts": {
    "workingHours": "From 10 am to 10 pm",
    "phoneNumber": "+123987465"
  },
  "cardTypes": [
    {
      "type": "Multisport plus"
    },
    {
      "type": "Multisport classic"
    }
  ],
  "activities": [
    {
      "activity": {
        "name": "gym"
      },
      "duration": "1.30"
    },
    {
      "activity": {
        "name": "sauna"
      },
      "duration": "2.00"
    }
  ]
}');

CALL usp_parse_json_register_sportclub('{
  "guest": {
    "time": "2021-04-11 06:43:18",
    "browser": "Google Chrome",
    "ipAddress": "162.192.0.6",
    "device": "Iphone 12 pro max"
  },
  "sportclub": {
    "email": "xfit_gym@gmail.com",
    "name": "Xfit",
    "password": "XPasswordFit",
    "city": "Minsk",
    "street": "Chapaeva",
    "building": "5"
  },
  "contacts": {
    "workingHours": "From 10 am to 10 pm",
    "phoneNumber": "+987654321"
  },
  "cardTypes": [
    {
      "type": "Multisport light"
    },
    {
      "type": "Multisport classic"
    }
  ],
  "activities": [
    {
      "activity": {
        "name": "tennis"
      },
      "duration": "1.30"
    },
    {
      "activity": {
        "name": "gym"
      },
      "duration": "2.00"
    }
  ]
}');

CALL usp_parse_json_register_sportclub('{
  "guest": {
    "time": "2021-05-11 06:44:18",
    "browser": "MOZZilla",
    "ipAddress": "162.192.0.5",
    "device": "Lenovo 5032"
  },
  "sportclub": {
    "email": "swim@gmail.com",
    "name": "Swimming pool",
    "password": "pass1",
    "city": "Minsk",
    "street": "Olshevskogo",
    "building": "1"
  },
  "contacts": {
    "workingHours": "From 8 am to 12 pm",
    "phoneNumber": "+3752988995533"
  },
  "cardTypes": [
    {
      "type": "Multisport light"
    },
    {
      "type": "Multisport classic"
    }
  ],
  "activities": [
    {
      "activity": {
        "name": "swimming pool"
      },
      "duration": "1.00"
    },
    {
      "activity": {
        "name": "sauna"
      },
      "duration": "4.00"
    }
  ]
}');


-- not executed
CALL usp_parse_json_register_sportclub('{
  "guest": {
    "time": "2021-08-12 06:44:18",
    "browser": "Google Chrome",
    "ipAddress": "192.211.2.12",
    "device": "Iphone 12 pro max"
  },
  "sportClub": {
    "email": "new_gmail@gmail.com",
    "password": "NewPassword",
    "name": "Xfit",
    "city": "Minsk",
    "street": "Chapaeva",
    "building": "5"
  },
  "contacts": {
    "phoneNumber": "+987654321",
    "workingHours": "From 10 am to 10 pm",
    "sportClub": {
      "email": "xfit_gym@gmail.com"
    }
  },
  "cardTypes": [
    {
      "type": "Multisport light"
    }
  ],
  "activities": [
    {
      "activity": {
        "name": "tennis"
      },
      "duration": "1.30"
    }
  ]
}');


-- not executed
CALL usp_parse_json_register_sportclub('{
  "guest": {
    "time": "2021-12-05 09:34:21",
    "browser": "Google Chrome",
    "ipAddress": "162.201.0.6",
    "device": "Iphone 14 pro"
  },
  "sportClub": {
    "email": "gym24@gmail.com",
    "name": "NotGym24",
    "password": "NotGymPassword24",
    "city": "Minsk",
    "street": "Pobediteley",
    "building": "7"
  },
  "contacts": {
    "phoneNumber": "+123987465",
    "workingHours": "From 10 am to 10 pm"
  },
  "cardTypes": [
    {
      "type": "Multisport plus"
    }
  ],
  "activities": [
    {
      "activity": {
        "name": "gym"
      },
      "duration": "1.30"
    }
  ]
}');


