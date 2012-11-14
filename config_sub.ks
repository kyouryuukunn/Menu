;開始時の処理
*config_sub_start
; 戻るために現在のメニューの設定を保存
@eval exp="tf.pre_menu_mode = sf.menu_mode"
@iscript
config_plugin_obj.button_00 = kag.fullScreened; // #0: ウィドウモード
config_plugin_obj.button_01 = sf.titleAsk; // #1: タイトルに戻るを確認するか
config_plugin_obj.button_02 = sf.exitAsk; // #2: ゲーム終了を確認するか
config_plugin_obj.button_03 = sf.qloadAsk; // #3: クイックロード時に確認するか
config_plugin_obj.button_04 = sf.returnAsk; // #4: 前の選択肢に戻るで確認するか
config_plugin_obj.button_05 = sf.saveAsk; // #5: セーブ上書き時に確認するか
config_plugin_obj.button_06 = sf.loadAsk; // #6: ロード時に確認するか
config_plugin_obj.button_07 = kag.chNonStopToPageBreak; // #7:「ページ末まで一度に表示」
config_plugin_obj.button_08 = sf.sceneskip; // #8: シーン毎のスキップをするか
config_plugin_obj.button_09 = sf.autocontinue; // #9: 選択肢後もオートモードを継続するか
config_plugin_obj.button_10 = sf.skipcontinue; // #10: 選択肢後もスキップモードを継続するか
config_plugin_obj.button_11 = sf.menu_mode == 0; // #11: マウスオンメニューを使用する
config_plugin_obj.button_12 = sf.menu_mode == 1; // #12: 右クリックメニューを使用する
config_plugin_obj.button_13 = sf.menu_mode == 2; // #13: システムメニューを使用する

config_plugin_obj.slider_00 = kag.bgm.buf1.volume2 / 100000;
config_plugin_obj.slider_01 = kag.se[0].volume2 / 100000;
config_plugin_obj.slider_02 = (100 - kag.chSpeed)/100;
config_plugin_obj.slider_03 = (2000 - kag.autoModePageWait)/2000;
config_plugin_obj.slider_04 = sf.messageopacity / 255;
@endscript

@return


;終了時の処理
;右クリックの設定もここでする
*config_sub_close
; 右クリックの設定
@set_menu
; メッセージ表示速度の設定を反映します
@delay speed=user cond="kag.chUserMode"
@return


;各サブルーチン変更を即座に反映したいときはここに記述する
*config_sub_button_00
;#0: ウィドウモード
; ウィンドウモードの「フルスクリーン」をクリックした時に実行されるスクリプト
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@jump storage=config.ks target=*return
*config_sub_button_01
;#1: タイトルに戻るを確認するか
@eval exp="sf.titleAsk = config_plugin_obj.button_01"
@jump storage=config.ks target=*return
*config_sub_button_02
;#2: ゲーム終了を確認するか
@eval exp="sf.exitAsk = config_plugin_obj.button_02"
@jump storage=config.ks target=*return
*config_sub_button_03
;#3: クイックロード時に確認するか
@eval exp="sf.qloadAsk = config_plugin_obj.button_03"
@jump storage=config.ks target=*return
*config_sub_button_04
;#4: 前の選択肢に戻るで確認するか
@eval exp="sf.returnAsk = config_plugin_obj.button_04"
@jump storage=config.ks target=*return
*config_sub_button_05
;#5: セーブ上書き時に確認するか
@eval exp="sf.saveAsk = config_plugin_obj.button_05"
@jump storage=config.ks target=*return
*config_sub_button_06
;#6: ロード時に確認するか
@eval exp="sf.loadAsk = config_plugin_obj.button_06"
@jump storage=config.ks target=*return
*config_sub_button_07
;#7:「ページ末まで一度に表示」
@eval exp="sf.pagebreak = config_plugin_obj.button_07"
@eval exp="kag.onChNonStopToPageBreakItemClick()"
@jump storage=config.ks target=*return
*config_sub_button_08
;#8: シーン毎のスキップをするか
@eval exp="sf.sceneskip = config_plugin_obj.button_08"
@jump storage=config.ks target=*return
*config_sub_button_09
;#9: 選択肢後もオートモードを継続するか
@eval exp="sf.autocontinue = config_plugin_obj.button_09"
@jump storage=config.ks target=*return
*config_sub_button_10
;#10: 選択肢後もスキップモードを継続するか
@eval exp="sf.skipcontinue = config_plugin_obj.button_10"
@jump storage=config.ks target=*return
*config_sub_button_11
;#11: マウスオンメニューを使用する
;ラジオボタンにするために
;その場で他のボタンを変更する
;配列の数字はひとつずれているので注意
@eval exp="sf.menu_mode=0 if config_plugin_obj.button_11"
@eval exp="config_plugin_obj.button_11 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_12
;#12: 右クリックメニューを使用する
@eval exp="sf.menu_mode=1 if config_plugin_obj.button_12"
@eval exp="config_plugin_obj.button_11 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_13
;#13: システムメニューを使用する
@eval exp="sf.menu_mode=2 if config_plugin_obj.button_13"
@eval exp="config_plugin_obj.button_11 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_14
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

;スライダー用サブルーチン
*config_sub_slider_00
@bgmopt gvolume="&config_plugin_obj.slider_00*100"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"
@jump storage=config.ks target=*return
*config_sub_slider_01
@seopt gvolume="&config_plugin_obj.slider_01*100"
@eval exp="&sf.sevolume = kag.se[0].volume2"
@jump storage=config.ks target=*return
*config_sub_slider_02
@eval exp="kag.userChSpeed=100 - config_plugin_obj.slider_02*100"
@jump storage=config.ks target=*return
*config_sub_slider_03
@eval exp="&kag.autoModePageWait = 2000 -  config_plugin_obj.slider_03 * 2000;"
@eval exp="&kag.autoModeLineWait = 1000 -  config_plugin_obj.slider_03 * 1000;"
@jump storage=config.ks target=*return
*config_sub_slider_04
@eval exp="&sf.messageopacity = (config_plugin_obj.slider_04 * 255)"
@eval exp="&SetMessageOpacity_object.foreLay.opacity = sf.messageopacity"
@eval exp="&SetMessageOpacity_object.backLay.opacity = sf.messageopacity"
@jump storage=config.ks target=*return
*config_sub_slider_05
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
