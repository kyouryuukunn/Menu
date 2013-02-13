@iscript
var chose_novel = 1;	//選択肢ありか, 前の選択肢に戻るを表示
var in_scene_mode_button_mark = 0; //回想モード
@endscript

@call storage=SetMessageOpacity.ks
@call storage=save_mode_init.ks
@call storage=config_init.ks
@call storage=exsystembutton.ks
@call storage=MoveMenu.ks
@call storage=TJSFunctions.ks
@call storage=KLayers.ks

@iscript
//exsystembutton_objectとMoveMenu_objectをくっつけるプラグイン
class MenuPlugin extends KAGPlugin{
	//2つの後に呼ばれないとまずいんだが、登録順に呼ばれるのか？
	function onRestore(elm, clear, tempelm){
		//状況に合わせて右クリックを設定
		if  ( kag.canStore() && (sf.menu_mode == 0 || sf.menu_mode == 2) ){
		//マウスオンまたはシステムメニューが有効なら、右クリックで背景を表示
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => false, 'jump' => false]);
		}else if (kag.canStore() && sf.menu_mode == 1){
		//右クリックメニューが有効なら、右クリックでメニュー表示
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => true, 'jump' => false, 'storage' => 'Menu.ks', 'target' => '*rclick']);
		}else if (!kag.canStore()){
		//セーブ不可ならタイトルと判断して右クリック禁止
			kag.tagHandlers.rclick(%['enabled' => false]);
		}
		//マウスオンメニューを設定
		MoveMenu_object.move_menuon = sf.menu_mode == 0 && kag.canStore() ? 1 : 0;
		//システムメニューを設定
		if (kag.canStore() && sf.menu_mode == 2) exsystembutton_object.setOptions(%['forevisible'=>true, 'backvisible'=>true]);
		if (sf.menu_mode != 2) exsystembutton_object.setOptions(%['forevisible'=>false, 'backvisible'=>false]);
	}
}
kag.addPlugin(global.Menu_object = new MenuPlugin());
kag.lockSnapshot = function() {
	// スナップショットをロックする
	// 初めてスナップショットがロックされた時点での画面を保存する
	if(snapshotLockCount == 0)
	{
		if(snapshotLayer === void)
			snapshotLayer = new Layer(this, primaryLayer);
		snapshotLayer.setImageSize(scWidth, scHeight);
		snapshotLayer.face = dfAlpha;
		


		//スナップショットに表示させたくないレイヤーが表示されている場合、一時的に非表示にします。
		MoveMenu_object.setObjProp(MoveMenu_object.foreButtons, 'visible', false);
		exsystembutton_object.setObjProp(exsystembutton_object.foreButtons, 'visible', false);
		SetMessageOpacity_object.foreLay.visible=false;
		
		var mes0 = false;
		
		if (kag.fore.messages[0].visible)
		{
			mes0 = true;
			kag.fore.messages[0].visible = false;
		}
		//スナップショット作成
		snapshotLayer.piledCopy(0, 0, kag.fore.base, 0, 0, scWidth, scHeight);
		
		//レイヤーの表示状態を元に戻します。
		if (mes0)
		{
			kag.fore.messages[0].visible = true;
		}
		//foreSeenは、ボタンが本来表示中であったかどうかを記録している
		MoveMenu_object.setObjProp(MoveMenu_object.foreButtons, 'visible', MoveMenu_object.foreSeen);
		exsystembutton_object.setObjProp(exsystembutton_object.foreButtons, 'visible', exsystembutton_object.foreSeen);
		SetMessageOpacity_object.setOptions(%[visible:SetMessageOpacity_object.foreSeen]);
	}
		snapshotLockCount ++;
} incontextof kag;

kag.onMouseMove=function(x, y, shift){
	with(MoveMenu_object)
	{
		if (.move_menuon && sf.menu_mode == 0)
		{
			if (kag.fore.messages[0].visible == true && kag.historyLayer.visible == false && kag.inStable)
			{
				//マウスイベントで渡されるxとyの値はウィンドウモード時とフルスクリーンモード時で異なる
				//fore.base.cursorXとfore.base.cursorYにはウィンドウモード時でもフルスクリーンモード時でも同じ値が入る
				x = fore.base.cursorX, y = fore.base.cursorY;
				
				if ( 
					( ( .position == 'right') && ( x >= kag.scWidth - .foreButtons[0].width) && ( x <= kag.scWidth - 10 ) && ( y <= .foreButtons[0].height*.foreButtons.count) ) || 
					( ( .position == 'top' ) && (y <= .foreButtons[0].height) && (y >= 10) )
				   )
				{
					.setOptions(%['forevisible'=>'true','backvisible'=>'true']);
				}
				else
				{
					.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
				}
			}
		}
	}
} incontextof kag;
@endscript

;メッセージレイヤを透明に
@position page=fore layer=message0 opacity=0
@position page=back layer=message0 opacity=0
;メッセージ枠を設定
@SetMessageOpacity page=fore visible=false opacity=&sf.messageopacity
@SetMessageOpacity page=back visible=false opacity=&sf.messageopacity



;マクロ設定

; 状況に合わせて右クリック設定
@macro name=set_rclick        
; マウスオンメニュー
@rclick enabled=true call=false jump=false cond="kag.canStore() && sf.menu_mode==0"
; 通常ボタンメニュー
@rclick enabled=true call=false jump=false cond="kag.canStore() && sf.menu_mode==2"
; 右クリックメニュー
@rclick enabled=true call=true  jump=false storage=Menu.ks target="*rclick" cond="kag.canStore() && sf.menu_mode==1"
; タイトル
@rclick enabled=false cond="!kag.canStore()"
@endmacro

; 状況に合わせてメニュー設定
@macro name=set_menu
@set_rclick
@eval exp="MoveMenu_object.move_menuon = sf.menu_mode == 0 && kag.canStore() ? 1 : 0"
@exsysbtopt forevisible=true backvisible=true cond="sf.menu_mode == 2 && kag.canStore()"
@exsysbtopt forevisible=false backvisible=false cond="sf.menu_mode != 2 || !kag.canStore()"
@endmacro

; メニュー無効化する
@macro name=unset_menu
@rclick enabled=false
@eval exp="MoveMenu_object.move_menuon = 0"
@exsysbtopt forevisible=false backvisible=false
@endmacro

; 状況に合わせて右クリックまたはメニューから戻る
@macro name=myreturn        
@return cond="!kag.canStore() || sf.menu_mode == 0 || sf.menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="sf.menu_mode == 1"
@endmacro

; 回想モード用にボタンを無効化する
@macro name=in_scene_mode_button        
@eval exp="in_scene_mode_button_mark=1"
@endmacro

; 回想モード用に無効化したボタンを有効化する
; タイトル画面など、回想モードから戻る場所において
@macro name=out_scene_mode_button        
@eval exp="in_scene_mode_button_mark=0"
@endmacro

@return

;右クリックサブルーチン----------------------------------------------------- 
*rclick
@eval exp="kag.skipMode_rclick = false"
@rclick enabled=true jump=true storage=Menu.ks target=*rclick_return
@history enabled=false output=false
@sysbtopt forevisible=true
@if exp="typeof(global.MoveMouseCursorPlugin_object) != 'undefined'"
	@MoveCursor time=100 x=750 y=10 cond="MoveMenu_object.position=='right'"
	@MoveCursor time=100 x=30  y=10 cond="MoveMenu_object.position=='top'"
@else
	@eval exp="kag.fore.base.cursorX=kag.scWidth - MoveMenu_object.foreButtons[0].width/2, kag.fore.base.cursorY=10" cond="MoveMenu_object.position=='right'"
	@eval exp="kag.fore.base.cursorX=MoveMenu_object.foreButtons[0].width/2, kag.fore.base.cursorY=10" cond="MoveMenu_object.position=='top'"
@endif
@s

*auto
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_rclick
@eval exp="kag.enterAutoMode()"
@return

*skip
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_rclick
@eval exp="kag.skipMode_rclick = true"
@return		

*return
@goback ask=false
@myreturn

*hide
@iscript
	// システムボタンを使っていて、メッセージレイヤが表示されている時は onMessageHiddenStateChanged を呼び出します
	if(typeof(global.exsystembutton_object) != "undefined")
		exsystembutton_object.onMessageHiddenStateChanged(true);
	if(typeof(global.MoveMenu_object) != "undefined")
		MoveMenu_object.onMessageHiddenStateChanged(true);
	if (typeof(global.SetMessageOpacity_object) != 'undefined')
		SetMessageOpacity_object.onMessageHiddenStateChanged(true);
	// 全てのメッセージレイヤを非表示にします
	for(var i=0;i<kag.numMessageLayers;i++)
		kag.fore.messages[i].setOptions(%["visible" => false]);
@endscript
@p
@iscript
	kag.fore.messages[0].visible = true;
	if(typeof(global.exsystembutton_object) != "undefined" && sf.menu_mode == 2)
		exsystembutton_object.onMessageHiddenStateChanged(false);
	if (typeof(global.SetMessageOpacity_object) != 'undefined')
		SetMessageOpacity_object.onMessageHiddenStateChanged(false);
@endscript
@myreturn

*qsave
@if exp="sf.qsaveAsk"
	@if exp="!askYesNo('クイックセーブしますか？')"
		@myreturn
	@endif
@endif
@save place=0
@myreturn

*qload
@myreturn cond="kag.getBookMarkPageName(0) == '(未設定)'"
@if exp="sf.qloadAsk"
	@if exp="!askYesNo('クイックロードしますか？')"
		@myreturn
	@endif
@endif
@cm
@load place=0

*title
@gotostart ask=true
@myreturn


*exit
@eval exp="kag.closeByScript(%[ask:false])"

*rclick_return
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_menu
@return

