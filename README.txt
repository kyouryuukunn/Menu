�g���g���Ƀ��j���[�Ƃ���ɂƂ��Ȃ�
�Z�[�u�A���[�h�A�R���t�B�O��ʂ�ݒ肷��

�������g�������l�������Ȃ�D���Ɏg���Ă���
���ρA�Ĕz�z�͎��R
�g�p�𖾋L����K�v���񍐂���K�v���Ȃ�
���Ǖ񍐂������Ƃ��ꂵ��
���R�Ȃɂ������Ă��ӔC�͎��Ȃ�����
�g�p�ɂ�Biscrat��SKN_Slider.ks
�T�[�N��������MoveMouseCursorPlugin.tjs���K�v
exsystembutton.ks��config.ks��tjs�ɒ���I�Ŕz�z����
�����̂����������B


���j���[�̓}�E�X�I���A�E�N���b�N�A�ʏ�̃V�X�e���{�^��
����I�ׁA�Q�[�����ɕύX���o����B��z���[�h�ł͂�������
�{�^���𖳌����ł��邪�A���̂��߃{�^���͖������̂Ƃ����܂߂�
�ЂƂ̉摜��4�̊G���K�v



�Z�[�u�A���[�h�̐ݒ��Save_mode.txt���Q��
first.ks��
@call storage=Menu.ks
�ƌĂяo��

�ݒ�
AfterInit.tjs�Ɏ��̐ݒ������(�Ȃ���΍��)
kag.tagHandlers.s = function(elm)
{
	// ���s��~
	stablePosibility = true;
	if (!sf.skipcontinue)
		cancelSkip(); //�X�L�b�v���L�����Z������̂���߂܂��B
	if (!sf.autocontinue)
		cancelAutoMode();
	if(!usingExtraConductor) incRecordLabel(true);
	inSleep = true;
	if(recordHistoryOfStore == 2) // 2 : �I���� ( @s �^�O ) ����
	setToRecordHistory();
	notifyStable();
	return -1;
} incontextof kag;
kag.onCloseQuery = function ()
{
	saveSystemVariables();
	//if(!askOnClose) { global.Window.onCloseQuery(true); return; }
	if(!askOnClose && !sf.exitAsk) { global.Window.onCloseQuery(true); return; }
	global.Window.onCloseQuery(askYesNo("�I�����܂����H"));
} incontextof kag;
kag.onHelpAboutMenuItemClick = function (sender)
{
	// �u���̃\�t�g�ɂ��āv�E�B���h�E��\��
	tf.exitAsktemp=sf.exitAsk;
	sf.exitAsk=0;
	var win = new global.KAGWindow(false, aboutWidth, aboutHeight);
	win.setPos(left + ((width - win.width)>>1), top + ((height - win.height)>>1));
	win.process('about.ks' ,,, true); // about.ks �� immediate �ŕ\��
	win.showModal(); // ���[�h�t���ŕ\��
	invalidate win;
	sf.exitAsk=tf.exitAsktemp;
} incontextof kag;
kag.goToStartWithAsk = function ()
{
	// �ŏ��ɖ߂�(�m�F����)
	//var result = askYesNo("�ŏ��ɖ߂�܂��B��낵���ł��� ?");
	//if(result) goToStart();
	if (sf.titleAsk)
	{
		if (askYesNo("�^�C�g���ɖ߂�܂���?")) goToStart();
	}
	else
	{
		goToStart();
	}
} incontextof kag;
kag.restoreFromRightClick = function ()
{
	// �E�N���b�N�T�u���[�`�����甲����Ƃ��ɌĂ΂��
	if(typeof this.rightClickMenuItem != "undefined")
	{
		if(rightClickName == "default")
			rightClickMenuItem.caption = rightClickCurrentMenuName = rightClickDefaultName;
		else
			rightClickMenuItem.caption = rightClickCurrentMenuName = rightClickName;
	}
	// �������牺��ǉ�
	// �E�N���b�N����autoMode�ݒ肳�ꂽ�ꍇ�ɑΉ��B 
	if(autoMode) 
	{
		enterAutoMode(); 
		// inStable = 0��enterAutoMode()����PrimaryClick()���� 
		// �Ȃ��̂ŁA������click���Ă��� 
		conductor.trigger('click'); 
	}
	// �E�N���b�N����skipMode�ݒ肳�ꂽ�ꍇ�ɑΉ�
	if(skipMode_rclick)
	skipToNextStopByKey();
} incontextof kag;

����Menu.ks��6�s�ڂ���̂��̕ϐ���ݒ肷��
sf.saveAsk = 1; //�Z�[�u�㏑�����Ɋm�F����
sf.loadAsk = 1; //���[�h���Ɋm�F����
sf.qloadAsk = 1; //�N�C�b�N���[�h���Ɋm�F����
sf.returnAsk = 1; //�O�ɖ߂�Ŋm�F����
sf.titleAsk = 1; //�^�C�g���ɖ߂�Ŋm�F����
sf.exitAsk = 1; //�I�����Ɋm�F����
sf.autocontinue = 1; //�I��������I�[�g���[�h�𑱂���
sf.skipcontinue = 1; //�I��������X�L�b�v���[�h�𑱂���
sf.sceneskip = 1; //�V�[�����̃X�L�b�v������(scene.ks���Ȃ��Ȃ疳�Ӗ�)
sf.menu_mode = 0; //�g�p���j���[��I�� 
	0:�}�E�X�I�����j���[ 1:�E�N���b�N���j���[ 2:�ʏ�̃V�X�e���{�^��
sf.messageopacity = 128; //���b�Z�[�W�g�̓����x

24�s�ڂ�����ݒ肷��
tf.chose_novel = 1;	//�I�������肩(�O�̑I�����ɖ߂��\��)
tf.message_base = 'message'; //���b�Z�[�W���C���Ɠ����傫����
			     //�����摜
			     
���b�Z�[�W���C���̔Z�x��ς���̂ɑO�i���C���[0��
�����摜������Ă���̂ŁA�O�i���C���[0�͎g���Ă͂����Ȃ�
�܂��AMoveMenu.ks��143�s�ڂ�position��ς���΃��j���[��
�ʒu����[�ƉE�[����I�ׂ�
	var position = 'top';	    //���j���[�̈ʒu (right or top)	
exsystembutton.ks��240�s�ڂ���̕ϐ���ݒ肷��΁A�ʏ�{�^��
�̈ʒu��ς�����
x = kag.fore.messages[0].left; // ���� x �ʒu
y = kag.fore.messages[0].top + kag.fore.messages[0].height - 30; // ���� y �ʒu
x_width = 70;  //�{�^���Ԃ̕�
y_height = 0;  //�{�^���Ԃ̍���

�܂��Aconfig.ks,load_mode.ks�̓^�C�g����ʂł����܂���
�T�u���[�`���Ƃ��ČĂяo���Ă��g�p�\


�g����^�O

set_menu
sf.menu_mode�ɂ��킹�ĉE�N���b�N�A���j���[�\����
�ݒ肷��A�������Adisablestore���ݒ肵�Ă������ꍇ
�^�C�g����ʂɂ���Ɣ��f���āAset_unmenu���g��
�Ȃ��A���[�h�����Ă����l�̏����������Ȃ���

set_unmenu
�E�N���b�N�𖳌����A���j���[�\�����\���ɂ���
�^�C�g����ʂȂǁA�{�҂���߂�ꏊ�ɒu������

laycount2
laycount���g���Ă͂Ȃ�Ȃ�laycount2���g��

set_messageopacity
���b�Z�[�W���C���̓����x��ݒ肵�A�\������(�Z�[�u�\���x���̌�ɂ���)


in_scene_mode_button        
��z���[�h�p�Ƀ{�^�����Z�[�u�A���[�h�A�O�̑I�����ɖ߂�𖳌�������

out_scene_mode_button        
��z���[�h�p�ɖ����������{�^����L��������
�^�C�g����ʂȂǁA��z���[�h����߂�ꏊ�ɂ�����
