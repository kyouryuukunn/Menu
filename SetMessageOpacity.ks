;使えるタグ
;SetMessageOpacity
;属性名
;page		:fore or back  (デフォルト fore)
;visible	:true or false (デフォルト true)
;opacity	:透明度
;reset		:true or false (デフォルト false)
;		 メッセージレイヤ0と同じ位置、大きさに
;		 枠を再描画する(ゲーム中にメッセージレイヤの
;		 設定が変わったとき用)
;メッセージフレームを設定する
;
;メッセージレイヤの文字を消去せずに、ゲーム中に
;メッセージレイヤの濃度を変更するプラグイン
;実際にはメッセージレイヤ0のひとつ後ろに黒いレイヤ
;を表示する。レイヤの表示、非表示を記録しているので
;コンフィグ画面等ではシステムボタン同様にonMessageHiddenStateChanged
;を呼び出してくれればよい
@return cond="typeof(global.SetMessageOpacity_object) != 'undefined'"

@iscript
class SetMessageOpacity extends KAGPlugin
{
	var foreSeen = false; // 表画面のレイヤが可視か
	var backSeen = false; // 裏画面のレイヤが可視か
	var foreLay;  // 表画面用のレイヤ
	var backLay;  // 裏画面用のレイヤ

	// コンストラクタ
	function SetMessageOpacity()
	{
		// 表画面用のレイヤを作ります
		foreLay = new Layer(kag, kag.fore.base);  // 表画面の背景レイヤを親レイヤにします
		with(foreLay)
		{
			.setSize(kag.fore.messages[0].width, kag.fore.messages[0].height);
			.setPos(kag.fore.messages[0].left, kag.fore.messages[0].top);
			.fillRect(0, 0, .width, .height, 0xFF000000);
			.absolute=1000000 - 1;
			.onMouseDown = kag.fore.base.onMouseDown;
			.visible = foreSeen;
		}

		// 裏画面用のレイヤを作ります
		backLay = new Layer(kag, kag.back.base);  // 裏画面の背景レイヤを親レイヤにします
		with(backLay)
		{
			.setSize(kag.fore.messages[0].width, kag.fore.messages[0].height);
			.setPos(kag.fore.messages[0].left, kag.fore.messages[0].top);
			.fillRect(0, 0, .width, .height, 0xFF000000);
			.absolute=1000000 - 1;
			.onMouseDown = kag.back.base.onMouseDown;
			.visible = backSeen;
		}
	}

	// デストラクタ
	function finalize()
	{
		invalidate foreLay;  // 表画面用のレイヤを無効化します
		invalidate backLay;  // 裏画面用のレイヤを無効化します
	}

	function setOptions(elm)
	{
		elm.page='fore' if elm.page === void;
		elm.visible=true if elm.visible === void;
		if (elm.page == 'fore')
		{
			foreLay.visible=foreSeen=elm.visible;
			foreLay.opacity=elm.opacity if elm.opacity !== void;
		}
		else if (elm.page == 'back')
		{
			backLay.visible=backSeen=elm.visible;
			backLay.opacity=elm.opacity if elm.opacity !== void;
		}
		if (elm.reset)
		{
			foreLay.setSize(kag.fore.messages[0].width, kag.fore.messages[0].height);
			foreLay.setPos(kag.fore.messages[0].left, kag.fore.messages[0].top);
			backLay.setSize(kag.fore.messages[0].width, kag.fore.messages[0].height);
			backLay.setPos(kag.fore.messages[0].left, kag.fore.messages[0].top);
		}
	}

	function onStore(f, elm)
	{
		var dic = f.SetMessageOpacity = %[];
			// f.exSystemButtons に辞書配列を作成
		dic.foreSeen = foreSeen;
		dic.backSeen = backSeen;
		dic.top = foreLay.top;
		dic.left = foreLay.left;
		dic.width = foreLay.width;
		dic.height = foreLay.height;
		// 各情報を辞書配列に記録
		// 栞を保存する際に呼ばれる
		// f = 保存先の栞データ ( Dictionary クラスのオブジェクト )
		// elm = tempsave 時のオプション ( 現在は常に void )
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.SetMessageOpacity;
		if(dic === void)
		{
			// SetMessageOpacityの情報が栞に保存されていない
			setOptions('page'=>'fore', 'visible'=>false);
			setOptions('page'=>'back', 'visible'=>false);
		}
		else
		{
			// SetMessageOpacityの情報が栞に保存されている
			setOptions(%['page'=>'fore', 'visible'=>dic.foreSeen]);
			setOptions(%['page'=>'back', 'visible'=>dic.backSeen]);
			foreLay.setSize(dic.width, dic.height);
			foreLay.setPos(dic.left, dic.top);
			backLay.setSize(dic.width, dic.height);
			backLay.setPos(dic.left, dic.top);
				// オプションを設定
		}
		// 栞を読み出すときに呼ばれる
		// f = 読み込む栞データ ( Dictionary クラスのオブジェクト )
		// clear = メッセージレイヤをクリアするか ( tempload の時のみ false )
		// elm = tempload 時のオプション ( tempload でない場合は 常に void,
		//                                 tempload の時は Dictionary クラスのオブジェクト )
	}

	function onStableStateChanged(stable)
	{
		// 安定 ( s l p タグで停止中 ) または 走行中 ( それ以外 )
		// の状態が変化したときに呼ばれる
		// stable = 安定の状態に true, それ以外の場合に false
	}

	function onMessageHiddenStateChanged(hidden)
	{
		if (hidden)
		{
			foreLay.visible=false;
			backLay.visible=false;
		}
		else
		{
			foreLay.visible=foreSeen;
			backLay.visible=backSeen;
		}
		// 右クリックなどでメッセージレイヤが隠されたり、または
		// その状態から抜ける時に呼ばれる
		// hidden = メッセージが隠された場合に true, 現れた場合に false
	}

	function onCopyLayer(toback)
	{
		// backlay タグ / forelay タグがすべてのレイヤに対して実行される時、
		// あるいは layer=base chidlren=true exchange=false のトランジションの終了時に、
		// 裏画面の内容を表画面にコピーする
		// 必要が発生すると呼び出される
		// toback = 表画面の内容を裏画面にコピーする時に true,
		//          裏画面の内容を表画面にコピーするときに false
		// layer=base children=true のトランジション終了時には toback = false で呼ばれる。
		if (toback)
		{
			backLay.visible=foreLay.visible;
			backLay.opacity=foreLay.opacity;
			backSeen = foreSeen;
		}
		else
		{
			foreLay.visible=backLay.visible;
			foreLay.opacity=backLay.opacity;
			foreSeen = backSeen;
		}
	}

	function onExchangeForeBack()
	{
		// layer=base children=true のトランジションの終了時に呼ばれ、
		// 表レイヤと裏レイヤの情報を交換する目的で呼ばれる
		// この時点ですでにレイヤのツリー構造は入れ替わっているので、
		// 通常、ここでは、ツリー構造の入れ替えを行うと情報が矛盾するもの
		// ( レイヤの名前とか、レイヤへの参照とか ) を裏画面と面画面の間で入れ替える
		// トランジション終了時の onCopyLayer はこのイベントより前に呼ばれるので
		// 注意
		backLay <-> foreLay;
		backSeen <-> foreSeen;
	}

	function onSaveSystemVariables()
	{
		// システム変数に情報が保存され時に呼ばれる
		// このタイミングで kag.scflags に情報を書き込めば
		// 確実にシステム変数に情報を書くことができる
	}
}

kag.addPlugin(global.SetMessageOpacity_object = new SetMessageOpacity());
@endscript

; [SetMessageOpacity page=(fore)|back visible=(true)|false opacity= ]
@macro name=SetMessageOpacity
@eval exp="SetMessageOpacity_object.setOptions(mp)"
@endmacro

@return
