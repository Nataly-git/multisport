USE Multisport;

CALL usp_parse_json_register_user('{
  "guest": {
    "time": "2022-01-27 12:00:21",
    "browser": "Google Chrome",
    "ipAddress": "162.192.0.6",
    "device": "Iphone 13 pro max"
  },
  "user": {
    "email": "anton_antonov@gmail.com",
    "name": "Anton",
    "surname": "Antonov",
    "password": "AntonPasswordAntonov"
  },
  "contacts": {
    "apartments": "521",
    "city": "Minsk",
    "street": "Nezavisimosti",
    "building": "4",
    "phoneNumber": "+918273645"
  }
}');

CALL usp_parse_json_register_user('{
  "guest": {
    "time": "2021-04-05 09:34:21",
    "browser": "Google Chrome",
    "ipAddress": "162.192.0.6",
    "device": "Iphone 12 pro max"
  },
  "user": {
    "email": "ivan_ivanov@gmail.com",
    "name": "Ivan",
    "surname": "Ivanov",
    "password": "IvanPasswordIvanov"
  },
  "contacts": {
    "apartments": "414",
    "city": "Minsk",
    "street": "Chapaeva",
    "building": "5",
    "phoneNumber": "+123456789"
  }
}');

CALL usp_parse_json_register_user('{
  "guest": {
    "time": "2022-07-22 10:41:12",
    "browser": "Microsoft Edge",
    "ipAddress": "178.192.12.0",
    "device": "Iphone 14 Pro Max"
  },
  "user": {
    "email": "petr_petrov@gmail.com",
    "name": "Petr",
    "surname": "Petrov",
    "password": "PetrPasswordPetrov"
  },
  "contacts": {
    "city": "Minsk",
    "street": "Gurskogo",
    "building": "44",
    "phoneNumber": "+333123542"
  }
}');

CALL usp_parse_json_register_user('{
  "guest": {
    "time": "2022-07-22 10:41:12",
    "browser": "Safari",
    "ipAddress": "162.192.0.5",
    "device": "Iphone 4"
  },
  "user": {
    "email": "grisga_rulit@mail.ru",
    "name": "Grisha",
    "surname": "Vasechkin",
    "password": "mojpass"
  },
  "contacts": {
    "city": "Minsk",
    "street": "Loshitskaja",
    "building": "2",
    "phoneNumber": "+641654148"
  }
}');


-- not executed
CALL usp_parse_json_register_user('{
  "guest": {
    "time": "2022-33-34 12:00:21",
    "browser": "Opera",
    "ipAddress": "192.192.0.8",
    "device": "Iphone 11"
  },
  "user": {
    "email": "some_acc@gmail.com",
    "name": "Antonio",
    "surname": "Maharadja",
    "password": "password"
  },
  "contacts": {
    "apartments": "3",
    "city": "Grodno",
    "street": "Kastusia K.",
    "building": "5",
    "phoneNumber": "+51616165"
  }
}');


-- not executed
CALL usp_parse_json_register_user('{
  "guest": {
    "time": "2022-33-34 12:00:21",
    "browser": "Opera",
    "ipAddress": "192.192.0.8",
    "device": "Iphone 11"
  },
  "user": {
    "email": "some_acc@gmail.com",
    "name": "Antonio",
    "surname": "Maharadja",
    "password": "password"
  },
  "contacts": {
    "apartments": "3",
    "city": "Grodno",
    "street": "Kastusia K.",
    "building": "5",
    "phoneNumber": "+51616165"
  }
}');