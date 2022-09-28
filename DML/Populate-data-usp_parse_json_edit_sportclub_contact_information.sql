USE Multisport;

CALL usp_parse_json_edit_sportclub_contact_information('{
  "sportClub": {
    "email": "gym24@gmail.com"
  },
  "contacts": {
    "workingHours": "From 12 am to 10 pm"
  }
}');

CALL usp_parse_json_edit_sportclub_contact_information('{
  "sportClub": {
    "email": "xfit_gym@gmail.com"
  },
  "contacts": {
    "phoneNumber": "+377654321",
    "workingHours": "From 9 am to 10 pm"
  }
}');