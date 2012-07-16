import fl.video.FLVPlayback;
import flash.display.Loader;
import flash.events.Event;
import fl.video.VideoEvent;
import fl.video.VideoState;
import fl.video.VideoAlign;
import fl.video.FLVPlayback;
import flash.display.Loader;       
import flash.display.LoaderInfo;
import flash.net.URLRequest;
import flash.display.Bitmap;
import flash.system.*;
import flash.system.Security;
import flash.external.*;
import flash.external.ExternalInterface;
Security.allowDomain("*");
Security.allowInsecureDomain("*")
//Security.loadPolicyFile('http://mm3.777partner.com/777cams.xml');
var flashVars = this.loaderInfo.parameters;
//Variables
var strVideo:String = flashVars.clip;
var strPoster:String = flashVars.poster;
var strAutploay:String = flashVars.autoplay;
var strLoop:String = flashVars.loop;
var strLive:String = flashVars.live;
var strVolume:String = flashVars.volume;
//Objects
var my_poster:Bitmap;
var my_video:FLVPlayback = new FLVPlayback();
var my_interlude:FLVPlayback = new FLVPlayback();
var my_loader:Loader = new Loader();
var my_request:URLRequest = new URLRequest();
var loaderContext:LoaderContext = new LoaderContext(); 
//loaderContext.checkPolicyFile = true;
loaderContext.securityDomain = SecurityDomain.currentDomain;
loaderContext.applicationDomain = ApplicationDomain.currentDomain;

//Init Flash Canvas
function initScreen():void {
	if(ExternalInterface.available){
		ExternalInterface.addCallback("playVideo", playVideo);
		ExternalInterface.addCallback("playInterlude", playInterlude);
		ExternalInterface.call("swfReady","Screen");
	}
	if(strVolume == "false") {
		strVolume = "100";
	}
	stage.align = StageAlign.TOP_LEFT;
	stage.alpha 100;
}

//load and show an image
function initPoster(poster:String):void {
	if( poster != ""){
		my_request.url = poster;
		my_loader.visible = true;
		my_loader.width = stage.width;
		my_loader.height = stage.height;
		my_loader.contentLoaderInfo.addEventListener("complete", onPosterLoaded);
		my_loader.load(my_request, loaderContext);
	}
}

//called when poster is loaded
function onPosterLoaded(e:Event) {
	my_poster = my_loader.content as Bitmap;
	addChild(my_poster);
	if(ExternalInterface.available){
		ExternalInterface.call("swfReady","Poster Loaded");
	}
	if(strAutploay == "true") {
		initVideo(strVideo);
	}
}
//called when video is loaded
function onVideoLoaded(e:Event){
	if(my_video.stage == null) {
		addChild(my_video);
	}
	if(ExternalInterface.available){
		ExternalInterface.call("swfReady","Video Loaded");
	}
}
//called when video is played
function onVideoPlay(e:Event){
	if(my_video.stage == null) {
		addChild(my_video);
	}
	if(ExternalInterface.available){
		ExternalInterface.call("swfReady","Video Play");
		ExternalInterface.call("swfClipStart", my_video.source);
	}
}
//called when poster is shown
function onPosterShow(e:Event){
	if(ExternalInterface.available){
		ExternalInterface.call("swfReady","Poster Show");
	}
}
//called when interlude is loaded
function onInterludeLoaded(e:Event){
	my_video.stop();
	if(my_interlude.stage == null) {
		addChild(my_interlude);
	}
	if(ExternalInterface.available){
		ExternalInterface.call("swfReady","Interlude Loaded");
	}
}
//called when interlude is played
function onInterludePlay(e:Event){
	my_video.stop();
	if(my_interlude.stage == null) {
		addChild(my_interlude);
	}
	if(ExternalInterface.available){
		ExternalInterface.call("swfClipStart", my_interlude.source);
	}
}
//called when Video is played till end
function completePlay(e:Event):void {
	if(strLoop == "true") {
		my_video.play();
	}
	if(ExternalInterface.available){
		ExternalInterface.call("swfClipStop", my_video.source);
	}
} 
//called when Interlude is played till end
function completeInterlude(e:Event):void {
	removeChild(my_interlude);
	if(my_video.stage == null) {
		addChild(my_video);
	}
	my_video.play();
	if(ExternalInterface.available){
		ExternalInterface.call("swfReady","switch to Video");
		ExternalInterface.call("swfClipStop", my_interlude.source);
	}
} 

//load and show a video
function initVideo(video):void {
	if (video != "") {
		my_video.width = stage.width;
		my_video.height = stage.height;
		my_video.volume = int(strVolume);
		if(strLive == "true") {
			my_video.isLive = true;
		} else {
			my_video.isLive = false;
		}
		my_video.align = VideoAlign.TOP_LEFT;
		my_video.source = video;
		my_video.play();
		my_video.addEventListener("ready", onVideoLoaded); 
		my_video.addEventListener("playingStateEntered", onVideoPlay); 
		my_video.addEventListener("complete", completePlay);
	}
}

//load and show a interlude video
function playInterlude(interlude:String):void {
	my_interlude.width = stage.width;
	my_interlude.height = stage.height;
	my_interlude.volume = int(strVolume);
	if(strLive == "true") {
		my_interlude.isLive = true;
	} else {
		my_interlude.isLive = false;
	}
	my_interlude.align = VideoAlign.TOP_LEFT;
	my_interlude.source = interlude;
	my_interlude.play();
	my_interlude.addEventListener("ready", onInterludeLoaded); 
	my_interlude.addEventListener("playingStateEntered", onInterludePlay); 
	my_interlude.addEventListener("complete", completeInterlude);
}

function playVideo(video:String):void {
	initVideo(video);
}

function debuglog(info:String) {
	if(ExternalInterface.available){
		ExternalInterface.call("swfDebug", info);	
	}
}

initScreen();
if(strPoster != "false") {
	initPoster(strPoster);
} else {
	if(strAutploay == "true") {
		initVideo(strVideo);
	}
}
