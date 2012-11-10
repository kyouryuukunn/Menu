吉里吉里にメニューとそれにともなう
セーブ、ロード、コンフィグ画面を設定する

もしも使いたい人がいたなら好きに使っていい
改変、再配布は自由
使用を明記する必要も報告する必要もない
けど報告をくれるとうれしい
当然なにかあっても責任は取れないけど
exsystembutton.ksとconfig.ksはtjsに挑戦！で配布して
いたのを改造した。
またスライダーには色々な墓場のKLayers.ksを利用した

全部入りサンプルをskydriveで公開している
https://skydrive.live.com/#cid=8F8EF4D2142F33D4&id=8F8EF4D2142F33D4!257


メニューはマウスオン、右クリック、通常のシステムボタン
から選べ、ゲーム中に変更も出来る。回想モードではいくつかの
ボタンを無効化できるが、そのためボタンは無効化のときを含めて
ひとつの画像に4つの絵が必要
exsystembutton.ksで通常のシステムボタン、MoveMenu.ksでマウスオン
ボタン、右クリックボタンを作っている。
現在どちらも同じボタン画像をしようしているが、適宜改造してくれ。
ボタンを増やすときはonStableStateChangedに注意


使っている変数
sf.saveAsk = 1; //セーブ上書き時に確認する
sf.loadAsk = 1; //ロード時に確認する
sf.qloadAsk = 1; //クイックロード時に確認する
sf.returnAsk = 1; //前に戻るで確認する
sf.titleAsk = 1; //タイトルに戻るで確認する
sf.exitAsk = 1; //終了時に確認する
sf.autocontinue = 1; //選択肢後もオートモードを続ける
sf.skipcontinue = 1; //選択肢後もスキップモードを続ける
sf.sceneskip = 1; //シーン毎のスキップをする(scene.ksがないなら無意味)
sf.menu_mode = 0; //使用メニューを選ぶ 
global.chose_novel = 1;	//選択肢ありか(前の選択肢に戻るを表示するかどうか)
global.message_base = 'message'; //メッセージレイヤと同じ大きさの黒い画像
global.in_scene_mode_button = 0; //回想モードでいくつかのボタンを無効化する
global.config
global.MoveMenu_object
global.exsystembutton_object


セーブ、ロードの設定はSave_mode.txtを参照

設定
AfterInit.tjsに次の設定をする(なければ作る)
kag.tagHandlers.s = function(elm)
{
	// 実行停止
	stablePosibility = true;
	//追加部分↓
	if (!sf.skipcontinue)
		cancelSkip(); //スキップをキャンセルするのをやめます。
	if (!sf.autocontinue)
		cancelAutoMode();
	//追加部分↑
	if(!usingExtraConductor) incRecordLabel(true);
	inSleep = true;
	if(recordHistoryOfStore == 2) // 2 : 選択肢 ( @s タグ ) ごと
	setToRecordHistory();
	notifyStable();
	return -1;
} incontextof kag;
kag.onCloseQuery = function ()
{
	saveSystemVariables();
	//追加部分↓
	//if(!askOnClose) { global.Window.onCloseQuery(true); return; }
	if(!askOnClose && !sf.exitAsk) { global.Window.onCloseQuery(true); return; }
	//追加部分↑
	global.Window.onCloseQuery(askYesNo("終了しますか？"));
} incontextof kag;
kag.onHelpAboutMenuItemClick = function (sender)
{
	// 「このソフトについて」ウィンドウを表示
	//追加部分↓
	tf.exitAsktemp=sf.exitAsk;
	sf.exitAsk=0;
	//追加部分↑
	var win = new global.KAGWindow(false, aboutWidth, aboutHeight);
	win.setPos(left + ((width - win.width)>>1), top + ((height - win.height)>>1));
	win.process('about.ks' ,,, true); // about.ks を immediate で表示
	win.showModal(); // モード付きで表示
	invalidate win;
	//追加部分↓
	sf.exitAsk=tf.exitAsktemp;
	//追加部分↑
} incontextof kag;
kag.goToStartWithAsk = function ()
{
	//追加部分↓
	// 最初に戻る(確認あり)
	//var result = askYesNo("最初に戻ります。よろしいですか ?");
	//if(result) goToStart();
	if (sf.titleAsk)
	{
		if (askYesNo("タイトルに戻りますか?")) goToStart();
	}
	else
	{
		goToStart();
	}
	//追加部分↑
} incontextof kag;
kag.restoreFromRightClick = function ()
{
	// 右クリックサブルーチンから抜けるときに呼ばれる
	if(typeof this.rightClickMenuItem != "undefined")
	{
		if(rightClickName == "default")
			rightClickMenuItem.caption = rightClickCurrentMenuName = rightClickDefaultName;
		else
			rightClickMenuItem.caption = rightClickCurrentMenuName = rightClickName;
	}
	//追加部分↓
	if(autoMode) 
	{
		enterAutoMode(); 
		// inStable = 0でenterAutoMode()内でPrimaryClick()され 
		// ないので、ここでclickしておく 
		conductor.trigger('click'); 
	}
	// 右クリック中でskipMode設定された場合に対応
	if(skipMode_rclick)
	skipToNextStopByKey();
	//追加部分↑
} incontextof kag;

次にMenu.ksの2,3行目のつぎの設定のデフォルト値を設定する
var chose_novel = 1;	//選択肢ありか, 前の選択肢に戻るを表示
var in_scene_mode_button_mark = 0; //回想モード

config_init.ksのつぎの設定のデフォルト値を設定する
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

また、次の変数でコンフィグ画面のレイアウトを変更する
config.back = 'config_bg'; // 背景(透明部分には直前のゲーム画面を表示)
config.slider_base = 'slider_base'; // スライダーの背景
config.slider_tab = 'slider_tab';   // スライダーのつまみ(ボタンと同じ構成)
config.windowmode=	[340, 525]; // #0: フルスクリーンに表示するチェック画像の座標
config.titleAsk=	[680, 435]; // #1: titleに表示するチェック画像の座標
config.exitAsk=		[680, 475]; // #2: exitに表示するチェック画像の座標
config.qloadAsk=	[420, 435]; // #3: qloadに表示するチェック画像の座標
config.returnAsk=	[420, 475]; // #4: returnに表示するチェック画像の座標
config.saveAsk=		[140, 435]; // #5: saveに表示するチェック画像の座標
config.loadAsk=		[140, 475]; // #6: loadに表示するチェック画像の座標
config.pagebreak=	[740, 165]; // #7:「ページ末まで一度に表示」に表示するチェック画像の座標
config.sceneskip=	[740, 205]; // #8: sceneskipに表示するチェック画像の座標
config.autocontinue=	[390, 165]; // #9: autocontinueに表示するチェック画像の座標
config.skipcontinue=	[390, 200]; // #10: skipcontinueに表示するチェック画像の座標
config.menu0= 		[570, 305]; // #11: menu0に表示するチェック画像の座標
config.menu1= 		[570, 355]; // #14: menu1に表示するチェック画像の座標
config.menu2= 		[750, 305]; // #15: menu2に表示するチェック画像の座標
config.slider0 = [190, 305]; // ◇スライダー0の座標 - (BGM音量調整)
config.slider1 = [190, 345]; // ◇スライダー1の座標 - (SE音量調整)
config.slider2 = [450, 70];  // ◇スライダー2の座標 - (文字速度)
config.slider3 = [450, 100]; // ◇スライダー3の座標 - (オートモード速度)
config.slider4 = [450, 130]; // ◇スライダー4の座標 - (透明度)
config.basegraphic = '';	//トグルボタンの下レイヤ画像を指定(詳しくはKLayers.txtのKToggleButtonLayerを参照)
config.graphic = '';		//トグルボタンの上レイヤ画像を指定(詳しくはKLayers.txtのKToggleButtonLayerを参照)
使わない設定は、デフォルト値を決めた後、該当部分を画面外にでもやってくれ

また、MoveMenu.ksの146行目のpositionを変えればメニューの
位置を上端と右端から選べる
	var position = 'top';	    //メニューの位置 (right or top)	
exsystembutton.ksの240行目からの変数を設定すれば、通常ボタン
の位置を変えられる
x = kag.fore.messages[0].left; // 初期 x 位置
y = kag.fore.messages[0].top + kag.fore.messages[0].height - 30; // 初期 y 位置
x_width = 70;  //ボタン間の幅
y_height = 0;  //ボタン間の高さ


後はfirst.ksで次のように呼び出す
@call storage=Menu.ks

config.ks,load_mode.ksはタイトル画面であたまから
サブルーチンとして呼び出しても使用可能、セーブ可能かどうか
でタイトル画面かを判断しているのでちゃんとdisablestoreを
使うこと


使えるタグ------------------------------------------------------------------ 

set_menu
sf.menu_modeにあわせて右クリック、メニュー表示を
設定する、ただし、disablestoreが設定してあった場合
タイトル画面にいると判断して、set_unmenuを使う
なお、ロードをしても同様の処理がおこなわれる

unset_menu
右クリックを無効し、メニュー表示を非表示にする
タイトル画面など、本編から戻る場所に置くこと

in_scene_mode_button        
回想モード用にボタンをセーブ、ロード、前の選択肢に戻るを無効化する

out_scene_mode_button        
回想モード用に無効化したボタンを有効化する
タイトル画面など、回想モードから戻る場所において
