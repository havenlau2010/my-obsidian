/*
 * version : 6.2.0.2179
 * resolution : 720*1280
 * description : 获取指定点颜色值示例
 */
define("version", "6.2.0.2886");
define("resolution", "720*1280");
define("requireVersion", "1.5.0.2865");

//获取主控设备对象
var device = Device.getMain();

//定义X,Y坐标点位置
var x = 550;
var y = 550;

//利用getPixelColorStr进行获取550,550这个点的颜色值
var Color = device.getPixelColorStr(x, y);
print("坐标点" + x + "," + y + "十六进制颜色是：" + Color);

//将十六进制颜色转换为10进制
Color = parseInt(Color, 16).toString(10);
print("坐标点" + x + "," + y + "十进制的颜色是：" + Color);    	    