# android_protect_data_partion
Android 方案偶尔会因为/data 分区本身异常损坏或者/data 分区在某种情况爆掉
1. 引起的无法正常开机启动同时不能进入recovery模式
2. data 分区爆掉后, 在android 正常情况下无法通过卸载app来减少data分区使用, 并且无法在setting 中进入recovery模式.

发生上述两种情况后, 机器对于用户来讲已经变砖.为了解决上述问题, 引入此CBB
1. 开机后, 如果data 分区异常, 无法挂载, 则3分钟后会强制进入recovery 模式
2. 如果正常开机, data 分区在某种状况下剩余空间少于50M则会强制重启, 进入recovery模式
