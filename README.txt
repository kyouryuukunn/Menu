�ԋ���	http://akakyouryuu.blog.fc2.com/

�g���g���Ƀ��j���[�Ƃ���ɂƂ��Ȃ�
�Z�[�u�A���[�h�A�R���t�B�O��ʂ�ݒ肷��
�܂�V�X�e���ꎮ���낦����̂Ŋy���ł��邩�ƁB

�������g�������l�������Ȃ�D���Ɏg���Ă���
���ρA�Ĕz�z�͎��R
�g�p�𖾋L����K�v���񍐂���K�v���Ȃ�
���Ǖ񍐂������Ƃ��ꂵ��
���R�Ȃɂ������Ă��ӔC�͎��Ȃ�����
exsystembutton.ks��config.ks��tjs�ɒ���I�Ŕz�z����
�����̂����������B
�܂��X���C�_�[�ɂ͐F�X�ȕ���KLayers.ks�𗘗p����
�}�E�X�J�[�\�������ړ���
�T�[�N��������MoveMouseCursorPlugin�������
���������

������SetMessageOpacity�ASaveMode�AConfigMode��
�g�p���Ă���B


���j���[�̓}�E�X�I���A�E�N���b�N�A�ʏ�̃V�X�e���{�^��
����I�ׁA�Q�[�����ɕύX���o����(��̂̐l�͎g���������I��ł��I�����Ǝv������)
��z���[�h�ł͂������̃{�^���𖳌����ł��邪�A���̂��߃{�^���͖������̂Ƃ���������
�ЂƂ̉摜��4�̊G���K�v
exsystembutton.ks�Œʏ�̃V�X�e���{�^���AMoveMenu.ks�Ń}�E�X�I��
�{�^���A�E�N���b�N�{�^��������Ă���B
���݂ǂ���������{�^���摜���g�p���Ă��邪�A�K�X�������Ă���B
�{�^���𑝂₷�Ƃ���onStableStateChanged�ɒ���

�Z�[�u�A���[�h�̐ݒ��Save_mode.txt���Q��
�R���t�B�O��ʂ̐ݒ��ConfigMode.txt���Q��
�܂�SetMessageOpacity.ks���Q�Ƃ̂���

�ݒ�
AfterInit.tjs�Ɏ��̕�������(�Ȃ���΍��)
---------------------------------------------------------------------------- 
kag.tagHandlers.s = function(elm)
{
	// ���s��~
	stablePosibility = true;
	//�ǉ�������
	if (!sf.skipcontinue)
		cancelSkip(); //�X�L�b�v���L�����Z������̂���߂܂��B
	if (!sf.autocontinue)
		cancelAutoMode();
	//�ǉ�������
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
	//�ǉ�������
	//if(!askOnClose) { global.Window.onCloseQuery(true); return; }
	if(!askOnClose && !sf.exitAsk) { global.Window.onCloseQuery(true); return; }
	//�ǉ�������
	global.Window.onCloseQuery(askYesNo("�I�����܂����H"));
} incontextof kag;
kag.onHelpAboutMenuItemClick = function (sender)
{
	// �u���̃\�t�g�ɂ��āv�E�B���h�E��\��
	//�ǉ�������
	tf.exitAsktemp=sf.exitAsk;
	sf.exitAsk=0;
	//�ǉ�������
	var win = new global.KAGWindow(false, aboutWidth, aboutHeight);
	win.setPos(left + ((width - win.width)>>1), top + ((height - win.height)>>1));
	win.process('about.ks' ,,, true); // about.ks �� immediate �ŕ\��
	win.showModal(); // ���[�h�t���ŕ\��
	invalidate win;
	//�ǉ�������
	sf.exitAsk=tf.exitAsktemp;
	//�ǉ�������
} incontextof kag;
kag.goToStartWithAsk = function ()
{
	//�ǉ�������
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
	//�ǉ�������
} incontextof kag;
var restoreFromRightClick_org = kag.restoreFromRightClick;
kag.restoreFromRightClick = function ()
{
	restoreFromRightClick_org();
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
// OUTFOCUS���
// �m�V�X�e���]���ǂ��X�L�b�v�n���j���[�n���h���̒�`
kag.onAllSkipClick = function(sender)
{
	sf.allskip = !sf.allskip;
	allSkipMenuItem.checked = sf.allskip;
	if (sf.allskip)
		skipToNextStopMenuItem.caption = "���̑I�����܂Ői��(&F)";
	else
		skipToNextStopMenuItem.caption = autoRecordPageShowing ? "���̑I����/���ǂ܂Ői��(&F)" : "���̑I�����܂Ői��(&F)";
} incontextof kag;
// �m���ǂ��X�L�b�v�n���j���[�A�C�e�����쐬
kag.allSkipMenuItem = new KAGMenuItem(kag, "���ǂ��X�L�b�v(&L)", 0, kag.onAllSkipClick, false);
kag.allSkipMenuItem.checked = sf.allskip;
// �m�V�X�e���n���j���[�Ɂm���ǂ��X�L�b�v�n���j���[�A�C�e����o�^
kag.systemMenu.insert(kag.allSkipMenuItem, 3);
// kag.getCurrentRead()���\�b�h������������
kag.getCurrentRead_org = kag.getCurrentRead;
kag.getCurrentRead = function()
{
	if (sf.allskip)                 // ���ǂ��X�L�b�v����Ȃ�S�Ċ���
		return true;
	else
		return getCurrentRead_org();  // �����łȂ���΋�kag.getCurrentRead()���\�b�h�̖߂�l���g��
} incontextof kag;
---------------------------------------------------------------------------- 
����Menu.ks��2,3�s�ڂ̂��̐ݒ�̃f�t�H���g�l��ݒ肷��
var chose_novel = 1;	//�I�������肩, (�O�̑I�����ɖ߂��\�����邩�ǂ���)

�܂��AMoveMenu.ks��146�s�ڂ�position��ς���΃��j���[��
�ʒu����[�ƉE�[����I�ׂ�
	var position = 'top';	    //���j���[�̈ʒu (right or top)	
exsystembutton.ks��240�s�ڂ���̕ϐ���ݒ肷��΁A�ʏ�{�^��
�̈ʒu��ς�����
x = kag.fore.messages[0].left; // ���� x �ʒu
y = kag.fore.messages[0].top + kag.fore.messages[0].height - 30; // ���� y �ʒu
x_width = 70;  //�{�^���Ԃ̕�
y_height = 0;  //�{�^���Ԃ̍���


���first.ks�Ŏ��̂悤�ɌĂяo��
@call storage=Menu.ks

config.ks,load_mode.ks�̓^�C�g����ʂł����܂���
�T�u���[�`���Ƃ��ČĂяo���Ă��g�p�\�A�Z�[�u�\���ǂ���
�Ń^�C�g����ʂ��𔻒f���Ă���̂ł�����disablestore��
�g������


�g����^�O------------------------------------------------------------------ 

set_menu
sf.menu_mode�ɂ��킹�ĉE�N���b�N�A���j���[�\����
�ݒ肷��A�������Adisablestore���ݒ肵�Ă������ꍇ
�^�C�g����ʂɂ���Ɣ��f���āAset_unmenu���g��
�Ȃ��A���[�h�����Ă����l�̏����������Ȃ���

unset_menu
�E�N���b�N�𖳌����A���j���[�\�����\���ɂ���
�^�C�g����ʂȂǁA�{�҂���߂�ꏊ�ɒu������

in_scene_mode_button        
��z���[�h�p�Ƀ{�^�����Z�[�u�A���[�h�A�O�̑I�����ɖ߂�𖳌�������

out_scene_mode_button        
��z���[�h�p�ɖ����������{�^����L��������
�^�C�g����ʂȂǁA��z���[�h����߂�ꏊ�ɂ�����
