*initialize

;開始時サブルーチンを呼ぶ
@call storage=&config_plugin_obj.start_sub_storage target=&config_plugin_obj.start_sub_label
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
//マウスを中心に移動
kag.fore.base.cursorX = kag.scWidth/2;
kag.fore.base.cursorY = kag.scHeight/2;
@endscript


; レイヤを必要な数確保します
@laycount layers="&kag.numCharacterLayers + 1" messages="&kag.numMessageLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
@layopt index="&2000000+200" layer="&kag.numMessageLayers - 1"
; 背景
@image layer="&kag.numCharacterLayers-1" storage=&config_plugin_obj.back[config_plugin_obj.nowpage-1] page=fore visible=true
; メッセージレイヤの設定をします
@current layer="&'message' + (kag.numMessageLayers - 1)"
@position opacity=0 marginb=0 marginl=0 marginr=0 margint=0 left=0 top=0 width=&kag.scWidth height=&kag.scHeight visible=true
;閉じるボタン
@locate x=&config_plugin_obj.close_x y=&config_plugin_obj.close_y
@button storage=config.ks target=*back graphic=&config_plugin_obj.close_button

; ボタン設定
@iscript
tf.config_togglebutton = [];
for (var i = 0; i < 48; i++){
	tf.config_togglebutton[i] = new KToggleButtonLayer(kag, kag.fore.layers[kag.numCharacterLayers-1]);
}
tf.config_togglebutton[0].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_01_visible : 0, left:config_plugin_obj.button_01_pos[0], top:config_plugin_obj.button_01_pos[1], oncheck:'config_plugin_obj.button_01 = 1', onuncheck:'config_plugin_obj.button_01 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_01', unchecktarget:'*config_sub_button_01', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_01]);
tf.config_togglebutton[1].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_02_visible : 0, left:config_plugin_obj.button_02_pos[0], top:config_plugin_obj.button_02_pos[1], oncheck:'config_plugin_obj.button_02 = 1', onuncheck:'config_plugin_obj.button_02 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_02', unchecktarget:'*config_sub_button_02', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_02]);
tf.config_togglebutton[2].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_03_visible : 0, left:config_plugin_obj.button_03_pos[0], top:config_plugin_obj.button_03_pos[1], oncheck:'config_plugin_obj.button_03 = 1', onuncheck:'config_plugin_obj.button_03 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_03', unchecktarget:'*config_sub_button_03', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_03]);
tf.config_togglebutton[3].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_04_visible : 0, left:config_plugin_obj.button_04_pos[0], top:config_plugin_obj.button_04_pos[1], oncheck:'config_plugin_obj.button_04 = 1', onuncheck:'config_plugin_obj.button_04 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_04', unchecktarget:'*config_sub_button_04', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_04]);
tf.config_togglebutton[4].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_05_visible : 0, left:config_plugin_obj.button_05_pos[0], top:config_plugin_obj.button_05_pos[1], oncheck:'config_plugin_obj.button_05 = 1', onuncheck:'config_plugin_obj.button_05 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_05', unchecktarget:'*config_sub_button_05', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_05]);
tf.config_togglebutton[5].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_06_visible : 0, left:config_plugin_obj.button_06_pos[0], top:config_plugin_obj.button_06_pos[1], oncheck:'config_plugin_obj.button_06 = 1', onuncheck:'config_plugin_obj.button_06 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_06', unchecktarget:'*config_sub_button_06', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_06]);
tf.config_togglebutton[6].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_07_visible : 0, left:config_plugin_obj.button_07_pos[0], top:config_plugin_obj.button_07_pos[1], oncheck:'config_plugin_obj.button_07 = 1', onuncheck:'config_plugin_obj.button_07 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_07', unchecktarget:'*config_sub_button_07', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_07]);
tf.config_togglebutton[7].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_08_visible : 0, left:config_plugin_obj.button_08_pos[0], top:config_plugin_obj.button_08_pos[1], oncheck:'config_plugin_obj.button_08 = 1', onuncheck:'config_plugin_obj.button_08 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_08', unchecktarget:'*config_sub_button_08', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_08]);
tf.config_togglebutton[8].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_09_visible : 0, left:config_plugin_obj.button_09_pos[0], top:config_plugin_obj.button_09_pos[1], oncheck:'config_plugin_obj.button_09 = 1', onuncheck:'config_plugin_obj.button_09 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_09', unchecktarget:'*config_sub_button_09', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_09]);
tf.config_togglebutton[9].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_10_visible : 0, left:config_plugin_obj.button_10_pos[0], top:config_plugin_obj.button_10_pos[1], oncheck:'config_plugin_obj.button_10 = 1', onuncheck:'config_plugin_obj.button_10 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_10', unchecktarget:'*config_sub_button_10', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_10]);
tf.config_togglebutton[10].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_11_visible : 0, left:config_plugin_obj.button_11_pos[0], top:config_plugin_obj.button_11_pos[1], oncheck:'config_plugin_obj.button_11 = 1', onuncheck:'config_plugin_obj.button_11 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_11', unchecktarget:'*config_sub_button_11', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_11]);
tf.config_togglebutton[11].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_12_visible : 0, left:config_plugin_obj.button_12_pos[0], top:config_plugin_obj.button_12_pos[1], oncheck:'config_plugin_obj.button_12 = 1', onuncheck:'config_plugin_obj.button_12 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_12', unchecktarget:'*config_sub_button_12', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_12]);
tf.config_togglebutton[12].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_13_visible : 0, left:config_plugin_obj.button_13_pos[0], top:config_plugin_obj.button_13_pos[1], oncheck:'config_plugin_obj.button_13 = 1', onuncheck:'config_plugin_obj.button_13 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_13', unchecktarget:'*config_sub_button_13', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_13]);
tf.config_togglebutton[13].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_14_visible : 0, left:config_plugin_obj.button_14_pos[0], top:config_plugin_obj.button_14_pos[1], oncheck:'config_plugin_obj.button_14 = 1', onuncheck:'config_plugin_obj.button_14 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_14', unchecktarget:'*config_sub_button_14', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_14]);
tf.config_togglebutton[14].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_15_visible : 0, left:config_plugin_obj.button_15_pos[0], top:config_plugin_obj.button_15_pos[1], oncheck:'config_plugin_obj.button_15 = 1', onuncheck:'config_plugin_obj.button_15 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_15', unchecktarget:'*config_sub_button_15', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_15]);
tf.config_togglebutton[15].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_16_visible : 0, left:config_plugin_obj.button_16_pos[0], top:config_plugin_obj.button_16_pos[1], oncheck:'config_plugin_obj.button_16 = 1', onuncheck:'config_plugin_obj.button_16 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_16', unchecktarget:'*config_sub_button_16', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_16]);
tf.config_togglebutton[16].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_17_visible : 0, left:config_plugin_obj.button_17_pos[0], top:config_plugin_obj.button_17_pos[1], oncheck:'config_plugin_obj.button_17 = 1', onuncheck:'config_plugin_obj.button_17 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_17', unchecktarget:'*config_sub_button_17', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_17]);
tf.config_togglebutton[17].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_18_visible : 0, left:config_plugin_obj.button_18_pos[0], top:config_plugin_obj.button_18_pos[1], oncheck:'config_plugin_obj.button_18 = 1', onuncheck:'config_plugin_obj.button_18 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_18', unchecktarget:'*config_sub_button_18', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_18]);
tf.config_togglebutton[18].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_19_visible : 0, left:config_plugin_obj.button_19_pos[0], top:config_plugin_obj.button_19_pos[1], oncheck:'config_plugin_obj.button_19 = 1', onuncheck:'config_plugin_obj.button_19 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_19', unchecktarget:'*config_sub_button_19', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_19]);
tf.config_togglebutton[19].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_20_visible : 0, left:config_plugin_obj.button_20_pos[0], top:config_plugin_obj.button_20_pos[1], oncheck:'config_plugin_obj.button_20 = 1', onuncheck:'config_plugin_obj.button_20 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_20', unchecktarget:'*config_sub_button_20', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_20]);
tf.config_togglebutton[20].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_21_visible : 0, left:config_plugin_obj.button_21_pos[0], top:config_plugin_obj.button_21_pos[1], oncheck:'config_plugin_obj.button_21 = 1', onuncheck:'config_plugin_obj.button_21 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_21', unchecktarget:'*config_sub_button_21', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_21]);
tf.config_togglebutton[21].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_22_visible : 0, left:config_plugin_obj.button_22_pos[0], top:config_plugin_obj.button_22_pos[1], oncheck:'config_plugin_obj.button_22 = 1', onuncheck:'config_plugin_obj.button_22 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_22', unchecktarget:'*config_sub_button_22', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_22]);
tf.config_togglebutton[22].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_23_visible : 0, left:config_plugin_obj.button_23_pos[0], top:config_plugin_obj.button_23_pos[1], oncheck:'config_plugin_obj.button_23 = 1', onuncheck:'config_plugin_obj.button_23 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_23', unchecktarget:'*config_sub_button_23', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_23]);
tf.config_togglebutton[23].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_24_visible : 0, left:config_plugin_obj.button_24_pos[0], top:config_plugin_obj.button_24_pos[1], oncheck:'config_plugin_obj.button_24 = 1', onuncheck:'config_plugin_obj.button_24 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_24', unchecktarget:'*config_sub_button_24', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_24]);
tf.config_togglebutton[24].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_25_visible : 0, left:config_plugin_obj.button_25_pos[0], top:config_plugin_obj.button_25_pos[1], oncheck:'config_plugin_obj.button_25 = 1', onuncheck:'config_plugin_obj.button_25 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_25', unchecktarget:'*config_sub_button_25', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_25]);
tf.config_togglebutton[25].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_26_visible : 0, left:config_plugin_obj.button_26_pos[0], top:config_plugin_obj.button_26_pos[1], oncheck:'config_plugin_obj.button_26 = 1', onuncheck:'config_plugin_obj.button_26 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_26', unchecktarget:'*config_sub_button_26', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_26]);
tf.config_togglebutton[26].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_27_visible : 0, left:config_plugin_obj.button_27_pos[0], top:config_plugin_obj.button_27_pos[1], oncheck:'config_plugin_obj.button_27 = 1', onuncheck:'config_plugin_obj.button_27 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_27', unchecktarget:'*config_sub_button_27', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_27]);
tf.config_togglebutton[27].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_28_visible : 0, left:config_plugin_obj.button_28_pos[0], top:config_plugin_obj.button_28_pos[1], oncheck:'config_plugin_obj.button_28 = 1', onuncheck:'config_plugin_obj.button_28 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_28', unchecktarget:'*config_sub_button_28', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_28]);
tf.config_togglebutton[28].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_29_visible : 0, left:config_plugin_obj.button_29_pos[0], top:config_plugin_obj.button_29_pos[1], oncheck:'config_plugin_obj.button_29 = 1', onuncheck:'config_plugin_obj.button_29 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_29', unchecktarget:'*config_sub_button_29', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_29]);
tf.config_togglebutton[29].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_30_visible : 0, left:config_plugin_obj.button_30_pos[0], top:config_plugin_obj.button_30_pos[1], oncheck:'config_plugin_obj.button_30 = 1', onuncheck:'config_plugin_obj.button_30 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_30', unchecktarget:'*config_sub_button_30', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_30]);
tf.config_togglebutton[30].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_31_visible : 0, left:config_plugin_obj.button_31_pos[0], top:config_plugin_obj.button_31_pos[1], oncheck:'config_plugin_obj.button_31 = 1', onuncheck:'config_plugin_obj.button_31 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_31', unchecktarget:'*config_sub_button_31', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_31]);
tf.config_togglebutton[31].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_32_visible : 0, left:config_plugin_obj.button_32_pos[0], top:config_plugin_obj.button_32_pos[1], oncheck:'config_plugin_obj.button_32 = 1', onuncheck:'config_plugin_obj.button_32 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_32', unchecktarget:'*config_sub_button_32', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_32]);
tf.config_togglebutton[32].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_33_visible : 0, left:config_plugin_obj.button_33_pos[0], top:config_plugin_obj.button_33_pos[1], oncheck:'config_plugin_obj.button_33 = 1', onuncheck:'config_plugin_obj.button_33 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_33', unchecktarget:'*config_sub_button_33', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_33]);
tf.config_togglebutton[33].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_34_visible : 0, left:config_plugin_obj.button_34_pos[0], top:config_plugin_obj.button_34_pos[1], oncheck:'config_plugin_obj.button_34 = 1', onuncheck:'config_plugin_obj.button_34 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_34', unchecktarget:'*config_sub_button_34', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_34]);
tf.config_togglebutton[34].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_35_visible : 0, left:config_plugin_obj.button_35_pos[0], top:config_plugin_obj.button_35_pos[1], oncheck:'config_plugin_obj.button_35 = 1', onuncheck:'config_plugin_obj.button_35 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_35', unchecktarget:'*config_sub_button_35', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_35]);
tf.config_togglebutton[35].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_36_visible : 0, left:config_plugin_obj.button_36_pos[0], top:config_plugin_obj.button_36_pos[1], oncheck:'config_plugin_obj.button_36 = 1', onuncheck:'config_plugin_obj.button_36 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_36', unchecktarget:'*config_sub_button_36', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_36]);
tf.config_togglebutton[36].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_37_visible : 0, left:config_plugin_obj.button_37_pos[0], top:config_plugin_obj.button_37_pos[1], oncheck:'config_plugin_obj.button_37 = 1', onuncheck:'config_plugin_obj.button_37 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_37', unchecktarget:'*config_sub_button_37', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_37]);
tf.config_togglebutton[37].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_38_visible : 0, left:config_plugin_obj.button_38_pos[0], top:config_plugin_obj.button_38_pos[1], oncheck:'config_plugin_obj.button_38 = 1', onuncheck:'config_plugin_obj.button_38 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_38', unchecktarget:'*config_sub_button_38', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_38]);
tf.config_togglebutton[38].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_39_visible : 0, left:config_plugin_obj.button_39_pos[0], top:config_plugin_obj.button_39_pos[1], oncheck:'config_plugin_obj.button_39 = 1', onuncheck:'config_plugin_obj.button_39 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_39', unchecktarget:'*config_sub_button_39', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_39]);
tf.config_togglebutton[39].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_40_visible : 0, left:config_plugin_obj.button_40_pos[0], top:config_plugin_obj.button_40_pos[1], oncheck:'config_plugin_obj.button_40 = 1', onuncheck:'config_plugin_obj.button_40 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_40', unchecktarget:'*config_sub_button_40', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_40]);
tf.config_togglebutton[40].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_41_visible : 0, left:config_plugin_obj.button_41_pos[0], top:config_plugin_obj.button_41_pos[1], oncheck:'config_plugin_obj.button_41 = 1', onuncheck:'config_plugin_obj.button_41 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_41', unchecktarget:'*config_sub_button_41', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_41]);
tf.config_togglebutton[41].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_42_visible : 0, left:config_plugin_obj.button_42_pos[0], top:config_plugin_obj.button_42_pos[1], oncheck:'config_plugin_obj.button_42 = 1', onuncheck:'config_plugin_obj.button_42 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_42', unchecktarget:'*config_sub_button_42', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_42]);
tf.config_togglebutton[42].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_43_visible : 0, left:config_plugin_obj.button_43_pos[0], top:config_plugin_obj.button_43_pos[1], oncheck:'config_plugin_obj.button_43 = 1', onuncheck:'config_plugin_obj.button_43 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_43', unchecktarget:'*config_sub_button_43', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_43]);
tf.config_togglebutton[43].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_44_visible : 0, left:config_plugin_obj.button_44_pos[0], top:config_plugin_obj.button_44_pos[1], oncheck:'config_plugin_obj.button_44 = 1', onuncheck:'config_plugin_obj.button_44 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_44', unchecktarget:'*config_sub_button_44', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_44]);
tf.config_togglebutton[44].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_45_visible : 0, left:config_plugin_obj.button_45_pos[0], top:config_plugin_obj.button_45_pos[1], oncheck:'config_plugin_obj.button_45 = 1', onuncheck:'config_plugin_obj.button_45 = 0', checkstorage:'config_sub.ks', uncheckstorage:'config_sub.ks', checktarget:'*config_sub_button_45', unchecktarget:'*config_sub_button_45', graphic:config_plugin_obj.graphic, checked:config_plugin_obj.button_45]);
tf.config_togglebutton[45].setOptions( %[visible:config_plugin_obj.page1_visible, left:config_plugin_obj.page1_pos[0], top:config_plugin_obj.page1_pos[1], oncheck:"config_plugin_obj.nowpage = 1, kag.process('config.ks', '*pagedraw')", onuncheck:"kag.process('config.ks', '*pagedraw')", graphic:config_plugin_obj.page1_button, checked:config_plugin_obj.nowpage == 1]);
tf.config_togglebutton[46].setOptions( %[visible:config_plugin_obj.page2_visible, left:config_plugin_obj.page2_pos[0], top:config_plugin_obj.page2_pos[1], oncheck:"config_plugin_obj.nowpage = 2, kag.process('config.ks', '*pagedraw')", onuncheck:"kag.process('config.ks', '*pagedraw')", graphic:config_plugin_obj.page2_button, checked:config_plugin_obj.nowpage == 2]);
tf.config_togglebutton[47].setOptions( %[visible:config_plugin_obj.page3_visible, left:config_plugin_obj.page3_pos[0], top:config_plugin_obj.page3_pos[1], oncheck:"config_plugin_obj.nowpage = 3, kag.process('config.ks', '*pagedraw')", onuncheck:"kag.process('config.ks', '*pagedraw')", graphic:config_plugin_obj.page3_button, checked:config_plugin_obj.nowpage == 3]);

// ◆スライダー設定
tf.config_slider = new Array();
for (var i=0; i < 30; i++){
	tf.config_slider[i] = new KSliderLayer(kag, kag.fore.layers[kag.numCharacterLayers - 1]);
	with(tf.config_slider[i]){
		.setOptions(%['graphic' => config_plugin_obj.slider_base, 'tabgraphic' => config_plugin_obj.slider_tab]);
	}
}
with(tf.config_slider[0]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_01_visible : 0; .left = config_plugin_obj.slider_01_pos[0]; .top =  config_plugin_obj.slider_01_pos[1]; .hval = config_plugin_obj.slider_01; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_01'; .onchangefunc = 'config_plugin_obj.slider_01_func'; .updateState(); }
with(tf.config_slider[1]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_02_visible : 0; .left = config_plugin_obj.slider_02_pos[0]; .top =  config_plugin_obj.slider_02_pos[1]; .hval = config_plugin_obj.slider_02; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_02'; .onchangefunc = 'config_plugin_obj.slider_02_func'; .updateState(); }
with(tf.config_slider[2]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_03_visible : 0; .left = config_plugin_obj.slider_03_pos[0]; .top =  config_plugin_obj.slider_03_pos[1]; .hval = config_plugin_obj.slider_03; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_03'; .onchangefunc = 'config_plugin_obj.slider_03_func'; .updateState(); }
with(tf.config_slider[3]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_04_visible : 0; .left = config_plugin_obj.slider_04_pos[0]; .top =  config_plugin_obj.slider_04_pos[1]; .hval = config_plugin_obj.slider_04; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_04'; .onchangefunc = 'config_plugin_obj.slider_04_func'; .updateState(); }
with(tf.config_slider[4]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_05_visible : 0; .left = config_plugin_obj.slider_05_pos[0]; .top =  config_plugin_obj.slider_05_pos[1]; .hval = config_plugin_obj.slider_05; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_05'; .onchangefunc = 'config_plugin_obj.slider_05_func'; .updateState(); }
with(tf.config_slider[5]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_06_visible : 0; .left = config_plugin_obj.slider_06_pos[0]; .top =  config_plugin_obj.slider_06_pos[1]; .hval = config_plugin_obj.slider_06; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_06'; .onchangefunc = 'config_plugin_obj.slider_06_func'; .updateState(); }
with(tf.config_slider[6]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_07_visible : 0; .left = config_plugin_obj.slider_07_pos[0]; .top =  config_plugin_obj.slider_07_pos[1]; .hval = config_plugin_obj.slider_07; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_07'; .onchangefunc = 'config_plugin_obj.slider_07_func'; .updateState(); }
with(tf.config_slider[7]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_08_visible : 0; .left = config_plugin_obj.slider_08_pos[0]; .top =  config_plugin_obj.slider_08_pos[1]; .hval = config_plugin_obj.slider_08; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_08'; .onchangefunc = 'config_plugin_obj.slider_08_func'; .updateState(); }
with(tf.config_slider[8]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_09_visible : 0; .left = config_plugin_obj.slider_09_pos[0]; .top =  config_plugin_obj.slider_09_pos[1]; .hval = config_plugin_obj.slider_09; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_09'; .onchangefunc = 'config_plugin_obj.slider_09_func'; .updateState(); }
with(tf.config_slider[9]){  .countpage = 0; .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_10_visible : 0; .left = config_plugin_obj.slider_10_pos[0]; .top =  config_plugin_obj.slider_10_pos[1]; .hval = config_plugin_obj.slider_10; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_10'; .onchangefunc = 'config_plugin_obj.slider_10_func'; .updateState(); }
with(tf.config_slider[10]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_11_visible : 0; .left = config_plugin_obj.slider_11_pos[0]; .top =  config_plugin_obj.slider_11_pos[1]; .hval = config_plugin_obj.slider_11; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_11'; .onchangefunc = 'config_plugin_obj.slider_11_func'; .updateState(); }
with(tf.config_slider[11]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_12_visible : 0; .left = config_plugin_obj.slider_12_pos[0]; .top =  config_plugin_obj.slider_12_pos[1]; .hval = config_plugin_obj.slider_12; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_12'; .onchangefunc = 'config_plugin_obj.slider_12_func'; .updateState(); }
with(tf.config_slider[12]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_13_visible : 0; .left = config_plugin_obj.slider_13_pos[0]; .top =  config_plugin_obj.slider_13_pos[1]; .hval = config_plugin_obj.slider_13; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_13'; .onchangefunc = 'config_plugin_obj.slider_13_func'; .updateState(); }
with(tf.config_slider[13]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_14_visible : 0; .left = config_plugin_obj.slider_14_pos[0]; .top =  config_plugin_obj.slider_14_pos[1]; .hval = config_plugin_obj.slider_14; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_14'; .onchangefunc = 'config_plugin_obj.slider_14_func'; .updateState(); }
with(tf.config_slider[14]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_15_visible : 0; .left = config_plugin_obj.slider_15_pos[0]; .top =  config_plugin_obj.slider_15_pos[1]; .hval = config_plugin_obj.slider_15; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_15'; .onchangefunc = 'config_plugin_obj.slider_15_func'; .updateState(); }
with(tf.config_slider[15]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_16_visible : 0; .left = config_plugin_obj.slider_16_pos[0]; .top =  config_plugin_obj.slider_16_pos[1]; .hval = config_plugin_obj.slider_16; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_16'; .onchangefunc = 'config_plugin_obj.slider_16_func'; .updateState(); }
with(tf.config_slider[16]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_17_visible : 0; .left = config_plugin_obj.slider_17_pos[0]; .top =  config_plugin_obj.slider_17_pos[1]; .hval = config_plugin_obj.slider_17; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_17'; .onchangefunc = 'config_plugin_obj.slider_17_func'; .updateState(); }
with(tf.config_slider[17]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_18_visible : 0; .left = config_plugin_obj.slider_18_pos[0]; .top =  config_plugin_obj.slider_18_pos[1]; .hval = config_plugin_obj.slider_18; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_18'; .onchangefunc = 'config_plugin_obj.slider_18_func'; .updateState(); }
with(tf.config_slider[18]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_19_visible : 0; .left = config_plugin_obj.slider_19_pos[0]; .top =  config_plugin_obj.slider_19_pos[1]; .hval = config_plugin_obj.slider_19; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_19'; .onchangefunc = 'config_plugin_obj.slider_19_func'; .updateState(); }
with(tf.config_slider[19]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_20_visible : 0; .left = config_plugin_obj.slider_20_pos[0]; .top =  config_plugin_obj.slider_20_pos[1]; .hval = config_plugin_obj.slider_20; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_20'; .onchangefunc = 'config_plugin_obj.slider_20_func'; .updateState(); }
with(tf.config_slider[20]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_21_visible : 0; .left = config_plugin_obj.slider_21_pos[0]; .top =  config_plugin_obj.slider_21_pos[1]; .hval = config_plugin_obj.slider_21; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_21'; .onchangefunc = 'config_plugin_obj.slider_21_func'; .updateState(); }
with(tf.config_slider[21]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_22_visible : 0; .left = config_plugin_obj.slider_22_pos[0]; .top =  config_plugin_obj.slider_22_pos[1]; .hval = config_plugin_obj.slider_22; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_22'; .onchangefunc = 'config_plugin_obj.slider_22_func'; .updateState(); }
with(tf.config_slider[22]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_23_visible : 0; .left = config_plugin_obj.slider_23_pos[0]; .top =  config_plugin_obj.slider_23_pos[1]; .hval = config_plugin_obj.slider_23; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_23'; .onchangefunc = 'config_plugin_obj.slider_23_func'; .updateState(); }
with(tf.config_slider[23]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_24_visible : 0; .left = config_plugin_obj.slider_24_pos[0]; .top =  config_plugin_obj.slider_24_pos[1]; .hval = config_plugin_obj.slider_24; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_24'; .onchangefunc = 'config_plugin_obj.slider_24_func'; .updateState(); }
with(tf.config_slider[24]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_25_visible : 0; .left = config_plugin_obj.slider_25_pos[0]; .top =  config_plugin_obj.slider_25_pos[1]; .hval = config_plugin_obj.slider_25; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_25'; .onchangefunc = 'config_plugin_obj.slider_25_func'; .updateState(); }
with(tf.config_slider[25]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_26_visible : 0; .left = config_plugin_obj.slider_26_pos[0]; .top =  config_plugin_obj.slider_26_pos[1]; .hval = config_plugin_obj.slider_26; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_26'; .onchangefunc = 'config_plugin_obj.slider_26_func'; .updateState(); }
with(tf.config_slider[26]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_27_visible : 0; .left = config_plugin_obj.slider_27_pos[0]; .top =  config_plugin_obj.slider_27_pos[1]; .hval = config_plugin_obj.slider_27; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_27'; .onchangefunc = 'config_plugin_obj.slider_27_func'; .updateState(); }
with(tf.config_slider[27]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_28_visible : 0; .left = config_plugin_obj.slider_28_pos[0]; .top =  config_plugin_obj.slider_28_pos[1]; .hval = config_plugin_obj.slider_28; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_28'; .onchangefunc = 'config_plugin_obj.slider_28_func'; .updateState(); }
with(tf.config_slider[28]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_29_visible : 0; .left = config_plugin_obj.slider_29_pos[0]; .top =  config_plugin_obj.slider_29_pos[1]; .hval = config_plugin_obj.slider_29; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_29'; .onchangefunc = 'config_plugin_obj.slider_29_func'; .updateState(); }
with(tf.config_slider[29]){ .countpage = 0; .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_30_visible : 0; .left = config_plugin_obj.slider_30_pos[0]; .top =  config_plugin_obj.slider_30_pos[1]; .hval = config_plugin_obj.slider_30; .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_30'; .onchangefunc = 'config_plugin_obj.slider_30_func'; .updateState(); }
@endscript

;ページを替えたときに戻る
*pagedraw
@er

;背景
@image layer="&kag.numCharacterLayers-1" storage=&config_plugin_obj.back[config_plugin_obj.nowpage-1] page=fore visible=true
;閉じるボタン
@locate x=&config_plugin_obj.close_x y=&config_plugin_obj.close_y
@button storage=config.ks target=*back graphic=&config_plugin_obj.close_button
@iscript
tf.config_togglebutton[0].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_01_visible : 0]);
tf.config_togglebutton[1].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_02_visible : 0]);
tf.config_togglebutton[2].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_03_visible : 0]);
tf.config_togglebutton[3].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_04_visible : 0]);
tf.config_togglebutton[4].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_05_visible : 0]);
tf.config_togglebutton[5].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_06_visible : 0]);
tf.config_togglebutton[6].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_07_visible : 0]);
tf.config_togglebutton[7].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_08_visible : 0]);
tf.config_togglebutton[8].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_09_visible : 0]);
tf.config_togglebutton[9].setOptions(  %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_10_visible : 0]);
tf.config_togglebutton[10].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_11_visible : 0]);
tf.config_togglebutton[11].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_12_visible : 0]);
tf.config_togglebutton[12].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_13_visible : 0]);
tf.config_togglebutton[13].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_14_visible : 0]);
tf.config_togglebutton[14].setOptions( %[visible:config_plugin_obj.nowpage == 1 ? config_plugin_obj.button_15_visible : 0]);
tf.config_togglebutton[15].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_16_visible : 0]);
tf.config_togglebutton[16].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_17_visible : 0]);
tf.config_togglebutton[17].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_18_visible : 0]);
tf.config_togglebutton[18].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_19_visible : 0]);
tf.config_togglebutton[19].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_20_visible : 0]);
tf.config_togglebutton[20].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_21_visible : 0]);
tf.config_togglebutton[21].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_22_visible : 0]);
tf.config_togglebutton[22].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_23_visible : 0]);
tf.config_togglebutton[23].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_24_visible : 0]);
tf.config_togglebutton[24].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_25_visible : 0]);
tf.config_togglebutton[25].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_26_visible : 0]);
tf.config_togglebutton[26].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_27_visible : 0]);
tf.config_togglebutton[27].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_28_visible : 0]);
tf.config_togglebutton[28].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_29_visible : 0]);
tf.config_togglebutton[29].setOptions( %[visible:config_plugin_obj.nowpage == 2 ? config_plugin_obj.button_30_visible : 0]);
tf.config_togglebutton[30].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_31_visible : 0]);
tf.config_togglebutton[31].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_32_visible : 0]);
tf.config_togglebutton[32].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_33_visible : 0]);
tf.config_togglebutton[33].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_34_visible : 0]);
tf.config_togglebutton[34].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_35_visible : 0]);
tf.config_togglebutton[35].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_36_visible : 0]);
tf.config_togglebutton[36].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_37_visible : 0]);
tf.config_togglebutton[37].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_38_visible : 0]);
tf.config_togglebutton[38].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_39_visible : 0]);
tf.config_togglebutton[39].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_40_visible : 0]);
tf.config_togglebutton[40].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_41_visible : 0]);
tf.config_togglebutton[41].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_42_visible : 0]);
tf.config_togglebutton[42].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_43_visible : 0]);
tf.config_togglebutton[43].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_44_visible : 0]);
tf.config_togglebutton[44].setOptions( %[visible:config_plugin_obj.nowpage == 3 ? config_plugin_obj.button_45_visible : 0]);
tf.config_togglebutton[45].setOptions( %[visible:config_plugin_obj.page1_visible, checked:config_plugin_obj.nowpage == 1]);
tf.config_togglebutton[46].setOptions( %[visible:config_plugin_obj.page2_visible, checked:config_plugin_obj.nowpage == 2]);
tf.config_togglebutton[47].setOptions( %[visible:config_plugin_obj.page3_visible, checked:config_plugin_obj.nowpage == 3]);

with(tf.config_slider[0]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_01_visible : 0; }
with(tf.config_slider[1]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_02_visible : 0; }
with(tf.config_slider[2]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_03_visible : 0; }
with(tf.config_slider[3]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_04_visible : 0; }
with(tf.config_slider[4]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_05_visible : 0; }
with(tf.config_slider[5]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_06_visible : 0; }
with(tf.config_slider[6]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_07_visible : 0; }
with(tf.config_slider[7]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_08_visible : 0; }
with(tf.config_slider[8]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_09_visible : 0; }
with(tf.config_slider[9]){  .visible = config_plugin_obj.nowpage == 1 ? config_plugin_obj.slider_10_visible : 0; }
with(tf.config_slider[10]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_11_visible : 0; }
with(tf.config_slider[11]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_12_visible : 0; }
with(tf.config_slider[12]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_13_visible : 0; }
with(tf.config_slider[13]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_14_visible : 0; }
with(tf.config_slider[14]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_15_visible : 0; }
with(tf.config_slider[15]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_16_visible : 0; }
with(tf.config_slider[16]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_17_visible : 0; }
with(tf.config_slider[17]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_18_visible : 0; }
with(tf.config_slider[18]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_19_visible : 0; }
with(tf.config_slider[19]){ .visible = config_plugin_obj.nowpage == 2 ? config_plugin_obj.slider_20_visible : 0; }
with(tf.config_slider[20]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_21_visible : 0; }
with(tf.config_slider[21]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_22_visible : 0; }
with(tf.config_slider[22]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_23_visible : 0; }
with(tf.config_slider[23]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_24_visible : 0; }
with(tf.config_slider[24]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_25_visible : 0; }
with(tf.config_slider[25]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_26_visible : 0; }
with(tf.config_slider[26]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_27_visible : 0; }
with(tf.config_slider[27]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_28_visible : 0; }
with(tf.config_slider[28]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_29_visible : 0; }
with(tf.config_slider[29]){ .visible = config_plugin_obj.nowpage == 3 ? config_plugin_obj.slider_30_visible : 0; }
@endscript
;ジャンプから戻るため
*return
@s

; コンフィグ画面を閉じます
*back
; コンフィグ画面表示前の状態を復元します(但し BGM は復元しません)
@tempload place=0 bgm=false
; メッセージ履歴の出力・表示を有効にします(但しセーブ不可ならタイトル画面と判断)
@history output=true enabled=true cond="kag.canStore()"

@iscript
// システムボタンを使っていて、コンフィグ画面を表示する前にメッセージレイヤが表示されていた時は onMessageHiddenStateChanged を呼び出します
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(false);
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(false);
//これをやらないとメモリリークになる?
for (var i = 0; i < tf.config_slider.count; i++)
	invalidate tf.config_slider[i];
for (var i = 0; i < tf.config_togglebutton.count; i++)
	invalidate tf.config_togglebutton[i];
delete tf.config_slider;
delete tf.config_togglebutton;
@endscript

@current layer=message0
;終了時サブルーチンを呼ぶ
@call storage=&config_plugin_obj.close_sub_storage target=&config_plugin_obj.close_sub_label
;@return
@return cond="!kag.canStore()"
@return cond="tf.pre_menu_mode == 0 || tf.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="tf.pre_menu_mode == 1"
