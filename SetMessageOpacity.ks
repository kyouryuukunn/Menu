;�g����^�O
;SetMessageOpacity
;������
;page		:fore or back  (�f�t�H���g fore)
;visible	:true or false (�f�t�H���g true)
;opacity	:�����x
;reset		:true or false (�f�t�H���g false)
;		 ���b�Z�[�W���C��0�Ɠ����ʒu�A�傫����
;		 �g���ĕ`�悷��(�Q�[�����Ƀ��b�Z�[�W���C����
;		 �ݒ肪�ς�����Ƃ��p)
;���b�Z�[�W�t���[����ݒ肷��
;
;���b�Z�[�W���C���̕��������������ɁA�Q�[������
;���b�Z�[�W���C���̔Z�x��ύX����v���O�C��
;���ۂɂ̓��b�Z�[�W���C��0�̂ЂƂ��ɍ������C��
;��\������B���C���̕\���A��\�����L�^���Ă���̂�
;�R���t�B�O��ʓ��ł̓V�X�e���{�^�����l��onMessageHiddenStateChanged
;���Ăяo���Ă����΂悢
@return cond="typeof(global.SetMessageOpacity_object) != 'undefined'"

@iscript
class SetMessageOpacity extends KAGPlugin
{
	var foreSeen = false; // �\��ʂ̃��C��������
	var backSeen = false; // ����ʂ̃��C��������
	var foreLay;  // �\��ʗp�̃��C��
	var backLay;  // ����ʗp�̃��C��

	// �R���X�g���N�^
	function SetMessageOpacity()
	{
		// �\��ʗp�̃��C�������܂�
		foreLay = new Layer(kag, kag.fore.base);  // �\��ʂ̔w�i���C����e���C���ɂ��܂�
		with(foreLay)
		{
			.setSize(kag.fore.messages[0].width, kag.fore.messages[0].height);
			.setPos(kag.fore.messages[0].left, kag.fore.messages[0].top);
			.fillRect(0, 0, .width, .height, 0xFF000000);
			.absolute=1000000 - 1;
			.onMouseDown = kag.fore.base.onMouseDown;
			.visible = foreSeen;
		}

		// ����ʗp�̃��C�������܂�
		backLay = new Layer(kag, kag.back.base);  // ����ʂ̔w�i���C����e���C���ɂ��܂�
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

	// �f�X�g���N�^
	function finalize()
	{
		invalidate foreLay;  // �\��ʗp�̃��C���𖳌������܂�
		invalidate backLay;  // ����ʗp�̃��C���𖳌������܂�
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
			// f.exSystemButtons �Ɏ����z����쐬
		dic.foreSeen = foreSeen;
		dic.backSeen = backSeen;
		dic.top = foreLay.top;
		dic.left = foreLay.left;
		dic.width = foreLay.width;
		dic.height = foreLay.height;
		// �e���������z��ɋL�^
		// �x��ۑ�����ۂɌĂ΂��
		// f = �ۑ���̞x�f�[�^ ( Dictionary �N���X�̃I�u�W�F�N�g )
		// elm = tempsave ���̃I�v�V���� ( ���݂͏�� void )
	}

	function onRestore(f, clear, elm)
	{
		// �x��ǂݏo���Ƃ�
		var dic = f.SetMessageOpacity;
		if(dic === void)
		{
			// SetMessageOpacity�̏�񂪞x�ɕۑ�����Ă��Ȃ�
			setOptions('page'=>'fore', 'visible'=>false);
			setOptions('page'=>'back', 'visible'=>false);
		}
		else
		{
			// SetMessageOpacity�̏�񂪞x�ɕۑ�����Ă���
			setOptions(%['page'=>'fore', 'visible'=>dic.foreSeen]);
			setOptions(%['page'=>'back', 'visible'=>dic.backSeen]);
			foreLay.setSize(dic.width, dic.height);
			foreLay.setPos(dic.left, dic.top);
			backLay.setSize(dic.width, dic.height);
			backLay.setPos(dic.left, dic.top);
				// �I�v�V������ݒ�
		}
		// �x��ǂݏo���Ƃ��ɌĂ΂��
		// f = �ǂݍ��ޞx�f�[�^ ( Dictionary �N���X�̃I�u�W�F�N�g )
		// clear = ���b�Z�[�W���C�����N���A���邩 ( tempload �̎��̂� false )
		// elm = tempload ���̃I�v�V���� ( tempload �łȂ��ꍇ�� ��� void,
		//                                 tempload �̎��� Dictionary �N���X�̃I�u�W�F�N�g )
	}

	function onStableStateChanged(stable)
	{
		// ���� ( s l p �^�O�Œ�~�� ) �܂��� ���s�� ( ����ȊO )
		// �̏�Ԃ��ω������Ƃ��ɌĂ΂��
		// stable = ����̏�Ԃ� true, ����ȊO�̏ꍇ�� false
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
		// �E�N���b�N�ȂǂŃ��b�Z�[�W���C�����B���ꂽ��A�܂���
		// ���̏�Ԃ��甲���鎞�ɌĂ΂��
		// hidden = ���b�Z�[�W���B���ꂽ�ꍇ�� true, ���ꂽ�ꍇ�� false
	}

	function onCopyLayer(toback)
	{
		// backlay �^�O / forelay �^�O�����ׂẴ��C���ɑ΂��Ď��s����鎞�A
		// ���邢�� layer=base chidlren=true exchange=false �̃g�����W�V�����̏I�����ɁA
		// ����ʂ̓��e��\��ʂɃR�s�[����
		// �K�v����������ƌĂяo�����
		// toback = �\��ʂ̓��e�𗠉�ʂɃR�s�[���鎞�� true,
		//          ����ʂ̓��e��\��ʂɃR�s�[����Ƃ��� false
		// layer=base children=true �̃g�����W�V�����I�����ɂ� toback = false �ŌĂ΂��B
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
		// layer=base children=true �̃g�����W�V�����̏I�����ɌĂ΂�A
		// �\���C���Ɨ����C���̏�����������ړI�ŌĂ΂��
		// ���̎��_�ł��łɃ��C���̃c���[�\���͓���ւ���Ă���̂ŁA
		// �ʏ�A�����ł́A�c���[�\���̓���ւ����s���Ə�񂪖����������
		// ( ���C���̖��O�Ƃ��A���C���ւ̎Q�ƂƂ� ) �𗠉�ʂƖʉ�ʂ̊Ԃœ���ւ���
		// �g�����W�V�����I������ onCopyLayer �͂��̃C�x���g���O�ɌĂ΂��̂�
		// ����
		backLay <-> foreLay;
		backSeen <-> foreSeen;
	}

	function onSaveSystemVariables()
	{
		// �V�X�e���ϐ��ɏ�񂪕ۑ����ꎞ�ɌĂ΂��
		// ���̃^�C�~���O�� kag.scflags �ɏ����������߂�
		// �m���ɃV�X�e���ϐ��ɏ����������Ƃ��ł���
	}
}

kag.addPlugin(global.SetMessageOpacity_object = new SetMessageOpacity());
@endscript

; [SetMessageOpacity page=(fore)|back visible=(true)|false opacity= ]
@macro name=SetMessageOpacity
@eval exp="SetMessageOpacity_object.setOptions(mp)"
@endmacro

@return
