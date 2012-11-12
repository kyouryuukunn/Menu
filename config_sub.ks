;開始時の処理
*config_sub_start
; 戻るために現在のメニューの設定を保存
@eval exp="tf.pre_menu_mode = sf.menu_mode"
@iscript
config_plugin_obj.button_01 = kag.fullScreened; // #0: ウィドウモード
config_plugin_obj.button_02 = sf.titleAsk; // #1: タイトルに戻るを確認するか
config_plugin_obj.button_03 = sf.exitAsk; // #2: ゲーム終了を確認するか
config_plugin_obj.button_04 = sf.qloadAsk; // #3: クイックロード時に確認するか
config_plugin_obj.button_05 = sf.returnAsk; // #4: 前の選択肢に戻るで確認するか
config_plugin_obj.button_06 = sf.saveAsk; // #5: セーブ上書き時に確認するか
config_plugin_obj.button_07 = sf.loadAsk; // #6: ロード時に確認するか
config_plugin_obj.button_08 = sf.pagebreak; // #7:「ページ末まで一度に表示」
config_plugin_obj.button_09 = sf.sceneskip; // #8: シーン毎のスキップをするか
config_plugin_obj.button_10 = sf.autocontinue; // #9: 選択肢後もオートモードを継続するか
config_plugin_obj.button_11 = sf.skipcontinue; // #10: 選択肢後もスキップモードを継続するか
config_plugin_obj.button_12 = sf.menu_mode == 0; // #11: マウスオンメニューを使用する
config_plugin_obj.button_13 = sf.menu_mode == 1; // #12: 右クリックメニューを使用する
config_plugin_obj.button_14 = sf.menu_mode == 2; // #13: システムメニューを使用する

config_plugin_obj.slider_01 = kag.bgm.buf1.volume2 / 100000;
config_plugin_obj.slider_02 = kag.se[0].volume2 / 100000;
config_plugin_obj.slider_03 = (100 - kag.chSpeed)/100;
config_plugin_obj.slider_04 = (2000 - kag.autoModePageWait)/2000;
config_plugin_obj.slider_05 = sf.messageopacity / 255;
@endscript

@return


;終了時の処理
;右クリックの設定もここでする
*config_sub_close
@iscript
// 変数の変更を反映する
sf.titleAsk		=	config_plugin_obj.button_02; // #1: タイトルに戻るを確認するか
sf.exitAsk		=	config_plugin_obj.button_03; // #2: ゲーム終了を確認するか
sf.qloadAsk		=	config_plugin_obj.button_04; // #3: クイックロード時に確認するか
sf.returnAsk		=	config_plugin_obj.button_05; // #4: 前の選択肢に戻るで確認するか
sf.saveAsk		=	config_plugin_obj.button_06; // #5: セーブ上書き時に確認するか
sf.loadAsk		=	config_plugin_obj.button_07; // #6: ロード時に確認するか
sf.pagebreak		=	config_plugin_obj.button_08; // #7:「ページ末まで一度に表示」
sf.sceneskip		=	config_plugin_obj.button_09; // #8: シーン毎のスキップをするか
sf.autocontinue		=	config_plugin_obj.button_10; // #9: 選択肢後もオートモードを継続するか
sf.skipcontinue		=	config_plugin_obj.button_11; // #10: 選択肢後もスキップモードを継続するか
@endscript

@set_menu
; メッセージ履歴の出力・表示を有効にします
@history output=true enabled=true cond="kag.canStore()"
; メッセージ表示速度の設定を反映します
@delay speed=user cond="kag.chUserMode"

@return


;各サブルーチン変更を即座に反映したいときはここに記述する
*config_sub_button_01
; ウィンドウモードの「フルスクリーン」をクリックした時に実行されるスクリプト
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@jump storage=config.ks target=*return

*config_sub_button_02
@jump storage=config.ks target=*return
*config_sub_button_03
@jump storage=config.ks target=*return
*config_sub_button_04
@jump storage=config.ks target=*return
*config_sub_button_05
@jump storage=config.ks target=*return
*config_sub_button_06
@jump storage=config.ks target=*return
*config_sub_button_07
@jump storage=config.ks target=*return
*config_sub_button_08
@jump storage=config.ks target=*return
*config_sub_button_09
@jump storage=config.ks target=*return
*config_sub_button_10
@jump storage=config.ks target=*return
*config_sub_button_11
@jump storage=config.ks target=*return
*config_sub_button_12
;ラジオボタンにするために
;その場で他のボタンを変更する
;配列の数字はひとつずれているので注意
@eval exp="sf.menu_mode=0 if config_plugin_obj.button_12"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_14 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_13
@eval exp="sf.menu_mode=1 if config_plugin_obj.button_13"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_14 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_14
@eval exp="sf.menu_mode=2 if config_plugin_obj.button_14"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_14 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_15
@jump storage=config.ks target=*return
*config_sub_button_16
@jump storage=config.ks target=*return
*config_sub_button_17
@jump storage=config.ks target=*return
*config_sub_button_18
@jump storage=config.ks target=*return
*config_sub_button_19
@jump storage=config.ks target=*return
*config_sub_button_20
@jump storage=config.ks target=*return
*config_sub_button_21
@jump storage=config.ks target=*return
*config_sub_button_22
@jump storage=config.ks target=*return
*config_sub_button_23
@jump storage=config.ks target=*return
*config_sub_button_24
@jump storage=config.ks target=*return
*config_sub_button_25
@jump storage=config.ks target=*return
*config_sub_button_26
@jump storage=config.ks target=*return
*config_sub_button_27
@jump storage=config.ks target=*return
*config_sub_button_28
@jump storage=config.ks target=*return
*config_sub_button_29
@jump storage=config.ks target=*return
*config_sub_button_30
@jump storage=config.ks target=*return
*config_sub_button_31
@jump storage=config.ks target=*return
*config_sub_button_32
@jump storage=config.ks target=*return
*config_sub_button_33
@jump storage=config.ks target=*return
*config_sub_button_34
@jump storage=config.ks target=*return
*config_sub_button_35
@jump storage=config.ks target=*return
*config_sub_button_36
@jump storage=config.ks target=*return
*config_sub_button_37
@jump storage=config.ks target=*return
*config_sub_button_38
@jump storage=config.ks target=*return
*config_sub_button_39
@jump storage=config.ks target=*return
*config_sub_button_40
@jump storage=config.ks target=*return
*config_sub_button_41
@jump storage=config.ks target=*return
*config_sub_button_42
@jump storage=config.ks target=*return
*config_sub_button_43
@jump storage=config.ks target=*return
*config_sub_button_44
@jump storage=config.ks target=*return
*config_sub_button_45
@jump storage=config.ks target=*return

;スライダー用サブルーチン
*config_sub_slider_01
@bgmopt gvolume="&config_plugin_obj.slider_01*100"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"
@jump storage=config.ks target=*return
*config_sub_slider_02
@seopt gvolume="&config_plugin_obj.slider_02*100"
@eval exp="&sf.sevolume = kag.se[0].volume2"
@jump storage=config.ks target=*return
*config_sub_slider_03
@eval exp="kag.userChSpeed=100 - config_plugin_obj.slider_03*100"
@jump storage=config.ks target=*return
*config_sub_slider_04
@eval exp="&kag.autoModePageWait = 2000 -  config_plugin_obj.slider_04 * 2000;"
@eval exp="&kag.autoModeLineWait = 1000 -  config_plugin_obj.slider_04 * 1000;"
@jump storage=config.ks target=*return
*config_sub_slider_05
@eval exp="&sf.messageopacity = (config_plugin_obj.slider_05 * 255)"
@eval exp="&SetMessageOpacity_object.foreLay.opacity = sf.messageopacity"
@eval exp="&SetMessageOpacity_object.backLay.opacity = sf.messageopacity"
@jump storage=config.ks target=*return
*config_sub_slider_06
@jump storage=config.ks target=*return
*config_sub_slider_07
@jump storage=config.ks target=*return
*config_sub_slider_08
@jump storage=config.ks target=*return
*config_sub_slider_09
@jump storage=config.ks target=*return
*config_sub_slider_10
@jump storage=config.ks target=*return
*config_sub_slider_11
@jump storage=config.ks target=*return
*config_sub_slider_12
@jump storage=config.ks target=*return
*config_sub_slider_13
@jump storage=config.ks target=*return
*config_sub_slider_14
@jump storage=config.ks target=*return
*config_sub_slider_15
@jump storage=config.ks target=*return
*config_sub_slider_16
@jump storage=config.ks target=*return
*config_sub_slider_17
@jump storage=config.ks target=*return
*config_sub_slider_18
@jump storage=config.ks target=*return
*config_sub_slider_19
@jump storage=config.ks target=*return
*config_sub_slider_20
@jump storage=config.ks target=*return
*config_sub_slider_21
@jump storage=config.ks target=*return
*config_sub_slider_22
@jump storage=config.ks target=*return
*config_sub_slider_23
@jump storage=config.ks target=*return
*config_sub_slider_24
@jump storage=config.ks target=*return
*config_sub_slider_25
@jump storage=config.ks target=*return
*config_sub_slider_26
@jump storage=config.ks target=*return
*config_sub_slider_27
@jump storage=config.ks target=*return
*config_sub_slider_28
@jump storage=config.ks target=*return
*config_sub_slider_29
@jump storage=config.ks target=*return
*config_sub_slider_30
@jump storage=config.ks target=*return
