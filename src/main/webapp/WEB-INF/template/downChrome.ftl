<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>URL过滤</title>
        <link type="text/css" rel="stylesheet/less" href="${request.contextPath}/static/css/style.less">
        <style>
            .float-right{
                float:right
                }
            .float-right input[type=button]{
                height:32px;
                line-height:32px;
                background:#fff;
                border:1px solid #ccc;
                cursor:pointer;
                outline:none;
            }
        </style>
        <script>
          function downChrome64() {     //64位谷歌下载地址
            location.href = "http://7dx.pc6.com/ty5/chrome.zip";
          }
          function downChrome32() {     //32位谷歌下载地址
            location.href = "http://sw.bos.baidu.com/sw-search-sp/software/49313156f695c/ChromeStandalone_60.0.3112.101_Setup.exe";
          }
        </script>
    </head>
    <body>
        <div id="content">
            <h1 class="warning">不是谷歌浏览器</h1>
            <div class="partition"> <span class="partition_left" style="width:150px;"></span> </div>
            <p class="b_distance">本系统需要使用谷歌浏览器启动，若本地存在谷歌浏览器，请使用谷歌浏览器启动，若不存在，请点击下面链接下载。</p>
            <div class='float-right'>
                <input type='button' value='下载谷歌浏览器/32位' onclick="downChrome32()">
                <input type='button' value='下载谷歌浏览器/64位' onclick="downChrome64()">
            </div>
        </div>
    </body>
</html>