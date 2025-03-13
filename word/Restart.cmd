@Echo off
color 1f
powercfg /h off
REG DELETE HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /va /f /reg:64
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "00000000" /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\services\BITS" /v "Start" /t REG_DWORD /d "00000004" /f /reg:64
REG ADD "HKLM\SYSTEM\CurrentControlSet\services\wuauserv" /v "Start" /t REG_DWORD /d "00000004" /f /reg:64
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v "BackupCount" /t REG_DWORD /d "00000002" /f /reg:64
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager\LastKnownGood" /v "Enabled" /t REG_DWORD /d "00000001" /f /reg:64
bcdedit /set {current} bootmenupolicy legacy
cls
REG ADD "HKCR\.bmp" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKCR\.gif" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKCR\.ico" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKCR\.jpeg" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKCR\.jpg" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKCR\.png" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REG ADD "HKCR\.tiff" /v "" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
cls
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
cls
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\.NET Framework"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Active Directory Rights Management Services Client"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\AppID"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Application Experience"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\ApplicationData"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\AppxDeploymentClient"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Autochk"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Bluetooth"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\CertificateServicesClient"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Chkdsk"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Clip"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\CloudExperienceHost"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Customer Experience Improvement Program"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Data Integrity Scan"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Defrag"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Device Setup"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Device Information"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\DeviceDirectoryClient"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Diagnosis"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\DiskCleanup"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\DiskDiagnostic"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\DiskFootprint"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\DUSM"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\EDP"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\EnterpriseMgmt"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\ErrorDetails"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Feedback"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\File Classification Infrastructure"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\FileHistory"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\LanguageComponentsInstaller"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\License Manager"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Live"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Location"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Maps"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Offline Files"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\SettingSync"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Maintenance"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Management"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\MemoryDiagnostic"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Mobile Broadband Accounts"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\NlaSvc"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\PI"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\PLA"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\RecoveryEnvironment"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Registry"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\RemoteApp and Desktop Connections Update"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\RemoteAssistance"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\RetailDemo"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Servicing"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Setup"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\SharedPC"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\SpacePort"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Speech"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Storage Tiers Management"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Subscription"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\SyncCenter"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Sysmain"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\SystemRestore"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\TaskScheduler"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Time Synchronization"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Time Zone"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\TPM"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\UpdateOrchestrator"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\WCM"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\WDI"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Activation Technologies"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\WindowsBackup"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Defender"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Error Reporting"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Windows Media Sharing"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\WindowsUpdate"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\WOF"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Work Folders"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\Workplace Join"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\Windows\WS"
rd /S /Q "%SystemRoot%\System32\Tasks\Microsoft\XblGameSave"
cls

REM -- Disables Aero Shake
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v NoWindowMinimizingShortcuts /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v NoWindowMinimizingShortcuts /t REG_DWORD /d 1 /f

REM -- Enables Transparency, sets accent color, activates window/taskbar colorization
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v ColorPrevalence /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v AccentColor /t REG_DWORD /d 0x00d77800 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v Composition /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v ColorizationColor /t REG_DWORD /d 0xc40078d7 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v ColorizationAfterglow /t REG_DWORD /d 0xc40078d7 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v ColorizationGlassAttribute /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableWindowColorization /t REG_DWORD /d 1 /f

REM -- Enables an additional security feature for Windows Defender
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v MpEnablePus /t REG_DWORD /d 1 /f

REM -- Disables Driver Signing
reg add "HKLM\Software\Microsoft\Driver Signing" /v "Policy" /t REG_BINARY /d "01" /f

REM -- Sets Logon Background to accent color
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d 1 /f

REM -- Removes Pin to start from context menus
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\mscfile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1

REM -- Disables various Telemetry and data collection/synchronization settings (ShutUp10 equivalent)
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "DontSendAdditionalData" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\Windows Error Reporting" /v "DontShowUI" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "DontShowUI" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t "REG_DWORD" /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t "REG_DWORD" /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t "REG_DWORD" /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Biometrics" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\MRT" /v DontReportInfectionInformation /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v DisableSensors /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Personalization" /v NoLockScreenCamera /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v SpynetReporting /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v SubmitSamplesConsent /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\WMDRM" /v DisableOnline /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\System\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v SystemSettingsDownloadMode /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f > NUL 2>&1
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v Value /t REG_SZ /d Deny /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v SyncPolicy /t REG_DWORD /d 5 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\lfsvc\Service\Configuration" /v Status /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v SensorPermissionState /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v Value /t REG_SZ /d Deny /f

REM -- Disables Cortana and web search
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f

REM -- Sets default view for explorer to "This PC"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

REM -- Hides Task View Button
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f

REM -- Disable Tips, Notifications and Notification Center
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SoftLanding" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_SUPRESS_TOASTS_WHILE_DUPLICATING" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f

REM -- Disables security warnings
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "DefaultFileTypeRisk" /t REG_DWORD /d 1808 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d 1 /f

REM -- Sets timeout for the System to end processes/services after the user tries to shutdown
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "10000" /f
reg add "HKLM\System\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "10000" /f

REM -- Improves responsiveness of your system by removing delays
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d 0 /f

REM -- Disables automatic maintenance
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f

REM -- Disables Encrypting File System
reg add "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableEncryption" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

REM -- Disables Active Desktop
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ForceActiveDesktopOn" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoActiveDesktop" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoActiveDesktopChanges" /t REG_DWORD /d 1 /f

REM -- Disables Smart Screen
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t "REG_DWORD" /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t "REG_DWORD" /d 0 /f

REM -- Disables Lockscreen (no longer working on Windows Core/Pro 1607)
reg add "HKLM\Software\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f

REM -- Disables Wifi Sense
reg add "HKLM\Software\Microsoft\WcmSvc\wifinetworkmanager\config" /v AutoConnectAllowedOEM /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f

REM -- Disables sending files to encrypted drives
reg add "HKLM\Software\Policies\Microsoft\Windows\EnhancedStorageDevices" /v "TCGSecurityActivationDisabled" /t REG_DWORD /d 0 /f

REM -- Disables OneDrive Sync
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f

REM -- Disables settings synchronization
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Steps-Recorder" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f

REM -- Increases wallpaper image quality
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 100 /f

REM -- Disables automatic update for downloaded maps
reg add "HKLM\Software\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdateMapData" /t "REG_DWORD" /d 0 /f

REM -- Removes OneDrive from autorun and explorer
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f > NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > NUL 2>&1

REM -- Deactivate screensaver
reg add "HKCU\Control Panel\Desktop" /v "ScreenSaveActive" /t REG_SZ /d 0 /f

REM -- Disables GameDVR
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f

REM -- Removes frequent/recent entries from explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f

REM -- Disables CD/DVD/USB autorun
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f

REM -- Sets computers active hours to 10-22h
reg add "HKLM\Software\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursStart" /t REG_DWORD /d "10" /f
reg add "HKLM\Software\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursEnd" /t REG_DWORD /d "22" /f

REM -- Removes "Scan with Windows defender" from context menu (only works if WD is disabled)
reg delete "HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\EPP" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\EPP" /f > NUL 2>&1

REM -- Disables reveal password button
reg add "HKLM\Software\Policies\Microsoft\Windows\CredUI" /v DisablePasswordReveal /t REG_DWORD /d 1 /f

REM -- Internet Explorer / Microsoft Edge optimizations
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Suggested Sites" /v Enabled /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer" /v AllowServicePoweredQSA /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v AutoSuggest /t REG_SZ /d no /f
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v NoUpdateCheck /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v PolicyDisableGeolocation /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d no /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d no /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f

REM -- Prevent device metadata retrieval from the Internet
reg add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f

REM -- Disable Windows Updates for Malicious Software Removal Tool
reg add "HKLM\Software\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

REM -- Disables Aero Peek
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f

REM -- Disables Windows Telemetry services
sc config diagnosticshub.standardcollector.service start= disabled
net stop diagnosticshub.standardcollector.service > NUL 2>&1
sc config DiagTrack start= disabled
net stop DiagTrack > NUL 2>&1
sc config dmwappushservice start= disabled
net stop dmwappushservice > NUL 2>&1

REM -- Disables OneDrive service
sc config OneSyncSvc start= disabled
net stop OneSyncSvc > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\OneSyncSvc_Session1" /v "Start" /t REG_DWORD /d 4 /f > NUL 2>&1

REM -- Disables RetailDemo service
sc config RetailDemo start=disabled
net stop RetailDemo > NUL 2>&1

REM -- Disables Windows Search service
sc config WSearch start= disabled
net stop WSearch > NUL 2>&1
del "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1

REM -- Disables Adobe services if installed
sc config AdobeARMservice start= disabled > NUL 2>&1
net stop AdobeARMservice > NUL 2>&1
sc config AGSService start= disabled > NUL 2>&1
net stop AGSService > NUL 2>&1

REM -- Disables OneDrive

taskkill /F /IM OneDrive.exe /T
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f > NUL 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f
sc config OneSyncSvc start= disabled
net stop OneSyncSvc > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 4 /f > NUL 2>&1
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > NUL 2>&1

REM -- Tweak Services TNBT

sc config diagnosticshub.standardcollector.service start= disabled
net stop diagnosticshub.standardcollector.service > NUL 2>&1
sc config DiagTrack start= disabled
net stop DiagTrack > NUL 2>&1
sc config dmwappushservice start= disabled
net stop dmwappushservice > NUL 2>&1
sc config OneSyncSvc start= disabled
net stop OneSyncSvc > NUL 2>&1
reg add "HKLM\System\CurrentControlSet\Services\OneSyncSvc_Session1" /v "Start" /t REG_DWORD /d 4 /f > NUL 2>&1
del "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1
sc config AdobeARMservice start= disabled
net stop AdobeARMservice > NUL 2>&1
sc config AGSService start= disabled
net stop AGSService > NUL 2>&1
cls


reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "setup_cleanup" /d "%comspec% /c rd /s /q %SystemDrive%\Users\defaultuser0\"
shutdown.exe /r /f /t 10 /c "Restart"
del /F /Q %0
exit

