@return cond="typeof(global.config_plugin_obj) != 'undefined'"
@call storage=KLayers.ks

@iscript
if (sf.config_init === void)
{
//初期設定 初回のみ設定したい項目を設定
//ここを書き換える↓------------------------------------------------------- 
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
//ここを書き換える↑------------------------------------------------------- 
}

//ここを書き換える↓------------------------------------------------------- 
//自前の終了処理に置き替える
kag.askOnClose=false;

kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;
//ここを書き換える↑------------------------------------------------------- 

//config_pluginクラスに必要な変数、関数をまとめる
class config_plugin{


//ここを書き換える↓------------------------------------------------------- 
	//複数ページを使われないなら2ページ目から空欄にする
	var back = ['config_bg', 'black', 'black'];  // 1, 2, 3ページの背景(透明部分には直前のゲーム画面を表示)
	var slider_base = 'slider_base'; // スライダーの背景
	var slider_tab = 'slider_tab';   // スライダーのつまみ(ボタンと同じ構成)
	var graphic = 'graphic';		//トグルボタンの画像を指定(詳しくはKLayers.txtのKToggleButtonLayerを参照, basegraphicはいらないっぽい)
	
	var close_button = 'config_close'; //閉じるボタン
	var close_x = kag.scWidth - 100;   //閉じるボタンのx座標
	var close_y = kag.scHeight - 50;  //閉じるボタンのy座標
	
	var nowpage = 1; //現在のページ
	//複数ページを使われないなら適当な画像を指定して非表示にする
	//(トグルボタンと同じ形式)
	//ページ1のボタン
	var page1_button = 'graphic';  //ぺージ1ボタン
	var page1_visible = 0; //ぺージ1ボタンを表示するか
	var page1_pos = [kag.scWidth-300, 0];   //ぺージ1ボタンの座標
	
	//ページ2のボタン
	var page2_button = 'graphic';  //ぺージ2ボタン
	var page2_visible = 0; 		   //ぺージ2ボタンを表示するか
	var page2_pos = [kag.scWidth-200, 0];   //ぺージ2ボタンの座標
	
	//ページ3のボタン
	var page3_button = 'graphic';  //ぺージ3ボタン
	var page3_visible = 0; 		    //ぺージ3ボタンを表示するか
	var page3_pos = [kag.scWidth-100, 0];   //ぺージ3ボタンの座標
	
	//開始時に呼ばれるサブルーチン
	var start_sub_label	= '*config_sub_start'; //ラベル名
	var start_sub_storage	= 'config_sub.ks'; //ファイル名
	//終了時に呼ばれるサブルーチン
	var close_sub_label	= '*config_sub_close'; //ラベル名
	var close_sub_storage	= 'config_sub.ks'; //ファイル名
	
	// 各ボタン、スライダーの操作する変数
	//ボタンは1ページ15個づつ
	//スライダーは1ぺージ10個づつある
	
	// ボタンはトグルボタンに合わせて0か1をとる
	//1ページ目
	var button_00 = 0;
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
	//2ページ目
	var button_15 = 0;
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
	//3ページ目
	var button_30 = 0;
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
	
	// スライダーの操作する変数は、
	//スライダーに合わせて0～1まで変化する
	//1ページ目
	var slider_00 = 0;
	var slider_01 = 0;
	var slider_02 = 0;
	var slider_03 = 0;
	var slider_04 = 0;
	var slider_05 = 0;
	var slider_06 = 0;
	var slider_07 = 0;
	var slider_08 = 0;
	var slider_09 = 0;
	//2ページ目
	var slider_10 = 0;
	var slider_11 = 0;
	var slider_12 = 0;
	var slider_13 = 0;
	var slider_14 = 0;
	var slider_15 = 0;
	var slider_16 = 0;
	var slider_17 = 0;
	var slider_18 = 0;
	var slider_19 = 0;
	//3ページ目
	var slider_20 = 0;
	var slider_21 = 0;
	var slider_22 = 0;
	var slider_23 = 0;
	var slider_24 = 0;
	var slider_25 = 0;
	var slider_26 = 0;
	var slider_27 = 0;
	var slider_28 = 0;
	var slider_29 = 0;

	//各ボタン、スライダーを表示するか
	var button_visible = [
				 1,  //00 
				 1,  //01 
				 1,  //02 
				 1,  //03 
				 1,  //04 
				 1,  //05 
				 1,  //06 
				 1,  //07 
				 1,  //08 
				 1,  //09 
				 1,  //10 
				 1,  //11 
				 1,  //12 
				 1,  //13 
				 0,  //14 
				 0,  //15 
				 0,  //16 
				 0,  //17 
				 0,  //18 
				 0,  //19 
				 0,  //20 
				 0,  //21 
				 0,  //22 
				 0,  //23 
				 0,  //24 
				 0,  //25 
				 0,  //26 
				 0,  //27 
				 0,  //28 
				 0,  //29 
				 0,  //30 
				 0,  //31 
				 0,  //32 
				 0,  //33 
				 0,  //34 
				 0,  //35 
				 0,  //36 
				 0,  //37 
				 0,  //38 
				 0,  //39 
				 0,  //40 
				 0,  //41 
				 0,  //42 
				 0,  //43 
				 0   //44 
			];

	var slider_visible = [
				1,  //00
				1,  //01
				1,  //02
				1,  //03
				1,  //04
				0,  //05
				0,  //06
				0,  //07
				0,  //08
				0,  //09
				0,  //10
				0,  //11
				0,  //12
				0,  //13
				0,  //14
				0,  //15
				0,  //16
				0,  //17
				0,  //18
				0,  //19
				0,  //20
				0,  //21
				0,  //22
				0,  //23
				0,  //24
				0,  //25
				0,  //26
				0,  //27
				0,  //28
				0   //29
			];

	// 各ボタン、スライダーの座標を設定
	var button_pos = [
				[340, 525],  //00
				[680, 435],  //01
				[680, 475],  //02
				[420, 435],  //03
				[420, 475],  //04
				[140, 435],  //05
				[140, 475],  //06
				[740, 165],  //07
				[740, 205],  //08
				[390, 165],  //09
				[390, 200],  //10
				[570, 305],  //11
				[570, 355],  //12
				[750, 305],  //13
				[0, 0],      //14
				[0, 0],      //15
				[0, 0],      //16
				[0, 0],      //17
				[0, 0],      //18
				[0, 0],      //19
				[0, 0],      //20
				[0, 0],      //21
				[0, 0],      //22
				[0, 0],      //23
				[0, 0],      //24
				[0, 0],      //25
				[0, 0],      //26
				[0, 0],      //27
				[0, 0],      //28
				[0, 0],      //29
				[0, 0],      //30
				[0, 0],      //31
				[0, 0],      //32
				[0, 0],      //33
				[0, 0],      //34
				[0, 0],      //35
				[0, 0],      //36
				[0, 0],      //37
				[0, 0],      //38
				[0, 0],      //39
				[0, 0],      //40
				[0, 0],      //41
				[0, 0],      //42
				[0, 0],      //43
				[0, 0]       //44
			];
	
	var slider_pos = [
				[190, 305],  //00
				[190, 345],  //01
				[450, 70],   //02
				[450, 100],  //03
				[450, 130],  //04
				[0, 0],      //05
				[0, 0],      //06
				[0, 0],      //07
				[0, 0],      //08
				[0, 0],      //09
				[0, 0],      //10
				[0, 0],      //11
				[0, 0],      //12
				[0, 0],      //13
				[0, 0],      //14
				[0, 0],      //15
				[0, 0],      //16
				[0, 0],      //17
				[0, 0],      //18
				[0, 0],      //19
				[0, 0],      //20
				[0, 0],      //21
				[0, 0],      //22
				[0, 0],      //23
				[0, 0],      //24
				[0, 0],      //25
				[0, 0],      //26
				[0, 0],      //27
				[0, 0],      //28
				[0, 0]       //29
			];
//ここを書き換える↑------------------------------------------------------- 
	
	//スライダーが操作される時に
	//呼びだされる関数(もし必要なら設定する)
	function slider_func_00(hval,vval,drag) {slider_00 = hval;}
	function slider_func_01(hval,vval,drag) {slider_01 = hval;}
	function slider_func_02(hval,vval,drag) {slider_02 = hval;}
	function slider_func_03(hval,vval,drag) {slider_03 = hval;}
	function slider_func_04(hval,vval,drag) {slider_04 = hval;}
	function slider_func_05(hval,vval,drag) {slider_05 = hval;}
	function slider_func_06(hval,vval,drag) {slider_06 = hval;}
	function slider_func_07(hval,vval,drag) {slider_07 = hval;}
	function slider_func_08(hval,vval,drag) {slider_08 = hval;}
	function slider_func_09(hval,vval,drag) {slider_09 = hval;}
	function slider_func_10(hval,vval,drag) {slider_10 = hval;}
	function slider_func_11(hval,vval,drag) {slider_11 = hval;}
	function slider_func_12(hval,vval,drag) {slider_12 = hval;}
	function slider_func_13(hval,vval,drag) {slider_13 = hval;}
	function slider_func_14(hval,vval,drag) {slider_14 = hval;}
	function slider_func_15(hval,vval,drag) {slider_15 = hval;}
	function slider_func_16(hval,vval,drag) {slider_16 = hval;}
	function slider_func_17(hval,vval,drag) {slider_17 = hval;}
	function slider_func_18(hval,vval,drag) {slider_18 = hval;}
	function slider_func_19(hval,vval,drag) {slider_19 = hval;}
	function slider_func_20(hval,vval,drag) {slider_20 = hval;}
	function slider_func_21(hval,vval,drag) {slider_21 = hval;}
	function slider_func_22(hval,vval,drag) {slider_22 = hval;}
	function slider_func_23(hval,vval,drag) {slider_23 = hval;}
	function slider_func_24(hval,vval,drag) {slider_24 = hval;}
	function slider_func_25(hval,vval,drag) {slider_25 = hval;}
	function slider_func_26(hval,vval,drag) {slider_26 = hval;}
	function slider_func_27(hval,vval,drag) {slider_27 = hval;}
	function slider_func_28(hval,vval,drag) {slider_28 = hval;}
	function slider_func_29(hval,vval,drag) {slider_29 = hval;}
}

var config_plugin_obj = new config_plugin();
@endscript

@return
