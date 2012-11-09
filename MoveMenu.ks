@if exp="typeof(global.MoveMenu_object) == 'undefined'"
@iscript

// ��ʂɁu�Z�[�u�v�u���[�h�v�̃{�^����\������T���v��

// ���b�Z�[�W���C���̃N���A���Ƃɂ����̃{�^���� button �^�O�ŕ\�����邱�Ƃł�
// �����ł��܂����A���܂肻��ł͌������ǂ��Ȃ��ł��B
// ���̃T���v���ł́A�u�Z�[�u�v�Ɓu���[�h�v�̃{�^�����܂񂾃��C������ʏ��
// �\��������̂ł��B
// ���̗�̓t���[�Z�[�u���[�h�œ��삵�܂��B���낢������ł���Ǝv���܂��B
//�}�E�X�I�����j���[�ɉ���

// �E�N���b�N����ςȕ��@�Ŗ߂�̂ŗv����
//��z���[�h�����f����Ȃ���������f(�Ȃ����Aenabled��true�ɂȂ�)
//enabled���g���ƃ}�E�X���f�t�H���g�ɖ߂��Ă��܂�
//hitThreshold = 256;
//joinFocusChain = false;


class SystemButtonLayer extends ButtonLayer
	// �N���b�N���ꂽ�Ƃ��Ɏ��s����֐����w��ł���{�^�����C��
{
	var onClickFunction;

	function SystemButtonLayer(window, parent, func)
	{
		super.ButtonLayer(window, parent);
		focusable = false;
		visible = true;
		opacity = 150;
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

// �g���V�X�e���{�^�����C���N���X�̒�`
class ExSystemButtonLayer extends SystemButtonLayer
{
	var clickse, clicksebuf;	// �N���b�N���ꂽ�Ƃ��ɍĐ�������ʉ��̃t�@�C�����ƃo�b�t�@�ԍ�
	var enterse, entersebuf;	// �{�^���̏�Ƀ}�E�X�J�[�\������������ɍĐ�������ʉ��̃t�@�C�����ƃo�b�t�@�ԍ�
	var leavese, leavesebuf;	// �{�^���̏ォ��}�E�X�J�[�\�����o�čs�������ɍĐ�������ʉ��̃t�@�C�����ƃo�b�t�@�ԍ�

	function ExSystemButtonLayer(window, parent, func)
	{
		super.SystemButtonLayer(window, parent, func);

		// �f�t�H���g�̃o�b�t�@�ԍ��� 0 �ɐݒ肵�܂�
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
		// �X�[�p�[�N���X(SystemButtonLayer�N���X)�� loadImages ���\�b�h���Ăяo���܂�
		super.loadImages(storage, key);

		// ���C���̕\�������{�^���摜�̂S���̂P�ɐݒ肵�܂�
		global.Layer.width = imageWidth \ 4;
	}

	function drawState(s)
	{
		// ��� s �ɑΉ�����摜��`��
		// s :  0 : ���ʂ̏��
		//      1 : �{�^���������ꂽ���
		//      2 : �{�^���̏�Ƀ}�E�X�J�[�\����������
		if(!enabled)
		{
			s = 3; // �������
		}

		if(Butt_imageLoaded)
		{
			// �{�^���̉摜��ݒ�i������(s+1)�Ԗڂ̉摜��\���j���܂�
			imageLeft = -s * width;
		}
	}

	function onMouseUp(x, y, button, shift)
	{
		// clickse ���w�肳��Ă���Ό��ʉ����Đ����܂�
		if(clickse !== void)
			window.se[clicksebuf].play(%["storage" => clickse, "loop" => false]);

		// �X�[�p�[�N���X(SystemButtonLayer �N���X)�� onMouseUp ���\�b�h���Ăяo���܂�
		super.onMouseUp(...);
	}

	function onMouseEnter()
	{
		// enterse ���w�肳��Ă���Ό��ʉ����Đ����܂�
		if(enterse !== void)
			window.se[entersebuf].play(%["storage" => enterse, "loop" => false]);

		// �X�[�p�[�N���X(SystemButtonLayer �N���X)�� onMouseEnter ���\�b�h���Ăяo���܂�
		super.onMouseEnter(...);
	}

	function onMouseLeave()
	{
		// leavese ���w�肳��Ă���Ό��ʉ����Đ����܂�
		if(leavese !== void)
			window.se[leavesebuf].play(%["storage" => leavese, "loop" => false]);

		// �X�[�p�[�N���X(SystemButtonLayer �N���X)�� onMouseLeave ���\�b�h���Ăяo���܂�
		super.onMouseLeave(...);
	}
}


class MoveMenuPlugin extends KAGPlugin
{
	var x = 0; // ���� x �ʒu
	var y = 0; // ���� y �ʒu

	var foreSeen = false; // �\��ʂ̃{�^��������
	var backSeen = false; // ����ʂ̃{�^��������

	var foreButtons = []; // �\��ʂ̃{�^���̔z��
	var backButtons = []; // ����ʂ̃{�^���̔z��

	var menuon = false; //���j���[��\�����邩�ǂ���
	var position = 'top';	    //���j���[�̈ʒu (right or top)	
	var move_menuon = 0; //�}�E�X�������j���[�̗L������
	
	var forelayer = new Layer(kag, kag.fore.base); //�\��ʂ̃{�^���̐e���C��
	var backlayer = new Layer(kag, kag.back.base); //����ʂ̃{�^���̐e���C��
	 with(forelayer)
        {
		.setSize(kag.scWidth, kag.scHeight);
		.setPos(0, 0);
		.visible = false;
		.absolute = 2000000-3; // �d�ˍ��킹�����̓��b�Z�[�W����������
		//�E�N���b�N����߂邽��
		.onMouseDown = kag.fore.base.onMouseDown;
        }
	 with(backlayer)
        {
		.setSize(kag.scWidth, kag.scHeight);
		.setPos(0, 0);
		.visible = false;
		.absolute = 2000000-3; // �d�ˍ��킹�����̓��b�Z�[�W����������
		//�E�N���b�N����߂邽��
		.onMouseDown = kag.back.base.onMouseDown;
        }

	function MoveMenuPlugin()
	{
		// MoveMenuPlugin �R���X�g���N�^

		createButtons(forelayer, foreButtons); // �\��ʂ̃{�^�����쐬
		createButtons(backlayer, backButtons);

		realign(); // �Ĕz�u
		setObjProp(foreButtons, 'visible', foreSeen = false);
		setObjProp(backButtons, 'visible', backSeen = false);
			// ��\����
	}

	function finalize()
	{
		// �{�^���𖳌���
		for(var i = 0; i < foreButtons.count; i++)
			invalidate foreButtons[i];
		for(var i = 0; i < backButtons.count; i++)
			invalidate backButtons[i];
		invalidate forelayer;
		invalidate backlayer;

		super.finalize(...);
	}
	//�^�C�~���O���
	function onRestore(elm, clear, tempelm){
		//�󋵂ɍ��킹�ĉE�N���b�N��ݒ�
		if  (kag.canStore() && sf.menu_mode == 0){
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => false, 'jump' => false]);
		}else if (kag.canStore() && sf.menu_mode == 2){
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => false, 'jump' => false]);
		}else if (kag.canStore() && sf.menu_mode == 1){
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => true, 'jump' => false, 'storage' => 'Menu.ks', 'target' => '*rclick']);
		}else if (!kag.canStore()){
			kag.tagHandlers.rclick(%['enabled' => false]);
		}
		move_menuon = sf.menu_mode == 0 && kag.canStore() ? 1 : 0;
		if (kag.canStore() && sf.menu_mode == 2) exsystembutton_object.setOptions(%['forevisible'=>true, 'backvisible'=>true]);
		if (sf.menu_mode != 2) exsystembutton_object.setOptions(%['forevisible'=>false, 'backvisible'=>false]);
	}
	function setObjProp(array, member, value)
	{
		// array �̊e�����o�̃v���p�e�B�̐ݒ�
		for(var i = array.count - 1; i >= 0; i--) array[i][member] = value;
	}

	function createButtons(parent, array)
	{
		// parent ��e���C���Ƃ��ă{�^�����쐬���Aarray �ɓo�^����B
		// �{�^���͕\��ʂƗ���ʂ̗����ɑ΂��č쐬�����̂Œ��ӁB

		// �{�^����ǉ�����ɂ́A������Q�l�ɂ��� ���낢��ǉ����Ă��������B

		var obj;
		//�ʏ탁�j���[
		//No 0
		array.add(obj = new ExSystemButtonLayer(kag, parent, onSaveButtonClick));
		obj.loadImages('savebutton'); 
		obj.hint = '�Z�[�u��ʂɓ���܂�';
		
		//No 1
		array.add(obj = new ExSystemButtonLayer(kag, parent, onLoadButtonClick));
		obj.loadImages('loadbutton'); 
		obj.hint = '���[�h��ʂɓ���܂�';
		
		//No 2
		array.add(obj = new ExSystemButtonLayer(kag, parent, onqSaveButtonClick));
		obj.loadImages('q-savebutton'); 
		obj.hint = '�N�C�b�N�Z�[�u�����܂�';
		
		//No 3
		array.add(obj = new ExSystemButtonLayer(kag, parent, onqLoadButtonClick));
		obj.loadImages('q-loadbutton'); 
		obj.hint = '�N�C�b�N���[�h�����܂�';
		
		//No 4
		array.add(obj = new ExSystemButtonLayer(kag, parent, onAutoButtonClick));
		obj.loadImages('autobutton'); 
		obj.hint = '�I�[�g���[�h���n�߂܂�';
		
		//No 5
		array.add(obj = new ExSystemButtonLayer(kag, parent, onSkipButtonClick));
		obj.loadImages('skipbutton'); 
		obj.hint = '�X�L�b�v���[�h���n�߂܂�';
		
		//No 6
		array.add(obj = new ExSystemButtonLayer(kag, parent, onHideButtonClick));
		obj.loadImages('hidebutton'); 
		obj.hint = '�摜��\�����܂�';
		
		//No 7
		if (chose_novel){
			array.add(obj = new ExSystemButtonLayer(kag, parent, onReturnButtonClick));
			obj.loadImages('returnbutton'); 
			obj.hint = '�O�̑I�����ɖ߂�܂�';
		}
				
		//No 8
		array.add(obj = new ExSystemButtonLayer(kag, parent, onConfigButtonClick));
		obj.loadImages('configbutton'); 
		obj.hint = '�R���t�B�O��ʂɓ���܂�';
		
		//No 9
		array.add(obj = new ExSystemButtonLayer(kag, parent, onTitleButtonClick));
		obj.loadImages('titlebutton'); 
		obj.hint = '�^�C�g���ɖ߂�܂�';

		//No 10
		array.add(obj = new ExSystemButtonLayer(kag, parent, onExitButtonClick));
		obj.loadImages('exitbutton'); 
		obj.hint = '�I�����܂�';
		
		// �����Ƃ����摜���쐬���Ă����Ƃ����t�@�C�������w�肷���
		// �悢�ł��傤�B�{�^���p�摜�̍����� button �^�O�p�摜�̍���
		// �Ɠ����ł��B
	}

	function realign()
	{
		// �{�^���̍Ĕz�u
		// ���̃��\�b�h�́A�{�^���� x y �ʒu����c���ɔz�u����
		if (position == 'right') { x= kag.scWidth - foreButtons[0].width; y = 10/(foreButtons.count + 1);}
		if (position == 'top')   { x= (kag.scWidth - foreButtons.count * foreButtons[0].width)/(foreButtons.count + 1); y = 0;}
		var fore, back, btn_x, btn_y;
		btn_y = 0;
		btn_x = 0;
		if (position == 'top')
		{
			for(var i = 0; i < foreButtons.count; i++)
			{
				var xpos = btn_x + x;
				var obj;

				obj = backButtons[i];
				obj.setPos(xpos, y);

				obj = foreButtons[i];
				obj.setPos(xpos, y);

				btn_x += obj.width + (kag.scWidth - foreButtons.count * obj.width)/(foreButtons.count + 1);
			}
		}
		else if (position == 'right')
		{
			for(var i = 0; i < foreButtons.count; i++)
			{
				var ypos = btn_y + y;
				var obj;

				obj = backButtons[i];
				obj.setPos(x, ypos);

				obj = foreButtons[i];
				obj.setPos(x, ypos);

				btn_y += obj.height + 10/(foreButtons.count + 1);
			}
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
		// �I�v�V������ݒ�
		setObjProp(foreButtons, 'visible', foreSeen = +elm.forevisible) if elm.forevisible !== void;
		setObjProp(backButtons, 'visible', backSeen = +elm.backvisible) if elm.backvisible !== void;
		forelayer.visible = +elm.forevisible;
                backlayer.visible = +elm.backvisible;
		if (sf.menu_mode == 1) //�E�N���b�N���j���[�ł͉�ʂ��Â�����
		{
			forelayer.fillRect(0, 0, kag.scWidth, kag.scHeight, 0x66000000);
			backlayer.fillRect(0, 0, kag.scWidth, kag.scHeight, 0x66000000);
		}
		else
		{
			forelayer.fillRect(0, 0, kag.scWidth, kag.scHeight, 0x00000000);
			backlayer.fillRect(0, 0, kag.scWidth, kag.scHeight, 0x00000000);
		}
		//if (position == 'top') //�g��\��
		//{
		//	forelayer.fillRect(0,0,kag.scWidth,foreButtons[0].height,0xB4FFFFFF);
		//	backlayer.fillRect(0,0,kag.scWidth,foreButtons[0].height,0xB4FFFFFF);
		//}
		//else if (position == 'right')
		//{
		//	forelayer.fillRect(kag.scWidth - foreButtons[0].width - 1, 0, foreButtons[0].width + 10, foreButtons[0].height*foreButtons.count + 10, 0xB4FFFFFF);
		//	backlayer.fillRect(kag.scWidth - foreButtons[0].width - 1, 0, foreButtons[0].width + 10, foreButtons[0].height*foreButtons.count + 10, 0xB4FFFFFF);
		//}

		var poschanged = false;
		(x = +elm.left, poschanged = true) if elm.left !== void;
		(y = +elm.top, poschanged = true) if elm.top !== void;
		if(poschanged) realign(); // �\���ʒu�̕ύX
	}


	function onStableStateChanged(stable)
	{
		// �u����v( s l p �̊e�^�O�Œ�~�� ) ���A
		// �u���s���v ( ����ȊO ) ���̏�Ԃ��ς�����Ƃ��ɌĂ΂��

		if (stable)
		{ //���莞�́A��z���[�h���ǂ����ŗL���ɂ���{�^����ς���
			if (in_scene_mode_button_mark)
			{ //��z���[�h
				setObjProp(foreButtons, 'enabled', true);
				setObjProp(backButtons, 'enabled', true);
				// ��U���ׂėL�������Ă���ꕔ����������
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
		{ //�������������\����, ���s���͊e�{�^���𖳌��ɂ���
			setObjProp(foreButtons, 'enabled', false);
			setObjProp(backButtons, 'enabled', false);
			setOptions(%['forevisible'=>'false','backvisible'=>'false']);
		}
	}

	function onMessageHiddenStateChanged(hidden)
	{
		// ���b�Z�[�W���C�������[�U�̑���ɂ���ĉB�����Ƃ��A�����Ƃ���
		// �Ă΂��B���b�Z�[�W���C���ƂƂ��ɕ\��/��\����؂�ւ������Ƃ���
		// �����Őݒ肷��B
		if(hidden)
		{
			setObjProp(foreButtons, 'visible', false);
			setObjProp(backButtons, 'visible', false);
			forelayer.visible = false;
			backlayer.visible = false;
		}
		else
		{
			// foreSeen, backSeen �́A�{�^�����{���\�����ł��������ǂ������L�^���Ă���
			setObjProp(foreButtons, 'visible', foreSeen);
			setObjProp(backButtons, 'visible', backSeen);
			forelayer.visible = foreSeen;
			backlayer.visible = backSeen;
		}
	}

	function onCopyLayer(toback)
	{
		// ���C���̕\�������̏��̃R�s�[

		// backlay �^�O��g�����W�V�����̏I�����ɌĂ΂��

		// �����Ń��C���Ɋւ��ăR�s�[���ׂ��Ȃ̂�
		// �\��/��\���̏�񂾂�

		if(toback)
		{
			// �\����
			setObjProp(backButtons, 'visible', foreButtons[0].visible);
			backlayer.visible = foreButtons[0].visible;
			backSeen = foreSeen;
		}
		else
		{
			// �����\
			setObjProp(foreButtons, 'visible', backButtons[0].visible);
			forelayer.visible = backButtons[0].visible;
			foreSeen = backSeen;
		}
	}

	function onExchangeForeBack()
	{
		// ���ƕ\�̊Ǘ���������

		// children = true �̃g�����W�V�����ł́A�g�����W�V�����I������
		// �\��ʂƗ���ʂ̃��C���\���������������ւ��̂ŁA
		// ����܂� �\��ʂ��Ǝv���Ă������̂�����ʂɁA����ʂ��Ǝv����
		// �������̂��\��ʂɂȂ��Ă��܂��B�����̃^�C�~���O�ł��̏���
		// ����ւ���΁A�����͐����Ȃ��ōςށB

		// �����ŕ\��ʁA����ʂ̃��C���Ɋւ��ĊǗ����ׂ��Ȃ̂�
		// foreButtons �� backButton �AforeSeen �� backSeen �̕ϐ�����
		foreButtons <-> backButtons; 
		forelayer <-> backlayer;
		foreSeen <-> backSeen;
	}
}





kag.addPlugin(global.MoveMenu_object = new MoveMenuPlugin());
	// �v���O�C���I�u�W�F�N�g���쐬���A�o�^����
@endscript
@endif

; �}�N���̓o�^
@macro name="sysbtopt"
@eval exp="MoveMenu_object.setOptions(mp)"
; mp ���}�N���ɓn���ꂽ���������������z��I�u�W�F�N�g
@endmacro

@return
