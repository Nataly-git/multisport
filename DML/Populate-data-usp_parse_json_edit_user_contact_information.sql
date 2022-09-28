USE Multisport;

CALL usp_parse_json_edit_user_contact_information('{
  "user": {
    "email": "anton_antonov@gmail.com"
  },
  "contacts": {
    "street": "Kozlova",
    "building": "11",
    "apartments": "1"
  }
}');

CALL usp_parse_json_edit_user_contact_information('{
  "user": {
    "email": "ivan_ivanov@gmail.com"
  },
  "contacts": {
    "phoneNumber": "+100770922"
  }
}');
