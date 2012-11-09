;//
;//　TJSに挑戦！ ～ §5.10　システムボタンプラグインのカスタマイズ
;//
;//  ※自由に配布・改変して頂いて構いません。
;//

[iscript]

// システムボタンレイヤクラスの定義（systembutton.ks より抜粋）
class SystemButtonLayer extends ButtonLayer
	// クリックされたときに実行する関数を指定できるボタンレイヤ
{
	var onClickFunction;

	function SystemButtonLayer(window, parent, func)
	{
		super.ButtonLayer(window, parent);
		focusable = false;
		visible = true;
		onClickFunction = func;
	}

	function finalize()
	{
		super.finalize(...);
	}

	function onClick()
	{
		super.onClick(...);
	}

	function onMouseUp(x, y, button, shift)
	{
		if(enabled && button == mbLeft)
			onClickFunction(this);
		super.onMouseUp(...);
	}
}

// 拡張システムボタンレイヤクラスの定義
class ExSystemButtonLayer extends SystemButtonLayer
{
	var clickse, clicksebuf;	// クリックされたときに再生する効果音のファイル名とバッファ番号
	var enterse, entersebuf;	// ボタンの上にマウスカーソルが乗った時に再生する効果音のファイル名とバッファ番号
	var leavese, leavesebuf;	// ボタンの上からマウスカーソルが出て行った時に再生する効果音のファイル名とバッファ番号

	function ExSystemButtonLayer(window, parent, func)
	{
		super.SystemButtonLayer(window, parent, func);

		// デフォルトのバッファ番号を 0 に設定します
		clicksebuf = 0;
		entersebuf = 0;
		leavesebuf = 0;
	}

	function finalize()
	{
		super.finalize();
	}

	function loadImages(storage, key)
	{
		// スーパークラス(SystemButtonLayerクラス)の loadImages メソッドを呼び出します
		super.loadImages(storage, key);

		// レイヤの表示幅をボタン画像の４分の１に設定します
		global.Layer.width = imageWidth \ 4;
	}

	function drawState(s)
	{
		// 状態 s に対応する画像を描画
		// s :  0 : 普通の状態
		//      1 : ボタンが押された状態
		//      2 : ボタンの上にマウスカーソルがある状態
		if(!enabled)
		{
			s = 3; // 無効状態
		}

		if(Butt_imageLoaded)
		{
			// ボタンの画像を設定（左から(s+1)番目の画像を表示）します
			imageLeft = -s * width;
		}
	}

	function onMouseUp(x, y, button, shift)
	{
		// clickse が指定されていれば効果音を再生します
		if(clickse !== void)
			window.se[clicksebuf].play(%["storage" => clickse, "loop" => false]);

		// スーパークラス(SystemButtonLayer クラス)の onMouseUp メソッドを呼び出します
		super.onMouseUp(...);
	}

	function onMouseEnter()
	{
		// enterse が指定されていれば効果音を再生します
		if(enterse !== void)
			window.se[entersebuf].play(%["storage" => enterse, "loop" => false]);

		// スーパークラス(SystemButtonLayer クラス)の onMouseEnter メソッドを呼び出します
		super.onMouseEnter(...);
	}

	function onMouseLeave()
	{
		// leavese が指定されていれば効果音を再生します
		if(leavese !== void)
			window.se[leavesebuf].play(%["storage" => leavese, "loop" => false]);

		// スーパークラス(SystemButtonLayer クラス)の onMouseLeave メソッドを呼び出します
		super.onMouseLeave(...);
	}
}

// 拡張システムボタンプラグインクラスの定義
class ExSystemButtonPlugin extends KAGPlugin
{

	var foreSeen = false; // 表画面のボタンが可視か
	var backSeen = false; // 裏画面のボタンが可視か

	var foreButtons = []; // 表画面のボタンの配列
	var backButtons = []; // 裏画面のボタンの配列
	
	var x;
	var y;
	var x_width;
	var y_height;

	function ExSystemButtonPlugin()
	{
		// ExSystemButtonPlugin コンストラクタ

		createButtons(kag.fore.base, foreButtons); // 表画面のボタンを作成
		createButtons(kag.back.base, backButtons);

		realign(); // 再配置

		setObjProp(foreButtons, 'visible', foreSeen = false);
		setObjProp(backButtons, 'visible', backSeen = false);
			// 非表示に
	}

	function finalize()
	{
		// ボタンを無効化
		for(var i = 0; i < foreButtons.count; i++)
			invalidate foreButtons[i];
		for(var i = 0; i < backButtons.count; i++)
			invalidate backButtons[i];

		super.finalize(...);
	}

	function setObjProp(array, member, value)
	{
		// array の各メンバのプロパティの設定
		for(var i = array.count - 1; i >= 0; i--) array[i][member] = value;
	}

	function createButtons(parent, array)
	{
		var obj;

		// ExSystemButtonLayer を SystemButtonLayer に置き換えても使えます（但し効果音の設定はできなくなります）

		// 効果音を再生する場合は以下のコメントを外して、各ボタンについて適宜設定してください
		// obj.clickse = 'click.wav';
		// obj.clicksebuf = 1;
		// obj.enterse = 'enter.wav';	// entersebuf の設定は省略しているので 0 番のバッファが使われます
		// obj.leavese = 'leave.wav';	// leavesebuf の設定は省略しているので 0 番のバッファが使われます

		//No 0
		array.add(obj = new ExSystemButtonLayer(kag, parent, onSaveButtonClick));
		obj.loadImages('savebutton'); 
		obj.hint = 'セーブ画面に入ります';
		
		//No 1
		array.add(obj = new ExSystemButtonLayer(kag, parent, onLoadButtonClick));
		obj.loadImages('loadbutton'); 
		obj.hint = 'ロード画面に入ります';
		
		//No 2
		array.add(obj = new ExSystemButtonLayer(kag, parent, onqSaveButtonClick));
		obj.loadImages('q-savebutton'); 
		obj.hint = 'クイックセーブをします';
		
		//No 3
		array.add(obj = new ExSystemButtonLayer(kag, parent, onqLoadButtonClick));
		obj.loadImages('q-loadbutton'); 
		obj.hint = 'クイックロードをします';
		
		//No 4
		array.add(obj = new ExSystemButtonLayer(kag, parent, onAutoButtonClick));
		obj.loadImages('autobutton'); 
		obj.hint = 'オートモードを始めます';
		
		//No 5
		array.add(obj = new ExSystemButtonLayer(kag, parent, onSkipButtonClick));
		obj.loadImages('skipbutton'); 
		obj.hint = 'スキップモードを始めます';
		
		//No 6
		array.add(obj = new ExSystemButtonLayer(kag, parent, onHideButtonClick));
		obj.loadImages('hidebutton'); 
		obj.hint = '画像を表示します';
		
		//No 7
		if (chose_novel){
			array.add(obj = new ExSystemButtonLayer(kag, parent, onReturnButtonClick));
			obj.loadImages('returnbutton'); 
			obj.hint = '前の選択肢に戻ります';
		}
				
		//No 8
		array.add(obj = new ExSystemButtonLayer(kag, parent, onConfigButtonClick));
		obj.loadImages('configbutton'); 
		obj.hint = 'コンフィグ画面に入ります';
		
		//No 9
		array.add(obj = new ExSystemButtonLayer(kag, parent, onTitleButtonClick));
		obj.loadImages('titlebutton'); 
		obj.hint = 'タイトルに戻ります';

		//No 10
		array.add(obj = new ExSystemButtonLayer(kag, parent, onExitButtonClick));
		obj.loadImages('exitbutton'); 
		obj.hint = '終了します';
		
	}

	function realign()
	{
		x = kag.fore.messages[0].left; // 初期 x 位置
		y = kag.fore.messages[0].top + kag.fore.messages[0].height - 30; // 初期 y 位置
		x_width = 70;  //ボタン間の幅
		y_height = 0;  //ボタン間の高さ
		// ボタンの再配置
		// このメソッドは、ボタンを x y 位置から縦一列に配置します
		var fore, back, count, btn_y, btn_x;

		count = foreButtons.count;
		btn_x = 0;
		btn_y = 0;
		for(var i = 0; i < count; i++)
		{
			var xpos = btn_x + x;
			var ypos = btn_y + y;
			var obj;

			obj = backButtons[i];
			obj.setPos(xpos, ypos);
			obj.absolute = 2000000-3; // 重ね合わせ順序はメッセージ履歴よりも奥にします

			obj = foreButtons[i];
			obj.setPos(xpos, ypos);
			obj.absolute = 2000000-3;

			btn_x += x_width;
			btn_y += y_height;
		}
	}

	function onSaveButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
			kag.process('save_mode.ks');
		}
		else
		{
			kag.callExtraConductor('save_mode.ks');
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onLoadButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
			kag.process('load_mode.ks');
		}
		else
		{
			kag.callExtraConductor('load_mode.ks');
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onqSaveButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.storeBookMark(0,false);
			kag.process('Menu.ks', '*rclick_return');
		}
		else
		{
			kag.storeBookMark(0,false);
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onqLoadButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.process('Menu.ks', '*qload');
		}
		else
		{
			kag.callExtraConductor('Menu.ks','*qload');
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onAutoButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.process('Menu.ks', '*auto');
		}
		else
		{
			kag.enterAutoMode();
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onSkipButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.process('Menu.ks', '*skip');
		}
		else
		{
			kag.skipToStop();
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onHideButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.process('Menu.ks', '*hide');
		}
		else
		{
			kag.callExtraConductor('Menu.ks','*hide');
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	if (chose_novel){
		function onReturnButtonClick()
		{
			if (sf.menu_mode == 1)
			{
				kag.process('Menu.ks', '*return');
			}
			else
			{
				kag.callExtraConductor('Menu.ks','*return');
				MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
			}
		}
	}
	function onConfigButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
			kag.process('config.ks', '*initialize');
		}
		else
		{
			kag.callExtraConductor('config.ks','*initialize');
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onTitleButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.process('Menu.ks', '*title');
		}
		else
		{
			kag.callExtraConductor('Menu.ks','*title');
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}
	function onExitButtonClick()
	{
		if (sf.menu_mode == 1)
		{
			kag.process('Menu.ks', '*exit');
		}
		else
		{
			kag.closeByScript(%[ask:false,ignore:true]);
			MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}

	function setOptions(elm)
	{
		// オプションを設定
		setObjProp(foreButtons, 'visible', foreSeen = +elm.forevisible) if elm.forevisible !== void;
		setObjProp(backButtons, 'visible', backSeen = +elm.backvisible) if elm.backvisible !== void;
		realign(); // 表示位置の変更
	}

	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f.exSystemButtons = %[];
			// f.exSystemButtons に辞書配列を作成
		dic.foreVisible = foreSeen;
		dic.backVisible = backSeen;
		dic.left = x;
		dic.top = y;
			// 各情報を辞書配列に記録
	}

	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		var dic = f.exSystemButtons;
		if(dic === void)
		{
			// exSystemButtons の情報が栞に保存されていない
			setObjProp(foreButtons, 'visible', foreSeen = false);
			setObjProp(backButtons, 'visible', backSeen = false);
		}
		else
		{
			// exSystemButtons の情報が栞に保存されている
			setOptions(%[ forevisible : dic.foreVisible, backvisible : dic.backVisible,
				left : dic.left, top : dic.top]);
				// オプションを設定
		}
	}

	function onStableStateChanged(stable)
	{
		// 「安定」( s l p の各タグで停止中 ) か、
		// 「走行中」 ( それ以外 ) かの状態が変わったときに呼ばれる
		if (stable)
		{ //安定時は、回想モードかどうかで有効にするボタンを変える
			if (in_scene_mode_button_mark)
			{ //回想モード
				setObjProp(foreButtons, 'enabled', true);
				setObjProp(backButtons, 'enabled', true);
				// 一旦すべて有効化してから一部無効化する
				foreButtons[0].enabled = false;
				foreButtons[1].enabled = false;
				foreButtons[2].enabled = false;
				foreButtons[3].enabled = false;
				if (chose_novel) foreButtons[7].enabled = false;
				backButtons[0].enabled = false;
				backButtons[1].enabled = false;
				backButtons[2].enabled = false;
				backButtons[3].enabled = false;
				if (chose_novel) backButtons[7].enabled = false;
			}else{
				setObjProp(foreButtons, 'enabled', true);
				setObjProp(backButtons, 'enabled', true);
			}
		}
		else
		{ // 走行中は各ボタンを無効にする
			setObjProp(foreButtons, 'enabled', false);
			setObjProp(backButtons, 'enabled', false);
		}
		
		
	}

	function onMessageHiddenStateChanged(hidden)
	{
		// メッセージレイヤがユーザの操作によって隠されるとき、現れるときに
		// 呼ばれる。メッセージレイヤとともに表示/非表示を切り替えたいときは
		// ここで設定する。
		if(hidden)
		{
			setObjProp(foreButtons, 'visible', false);
			setObjProp(backButtons, 'visible', false);
		}
		else
		{
			// foreSeen, backSeen は、ボタンが本来表示中であったかどうかを記録している
			setObjProp(foreButtons, 'visible', foreSeen);
			setObjProp(backButtons, 'visible', backSeen);
		}
	}

	function onCopyLayer(toback)
	{
		// レイヤの表←→裏の情報のコピー

		// backlay タグやトランジションの終了時に呼ばれる

		// ここでレイヤに関してコピーすべきなのは
		// 表示/非表示の情報だけ

		if(toback)
		{
			// 表→裏
			setObjProp(backButtons, 'visible', foreButtons[0].visible);
			backSeen = foreSeen;
		}
		else
		{
			// 裏→表
			setObjProp(foreButtons, 'visible', backButtons[0].visible);
			foreSeen = backSeen;
		}
	}

	function onExchangeForeBack()
	{
		// 裏と表の管理情報を交換

		// children = true のトランジションでは、トランジション終了時に
		// 表画面と裏画面のレイヤ構造がそっくり入れ替わるので、
		// それまで 表画面だと思っていたものが裏画面に、裏画面だと思って
		// いたものが表画面になってしまう。ここのタイミングでその情報を
		// 入れ替えれば、矛盾は生じないで済む。

		// ここで表画面、裏画面のレイヤに関して管理すべきなのは
		// foreButtons と backButton 、foreSeen と backSeen の変数だけ
		var tmp;

		tmp = backButtons;
		backButtons = foreButtons;
		foreButtons = tmp;

		tmp = backSeen;
		backSeen = foreSeen;
		foreSeen = tmp;
	}
}

kag.addPlugin(global.exsystembutton_object = new ExSystemButtonPlugin(kag));
	// プラグインオブジェクトを作成し、登録する

[endscript]

; マクロの登録
[macro name="exsysbtopt"]
[eval exp="exsystembutton_object.setOptions(mp)"]
; mp がマクロに渡された属性を示す辞書配列オブジェクト
[endmacro]

[return]
