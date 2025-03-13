//获取主控设备对象
var device = Device.getMain();

var runQQMusicAppName = "com.tencent.qqmusic";

var qqMuiscApp = device.closeApp(runQQMusicAppName);

if(qqMusicApp == 0 ){
    print('已经关闭')
}else{
    print('关闭失败')
}