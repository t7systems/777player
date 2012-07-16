<html>
  <head>
    <script type="text/javascript" src="swfobject.js"></script>
    <script type="text/javascript" src="jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
      var swf = false;
      function swfReady(status){
        try {
          swfDebug("Status: " + status );
          swf = true;
        } catch(e) {
          jsDebug("Error: " + e );
        }
      }
      function swfPlay(clip){
        try {
          if(swf == true){
            var flashMovie = swfobject.getObjectById("777player");
            flashMovie.playInterlude(clip);
          }
        } catch(e) {
          jsDebug("Error: " + e );
        }
      }
      function swfClipStart(clip){
        try {
          if(swf == true){
            swfDebug("swfClipStart: " + clip );
          }
        } catch(e) {
          jsDebug("Error: " + e );
        }
      }
      function swfClipStop(clip){
        try {
          if(swf == true){
            swfDebug("swfClipStop: " + clip );
          }
        } catch(e) {
          jsDebug("Error: " + e );
        }
      }
      function swfDebug(info){
        console.log('[777playerSWF] ' + info );
      }
      function jsDebug(info){
        console.log('[777playerJS] ' + info );
      }
    </script>
  </head>
  <body BGCOLOR="#888888" TEXT="#FFFFFF" LINK="#0000FF" VLINK="#0000FF" ALINK="#0000FF">
    <div style="text-align: center ; ">

      <div id="flashContent">
        <script type="text/javascript">
          // <![CDATA[
          var width=320;
          var height=240;
          var flashVersion = "9.0.115";
          var movie = "777player.swf";
          var movieName = "777player";
          var bgColor = "#000000";
          var express = "expressinstall.swf";
          var replaceDiv = "777player";
          var flashvars = {};
          flashvars.poster = "poster.png";
          flashvars.clip = "video.mp4";
          flashvars.autoplay = "true";
          flashvars.loop = "true";
          flashvars.live = "false";
          flashvars.volume = "100";
          flashvars.swliveconnect="true"
          var params = {};
          params.bgcolor = bgColor;
          params.allowFullScreen = "true";
          params.allowScriptAccess = "always";
          params.swliveconnect="true"
          params.wmode= "transparent";
          var attributes = {};
          swfobject.embedSWF(movie, replaceDiv, width, height, flashVersion, express, flashvars, params, attributes);
          // ]]>
        </script>
        <div id="777player"></div>

        <div>
          <button onclick="swfPlay('interlude.mp4');">Interlude</button>
        </div>
      </div>

  </body>
</html>