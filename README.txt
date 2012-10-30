吉里吉里にメニューとそれにともなう
セーブ、ロード、コンフィグ画面を設定する

もしも使いたい人がいたなら好きに使っていい
改変、再配布は自由
使用を明記する必要も報告する必要もない
けど報告をくれるとうれしい
当然なにかあっても責任は取れないけど
使用にはBiscratのSKN_Slider.ks
サークル煌明のMoveMouseCursorPlugin.tjsが必要
exsystembutton.ksとconfig.ksはtjsに挑戦！で配布して
いたのを改造した。


メニューはマウスオン、右クリック、通常のシステムボタン
から選べ、ゲーム中に変更も出来る。回想モードではいくつかの
ボタンを無効化できるが、そのためボタンは無効化のときを含めて
ひとつの画像に4つの絵が必要



セーブ、ロードの設定はSave_mode.txtを参照
first.ksで
@call storage=Menu.ks
と呼び出す

設定
AfterInit.tjsに次の設定をする(なければ作る)
kag.tagHandlers.s = function(elm)
{
	// 実行停止
	stablePosibility = true;
	if (!sf.skipcontinue)
		cancelSkip(); //スキップをキャンセルするのをやめます。
	if (!sf.autocontinue)
		cancelAutoMode();
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
	//if(!askOnClose) { global.Window.onCloseQuery(true); return; }
	if(!askOnClose && !sf.exitAsk) { global.Window.onCloseQuery(true); return; }
	global.Window.onCloseQuery(askYesNo("終了しますか？"));
} incontextof kag;
kag.onHelpAboutMenuItemClick = function (sender)
{
	// 「このソフトについて」ウィンドウを表示
	tf.exitAsktemp=sf.exitAsk;
	sf.exitAsk=0;
	var win = new global.KAGWindow(false, aboutWidth, aboutHeight);
	win.setPos(left + ((width - win.width)>>1), top + ((height - win.height)>>1));
	win.process('about.ks' ,,, true); // about.ks を immediate で表示
	win.showModal(); // モード付きで表示
	invalidate win;
	sf.exitAsk=tf.exitAsktemp;
} incontextof kag;
kag.goToStartWithAsk = function ()
{
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
	// ここから下を追加
	// 右クリック中でautoMode設定された場合に対応。 
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

次にMenu.ksの6行目からのつぎの変数を設定する
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
	0:マウスオンメニュー 1:右クリックメニュー 2:通常のシステムボタン
sf.messageopacity = 128; //メッセージ枠の透明度

24行目からも設定する
tf.chose_novel = 1;	//選択肢ありか(前の選択肢に戻るを表示)
tf.message_base = 'message'; //メッセージレイヤと同じ大きさの
			     //黒い画像
			     
メッセージレイヤの濃度を変えるのに前景レイヤー0に
黒い画像をいれているので、前景レイヤー0は使ってはいけない
また、MoveMenu.ksの143行目のpositionを変えればメニューの
位置を上端と右端から選べる
	var position = 'top';	    //メニューの位置 (right or top)	
exsystembutton.ksの240行目からの変数を設定すれば、通常ボタン
の位置を変えられる
x = kag.fore.messages[0].left; // 初期 x 位置
y = kag.fore.messages[0].top + kag.fore.messages[0].height - 30; // 初期 y 位置
x_width = 70;  //ボタン間の幅
y_height = 0;  //ボタン間の高さ

また、config.ks,load_mode.ksはタイトル画面であたまから
サブルーチンとして呼び出しても使用可能


使えるタグ

set_menu
sf.menu_modeにあわせて右クリック、メニュー表示を
設定する、ただし、disablestoreが設定してあった場合
タイトル画面にいると判断して、set_unmenuを使う
なお、ロードをしても同様の処理がおこなわれる

set_unmenu
右クリックを無効し、メニュー表示を非表示にする
タイトル画面など、本編から戻る場所に置くこと

laycount2
laycountを使ってはならないlaycount2を使う

set_messageopacity
メッセージレイヤの透明度を設定し、表示する(セーブ可能ラベルの後におく)


in_scene_mode_button        
回想モード用にボタンをセーブ、ロード、前の選択肢に戻るを無効化する

out_scene_mode_button        
回想モード用に無効化したボタンを有効化する
タイトル画面など、回想モードから戻る場所において
