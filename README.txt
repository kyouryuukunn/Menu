�g���g���Ƀ��j���[�Ƃ���ɂƂ��Ȃ�
�Z�[�u�A���[�h�A�R���t�B�O��ʂ�ݒ肷��

�������g�������l�������Ȃ�D���Ɏg���Ă���
���ρA�Ĕz�z�͎��R
�g�p�𖾋L����K�v���񍐂���K�v���Ȃ�
���Ǖ񍐂������Ƃ��ꂵ��
���R�Ȃɂ������Ă��ӔC�͎��Ȃ�����
exsystembutton.ks��config.ks��tjs�ɒ���I�Ŕz�z����
�����̂����������B
�܂��X���C�_�[�ɂ͐F�X�ȕ���KLayers.ks�𗘗p����

�S������T���v����skydrive�Ō��J���Ă���
https://skydrive.live.com/#cid=8F8EF4D2142F33D4&id=8F8EF4D2142F33D4!257


���j���[�̓}�E�X�I���A�E�N���b�N�A�ʏ�̃V�X�e���{�^��
����I�ׁA�Q�[�����ɕύX���o����B��z���[�h�ł͂�������
�{�^���𖳌����ł��邪�A���̂��߃{�^���͖������̂Ƃ����܂߂�
�ЂƂ̉摜��4�̊G���K�v
exsystembutton.ks�Œʏ�̃V�X�e���{�^���AMoveMenu.ks�Ń}�E�X�I��
�{�^���A�E�N���b�N�{�^��������Ă���B
���݂ǂ���������{�^���摜�����悤���Ă��邪�A�K�X�������Ă���B
�{�^���𑝂₷�Ƃ���onStableStateChanged�ɒ���


�g���Ă���ϐ�
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
global.chose_novel = 1;	//�I�������肩(�O�̑I�����ɖ߂��\�����邩�ǂ���)
global.message_base = 'message'; //���b�Z�[�W���C���Ɠ����傫���̍����摜
global.in_scene_mode_button = 0; //��z���[�h�ł������̃{�^���𖳌�������
global.config
global.MoveMenu_object
global.exsystembutton_object


�Z�[�u�A���[�h�̐ݒ��Save_mode.txt���Q��

�ݒ�
AfterInit.tjs�Ɏ��̐ݒ������(�Ȃ���΍��)
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
	//�ǉ�������
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
	//�ǉ�������
} incontextof kag;

����Menu.ks��2,3�s�ڂ̂��̐ݒ�̃f�t�H���g�l��ݒ肷��
var chose_novel = 1;	//�I�������肩, �O�̑I�����ɖ߂��\��
var in_scene_mode_button_mark = 0; //��z���[�h

config_init.ks�̂��̐ݒ�̃f�t�H���g�l��ݒ肷��
	sf.saveAsk = 1; //�Z�[�u�㏑�����Ɋm�F����
	sf.loadAsk = 1; //���[�h���Ɋm�F����
	sf.qsaveAsk = 0; //�N�C�b�N�Z�[�u���Ɋm�F����
	sf.qloadAsk = 1; //�N�C�b�N���[�h���Ɋm�F����
	sf.returnAsk = 1; //�O�ɖ߂�Ŋm�F����
	sf.titleAsk = 1; //�^�C�g���ɖ߂�Ŋm�F����
	sf.exitAsk = 1; //�I�����Ɋm�F����
	sf.autocontinue = 1; //�I��������I�[�g���[�h�𑱂���
	sf.skipcontinue = 1; //�I��������X�L�b�v���[�h�𑱂���
	sf.sceneskip = 1; //�V�[�����̃X�L�b�v������
	sf.menu_mode = 0; //0:�}�E�X�I�����j���[���g�p����
			  //1:�E�N���b�N���j���[���g�p����
			  //2:�V�X�e���{�^�����g�p����
	sf.messageopacity = 128; //���b�Z�[�W�g�̓����x

�܂��A���̕ϐ��ŃR���t�B�O��ʂ̃��C�A�E�g��ύX����
config.back = 'config_bg'; // �w�i(���������ɂ͒��O�̃Q�[����ʂ�\��)
config.slider_base = 'slider_base'; // �X���C�_�[�̔w�i
config.slider_tab = 'slider_tab';   // �X���C�_�[�̂܂�(�{�^���Ɠ����\��)
config.windowmode=	[340, 525]; // #0: �t���X�N���[���ɕ\������`�F�b�N�摜�̍��W
config.titleAsk=	[680, 435]; // #1: title�ɕ\������`�F�b�N�摜�̍��W
config.exitAsk=		[680, 475]; // #2: exit�ɕ\������`�F�b�N�摜�̍��W
config.qloadAsk=	[420, 435]; // #3: qload�ɕ\������`�F�b�N�摜�̍��W
config.returnAsk=	[420, 475]; // #4: return�ɕ\������`�F�b�N�摜�̍��W
config.saveAsk=		[140, 435]; // #5: save�ɕ\������`�F�b�N�摜�̍��W
config.loadAsk=		[140, 475]; // #6: load�ɕ\������`�F�b�N�摜�̍��W
config.pagebreak=	[740, 165]; // #7:�u�y�[�W���܂ň�x�ɕ\���v�ɕ\������`�F�b�N�摜�̍��W
config.sceneskip=	[740, 205]; // #8: sceneskip�ɕ\������`�F�b�N�摜�̍��W
config.autocontinue=	[390, 165]; // #9: autocontinue�ɕ\������`�F�b�N�摜�̍��W
config.skipcontinue=	[390, 200]; // #10: skipcontinue�ɕ\������`�F�b�N�摜�̍��W
config.menu0= 		[570, 305]; // #11: menu0�ɕ\������`�F�b�N�摜�̍��W
config.menu1= 		[570, 355]; // #14: menu1�ɕ\������`�F�b�N�摜�̍��W
config.menu2= 		[750, 305]; // #15: menu2�ɕ\������`�F�b�N�摜�̍��W
config.slider0 = [190, 305]; // ���X���C�_�[0�̍��W - (BGM���ʒ���)
config.slider1 = [190, 345]; // ���X���C�_�[1�̍��W - (SE���ʒ���)
config.slider2 = [450, 70];  // ���X���C�_�[2�̍��W - (�������x)
config.slider3 = [450, 100]; // ���X���C�_�[3�̍��W - (�I�[�g���[�h���x)
config.slider4 = [450, 130]; // ���X���C�_�[4�̍��W - (�����x)
config.basegraphic = '';	//�g�O���{�^���̉����C���摜���w��(�ڂ�����KLayers.txt��KToggleButtonLayer���Q��)
config.graphic = '';		//�g�O���{�^���̏ヌ�C���摜���w��(�ڂ�����KLayers.txt��KToggleButtonLayer���Q��)
�g��Ȃ��ݒ�́A�f�t�H���g�l�����߂���A�Y����������ʊO�ɂł�����Ă���

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
