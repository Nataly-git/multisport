USE Multisport;

CALL usp_addUniqueKey('guest', 'AK_guest_time_browser_ip_device', 'time, browser, ip, device');
