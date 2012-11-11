@iscript
//初期設定 初回のみ実行
if (sf.config_init === void)
{
	//設定の初期化
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
var config = %[];

config.back = 'config_bg'; // 背景(透明部分には直前のゲーム画面を表示)
config.slider_base = 'slider_base'; // スライダーの背景
config.slider_tab = 'slider_tab';   // スライダーのつまみ(ボタンと同じ構成)
config.basegraphic = 'basegraphic';	//トグルボタンの下レイヤ画像を指定(詳しくはKLayers.txtのKToggleButtonLayerを参照)
					//指定しないと表示されないが、無意味？
config.graphic = 'graphic';		//トグルボタンの上レイヤ画像を指定(詳しくはKLayers.txtのKToggleButtonLayerを参照)


//各ボタン、スライダーを表示するか
config.windowmodeon	=	1; // #0: フルスクリーンを表示するか
config.titleAskon	=	1; // #1: タイトルに戻るを確認するかを表示するか
config.exitAskon	=	1; // #2: ゲーム終了を確認するかを表示するか
config.qloadAskon	=	1; // #3: クイックロード時に確認するかを表示するか
config.returnAskon	=	1; // #4: 前の選択肢に戻るで確認するかを表示するか
config.saveAskon	=	1; // #5: セーブ上書き時に確認するかを表示するか
config.loadAskon	=	1; // #6: ロード時に確認するかを表示するか
config.pagebreakon	=	1; // #7:「ページ末まで一度に表示」を表示するか
config.sceneskipon	=	1; // #8: シーン毎のスキップをするかを表示するか
config.autocontinueon	=	1; // #9: 選択肢後もオートモードを継続するかを表示するか
config.skipcontinueon	=	1; // #10: 選択肢後もスキップモードを継続するかを表示するか
config.menu0on		=	1; // #11: マウスオンメニューを使用するを表示するか
config.menu1on		=	1; // #14: 右クリックメニューを使用するを表示するか
config.menu2on		=	1; // #15: システムメニューを使用するを表示するか
config.slider0_on 	=	1; // ◇スライダー0を表示するか - (BGM音量調整)
config.slider1_on 	=	1; // ◇スライダー1を表示するか - (SE音量調整)
config.slider2_on 	=	1; // ◇スライダー2を表示するか - (文字速度)
config.slider3_on 	=	1; // ◇スライダー3を表示するか - (オートモード速度)
config.slider4_on 	=	1; // ◇スライダー4を表示するか - (透明度)

config.windowmode=	[340, 525]; // #0: フルスクリーンに表示するチェック画像の座標
config.titleAsk=	[680, 435]; // #1: タイトルに戻るを確認するかに表示するチェック画像の座標
config.exitAsk=		[680, 475]; // #2: ゲーム終了を確認するかに表示するチェック画像の座標
config.qloadAsk=	[420, 435]; // #3: クイックロード時に確認するかに表示するチェック画像の座標
config.returnAsk=	[420, 475]; // #4: 前の選択肢に戻るで確認するかに表示するチェック画像の座標
config.saveAsk=		[140, 435]; // #5: セーブ上書き時に確認するかに表示するチェック画像の座標
config.loadAsk=		[140, 475]; // #6: ロード時に確認するかに表示するチェック画像の座標
config.pagebreak=	[740, 165]; // #7:「ページ末まで一度に表示」に表示するチェック画像の座標
config.sceneskip=	[740, 205]; // #8: シーン毎のスキップをするかに表示するチェック画像の座標
config.autocontinue=	[390, 165]; // #9: 選択肢後もオートモードを継続するかに表示するチェック画像の座標
config.skipcontinue=	[390, 200]; // #10: 選択肢後もスキップモードを継続するかに表示するチェック画像の座標
config.menu0= 		[570, 305]; // #11: マウスオンメニューを使用するに表示するチェック画像の座標
config.menu1= 		[570, 355]; // #14: 右クリックメニューを使用するに表示するチェック画像の座標
config.menu2= 		[750, 305]; // #15: システムメニューを使用するに表示するチェック画像の座標
config.slider0=		[190, 305]; // ◇スライダー0の座標 - (BGM音量調整)
config.slider1=		[190, 345]; // ◇スライダー1の座標 - (SE音量調整)
config.slider2=		[450, 70];  // ◇スライダー2の座標 - (文字速度)
config.slider3=		[450, 100]; // ◇スライダー3の座標 - (オートモード速度)
config.slider4=		[450, 130]; // ◇スライダー4の座標 - (透明度)

//スライダー設定の関数設定
config.bgmslider = function (hval,vval,drag){
	kag.tagHandlers.bgmopt(%['gvolume' => hval*100]);
	sf.bgmvolume = kag.bgm.buf1.volume2;
} incontextof global;
config.seslider = function (hval,vval,drag){
	for(var i=0;i<kag.numSEBuffers;i++)
		kag.se[i].setOptions(%['gvolume' => hval*100 ]);
	sf.sevolume = kag.se[0].volume2;
} incontextof global;
config.chspeedslider = function (hval,vval,drag){ 
	kag.userChSpeed=( 100 - hval*100 );
} incontextof global;
config.autospeedslider = function (hval,vval,drag){
	// オート速度
	kag.autoModePageWait = 2000 -  hval * 2000;
	kag.autoModeLineWait = 1000 -  hval * 1000;
} incontextof global;
config.messageopacityslider = function (hval,vval,drag){
	sf.messageopacity = (hval * 255);
	SetMessageOpacity_object.foreLay.opacity = sf.messageopacity;
	SetMessageOpacity_object.backLay.opacity = sf.messageopacity;
} incontextof global;
@endscript

@return
