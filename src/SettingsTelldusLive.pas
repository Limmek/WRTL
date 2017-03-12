unit SettingsTelldusLive;

interface


const
    API_URL = 'https://api.telldus.com'; // Use https in production
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

    DOWNLOAD_URL = 'https://github.com/Limmek/WRTL/releases/download/1.0/WinRemoteTelldusLive.exe';
    VERSION_URL = 'https://raw.githubusercontent.com/Limmek/WRTL/master/VERSION';
    ABOUT_GIT = 'https://github.com/Limmek/WRTL';
    ABOUT_INFO = 'This application is used to call the TelldusLive API and remotely control your devices from any computer.';

    LOGFILE_EXT ='.txt';
    LOGFILE_FOLDER ='logs/';
    CONFIG_EXT='.ini';
    DEVICES_LIST_FILE = 'DeviceList.ini';
    SCHEDULE_FILE ='ScheduleList.ini';
    HOTKEY_ENABLE_FILE ='HotkeysEnable.ini';
    HOTKEY_DISABLE_FILE ='HotkeysDisable.ini';


var
    LOGGING: Boolean;


implementation

end.
