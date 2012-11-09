;//
;//�@TJS�ɒ���I �` ��5.10�@�V�X�e���{�^���v���O�C���̃J�X�^�}�C�Y
;//
;//  �����R�ɔz�z�E���ς��Ē����č\���܂���B
;//

[iscript]

// �V�X�e���{�^�����C���N���X�̒�`�isystembutton.ks ��蔲���j
class SystemButtonLayer extends ButtonLayer
	// �N���b�N���ꂽ�Ƃ��Ɏ��s����֐����w��ł���{�^�����C��
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

// �g���V�X�e���{�^���v���O�C���N���X�̒�`
class ExSystemButtonPlugin extends KAGPlugin
{

	var foreSeen = false; // �\��ʂ̃{�^��������
	var backSeen = false; // ����ʂ̃{�^��������

	var foreButtons = []; // �\��ʂ̃{�^���̔z��
	var backButtons = []; // ����ʂ̃{�^���̔z��
	
	var x;
	var y;
	var x_width;
	var y_height;

	function ExSystemButtonPlugin()
	{
		// ExSystemButtonPlugin �R���X�g���N�^

		createButtons(kag.fore.base, foreButtons); // �\��ʂ̃{�^�����쐬
		createButtons(kag.back.base, backButtons);

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

		super.finalize(...);
	}

	function setObjProp(array, member, value)
	{
		// array �̊e�����o�̃v���p�e�B�̐ݒ�
		for(var i = array.count - 1; i >= 0; i--) array[i][member] = value;
	}

	function createButtons(parent, array)
	{
		var obj;

		// ExSystemButtonLayer �� SystemButtonLayer �ɒu�������Ă��g���܂��i�A�����ʉ��̐ݒ�͂ł��Ȃ��Ȃ�܂��j

		// ���ʉ����Đ�����ꍇ�͈ȉ��̃R�����g���O���āA�e�{�^���ɂ��ēK�X�ݒ肵�Ă�������
		// obj.clickse = 'click.wav';
		// obj.clicksebuf = 1;
		// obj.enterse = 'enter.wav';	// entersebuf �̐ݒ�͏ȗ����Ă���̂� 0 �Ԃ̃o�b�t�@���g���܂�
		// obj.leavese = 'leave.wav';	// leavesebuf �̐ݒ�͏ȗ����Ă���̂� 0 �Ԃ̃o�b�t�@���g���܂�

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
		
	}

	function realign()
	{
		x = kag.fore.messages[0].left; // ���� x �ʒu
		y = kag.fore.messages[0].top + kag.fore.messages[0].height - 30; // ���� y �ʒu
		x_width = 70;  //�{�^���Ԃ̕�
		y_height = 0;  //�{�^���Ԃ̍���
		// �{�^���̍Ĕz�u
		// ���̃��\�b�h�́A�{�^���� x y �ʒu����c���ɔz�u���܂�
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
			obj.absolute = 2000000-3; // �d�ˍ��킹�����̓��b�Z�[�W�����������ɂ��܂�

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
		// �I�v�V������ݒ�
		setObjProp(foreButtons, 'visible', foreSeen = +elm.forevisible) if elm.forevisible !== void;
		setObjProp(backButtons, 'visible', backSeen = +elm.backvisible) if elm.backvisible !== void;
		realign(); // �\���ʒu�̕ύX
	}

	function onStore(f, elm)
	{
		// �x��ۑ�����Ƃ�
		var dic = f.exSystemButtons = %[];
			// f.exSystemButtons �Ɏ����z����쐬
		dic.foreVisible = foreSeen;
		dic.backVisible = backSeen;
		dic.left = x;
		dic.top = y;
			// �e���������z��ɋL�^
	}

	function onRestore(f, clear, elm)
	{
		// �x��ǂݏo���Ƃ�
		var dic = f.exSystemButtons;
		if(dic === void)
		{
			// exSystemButtons �̏�񂪞x�ɕۑ�����Ă��Ȃ�
			setObjProp(foreButtons, 'visible', foreSeen = false);
			setObjProp(backButtons, 'visible', backSeen = false);
		}
		else
		{
			// exSystemButtons �̏�񂪞x�ɕۑ�����Ă���
			setOptions(%[ forevisible : dic.foreVisible, backvisible : dic.backVisible,
				left : dic.left, top : dic.top]);
				// �I�v�V������ݒ�
		}
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
		{ // ���s���͊e�{�^���𖳌��ɂ���
			setObjProp(foreButtons, 'enabled', false);
			setObjProp(backButtons, 'enabled', false);
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
		}
		else
		{
			// foreSeen, backSeen �́A�{�^�����{���\�����ł��������ǂ������L�^���Ă���
			setObjProp(foreButtons, 'visible', foreSeen);
			setObjProp(backButtons, 'visible', backSeen);
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
			backSeen = foreSeen;
		}
		else
		{
			// �����\
			setObjProp(foreButtons, 'visible', backButtons[0].visible);
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
	// �v���O�C���I�u�W�F�N�g���쐬���A�o�^����

[endscript]

; �}�N���̓o�^
[macro name="exsysbtopt"]
[eval exp="exsystembutton_object.setOptions(mp)"]
; mp ���}�N���ɓn���ꂽ���������������z��I�u�W�F�N�g
[endmacro]

[return]
