赤恐竜	http://akakyouryuu.blog.fc2.com/

吉里吉里にメニューとそれにともなう
セーブ、ロード、コンフィグ画面を設定する
つまりシステム一式そろえられるので楽ができるかと。

もしも使いたい人がいたなら好きに使っていい
改変、再配布は自由
使用を明記する必要も報告する必要もない
けど報告をくれるとうれしい
当然なにかあっても責任は取れないけど
exsystembutton.ksとconfig.ksはtjsに挑戦！で配布して
いたのを改造した。
またスライダーには色々な墓場のKLayers.ksを利用した
マウスカーソル自動移動は
サークル煌明のMoveMouseCursorPluginがあれば
それをつかう

内部でSetMessageOpacity、SaveMode、ConfigModeを
使用している。


メニューはマウスオン、右クリック、通常のシステムボタン
から選べ、ゲーム中に変更も出来る(大体の人は使いたい一つを選んでお終いだと思うけど)
回想モードではいくつかのボタンを無効化できるが、そのためボタンは無効化のときを加えて
ひとつの画像に4つの絵が必要
exsystembutton.ksで通常のシステムボタン、MoveMenu.ksでマウスオン
ボタン、右クリックボタンを作っている。
現在どちらも同じボタン画像を使用しているが、適宜改造してくれ。
ボタンを増やすときはonStableStateChangedに注意

セーブ、ロードの設定はSave_mode.txtを参照
コンフィグ画面の設定はConfigMode.txtを参照
またSetMessageOpacity.ksも参照のこと

設定
AfterInit.tjsに次の文を書く(なければ作る)
---------------------------------------------------------------------------- 
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
var restoreFromRightClick_org = kag.restoreFromRightClick;
kag.restoreFromRightClick = function ()
{
	restoreFromRightClick_org();
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
} incontextof kag;
// OUTFOCUSより
// ［システム‐未読もスキップ］メニューハンドラの定義
kag.onAllSkipClick = function(sender)
{
	sf.allskip = !sf.allskip;
	allSkipMenuItem.checked = sf.allskip;
	if (sf.allskip)
		skipToNextStopMenuItem.caption = "次の選択肢まで進む(&F)";
	else
		skipToNextStopMenuItem.caption = autoRecordPageShowing ? "次の選択肢/未読まで進む(&F)" : "次の選択肢まで進む(&F)";
} incontextof kag;
// ［未読もスキップ］メニューアイテムを作成
kag.allSkipMenuItem = new KAGMenuItem(kag, "未読もスキップ(&L)", 0, kag.onAllSkipClick, false);
kag.allSkipMenuItem.checked = sf.allskip;
// ［システム］メニューに［未読もスキップ］メニューアイテムを登録
kag.systemMenu.insert(kag.allSkipMenuItem, 3);
// kag.getCurrentRead()メソッドを差し換える
kag.getCurrentRead_org = kag.getCurrentRead;
kag.getCurrentRead = function()
{
	if (sf.allskip)                 // 未読もスキップするなら全て既読
		return true;
	else
		return getCurrentRead_org();  // そうでなければ旧kag.getCurrentRead()メソッドの戻り値を使う
} incontextof kag;
---------------------------------------------------------------------------- 
次にMenu.ksの2,3行目のつぎの設定のデフォルト値を設定する
var chose_novel = 1;	//選択肢ありか, (前の選択肢に戻るを表示するかどうか)

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
