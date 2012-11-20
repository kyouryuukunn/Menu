*initialize

; 右クリックでコンフィグ画面を閉じられるように右クリックの設定を変更します
@rclick jump=true storage="config.ks" target=*back enabled=true
; 現在の状態をメモリ上の栞に保存しておきます
@history enabled=false output=false
@tempsave place=0

@iscript
// システムボタンを使っているなら消去
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(true);
//SetMessageOpacityを使っているなら消去
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(true);
// 全てのメッセージレイヤを非表示にします
for(var i=0;i<kag.numMessageLayers;i++)
	kag.fore.messages[i].setOptions(%["visible" => false]);
// マウスホイールの動作を一時的に変える
var config_onMouseWheel_org = kag.onMouseWheel;
kag.onMouseWheel = function (shift, delta, x, y)
{
	config_onMouseWheel_org(...);
	config_plugin_obj.wheel(...);
} incontextof kag;
//マウスを中心に移動
kag.fore.base.cursorX = kag.scWidth/2;
kag.fore.base.cursorY = kag.scHeight/2;
@endscript


; レイヤを必要な数確保します
@laycount layers="&kag.numCharacterLayers + 1" messages="&kag.numMessageLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
@layopt index="&2000000+200" layer="&'message'+ ( kag.numMessageLayers - 1 )"
; メッセージレイヤの設定をします
@current layer="&'message' + (kag.numMessageLayers - 1)"
@position opacity=0 marginb=0 marginl=0 marginr=0 margint=0 left=0 top=0 width=&kag.scWidth height=&kag.scHeight visible=true

;開始時サブルーチンを呼ぶ
@call storage=&config_plugin_obj.start_sub_storage target=&config_plugin_obj.start_sub_label

@iscript
// ボタン設定
tf.config_button = [];
for (var i = 0; i < 6; i++){
	tf.config_button[i] = new Config_Button(kag, kag.fore.layers[kag.numCharacterLayers-1]);
}
// トグルボタン設定
tf.config_togglebutton = [];
for (var i = 0; i < 18; i++){
	tf.config_togglebutton[i] = new KToggleButtonLayer(kag, kag.fore.layers[kag.numCharacterLayers-1]);
}
// スライダー設定
tf.config_slider = new Array();
for (var i=0; i < 10; i++){
	tf.config_slider[i] = new KSliderLayer(kag, kag.fore.layers[kag.numCharacterLayers - 1]);
	with(tf.config_slider[i]){
		.setOptions(%['graphic' => config_plugin_obj.slider_base, 'tabgraphic' => config_plugin_obj.slider_tab]);
	}
}
@endscript

;ページを替えたときに戻る
*pagedraw
; 背景
@image layer="&kag.numCharacterLayers-1" storage=&config_plugin_obj.back[config_plugin_obj.nowpage-1] page=fore visible=true
;ページ変更サブルーチン
@call storage=config_sub.ks target="&'*config_sub_page' + config_plugin_obj.nowpage"

@iscript


// ボタン設定
with(tf.config_button[0]){ .visible = config_plugin_obj.button_visible[(config_plugin_obj.nowpage - 1)*5 + 0]; .loadImages(config_plugin_obj.button_graphic[(config_plugin_obj.nowpage - 1)*5 + 0]); .left = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 0][0]; .top = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 0][1]; .jump = ['config_sub.ks', '*config_sub_button_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*5 + 0)];}
with(tf.config_button[1]){ .visible = config_plugin_obj.button_visible[(config_plugin_obj.nowpage - 1)*5 + 1]; .loadImages(config_plugin_obj.button_graphic[(config_plugin_obj.nowpage - 1)*5 + 1]); .left = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 1][0]; .top = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 1][1]; .jump = ['config_sub.ks', '*config_sub_button_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*5 + 1)];}
with(tf.config_button[2]){ .visible = config_plugin_obj.button_visible[(config_plugin_obj.nowpage - 1)*5 + 2]; .loadImages(config_plugin_obj.button_graphic[(config_plugin_obj.nowpage - 1)*5 + 2]); .left = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 2][0]; .top = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 2][1]; .jump = ['config_sub.ks', '*config_sub_button_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*5 + 2)];}
with(tf.config_button[3]){ .visible = config_plugin_obj.button_visible[(config_plugin_obj.nowpage - 1)*5 + 3]; .loadImages(config_plugin_obj.button_graphic[(config_plugin_obj.nowpage - 1)*5 + 3]); .left = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 3][0]; .top = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 3][1]; .jump = ['config_sub.ks', '*config_sub_button_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*5 + 3)];}
with(tf.config_button[4]){ .visible = config_plugin_obj.button_visible[(config_plugin_obj.nowpage - 1)*5 + 4]; .loadImages(config_plugin_obj.button_graphic[(config_plugin_obj.nowpage - 1)*5 + 4]); .left = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 4][0]; .top = config_plugin_obj.button_pos[(config_plugin_obj.nowpage - 1)*5 + 4][1]; .jump = ['config_sub.ks', '*config_sub_button_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*5 + 4)];}
//閉じる用
with(tf.config_button[5]){ .visible = 1; .loadImages(config_plugin_obj.close_button); .left = config_plugin_obj.close_x; .top = config_plugin_obj.close_y; .jump = ['config.ks', '*back'];}


// トグルボタン設定--------------------------------------------------------- 
tf.config_togglebutton[0].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 0] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 0][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 0][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 0)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 0)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 0) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 0) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 0]]);
tf.config_togglebutton[1].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 1] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 1][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 1][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 1)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 1)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 1) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 1) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 1]]);
tf.config_togglebutton[2].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 2] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 2][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 2][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 2)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 2)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 2) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 2) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 2]]);
tf.config_togglebutton[3].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 3] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 3][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 3][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 3)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 3)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 3) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 3) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 3]]);
tf.config_togglebutton[4].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 4] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 4][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 4][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 4)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 4)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 4) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 4) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 4]]);
tf.config_togglebutton[5].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 5] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 5][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 5][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 5)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 5)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 5) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 5) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 5]]);
tf.config_togglebutton[6].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 6] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 6][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 6][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 6)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 6)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 6) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 6) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 6]]);
tf.config_togglebutton[7].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 7] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 7][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 7][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 7)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 7)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 7) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 7) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 7]]);
tf.config_togglebutton[8].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 8] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 8][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 8][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 8)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 8)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 8) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 8) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 8]]);
tf.config_togglebutton[9].setOptions(  %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 9] , left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 9][0] , top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 9][1] , oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 9)  + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 9)  + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 9) , unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 9) , graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 9]]);
tf.config_togglebutton[10].setOptions( %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 10], left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 10][0], top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 10][1], oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 10) + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 10) + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 10), unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 10), graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 10]]);
tf.config_togglebutton[11].setOptions( %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 11], left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 11][0], top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 11][1], oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 11) + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 11) + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 11), unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 11), graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 11]]);
tf.config_togglebutton[12].setOptions( %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 12], left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 12][0], top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 12][1], oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 12) + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 12) + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 12), unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 12), graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 12]]);
tf.config_togglebutton[13].setOptions( %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 13], left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 13][0], top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 13][1], oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 13) + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 13) + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 13), unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 13), graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 13]]);
tf.config_togglebutton[14].setOptions( %[visible:config_plugin_obj.togglebutton_visible[(config_plugin_obj.nowpage - 1)*15 + 14], left:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 14][0], top:config_plugin_obj.togglebutton_pos[(config_plugin_obj.nowpage - 1)*15 + 14][1], oncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 14) + ' = 1', onuncheck:'config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 14) + ' = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 14), unchecktarget:'*config_sub_togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 14), graphic:config_plugin_obj.togglebutton_graphic[(config_plugin_obj.nowpage - 1)*15 + 14]]);
//checkedは別にしないとぺージ変更時に値が変わってしまう
tf.config_togglebutton[0].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 0));
tf.config_togglebutton[1].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 1));
tf.config_togglebutton[2].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 2));
tf.config_togglebutton[3].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 3));
tf.config_togglebutton[4].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 4));
tf.config_togglebutton[5].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 5));
tf.config_togglebutton[6].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 6));
tf.config_togglebutton[7].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 7));
tf.config_togglebutton[8].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 8));
tf.config_togglebutton[9].checked  = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 9));
tf.config_togglebutton[10].checked = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 10));
tf.config_togglebutton[11].checked = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 11));
tf.config_togglebutton[12].checked = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 12));
tf.config_togglebutton[13].checked = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 13));
tf.config_togglebutton[14].checked = Scripts.eval('config_plugin_obj.togglebutton_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*15 + 14));

tf.config_togglebutton[0].draw(); 
tf.config_togglebutton[1].draw(); 
tf.config_togglebutton[2].draw(); 
tf.config_togglebutton[3].draw(); 
tf.config_togglebutton[4].draw(); 
tf.config_togglebutton[5].draw(); 
tf.config_togglebutton[6].draw(); 
tf.config_togglebutton[7].draw(); 
tf.config_togglebutton[8].draw(); 
tf.config_togglebutton[9].draw(); 
tf.config_togglebutton[10].draw();
tf.config_togglebutton[11].draw();
tf.config_togglebutton[12].draw();
tf.config_togglebutton[13].draw();
tf.config_togglebutton[14].draw();


//ぺージ用------------------------------------------------------------------ 
tf.config_togglebutton[15].setOptions( %[visible:config_plugin_obj.page1_visible, left:config_plugin_obj.page1_pos[0], top:config_plugin_obj.page1_pos[1], oncheck:"config_plugin_obj.nowpage = 1, kag.process('config.ks', '*pagedraw')", onuncheck:"kag.process('config.ks', '*pagedraw')", graphic:config_plugin_obj.page1_button, checked:config_plugin_obj.nowpage == 1]);
tf.config_togglebutton[16].setOptions( %[visible:config_plugin_obj.page2_visible, left:config_plugin_obj.page2_pos[0], top:config_plugin_obj.page2_pos[1], oncheck:"config_plugin_obj.nowpage = 2, kag.process('config.ks', '*pagedraw')", onuncheck:"kag.process('config.ks', '*pagedraw')", graphic:config_plugin_obj.page2_button, checked:config_plugin_obj.nowpage == 2]);
tf.config_togglebutton[17].setOptions( %[visible:config_plugin_obj.page3_visible, left:config_plugin_obj.page3_pos[0], top:config_plugin_obj.page3_pos[1], oncheck:"config_plugin_obj.nowpage = 3, kag.process('config.ks', '*pagedraw')", onuncheck:"kag.process('config.ks', '*pagedraw')", graphic:config_plugin_obj.page3_button, checked:config_plugin_obj.nowpage == 3]);

// スライダー設定----------------------------------------------------------- 
with(tf.config_slider[0]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 0]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 0][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 0][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 0)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 0); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 0); .updateState(); }
with(tf.config_slider[1]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 1]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 1][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 1][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 1)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 1); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 1); .updateState(); }
with(tf.config_slider[2]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 2]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 2][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 2][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 2)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 2); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 2); .updateState(); }
with(tf.config_slider[3]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 3]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 3][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 3][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 3)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 3); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 3); .updateState(); }
with(tf.config_slider[4]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 4]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 4][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 4][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 4)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 4); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 4); .updateState(); }
with(tf.config_slider[5]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 5]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 5][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 5][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 5)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 5); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 5); .updateState(); }
with(tf.config_slider[6]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 6]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 6][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 6][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 6)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 6); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 6); .updateState(); }
with(tf.config_slider[7]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 7]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 7][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 7][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 7)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 7); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 7); .updateState(); }
with(tf.config_slider[8]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 8]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 8][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 8][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 8)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 8); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 8); .updateState(); }
with(tf.config_slider[9]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 9]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 9][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 9][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 9)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 9); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 9); .updateState(); }
@endscript

;ジャンプから戻るため
*return
@s

; コンフィグ画面を閉じます-------------------------------------------------- 
*back
; コンフィグ画面表示前の状態を復元します(但し BGM は復元しません)
@tempload place=0 bgm=false
; メッセージ履歴の出力・表示を有効にします(但しセーブ不可ならタイトル画面と判断)
@history output=true enabled=true cond="kag.canStore()"

@current layer=message0
;終了時サブルーチンを呼ぶ
@call storage=&config_plugin_obj.close_sub_storage target=&config_plugin_obj.close_sub_label

@iscript
// システムボタンを使っていて、コンフィグ画面を表示する前にメッセージレイヤが表示されていた時は onMessageHiddenStateChanged を呼び出します
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(false);
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(false);
//これをやらないとメモリリークになる?
for (var i = 0; i < tf.config_button.count; i++)
	invalidate tf.config_button[i];
for (var i = 0; i < tf.config_slider.count; i++)
	invalidate tf.config_slider[i];
for (var i = 0; i < tf.config_togglebutton.count; i++)
	invalidate tf.config_togglebutton[i];
delete tf.config_slider;
delete tf.config_togglebutton;
delete tf.config_button;
// マウスホイールの動作を戻す
kag.onMouseWheel = config_onMouseWheel_org;
@endscript

;@return
@return cond="!kag.canStore()"
@return cond="tf.pre_menu_mode == 0 || tf.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="tf.pre_menu_mode == 1"
