@iscript
//�����ݒ� ����̂ݎ��s
if (sf.config_init === void)
{
	//�ݒ�̏�����
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
	
	sf.bgmvolume = kag.bgm.buf1.volume2;
	sf.sevolume = kag.se[0].volume2;
	sf.config_init = 1;
}


//���O�̏I�������ɒu���ւ���
kag.askOnClose=false;

kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;
var config = %[];

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
config.basegraphic = 'basegraphic';	//�g�O���{�^���̉����C���摜���w��(�ڂ�����KLayers.txt��KToggleButtonLayer���Q��)
config.graphic = 'graphic';		//�g�O���{�^���̏ヌ�C���摜���w��(�ڂ�����KLayers.txt��KToggleButtonLayer���Q��)



//�X���C�_�[�ݒ�̊֐��ݒ�
config.bgmslider = function (hval,vval,drag){
	kag.tagHandlers.bgmopt(%['gvolume' => hval*100]);
	sf.bgmvolume = kag.bgm.buf1.volume2;
} incontextof global;
config.seslider = function (hval,vval,drag){
	for(var i=0;i<kag.numSEBuffers;i++)
		kag.se[i].setOptions(%['gvolume' => hval*100 ]);
	sf.sevolume = kag.se[0].volume2;
} incontextof global;
config.chspeedslider = function (hval,vval,drag){ 
	kag.userChSpeed=( 100 - hval*100 );
} incontextof global;
config.autospeedslider = function (hval,vval,drag){
	// �I�[�g���x
	kag.autoModePageWait = 2000 -  hval * 2000;
	kag.autoModeLineWait = 1000 -  hval * 1000;
} incontextof global;
config.messageopacityslider = function (hval,vval,drag){
	sf.messageopacity = (hval * 255);
	SetMessageOpacity_object.foreLay.opacity = sf.messageopacity;
	SetMessageOpacity_object.backLay.opacity = sf.messageopacity;
} incontextof global;
@endscript

@return
