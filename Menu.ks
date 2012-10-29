@iscript
//初期設定 初回のみ実行
if (sf.startconfig === void)
{
	//設定の初期化
	sf.saveAsk = 1; //セーブ上書き時に確認する
	sf.loadAsk = 1; //ロード時に確認する
	sf.qloadAsk = 1; //クイックロード時に確認する
	sf.returnAsk = 1; //前に戻るで確認する
	sf.titleAsk = 1; //タイトルに戻るで確認する
	sf.exitAsk = 1; //終了時に確認する
	sf.autocontinue = 1; //選択肢後もオートモードを続ける
	sf.skipcontinue = 1; //選択肢後もスキップモードを続ける
	sf.sceneskip = 1; //シーン毎のスキップをする
	sf.menu_mode = 0; //右クリックメニューを使用するかマウスオンメニューを使用する
	sf.messageopacity = 128; //メッセージ枠の透明度
	
	sf.bgmvolume = kag.bgm.buf1.volume2;
	sf.sevolume = kag.se[0].volume2;
	sf.startconfig = 1;
}
//自前の終了処理に置き替える
kag.askOnClose=false;
tf.chose_novel = 1;	//選択肢ありか, 前の選択肢に戻るを表示
tf.in_scene_mode_button = 0; //回想モード
tf.message_base = 'message'; //メッセージレイヤと同じ大きさの
			     //黒い画像

tf.move_menuon = 0;

kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;
@endscript

@call storage=save_mode_init.ks
@call storage=exsystembutton.ks
@call storage=MoveMenu.ks

@iscript
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
		
		var mes0 = false;
		var lay1 = false;
		
		if (kag.fore.messages[0].visible)
		{
			mes0 = true;
			kag.fore.messages[0].visible = false;
		}
		if (kag.fore.layers[1].visible) //レイヤ1にメッセージ枠を表示してるので
		{
			lay1 = true;
			kag.fore.layers[1].visible = false;
		}
		//スナップショット作成
		snapshotLayer.piledCopy(0, 0, kag.fore.base, 0, 0, scWidth, scHeight);
		



		//レイヤーの表示状態を元に戻します。
		if (mes0)
		{
			kag.fore.messages[0].visible = true;
		}
		if (lay1)
		{
			kag.fore.layers[1].visible = true;
		}
		//foreSeenは、ボタンが本来表示中であったかどうかを記録している
		MoveMenu_object.setObjProp(MoveMenu_object.foreButtons, 'visible', MoveMenu_object.foreSeen);
		exsystembutton_object.setObjProp(exsystembutton_object.foreButtons, 'visible', exsystembutton_object.foreSeen);
	}
		snapshotLockCount ++;
} incontextof kag;
//回想モードではいくつかのボタンを無効化する
function in_scene_mode_button(){
	with(MoveMenu_object)
	{
		.foreButtons[0].enabled = false;
		.foreButtons[1].enabled = false;
		.foreButtons[2].enabled = false;
		.foreButtons[3].enabled = false;
		if (tf.chose_novel) .foreButtons[7].enabled = false;
		.backButtons[0].enabled = false;
		.backButtons[1].enabled = false;
		.backButtons[2].enabled = false;
		.backButtons[3].enabled = false;
		if (tf.chose_novel) .backButtons[7].enabled = false;
	}
	with(exsystembutton_object)
	{
		.foreButtons[0].enabled = false;
		.foreButtons[1].enabled = false;
		.foreButtons[2].enabled = false;
		.foreButtons[3].enabled = false;
		if (tf.chose_novel) .foreButtons[7].enabled = false;
		.backButtons[0].enabled = false;
		.backButtons[1].enabled = false;
		.backButtons[2].enabled = false;
		.backButtons[3].enabled = false;
		if (tf.chose_novel) .backButtons[7].enabled = false;
	}
}

//回想モードで無効化したボタンを無効化する
function out_scene_mode_button(){
	with(MoveMenu_object)
	{
		.foreButtons[0].enabled = true;
		.foreButtons[1].enabled = true;
		.foreButtons[2].enabled = true;
		.foreButtons[3].enabled = true;
		if (tf.chose_novel) .foreButtons[7].enabled = true;
		.backButtons[0].enabled = true;
		.backButtons[1].enabled = true;
		.backButtons[2].enabled = true;
		.backButtons[3].enabled = true;
		if (tf.chose_novel) .backButtons[7].enabled = true;
	}
	with(exsystembutton_object)
	{
		.foreButtons[0].enabled = true;
		.foreButtons[1].enabled = true;
		.foreButtons[2].enabled = true;
		.foreButtons[3].enabled = true;
		if (tf.chose_novel) .foreButtons[7].enabled = true;
		.backButtons[0].enabled = true;
		.backButtons[1].enabled = true;
		.backButtons[2].enabled = true;
		.backButtons[3].enabled = true;
		if (tf.chose_novel) .backButtons[7].enabled = true;
	}
}

kag.onMouseMove=function(x, y, shift){
	with(MoveMenu_object)
	{
		if (tf.in_scene_mode_button) //回想モードでは無効化
		{
			in_scene_mode_button();
		}
		else
		{
			out_scene_mode_button();
		}
		if (tf.move_menuon && sf.menu_mode == 0)
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
@image layer=0 storage=&tf.message_base page=fore opacity=&sf.messageopacity left=&kag.fore.messages[0].left top=&kag.fore.messages[0].top
@image layer=0 storage=&tf.message_base page=back opacity=&sf.messageopacity left=&kag.fore.messages[0].left top=&kag.fore.messages[0].top
@layopt layer=0 page=fore autohide=true index=999999
@layopt layer=0 page=back autohide=true index=999999



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
@eval exp="tf.move_menuon = sf.menu_mode == 0 && kag.canStore() ? 1 : 0"
@exsysbtopt forevisible=true backvisible=true cond="sf.menu_mode == 2 && kag.canStore()"
@exsysbtopt forevisible=false backvisible=false cond="sf.menu_mode != 2 || !kag.canStore()"
@endmacro

; メニュー無効化する
@macro name=unset_menu
@rclick enabled=false
@eval exp="tf.move_menuon = 0"
@exsysbtopt forevisible=false backvisible=false
@endmacro

; 状況に合わせて右クリックまたはメニューから戻る
@macro name=myreturn        
@return cond="!kag.canStore() || sf.menu_mode == 0 || sf.menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="sf.menu_mode == 1"
@endmacro

; 回想モード用にボタンを無効化する
@macro name=in_scene_mode_button        
@eval exp="tf.in_scene_mode_button=1"
@endmacro

; 回想モード用に無効化したボタンを有効化する
; タイトル画面など、回想モードから戻る場所において
@macro name=out_scene_mode_button        
@eval exp="tf.in_scene_mode_button=0"
@endmacro

;メッセージレイヤの透明度を設定し、表示する(セーブ可能ラベルの後におく)
@macro name=set_messageopacity
@layopt layer=0 page=fore visible=true opacity=&sf.messageopacity cond="kag.canStore()"
@layopt layer=0 page=back visible=true opacity=&sf.messageopacity cond="kag.canStore()"
@endmacro
; laycountの代用
@macro name=laycount2
@laycount *
@layopt layer=0 page=fore autohide=true index=999999
@layopt layer=0 page=back autohide=true index=999999
@endmacro

@return

;右クリックサブルーチン
*rclick
@eval exp="kag.skipMode_rclick = false"
@rclick enabled=true jump=true storage=Menu.ks target=*rclick_return
@history enabled=false output=false
@sysbtopt forevisible=true
@MoveCursor time=100 x=750 y=10 cond="MoveMenu_object.position=='right'"
@MoveCursor time=100 x=30  y=10 cond="MoveMenu_object.position=='top'"
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
@if exp="kag.historyOfStore.count==0"
	@myreturn
@else
	@if exp="sf.returnAsk==1"
		@if exp="askYesNo('1つ前の選択肢に戻りますか？')"
			@goback ask=false
		@else
			@myreturn
		@endif
	@else
		@goback ask=false
	@endif
@endif

*hide
@iscript
	kag.fore.layers[0].visible=false;
	var i;
	var elm = %["visible" => false];
	// 全てのメッセージレイヤを非表示にします
	for(i=0;i<kag.numMessageLayers;i++)
		kag.fore.messages[i].setOptions(elm);
	MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
@endscript
@l
@iscript
	kag.fore.messages[0].visible = true;
	kag.fore.layers[0].visible=true;
	MoveMenu_object.setOptions(%['forevisible'=>'true','backvisible'=>'true']);
@endscript
@myreturn

*qload
@myreturn cond="kag.getBookMarkPageName(0) == '(未設定)'"
@if exp="sf.qloadAsk==1"
	@if exp="!askYesNo('クイックロードしますか？')"
		@myreturn
	@endif
@endif
@cm
@load place=0

*title
@if exp="sf.titleAsk"
	@if exp="askYesNo('タイトルに戻りますか?')"
		@gotostart ask=false
	@else
		@myreturn
	@endif
@else
		@gotostart ask=false
@endif

*exit
@eval exp="kag.closeByScript(%[ask:false])"

*rclick_return
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_menu
@return

