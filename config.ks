*initialize

; 右クリックでコンフィグ画面を閉じられるように右クリックの設定を変更します
@rclick jump=true storage="config.ks" target=*back enabled=true
; 戻るために現在のメニューの設定を保存
@eval exp="tf.pre_menu_mode = sf.menu_mode"
; 現在の状態をメモリ上の栞に保存しておきます
@tempsave place=0

@iscript
// システムボタンを使っているなる消去
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(true);
//SetMessageOpacityを使っているなら消去
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(true);
// 全てのメッセージレイヤを非表示にします
for(var i=0;i<kag.numMessageLayers;i++)
	kag.fore.messages[i].setOptions(%["visible" => false]);
//マウスを中心に移動
kag.fore.base.cursorX = kag.scWidth/2;
kag.fore.base.cursorY = kag.scHeight/2;
@endscript


; レイヤを必要な数確保します
@laycount layers="&kag.numCharacterLayers + 17" messages="&kag.numMessageLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
@layopt index="&2000000+101" layer="&kag.numCharacterLayers - 2"
@layopt index="&2000000+102" layer="&kag.numCharacterLayers - 3"
@layopt index="&2000000+103" layer="&kag.numCharacterLayers - 4"
@layopt index="&2000000+104" layer="&kag.numCharacterLayers - 5"
@layopt index="&2000000+105" layer="&kag.numCharacterLayers - 6"
@layopt index="&2000000+106" layer="&kag.numCharacterLayers - 7"
@layopt index="&2000000+107" layer="&kag.numCharacterLayers - 8"
@layopt index="&2000000+108" layer="&kag.numCharacterLayers - 9"
@layopt index="&2000000+109" layer="&kag.numCharacterLayers - 10"
@layopt index="&2000000+110" layer="&kag.numCharacterLayers - 11"
@layopt index="&2000000+111" layer="&kag.numCharacterLayers - 12"
@layopt index="&2000000+112" layer="&kag.numCharacterLayers - 13"
@layopt index="&2000000+113" layer="&kag.numCharacterLayers - 14"
@layopt index="&2000000+114" layer="&kag.numCharacterLayers - 15"
@layopt index="&2000000+115" layer="&kag.numCharacterLayers - 16"
@layopt index="&2000000+116" layer="&kag.numCharacterLayers - 17"
@layopt index="&2000000+117" layer="&'message' + (kag.numMessageLayers-1)"
; 背景
@image layer="&kag.numCharacterLayers-1" storage="config_bg" page=fore visible=true

; 前景レイヤに画像を読み込みます
; #0: フルスクリーンに表示するチェック画像
@image layer="&kag.numCharacterLayers - 2" storage="checked" page=fore visible=false top=525 left=440
; #1: titleに表示するチェック画像
@image layer="&kag.numCharacterLayers - 3" storage="checked" page=fore visible=false top=435 left=700
; #2: exitに表示するチェック画像
@image layer="&kag.numCharacterLayers - 4" storage="checked" page=fore visible=false top=475 left=700
; #3: qloadに表示するチェック画像
@image layer="&kag.numCharacterLayers - 5" storage="checked" page=fore visible=false top=435 left=440
; #4: returnに表示するチェック画像
@image layer="&kag.numCharacterLayers - 6" storage="checked" page=fore visible=false top=475 left=440
; #5: saveに表示するチェック画像
@image layer="&kag.numCharacterLayers - 7" storage="checked" page=fore visible=false top=435 left=160
; #6: loadに表示するチェック画像
@image layer="&kag.numCharacterLayers - 8" storage="checked" page=fore visible=false top=475 left=160
; #7:「ページ末まで一度に表示」に表示するチェック画像
@image layer="&kag.numCharacterLayers - 9" storage="checked" page=fore visible=false top=165 left=740 
; #8: sceneskipに表示するチェック画像
@image layer="&kag.numCharacterLayers - 10" storage="checked" page=fore visible=false top=205 left=740 
; #9: autocontinueに表示するチェック画像
@image layer="&kag.numCharacterLayers - 11" storage="checked" page=fore visible=false top=165 left=410 
; #10: skipcontinueに表示するチェック画像
@image layer="&kag.numCharacterLayers - 12" storage="checked" page=fore visible=false top=200  left=410 
; #11:「Back」のロールオーバー用画像
@image layer="&kag.numCharacterLayers - 13" storage="back_ro" page=fore visible=false top=520 left=680 
; #12:「check」のロールオーバー用画像
@image layer="&kag.numCharacterLayers - 14" storage="check_ro" page=fore visible=false opacity=160
; #13: menu0に表示するチェック画像
@image layer="&kag.numCharacterLayers - 15" storage="checked" page=fore visible=false top=305  left=590
; #14: menu1に表示するチェック画像
@image layer="&kag.numCharacterLayers - 16" storage="checked" page=fore visible=false top=355  left=590
; #14: menu2に表示するチェック画像
@image layer="&kag.numCharacterLayers - 17" storage="checked" page=fore visible=false top=305  left=770

; メッセージレイヤの設定をします
@history enabled=false output=false
@current layer="&'message' + (kag.numMessageLayers - 1)"
@position opacity=0 marginb=0 marginl=0 marginr=0 margint=0 left=0 top=0 width=&kag.scWidth height=&kag.scHeight visible=true
; ◆スライダー設定
@iscript
//関数の設定
function config_bgmslider(hval,vval,drag){
	kag.tagHandlers.bgmopt(%['gvolume' => hval*100]);
	sf.bgmvolume = kag.bgm.buf1.volume2;
};
function config_seslider(hval,vval,drag){
	for(var i=0;i<kag.numSEBuffers;i++)
		kag.se[i].setOptions(%['gvolume' => hval*100 ]);
	sf.sevolume = kag.se[0].volume2;
};
function config_chspeed(hval,vval,drag){ 
	kag.userChSpeed=( 100 - hval*100 );
};
function config_autospeed(hval,vval,drag){
	// オート速度
	kag.autoModePageWait = 2000 -  hval * 2000;
	kag.autoModeLineWait = 1000 -  hval * 1000;
};
function config_messageopacity(hval,vval,drag){
	sf.messageopacity = (hval * 255);
	SetMessageOpacity_object.foreLay.opacity = sf.messageopacity;
	SetMessageOpacity_object.backLay.opacity = sf.messageopacity;
};
tf.slider = new Array();
for (var i=0; i < 5; i++){
	tf.slider[i] = new KSliderLayer(kag, kag.fore.layers[kag.numCharacterLayers - 1]);
	with(tf.slider[i]){
		.setOptions(%['graphic' => 'slider_base', 'tabgraphic' => 'slider_tab']);
	}
}
// ◇スライダー0の設定 - (BGM音量調整)
with(tf.slider[0]){
	.left = 190;
	.top = 305;
	.hval = kag.bgm.buf1.volume2 / 100000;
	.updateState();
	.onchangefunc = 'config_bgmslider';
}
// ◇スライダー1の設定 - (SE音量調整)
with(tf.slider[1]){
	.left = 190;
	.top = 345;
	.hval = kag.se[0].volume2 / 100000;
	.updateState();
	.onchangefunc = 'config_seslider';
}
// ◇スライダー2の設定 - (文字速度)
with(tf.slider[2]){
	.left = 450;
	.top = 70;
	.hval = (100 - kag.chSpeed)/100;
	.updateState();
	.onchangefunc = 'config_chspeed';
}
// ◇スライダー3の設定 - (オートモード速度)
with(tf.slider[3]){
	.left = 450;
	.top = 100;
	.hval = (2000 - kag.autoModePageWait)/2000;
	.updateState();
	.onchangefunc = 'config_autospeed';
}
// ◇スライダー4の設定 - (透明度)
with(tf.slider[4]){
	.left = 450;
	.top = 130;
	.hval = sf.messageopacity / 255;
	.updateState();
	.onchangefunc = 'config_messageopacity';
}
@endscript

; 各項目の表示を初期化します
@call target=*update_autocontinue
@call target=*update_skipcontinue
@call target=*update_pagebreak
@call target=*update_sceneskip
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@call target=*update_save
@call target=*update_load
@call target=*update_qload
@call target=*update_return
@call target=*update_title
@call target=*update_exit
@call target=*update_windowmode

; ユーザの操作を待ちます
@s

; ウィンドウモードの「フルスクリーン」をクリックした時に実行されるスクリプト
*windowmode
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@call target=*update_windowmode
@s

; ウィンドウモードのチェックボックスの表示を更新します
*update_windowmode
@layopt layer="&kag.numCharacterLayers - 2" page=fore visible="&kag.fullScreened ? true : false"
@return


; オートモードを継続するか確認する
*autocontinue
@if exp="sf.autocontinue==1"
	@eval exp="sf.autocontinue=0"
@elsif exp="sf.autocontinue==0"
	@eval exp="sf.autocontinue=1"
@endif
@call target=*update_autocontinue
@s

*update_autocontinue
@layopt layer="&kag.numCharacterLayers - 11" visible=&sf.autocontinue
@return
; スキップを継続するか確認する
*skipcontinue
@if exp="sf.skipcontinue==1"
	@eval exp="sf.skipcontinue=0"
@elsif exp="sf.skipcontinue==0"
	@eval exp="sf.skipcontinue=1"
@endif
@call target=*update_skipcontinue
@s

; 「ページ末まで一度に表示」をクリックした時に実行されるスクリプト
*pagebreak
[eval exp="kag.onChNonStopToPageBreakItemClick()"]
[call target=*update_pagebreak]
[s]

;「ページ末まで一度に表示」のチェックボックスの表示を更新します
*update_pagebreak
[layopt layer="&kag.numCharacterLayers - 9" page=fore visible="&kag.chNonStopToPageBreak"]
[return]

*update_skipcontinue
@layopt layer="&kag.numCharacterLayers - 12" visible=&sf.skipcontinue
@return
; シーンスキップをするか確認する
*sceneskip
@if exp="sf.sceneskip==1"
	@eval exp="sf.sceneskip=0"
@elsif exp="sf.sceneskip==0"
	@eval exp="sf.sceneskip=1"
@endif
@call target=*update_sceneskip
@s
*update_sceneskip
@layopt layer="&kag.numCharacterLayers - 10" visible=&sf.sceneskip
@return
; 右クリック
*menu0
@eval exp="sf.menu_mode=0"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu0
@layopt layer="&kag.numCharacterLayers - 15" visible="&sf.menu_mode == 0"
@return

*menu1
@eval exp="sf.menu_mode=1"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu1
@layopt layer="&kag.numCharacterLayers - 16" visible="&sf.menu_mode == 1"
@return

*menu2
@eval exp="sf.menu_mode=2"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu2
@layopt layer="&kag.numCharacterLayers - 17" visible="&sf.menu_mode == 2"
@return

; セーブするか確認する
*saveAsk
@if exp="sf.saveAsk==1"
	@eval exp="sf.saveAsk=0"
@elsif exp="sf.saveAsk==0"
	@eval exp="sf.saveAsk=1"
@endif
@call target=*update_save
@s

*update_save
@layopt layer="&kag.numCharacterLayers - 7" visible=&sf.saveAsk
@return
; ロードするか確認する
*loadAsk
@if exp="sf.loadAsk==1"
	@eval exp="sf.loadAsk=0"
@elsif exp="sf.loadAsk==0"
	@eval exp="sf.loadAsk=1"
@endif
@call target=*update_load
@s

*update_load
@layopt layer="&kag.numCharacterLayers - 8" visible=&sf.loadAsk
@return
; クイックロードするか確認する 
*qloadAsk
@if exp="sf.qloadAsk==1"
	@eval exp="sf.qloadAsk=0"
@elsif exp="sf.qloadAsk==0"
	@eval exp="sf.qloadAsk=1"
@endif
@call target=*update_qload
@s

*update_qload
@layopt layer="&kag.numCharacterLayers - 5" visible=&sf.qloadAsk
@return
; 前の選択肢に戻るか確認する
*returnAsk
@if exp="sf.returnAsk==1"
	@eval exp="sf.returnAsk=0"
@elsif exp="sf.returnAsk==0"
	@eval exp="sf.returnAsk=1"
@endif
@call target=*update_return
@s

*update_return
@layopt layer="&kag.numCharacterLayers - 6" visible=&sf.returnAsk
@return
; タイトルに戻るか確認する
*titleAsk
@if exp="sf.titleAsk==1"
	@eval exp="sf.titleAsk=0"
@elsif exp="sf.titleAsk==0"
	@eval exp="sf.titleAsk=1"
@endif
@call target=*update_title
@s

*update_title
@layopt layer="&kag.numCharacterLayers - 3" visible=&sf.titleAsk
@return
; 終了するか確認する
*exitAsk
@if exp="sf.exitAsk==1"
	@eval exp="sf.exitAsk=0"
@elsif exp="sf.exitAsk==0"
	@eval exp="sf.exitAsk=1"
@endif
@call target=*update_exit
@s

*update_exit
@layopt layer="&kag.numCharacterLayers - 4" visible=&sf.exitAsk
@return

; コンフィグ画面を閉じます
*back

; コンフィグ画面表示前の状態を復元します(但し BGM は復元しません)
@tempload place=0 bgm=false
; メッセージ履歴の出力・表示を有効にします
@history output=true enabled=true cond="kag.canStore()"
; メッセージ表示速度の設定を反映します
@delay speed=user cond="kag.chUserMode"

@iscript
// システムボタンを使っていて、コンフィグ画面を表示する前にメッセージレイヤが表示されていた時は onMessageHiddenStateChanged を呼び出します
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(false);
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(false);
@endscript

; 右クリックをデフォルトの動作（メッセージウィンドウ消去）に戻します
@current layer=message0
@set_menu
@return cond="!kag.canStore()"
@return cond="tf.pre_menu_mode == 0 || tf.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="tf.pre_menu_mode == 1"
