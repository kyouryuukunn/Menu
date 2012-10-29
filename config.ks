*initialize

; 右クリックでコンフィグ画面を閉じられるように右クリックの設定を変更します
@rclick jump=true storage="config.ks" target=*back enabled=true
@eval exp="tf.pre_menu_mode = sf.menu_mode"
; 現在の状態をメモリ上の栞に保存しておきます
@tempsave place=0

@iscript
// システムボタンを使っていて、メッセージレイヤが表示されている時は onMessageHiddenStateChanged を呼び出します
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(true);
var i;
var elm = %["visible" => false];
// 全ての前景レイヤを非表示にします
for(i=0;i<kag.numCharacterLayers;i++)
	kag.fore.layers[i].setOptions(elm);
// 全てのメッセージレイヤを非表示にします
for(i=0;i<kag.numMessageLayers;i++)
	kag.fore.messages[i].setOptions(elm);

@endscript

; 背景レイヤに画像（クリッカブルマップ）を読み込みます
@image layer=base storage="config_bg" page=fore

; レイヤを必要な数（前景レイヤ×16,）確保します
@laycount layers=16 messages="&kag.numMessageLayers + 1"

; 前景レイヤに画像を読み込みます
; #0: フルスクリーンに表示するチェック画像
@image layer=0 storage="checked" page=fore visible=false top=525 left=440
; #1: titleに表示するチェック画像
@image layer=1 storage="checked" page=fore visible=false top=435 left=700
; #2: exitに表示するチェック画像
@image layer=2 storage="checked" page=fore visible=false top=475 left=700
; #3: qloadに表示するチェック画像
@image layer=3 storage="checked" page=fore visible=false top=435 left=440
; #4: returnに表示するチェック画像
@image layer=4 storage="checked" page=fore visible=false top=475 left=440
; #5: saveに表示するチェック画像
@image layer=5 storage="checked" page=fore visible=false top=435 left=160
; #6: loadに表示するチェック画像
@image layer=6 storage="checked" page=fore visible=false top=475 left=160
; #7:「ページ末まで一度に表示」に表示するチェック画像
@image layer=7 storage="checked" page=fore visible=false top=165 left=740 
; #8: sceneskipに表示するチェック画像
@image layer=8 storage="checked" page=fore visible=false top=205 left=740 
; #9: autocontinueに表示するチェック画像
@image layer=9 storage="checked" page=fore visible=false top=165 left=410 
; #10: skipcontinueに表示するチェック画像
@image layer=10 storage="checked" page=fore visible=false top=200  left=410 
; #11:「Back」のロールオーバー用画像
@image layer=11 storage="back_ro" page=fore visible=false top=520 left=680 
; #12:「check」のロールオーバー用画像
@image layer=12 storage="check_ro" page=fore visible=false opacity=160
; #13: menu0に表示するチェック画像
@image layer=13 storage="checked" page=fore visible=false top=305  left=590
; #14: menu1に表示するチェック画像
@image layer=14 storage="checked" page=fore visible=false top=355  left=590
; #14: menu2に表示するチェック画像
@image layer=15 storage="checked" page=fore visible=false top=305  left=770

; メッセージレイヤの設定をします
@history enabled=false output=false
@current layer="&'message' + (kag.numMessageLayers - 1)"
; ◆スライダー設定
; ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
; ◇スライダーの値を入れる配列
@eval exp="f.slider = [ (int)(kag.bgm.buf1.volume2 / 1000), (int)(kag.se[0].volume2 / 1000), (int)(100 - kag.chSpeed),(int)(2000 - kag.autoModePageWait)/20, (int)(sf.messageopacity / 2.55)]"

; ◇スライダーの数
@setSliderCount sliders="5"

; ◇スライダー0の設定 - (BGM音量調整)
@setSliderImages slider="0" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="0" page="fore" visible="true" left="190" top="305" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ◇スライダー1の設定 - (SE音量調整)
@setSliderImages slider="1" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="1" page="fore" visible="true" left="190" top="345" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ◇スライダー2の設定 - (文字速度)
@setSliderImages slider="2" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="2" page="fore" visible="true" left="450" top="70" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ◇スライダー3の設定 - (オートモード速度)
@setSliderImages slider="3" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="3" page="fore" visible="true" left="450" top="100" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ◇スライダー4の設定 - (透明度)
@setSliderImages slider="4" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="4" page="fore" visible="true" left="450" top="130" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"

; ◇スライダの値を初期設定
@setSliderValue slider="0" value="&f.slider[0]"
@setSliderValue slider="1" value="&f.slider[1]"
@setSliderValue slider="2" value="&f.slider[2]"
@setSliderValue slider="3" value="&f.slider[3]"
@setSliderValue slider="4" value="&f.slider[4]"

@setSliderEnabled enabled="true"

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
@eval exp="global.AltEnterFullScreen_obj.toggleFullScreen()"
@call target=*update_windowmode
@s

; ウィンドウモードのチェックボックスの表示を更新します
*update_windowmode
@layopt layer=0 page=fore visible="&kag.fullScreened ? true : false"
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
@layopt layer=9 visible=&sf.autocontinue
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
[layopt layer=7 page=fore visible="&kag.chNonStopToPageBreak"]
[return]

*update_skipcontinue
@layopt layer=10 visible=&sf.skipcontinue
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
@layopt layer=8 visible=&sf.sceneskip
@return
; 右クリック
*menu0
@eval exp="sf.menu_mode=0"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu0
@layopt layer=13 visible="&sf.menu_mode == 0"
@return

*menu1
@eval exp="sf.menu_mode=1"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu1
@layopt layer=14 visible="&sf.menu_mode == 1"
@return

*menu2
@eval exp="sf.menu_mode=2"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu2
@layopt layer=15 visible="&sf.menu_mode == 2"
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
@layopt layer=5 visible=&sf.saveAsk
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
@layopt layer=6 visible=&sf.loadAsk
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
@layopt layer=3 visible=&sf.qloadAsk
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
@layopt layer=4 visible=&sf.returnAsk
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
@layopt layer=1 visible=&sf.titleAsk
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
@layopt layer=2 visible=&sf.exitAsk
@return

; コンフィグ画面を閉じます
*back
; スライダーを反映します
[getSliderValue slider="0" name="f.slider[0]"]
[getSliderValue slider="1" name="f.slider[1]"]
[getSliderValue slider="2" name="f.slider[2]"]
[getSliderValue slider="3" name="f.slider[3]"]
[getSliderValue slider="4" name="f.slider[4]"]
; ◇BGM音量調整のスライダが動いたときの処理
@bgmopt gvolume="&f.slider[0]"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"
; ◇SE音量調整のスライダが動いたときの処理
@iscript
	var elm = %['gvolume' => f.slider[1] ];
	for(var i=0;i<kag.numSEBuffers;i++)
		kag.se[i].setOptions(elm);
@endscript
@eval exp="sf.sevolume = kag.se[0].volume2"
; 文字速度
@eval exp="kag.userChSpeed=( 100 - f.slider[2] )"
; オート速度
[eval exp="kag.autoModePageWait = 2000 -  f.slider[3] * 20"]
[eval exp="kag.autoModeLineWait = 1000 -  f.slider[3] * 10"]
; メッセージレイヤの濃度
[eval exp="sf.messageopacity = (int)(f.slider[4] * 2.55)"]


; コンフィグ画面表示前の状態を復元します(但し BGM は復元しません)
@tempload place=0 bgm=false
; メッセージ履歴の出力・表示を有効にします
@history output=true enabled=true cond="kag.canStore()"
; メッセージ表示速度の設定を反映します
@delay speed=user cond="kag.chUserMode"
; メッセージレイヤの濃度
@set_messageopacity


@iscript
// システムボタンを使っていて、コンフィグ画面を表示する前にメッセージレイヤが表示されていた時は onMessageHiddenStateChanged を呼び出します
if(typeof(global.MoveMenu_object) != "undefined" && kag.fore.messages[0].visible)
	MoveMenu_object.onMessageHiddenStateChanged(false);
@endscript

; 右クリックをデフォルトの動作（メッセージウィンドウ消去）に戻します
@current layer=message0
@set_menu
@return cond="!kag.canStore()"
@return cond="tf.pre_menu_mode == 0 || tf.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="tf.pre_menu_mode == 1"
