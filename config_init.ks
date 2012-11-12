@return cond="typeof(global.config_plugin_obj) != 'undefined'"
@call storage=KLayers.ks

@iscript
if (sf.config_init === void)
{
//初期設定 初回のみ設定したい項目を設定
	sf.saveAsk = 1; //セーブ上書き時に確認する
	sf.loadAsk = 1; //ロード時に確認する
	sf.qsaveAsk = 0; //クイックセーブ時に確認する
	sf.qloadAsk = 1; //クイックロード時に確認する
	sf.returnAsk = 1; //前に戻るで確認する
	sf.titleAsk = 1; //タイトルに戻るで確認する
	sf.exitAsk = 1; //終了時に確認する
	sf.autocontinue = 1; //選択肢後もオートモードを続ける
	sf.skipcontinue = 1; //選択肢後もスキップモードを続ける
	sf.sceneskip = 1; //シーン毎のスキップをする
	sf.menu_mode = 0; //0:マウスオンメニューを使用する
			  //1:右クリックメニューを使用する
			  //2:システムボタンを使用する
	sf.messageopacity = 128; //メッセージ枠の透明度
	
	sf.bgmvolume = kag.bgm.buf1.volume2;
	sf.sevolume = kag.se[0].volume2;
	sf.config_init = 1;
}

//自前の終了処理に置き替える
kag.askOnClose=false;

kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;


//config_pluginクラスに必要な変数、関数をまとめる
class config_plugin{


	var back = 'config_bg'; // 背景(透明部分には直前のゲーム画面を表示)
	var slider_base = 'slider_base'; // スライダーの背景
	var slider_tab = 'slider_tab';   // スライダーのつまみ(ボタンと同じ構成)
	var graphic = 'graphic';		//トグルボタンの画像を指定(詳しくはKLayers.txtのKToggleButtonLayerを参照, basegraphicはいらないっぽい)
	
	var close_button = 'config_close'; //閉じるボタン
	var close_x = kag.scWidth - 100;   //閉じるボタンのx座標
	var close_y = kag.scHeight - 100;  //閉じるボタンのy座標
	
	var nowpage = 1; //現在のページ
	//複数ページを使われないなら適当な画像を指定して非表示にする
	//(トグルボタンと同じ形式)
	//ページ1のボタン
	var page1_button = 'graphic';  //ぺージ1ボタン
	var page1_visible = 0; //ぺージ1ボタンを表示するか
	var page1_pos = [0, 0];   //ぺージ1ボタンの座標
	
	//ページ2のボタン
	var page2_button = 'graphic';  //ぺージ2ボタン
	var page2_visible = 0; 		   //ぺージ2ボタンを表示するか
	var page2_pos = [100, 0];   //ぺージ2ボタンの座標
	
	//ページ3のボタン
	var page3_button = 'graphic';  //ぺージ3ボタン
	var page3_visible = 0; 		    //ぺージ3ボタンを表示するか
	var page3_pos = [200, 0];   //ぺージ3ボタンの座標
	
	//開始時に呼ばれるサブルーチン
	var start_sub_label	= '*config_sub_start'; //ラベル名
	var start_sub_storage	= 'config_sub.ks'; //ファイル名
	//終了時に呼ばれるサブルーチン
	var close_sub_label	= '*config_sub_close'; //ラベル名
	var close_sub_storage	= 'config_sub.ks'; //ファイル名
	
	// 各ボタン、スライダーの操作する変数
	// ボタンはトグルボタンに合わせて0か1
	//ボタンは1ページ15個づつ
	//スライダーは1ぺージ10個づつある
	
	//1ページ目
	var button_01 = 0;
	var button_02 = 0;
	var button_03 = 0;
	var button_04 = 0;
	var button_05 = 0;
	var button_06 = 0;
	var button_07 = 0;
	var button_08 = 0;
	var button_09 = 0;
	var button_10 = 0;
	var button_11 = 0;
	var button_12 = 0;
	var button_13 = 0;
	var button_14 = 0;
	var button_15 = 0;
	//2ページ目
	var button_16 = 0;
	var button_17 = 0;
	var button_18 = 0;
	var button_19 = 0;
	var button_20 = 0;
	var button_21 = 0;
	var button_22 = 0;
	var button_23 = 0;
	var button_24 = 0;
	var button_25 = 0;
	var button_26 = 0;
	var button_27 = 0;
	var button_28 = 0;
	var button_29 = 0;
	var button_30 = 0;
	//3ページ目
	var button_31 = 0;
	var button_32 = 0;
	var button_33 = 0;
	var button_34 = 0;
	var button_35 = 0;
	var button_36 = 0;
	var button_37 = 0;
	var button_38 = 0;
	var button_39 = 0;
	var button_40 = 0;
	var button_41 = 0;
	var button_42 = 0;
	var button_43 = 0;
	var button_44 = 0;
	var button_45 = 0;
	
	// スライダーの操作する変数は、
	//スライダーに合わせて0～1まで変化する
	//1ページ目
	var slider_01 = 0;
	var slider_02 = 0;
	var slider_03 = 0;
	var slider_04 = 0;
	var slider_05 = 0;
	var slider_06 = 0;
	var slider_07 = 0;
	var slider_08 = 0;
	var slider_09 = 0;
	var slider_10 = 0;
	//2ページ目
	var slider_11 = 0;
	var slider_12 = 0;
	var slider_13 = 0;
	var slider_14 = 0;
	var slider_15 = 0;
	var slider_16 = 0;
	var slider_17 = 0;
	var slider_18 = 0;
	var slider_19 = 0;
	var slider_20 = 0;
	//3ページ目
	var slider_21 = 0;
	var slider_22 = 0;
	var slider_23 = 0;
	var slider_24 = 0;
	var slider_25 = 0;
	var slider_26 = 0;
	var slider_27 = 0;
	var slider_28 = 0;
	var slider_29 = 0;
	var slider_30 = 0;

	//各ボタン、スライダーを表示するか
	var button_01_visible = 1;
	var button_02_visible = 1;
	var button_03_visible = 1;
	var button_04_visible = 1;
	var button_05_visible = 1;
	var button_06_visible = 1;
	var button_07_visible = 1;
	var button_08_visible = 1;
	var button_09_visible = 1;
	var button_10_visible = 1;
	var button_11_visible = 1;
	var button_12_visible = 1;
	var button_13_visible = 1;
	var button_14_visible = 1;
	var button_15_visible = 0;
	var button_16_visible = 0;
	var button_17_visible = 0;
	var button_18_visible = 0;
	var button_19_visible = 0;
	var button_20_visible = 0;
	var button_21_visible = 0;
	var button_22_visible = 0;
	var button_23_visible = 0;
	var button_24_visible = 0;
	var button_25_visible = 0;
	var button_26_visible = 0;
	var button_27_visible = 0;
	var button_28_visible = 0;
	var button_29_visible = 0;
	var button_30_visible = 0;
	var button_31_visible = 0;
	var button_32_visible = 0;
	var button_33_visible = 0;
	var button_34_visible = 0;
	var button_35_visible = 0;
	var button_36_visible = 0;
	var button_37_visible = 0;
	var button_38_visible = 0;
	var button_39_visible = 0;
	var button_40_visible = 0;
	var button_41_visible = 0;
	var button_42_visible = 0;
	var button_43_visible = 0;
	var button_44_visible = 0;
	var button_45_visible = 0;

	var slider_01_visible = 1;
	var slider_02_visible = 1;
	var slider_03_visible = 1;
	var slider_04_visible = 1;
	var slider_05_visible = 1;
	var slider_06_visible = 0;
	var slider_07_visible = 0;
	var slider_08_visible = 0;
	var slider_09_visible = 0;
	var slider_10_visible = 0;
	var slider_11_visible = 0;
	var slider_12_visible = 0;
	var slider_13_visible = 0;
	var slider_14_visible = 0;
	var slider_15_visible = 0;
	var slider_16_visible = 0;
	var slider_17_visible = 0;
	var slider_18_visible = 0;
	var slider_19_visible = 0;
	var slider_20_visible = 0;
	var slider_21_visible = 0;
	var slider_22_visible = 0;
	var slider_23_visible = 0;
	var slider_24_visible = 0;
	var slider_25_visible = 0;
	var slider_26_visible = 0;
	var slider_27_visible = 0;
	var slider_28_visible = 0;
	var slider_29_visible = 0;
	var slider_30_visible = 0;

	// 各ボタン、スライダーの座標を設定
	var button_01_pos = [340, 525];
	var button_02_pos = [680, 435];
	var button_03_pos = [680, 475];
	var button_04_pos = [420, 435];
	var button_05_pos = [420, 475];
	var button_06_pos = [140, 435];
	var button_07_pos = [140, 475];
	var button_08_pos = [740, 165];
	var button_09_pos = [740, 205];
	var button_10_pos = [390, 165];
	var button_11_pos = [390, 200];
	var button_12_pos = [570, 305];
	var button_13_pos = [570, 355];
	var button_14_pos = [750, 305];
	var button_15_pos = [0, 0];
	var button_16_pos = [0, 0];
	var button_17_pos = [0, 0];
	var button_18_pos = [0, 0];
	var button_19_pos = [0, 0];
	var button_20_pos = [0, 0];
	var button_21_pos = [0, 0];
	var button_22_pos = [0, 0];
	var button_23_pos = [0, 0];
	var button_24_pos = [0, 0];
	var button_25_pos = [0, 0];
	var button_26_pos = [0, 0];
	var button_27_pos = [0, 0];
	var button_28_pos = [0, 0];
	var button_29_pos = [0, 0];
	var button_30_pos = [0, 0];
	var button_31_pos = [0, 0];
	var button_32_pos = [0, 0];
	var button_33_pos = [0, 0];
	var button_34_pos = [0, 0];
	var button_35_pos = [0, 0];
	var button_36_pos = [0, 0];
	var button_37_pos = [0, 0];
	var button_38_pos = [0, 0];
	var button_39_pos = [0, 0];
	var button_40_pos = [0, 0];
	var button_41_pos = [0, 0];
	var button_42_pos = [0, 0];
	var button_43_pos = [0, 0];
	var button_44_pos = [0, 0];
	var button_45_pos = [0, 0];
	
	var slider_01_pos = [190, 305];
	var slider_02_pos = [190, 345];
	var slider_03_pos = [450, 70];
	var slider_04_pos = [450, 100];
	var slider_05_pos = [450, 130];
	var slider_06_pos = [0, 0];
	var slider_07_pos = [0, 0];
	var slider_08_pos = [0, 0];
	var slider_09_pos = [0, 0];
	var slider_10_pos = [0, 0];
	var slider_11_pos = [0, 0];
	var slider_12_pos = [0, 0];
	var slider_13_pos = [0, 0];
	var slider_14_pos = [0, 0];
	var slider_15_pos = [0, 0];
	var slider_16_pos = [0, 0];
	var slider_17_pos = [0, 0];
	var slider_18_pos = [0, 0];
	var slider_19_pos = [0, 0];
	var slider_20_pos = [0, 0];
	var slider_21_pos = [0, 0];
	var slider_22_pos = [0, 0];
	var slider_23_pos = [0, 0];
	var slider_24_pos = [0, 0];
	var slider_25_pos = [0, 0];
	var slider_26_pos = [0, 0];
	var slider_27_pos = [0, 0];
	var slider_28_pos = [0, 0];
	var slider_29_pos = [0, 0];
	var slider_30_pos = [0, 0];
	
	//スライダーが操作される時に
	//呼びだされる関数(もし必要なら設定する)
	function slider_01_func(hval,vval,drag) {slider_01 = hval;}
	function slider_02_func(hval,vval,drag) {slider_02 = hval;}
	function slider_03_func(hval,vval,drag) {slider_03 = hval;}
	function slider_04_func(hval,vval,drag) {slider_04 = hval;}
	function slider_05_func(hval,vval,drag) {slider_05 = hval;}
	function slider_06_func(hval,vval,drag) {slider_06 = hval;}
	function slider_07_func(hval,vval,drag) {slider_07 = hval;}
	function slider_08_func(hval,vval,drag) {slider_08 = hval;}
	function slider_09_func(hval,vval,drag) {slider_09 = hval;}
	function slider_10_func(hval,vval,drag) {slider_10 = hval;}
	function slider_11_func(hval,vval,drag) {slider_11 = hval;}
	function slider_12_func(hval,vval,drag) {slider_12 = hval;}
	function slider_13_func(hval,vval,drag) {slider_13 = hval;}
	function slider_14_func(hval,vval,drag) {slider_14 = hval;}
	function slider_15_func(hval,vval,drag) {slider_15 = hval;}
	function slider_16_func(hval,vval,drag) {slider_16 = hval;}
	function slider_17_func(hval,vval,drag) {slider_17 = hval;}
	function slider_18_func(hval,vval,drag) {slider_18 = hval;}
	function slider_19_func(hval,vval,drag) {slider_19 = hval;}
	function slider_20_func(hval,vval,drag) {slider_20 = hval;}
	function slider_21_func(hval,vval,drag) {slider_20 = hval;}
	function slider_22_func(hval,vval,drag) {slider_20 = hval;}
	function slider_23_func(hval,vval,drag) {slider_20 = hval;}
	function slider_24_func(hval,vval,drag) {slider_20 = hval;}
	function slider_25_func(hval,vval,drag) {slider_20 = hval;}
	function slider_26_func(hval,vval,drag) {slider_20 = hval;}
	function slider_27_func(hval,vval,drag) {slider_20 = hval;}
	function slider_28_func(hval,vval,drag) {slider_20 = hval;}
	function slider_29_func(hval,vval,drag) {slider_20 = hval;}
	function slider_30_func(hval,vval,drag) {slider_20 = hval;}
}

var config_plugin_obj = new config_plugin();
@endscript

@return
