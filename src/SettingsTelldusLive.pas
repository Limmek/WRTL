unit SettingsTelldusLive;

interface

uses
System.SysUtils;

const
    API_URL = 'https://api.telldus.com'; { Use https://.... in production}
    ACCESS_TOKEN = '/oauth/accessToken';
    REQUEST_TOKEN = '/oauth/requestToken';
    AUTHORIZE_TOKEN= '/oauth/authorize';
    REQUEST_XML = '/xml';
    REQUEST_JSON = '/json';
    SENSOR_LIST = '/sensors/list';
    DEVICES_LIST = '/devices/list';
    SENSOR_INFO = '/sensor/info';
    DEVICE_ON = '/device/turnOn';
    DEVICE_OFF = '/device/turnOff';

    ABOUT_GIT = 'https://github.com/Limmek/WRTL';
    ABOUT_INFO = 'This application is used to call the TelldusLive API and remotely control your devices from any computer.';

    LOGFILE_EXT ='.txt';
    LOGFILE_FOLDER ='logs/';
    CONFIG_EXT='.ini';
    DEVICES_LIST_FILE = 'DeviceList.ini';
    SCHEDULE_FILE ='ScheduleList.ini';
var
    LOGGING: Boolean;


implementation

end.
