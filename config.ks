*initialize

; 右クリックでコンフィグ画面を閉じられるように右クリックの設定を変更します
@rclick jump=true storage="config.ks" target=*back enabled=true
; 戻るために現在のメニューの設定を保存
@eval exp="config.pre_menu_mode = sf.menu_mode"
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
@laycount layers="&kag.numCharacterLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
; 背景
@image layer="&kag.numCharacterLayers-1" storage=&config.back page=fore visible=true

; ボタン設定
@iscript
config.togglebutton = [];
for (var i = 0; i < 14; i++){
	config.togglebutton[i] = new KToggleButtonLayer(kag, kag.fore.layers[kag.numCharacterLayers-1]);
}
// #0: フルスクリーンに表示するチェック画像
config.togglebutton[0].setOptions( %[left:config.windowmode[0], top:config.windowmode[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*windowmode', unchecktarget:'*windowmode', basegraphic:config.basegraphic, graphic:config.graphic, checked:kag.fullScreened]);
// #1: titleに表示するチェック画像
config.togglebutton[1].setOptions( %[left:config.titleAsk[0], top:config.titleAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*titleAsk', unchecktarget:'*titleAsk', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.titleAsk]);
// #2: exitに表示するチェック画像
config.togglebutton[2].setOptions( %[left:config.exitAsk[0], top:config.exitAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*exitAsk', unchecktarget:'*exitAsk', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.exitAsk]);
// #3: qloadに表示するチェック画像
config.togglebutton[3].setOptions( %[left:config.qloadAsk[0], top:config.qloadAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*qloadAsk', unchecktarget:'*qloadAsk', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.qloadAsk]);
// #4: returnに表示するチェック画像
config.togglebutton[4].setOptions( %[left:config.returnAsk[0], top:config.returnAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*returnAsk', unchecktarget:'*returnAsk', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.returnAsk]);
// #5: saveに表示するチェック画像
config.togglebutton[5].setOptions( %[left:config.saveAsk[0], top:config.saveAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*saveAsk', unchecktarget:'*saveAsk', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.saveAsk]);
// #6: loadに表示するチェック画像
config.togglebutton[6].setOptions( %[left:config.loadAsk[0], top:config.loadAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*loadAsk', unchecktarget:'*loadAsk', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.loadAsk]);
// #7:「ページ末まで一度に表示」に表示するチェック画像
config.togglebutton[7].setOptions( %[left:config.pagebreak[0], top:config.pagebreak[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*pagebreak', unchecktarget:'*pagebreak', basegraphic:config.basegraphic, graphic:config.graphic, checked:kag.chNonStopToPageBreak]);
// #8: sceneskipに表示するチェック画像
config.togglebutton[8].setOptions( %[left:config.sceneskip[0], top:config.sceneskip[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*sceneskip', unchecktarget:'*sceneskip', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.sceneskip]);
// #9: autocontinueに表示するチェック画像
config.togglebutton[9].setOptions( %[left:config.autocontinue[0], top:config.autocontinue[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*autocontinue', unchecktarget:'*autocontinue', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.autocontinue]);
// #10: skipcontinueに表示するチェック画像
config.togglebutton[10].setOptions(%[left:config.skipcontinue[0], top:config.skipcontinue[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*skipcontinue', unchecktarget:'*skipcontinue', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.skipcontinue]);


// #11: menu0に表示するチェック画像
config.togglebutton[11].setOptions(%[left:config.menu0[0], top:config.menu0[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*menu0', unchecktarget:'*menu0', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.menu_mode == 0]);
// #14: menu1に表示するチェック画像
config.togglebutton[12].setOptions(%[left:config.menu1[0], top:config.menu1[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*menu1', unchecktarget:'*menu1', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.menu_mode == 1]);
// #15: menu2に表示するチェック画像
config.togglebutton[13].setOptions(%[left:config.menu2[0], top:config.menu2[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*menu2', unchecktarget:'*menu2', basegraphic:config.basegraphic, graphic:config.graphic, checked:sf.menu_mode == 2]);
// #11:「Back」のロールオーバー用画像
//@image layer="&kag.numCharacterLayers - 13" storage="back_ro" page=fore visible=false top=520 left=680 
@endscript

; メッセージレイヤの設定をします
@history enabled=false output=false
@current layer="&'message' + (kag.numMessageLayers - 1)"
@position opacity=0 marginb=0 marginl=0 marginr=0 margint=0 left=0 top=0 width=&kag.scWidth height=&kag.scHeight visible=true
; ◆スライダー設定
@iscript
config.slider = new Array();
for (var i=0; i < 5; i++){
	config.slider[i] = new KSliderLayer(kag, kag.fore.layers[kag.numCharacterLayers - 1]);
	with(config.slider[i]){
		.setOptions(%['graphic' => config.slider_base, 'tabgraphic' => config.slider_tab]);
	}
}
// ◇スライダー0の設定 - (BGM音量調整)
with(config.slider[0]){
	.left = config.slider0[0];
	.top =  config.slider0[1];
	.hval = kag.bgm.buf1.volume2 / 100000;
	.updateState();
	.onchangefunc = 'config.bgmslider';
}
// ◇スライダー1の設定 - (SE音量調整)
with(config.slider[1]){
	.left = config.slider1[0];
	.top =  config.slider1[1];
	.hval = kag.se[0].volume2 / 100000;
	.updateState();
	.onchangefunc = 'config.seslider';
}
// ◇スライダー2の設定 - (文字速度)
with(config.slider[2]){
	.left = config.slider2[0];
	.top =  config.slider2[1];
	.hval = (100 - kag.chSpeed)/100;
	.updateState();
	.onchangefunc = 'config.chspeedslider';
}
// ◇スライダー3の設定 - (オートモード速度)
with(config.slider[3]){
	.left = config.slider3[0];
	.top =  config.slider3[1];
	.hval = (2000 - kag.autoModePageWait)/2000;
	.updateState();
	.onchangefunc = 'config.autospeedslider';
}
// ◇スライダー4の設定 - (透明度)
with(config.slider[4]){
	.left = config.slider4[0];
	.top =  config.slider4[1];
	.hval = sf.messageopacity / 255;
	.updateState();
	.onchangefunc = 'config.messageopacityslider';
}
@endscript

@s
; ここから先が各サブルーチン

; ウィンドウモードの「フルスクリーン」をクリックした時に実行されるスクリプト
*windowmode
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@s
; オートモードを継続するか確認する
*autocontinue
@if exp="sf.autocontinue==1"
	@eval exp="sf.autocontinue=0"
@elsif exp="sf.autocontinue==0"
	@eval exp="sf.autocontinue=1"
@endif
@s
; スキップを継続するか確認する
*skipcontinue
@if exp="sf.skipcontinue==1"
	@eval exp="sf.skipcontinue=0"
@elsif exp="sf.skipcontinue==0"
	@eval exp="sf.skipcontinue=1"
@endif
@s
; 「ページ末まで一度に表示」をクリックした時に実行されるスクリプト
*pagebreak
@eval exp="kag.onChNonStopToPageBreakItemClick()"
@s
; シーンスキップをするか確認する
*sceneskip
@if exp="sf.sceneskip==1"
	@eval exp="sf.sceneskip=0"
@elsif exp="sf.sceneskip==0"
	@eval exp="sf.sceneskip=1"
@endif
@s
; セーブするか確認する
*saveAsk
@if exp="sf.saveAsk==1"
	@eval exp="sf.saveAsk=0"
@elsif exp="sf.saveAsk==0"
	@eval exp="sf.saveAsk=1"
@endif
@s
; ロードするか確認する
*loadAsk
@if exp="sf.loadAsk==1"
	@eval exp="sf.loadAsk=0"
@elsif exp="sf.loadAsk==0"
	@eval exp="sf.loadAsk=1"
@endif
@s
; クイックロードするか確認する 
*qloadAsk
@if exp="sf.qloadAsk==1"
	@eval exp="sf.qloadAsk=0"
@elsif exp="sf.qloadAsk==0"
	@eval exp="sf.qloadAsk=1"
@endif
@s
; 前の選択肢に戻るか確認する
*returnAsk
@if exp="sf.returnAsk==1"
	@eval exp="sf.returnAsk=0"
@elsif exp="sf.returnAsk==0"
	@eval exp="sf.returnAsk=1"
@endif
@s
; タイトルに戻るか確認する
*titleAsk
@if exp="sf.titleAsk==1"
	@eval exp="sf.titleAsk=0"
@elsif exp="sf.titleAsk==0"
	@eval exp="sf.titleAsk=1"
@endif
@s
; 終了するか確認する
*exitAsk
@if exp="sf.exitAsk==1"
	@eval exp="sf.exitAsk=0"
@elsif exp="sf.exitAsk==0"
	@eval exp="sf.exitAsk=1"
@endif
@s

; 右クリック
*menu0
@eval exp="sf.menu_mode=0"
@jump storage=config.ks target=*update_menu
@s

*menu1
@eval exp="sf.menu_mode=1"
@jump storage=config.ks target=*update_menu
@s

*menu2
@eval exp="sf.menu_mode=2"
@jump storage=config.ks target=*update_menu
@s
;他のボタンの表示を変える
*update_menu
@eval exp="config.togglebutton[11].checked=sf.menu_mode == 0 ? 1 : 0"
@eval exp="config.togglebutton[12].checked=sf.menu_mode == 1 ? 1 : 0"
@eval exp="config.togglebutton[13].checked=sf.menu_mode == 2 ? 1 : 0"
@eval exp="config.togglebutton[11].draw()"
@eval exp="config.togglebutton[12].draw()"
@eval exp="config.togglebutton[13].draw()"
@s

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
@return cond="config.pre_menu_mode == 0 || config.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="config.pre_menu_mode == 1"
