@return cond="typeof(global.config_plugin_obj) != 'undefined'"
@call storage=KLayers.ks

@iscript
if (sf.config_init === void)
{
//ここを書き換える↓------------------------------------------------------- 
	//初期設定 初回のみ設定したい項目を設定
	sf.init_saveAsk = sf.saveAsk = 1; //セーブ上書き時に確認する
	sf.init_loadAsk = sf.loadAsk = 1; //ロード時に確認する
	sf.init_qsaveAsk = sf.qsaveAsk = 0; //クイックセーブ時に確認する
	sf.init_qloadAsk = sf.qloadAsk = 1; //クイックロード時に確認する
	sf.init_returnAsk = sf.returnAsk = 1; //前に戻るで確認する
	sf.init_titleAsk = sf.titleAsk = 1; //タイトルに戻るで確認する
	sf.init_exitAsk = sf.exitAsk = 1; //終了時に確認する
	sf.init_autocontinue = sf.autocontinue = 1; //選択肢後もオートモードを続ける
	sf.init_skipcontinue = sf.skipcontinue = 1; //選択肢後もスキップモードを続ける
	sf.init_allskip = sf.allskip = 0; //未読もスキップする
	//sf.init_sceneskip = sf.sceneskip = 1; //シーン毎のスキップをする
	sf.init_menu_mode = sf.menu_mode = 0; //マウスオンメニューを使用する
						  //右クリックメニューを使用する
						  //システムボタンを使用する
	sf.init_chShadow = sf.chShadow = kag.fore.messages[0].defaultEdge ? false : kag.fore.messages[0].defaultShadow;	// 影
	sf.init_chEdge = sf.chEdge = kag.fore.messages[0].defaultEdge;	// 縁取り
	sf.init_chBold = sf.chBold = kag.fore.messages[0].defaultBold;	// 太字
	
	sf.init_bgmvolume = sf.bgmvolume = kag.bgm.buf1.volume2;
	sf.init_sevolume = sf.sevolume = kag.se[0].volume2;
	sf.init_chspeed = kag.chSpeed;		//文字速度
	sf.init_autospeed = kag.autoModePageWait;	//オート速度
	sf.init_messageopacity = sf.messageopacity = 128; //メッセージ枠の透明度
	
	sf.init_font = kag.chDefaultFace;
	
	sf.config_init = 1;
//ここを書き換える↑------------------------------------------------------- 
}

//ここを書き換える↓------------------------------------------------------- 
//ゲーム開始時常にしたい処理を設定


kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;

// すべてのメッセージレイヤの defaultShadow と defaultEdge、defaultBoldの設定をする
//*注	新規メッセージレイヤには適用されない
for(var i = 0; i < kag.fore.messages.count; i++)
{
	kag.tagHandlers.current(%[layer:'message'+i, page:'fore']);
	kag.tagHandlers.deffont(%[shadow:sf.chShadow, edge:sf.chEdge, bold:sf.chBold]);
	kag.tagHandlers.resetfont();
	kag.tagHandlers.current(%[layer:'message'+i, page:'back']);
	kag.tagHandlers.deffont(%[shadow:sf.chShadow, edge:sf.chEdge, bold:sf.chBold]);
	kag.tagHandlers.resetfont();
}
kag.tagHandlers.current(%[layer:'message0', page:'fore']);
//ここを書き換える↑------------------------------------------------------- 

//config_pluginクラスに必要な変数、関数をまとめる
class config_plugin extends KAGPlugin
{


//ここを書き換える↓------------------------------------------------------- 
	//複数ページを使われないなら2ページ目から空欄にする
	var back = ['config_bg1', 'config_bg2', 'black'];  // 1, 2, 3ページの背景(透明部分には直前のゲーム画面を表示)
	var slider_base = 'slider_base'; // スライダーの背景
	var slider_tab = 'slider_tab';   // スライダーのつまみ(ボタンと同じ構成)
	
	var close_button = 'config_close'; //閉じるボタン
	var close_x = kag.scWidth - 100;   //閉じるボタンのx座標
	var close_y = kag.scHeight - 50;  //閉じるボタンのy座標
	
	var nowpage = 1; //現在のページ
	//複数ページを使われないなら適当な画像を指定して非表示にする
	//(トグルボタンと同じ形式)
	//ページ1のボタン
	var page1_button = 'page1';  //ぺージ1ボタン
	var page1_visible = 1; //ぺージ1ボタンを表示するか
	var page1_pos = [kag.scWidth-400, 0];   //ぺージ1ボタンの座標
	
	//ページ2のボタン
	var page2_button = 'page2';  //ぺージ2ボタン
	var page2_visible = 1; 		   //ぺージ2ボタンを表示するか
	var page2_pos = [kag.scWidth-200, 0];   //ぺージ2ボタンの座標
	
	//ページ3のボタン
	var page3_button = 'page2';  //ぺージ3ボタン
	var page3_visible = 0; 		    //ぺージ3ボタンを表示するか
	var page3_pos = [kag.scWidth-100, 0];   //ぺージ3ボタンの座標
	
	//開始時に呼ばれるサブルーチン
	var start_sub_label	= '*config_sub_start'; //ラベル名
	var start_sub_storage	= 'config_sub.ks'; //ファイル名
	//終了時に呼ばれるサブルーチン
	var close_sub_label	= '*config_sub_close'; //ラベル名
	var close_sub_storage	= 'config_sub.ks'; //ファイル名
	

	//各ボタン、トグルボタン 、スライダーを表示するか
	var button_visible = [
				1, //00
				0, //01
				0, //02
				0, //03
				1, //04
				0, //05
				0, //06
				0, //07
				0, //08
				1, //09
				0, //10
				0, //11
				0, //12
				0, //13
				0  //14
			];
	var togglebutton_visible = [
				 1,  //00 
				 1,  //01 
				 1,  //02 
				 1,  //03 
				 1,  //04 
				 1,  //05 
				 0,  //06 
				 0,  //07 
				 0,  //08 
				 0,  //09 
				 0,  //10 
				 0,  //11 
				 0,  //12 
				 0,  //13 
				 0,  //14 
				 1,  //15 
				 1,  //16 
				 1,  //17 
				 1,  //18 
				 1,  //19 
				 1,  //20 
				 1,  //21 
				 1,  //22 
				 1,  //23 
				 1,  //24 
				 1,  //25 
				 1,  //26 
				 1,  //27 
				 0,  //28 
				 1,  //29 
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

	// 各ボタン、トグルボタン、スライダーの座標を設定
	var button_pos = [
				[200, 315], //00
				[0, 0], //01
				[0, 0], //02
				[0, 0], //03
				[kag.scWidth-200, kag.scHeight-50], //04
				[0, 0], //05
				[0, 0], //06
				[0, 0], //07
				[0, 0], //08
				[kag.scWidth-200, kag.scHeight-50], //09
				[0, 0], //10
				[0, 0], //11
				[0, 0], //12
				[0, 0], //13
				[0, 0] //14
			];
			
	var togglebutton_pos = [
				[540, 180],  //00
				[540, 220],  //01
				[600, 320],  //02
				[220, 370],  //03
				[440, 370],  //04
				[630, 370],  //05
				[0, 0],  //06
				[0, 0],  //07
				[0, 0],  //08
				[0, 0],  //09
				[0, 0],  //10
				[0, 0],  //11
				[0, 0],  //12
				[0, 0],  //13
				[0, 0],  //14
				[400, 360],      //15
				[510, 510],      //16
				[720, 510],      //17
				[510, 450],      //18
				[510, 480],      //19
				[250, 510],      //20
				[250, 450],      //21
				[250, 480],      //22
				[470, 230],      //23
				[470, 200],      //24
				[190, 330],      //25
				[460, 330],      //26
				[730, 330],      //27
				[470, 260],      //28
				[470, 170],      //29
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
				[300, 490],  //00
				[300, 540],  //01
				[390,  80],   //02
				[390, 115],  //03
				[390, 150],  //04
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
			
	// 各ボタン、トグルボタンの設定画像を設定(使わないボタンでも何かはいれておいて)
	var button_graphic = [ //ボタンの画像を指定
				'font',		//00
				'config_close',	//01
				'config_close',	//02
				'config_close', //03
				'default', //04
				'config_close', //05
				'config_close', //06
				'config_close', //07
				'config_close', //08
				'default', //09
				'config_close', //10
				'config_close', //11
				'config_close', //12
				'config_close', //13
				'config_close'  //14
			];
	
	var togglebutton_graphic = [ 	//トグルボタンの画像を指定(左から, 未チェック状態/チェックされた状態/未チェックでカーソルがあたった状態)
					//詳しくはKLayers.txtのKToggleButtonLayerを参照, basegraphicはいらないっぽい
				'graphic', //00
				'graphic', //01
				'graphic', //02
				'graphic', //03
				'graphic', //04
				'graphic', //05
				'graphic', //06
				'graphic', //07
				'graphic', //08
				'graphic', //09
				'graphic', //10
				'graphic', //11
				'graphic', //12
				'graphic', //13
				'graphic', //14
				'graphic', //15
				'graphic', //16
				'graphic', //17
				'graphic', //18
				'graphic', //19
				'graphic', //20
				'graphic', //21
				'graphic', //22
				'graphic', //23
				'graphic', //24
				'graphic', //25
				'graphic', //26
				'graphic', //27
				'graphic', //28
				'graphic'  //29
			];
			
//ここを書き換える↑------------------------------------------------------- 
	function onRestore(f, clear, elm)
	{
	//ここを書き換える↓------------------------------------------------------- 
	//ロード時に実行したい処理を記述(もし必要ならば)
	
		// すべてのメッセージレイヤの defaultShadow と defaultEdge、defaultBoldの設定をする
		// ロード時に戻ってしまうので
		//*注	新規メッセージレイヤには適用されない
		for(var i = 0; i < kag.fore.messages.count; i++)
		{
			kag.tagHandlers.current(%[layer:'message'+i, page:'fore']);
			kag.tagHandlers.deffont(%[shadow:sf.chShadow, edge:sf.chEdge, bold:sf.chBold]);
			kag.tagHandlers.resetfont();
			kag.tagHandlers.current(%[layer:'message'+i, page:'back']);
			kag.tagHandlers.deffont(%[shadow:sf.chShadow, edge:sf.chEdge, bold:sf.chBold]);
			kag.tagHandlers.resetfont();
		}
		kag.tagHandlers.current(%[layer:'message0', page:'fore']);
	//ここを書き換える↑------------------------------------------------------- 
	}
	
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
	
	function wheel(shift, delta, x, y)	//マウスホイールでページ移動
	{
		var temp_nowpage = nowpage;
		if (delta < 0)
		{
			switch(temp_nowpage)
			{
				case 1:
					if (page2_visible) nowpage+=1;
					break;
				case 2:
					if (page3_visible) nowpage+=1;
					else nowpage-=1;
					break;
				case 3:
					nowpage-=1;
					break;
			}
		}
		else
		{
			switch(temp_nowpage)
			{
				case 1:
					if (page3_visible) nowpage=3;
					else if (page2_visible) nowpage=2;
					break;
				case 2:
					nowpage-=1;
					break;
				case 3:
					nowpage-=1;
					break;
			}
		}
		if (temp_nowpage != nowpage) kag.process('config.ks', '*pagedraw');
	}
	
	// 各ボタン、スライダーの操作する変数
	//ボタンは1ページ15個づつ
	//スライダーは1ぺージ10個づつある
	
	// ボタンはトグルボタンに合わせて0か1をとる
	//1ページ目
	var togglebutton_00 = 0;
	var togglebutton_01 = 0;
	var togglebutton_02 = 0;
	var togglebutton_03 = 0;
	var togglebutton_04 = 0;
	var togglebutton_05 = 0;
	var togglebutton_06 = 0;
	var togglebutton_07 = 0;
	var togglebutton_08 = 0;
	var togglebutton_09 = 0;
	var togglebutton_10 = 0;
	var togglebutton_11 = 0;
	var togglebutton_12 = 0;
	var togglebutton_13 = 0;
	var togglebutton_14 = 0;
	//2ページ目
	var togglebutton_15 = 0;
	var togglebutton_16 = 0;
	var togglebutton_17 = 0;
	var togglebutton_18 = 0;
	var togglebutton_19 = 0;
	var togglebutton_20 = 0;
	var togglebutton_21 = 0;
	var togglebutton_22 = 0;
	var togglebutton_23 = 0;
	var togglebutton_24 = 0;
	var togglebutton_25 = 0;
	var togglebutton_26 = 0;
	var togglebutton_27 = 0;
	var togglebutton_28 = 0;
	var togglebutton_29 = 0;
	//3ページ目
	var togglebutton_30 = 0;
	var togglebutton_31 = 0;
	var togglebutton_32 = 0;
	var togglebutton_33 = 0;
	var togglebutton_34 = 0;
	var togglebutton_35 = 0;
	var togglebutton_36 = 0;
	var togglebutton_37 = 0;
	var togglebutton_38 = 0;
	var togglebutton_39 = 0;
	var togglebutton_40 = 0;
	var togglebutton_41 = 0;
	var togglebutton_42 = 0;
	var togglebutton_43 = 0;
	var togglebutton_44 = 0;
	
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
}

kag.addPlugin(global.config_plugin_obj = new config_plugin());

// ボタン用クラス(ジャンプするだけ)
class Config_Button extends ButtonLayer{
	var jump; //ジャンプ先指定用
	function Config_Button(){
		super.ButtonLayer(...);
	}
	function finalize(){
		super.finalize();
	}
	function onExecute(x, y, button, shift){
		kag.process(jump[0], jump[1]);
	}
}
@endscript

@return
