;�e�g�O���{�^���A�X���C�_�[�̒l�ɂ�
;config_plugin_obj.togglebutton_00~44�Aconfig_plugin_obj.slider_00~14
;����A�N�Z�X�o����

;�J�n���̏���
;�����Ńg�O���{�^���A�X���C�_�[�̏�����Ԃ����߂�
*config_sub_start
; �߂邽�߂Ɍ��݂̃��j���[�̐ݒ��ۑ�
@eval exp="tf.pre_menu_mode = sf.menu_mode"
@iscript

//���j���[�𖳌������Ă���
kag.displayMenu.enabled=0;
kag.characterMenu.enabled=0;
kag.storeMenu.enabled=0;
kag.restoreMenu.enabled=0;
//�g�O���{�^���̏����l�����߂�
//1�y�[�W��
config_plugin_obj.togglebutton_00 = kag.chNonStopToPageBreak; //�y�[�W���܂ň�x�ɕ\��
config_plugin_obj.togglebutton_01 = kag.ch2ndNonStopToPageBreak; //���ǃy�[�W���܂ň�x�ɕ\��
config_plugin_obj.togglebutton_02 = kag.chDefaultAntialiased; //�A���`�G�C���A�X
config_plugin_obj.togglebutton_03 = sf.chShadow;	//�e
config_plugin_obj.togglebutton_04 = sf.chEdge;	// �����
config_plugin_obj.togglebutton_05 = sf.chBold;	// ����


config_plugin_obj.slider_00 = kag.bgm.buf1.volume2 / 100000;	//BGM
config_plugin_obj.slider_01 = kag.se[0].volume2 / 100000;	//SE
config_plugin_obj.slider_02 = (100 - kag.chSpeed)/100;		//�������x
config_plugin_obj.slider_03 = (2000 - kag.autoModePageWait)/2000;//�I�[�g���x
config_plugin_obj.slider_04 = sf.messageopacity / 255;		//���b�Z�[�W�g�Z�x

//2�y�[�W��
config_plugin_obj.togglebutton_15 = kag.fullScreened;		// �E�B�h�E���[�h
config_plugin_obj.togglebutton_16 = sf.titleAsk;		// �^�C�g���ɖ߂���m�F���邩
config_plugin_obj.togglebutton_17 = sf.exitAsk;			// �Q�[���I�����m�F���邩
config_plugin_obj.togglebutton_18 = sf.qsaveAsk;		// �N�C�b�N�Z�[�u���Ɋm�F���邩
config_plugin_obj.togglebutton_19 = sf.qloadAsk;		// �N�C�b�N���[�h���Ɋm�F���邩
config_plugin_obj.togglebutton_20 = sf.returnAsk;		// �O�̑I�����ɖ߂�Ŋm�F���邩
config_plugin_obj.togglebutton_21 = sf.saveAsk;			// �Z�[�u�㏑�����Ɋm�F���邩
config_plugin_obj.togglebutton_22 = sf.loadAsk;			// ���[�h���Ɋm�F���邩
config_plugin_obj.togglebutton_23 = sf.autocontinue;		// �I��������I�[�g���[�h���p�����邩
config_plugin_obj.togglebutton_24 = sf.skipcontinue;		// �I��������X�L�b�v���[�h���p�����邩
config_plugin_obj.togglebutton_25 = sf.menu_mode == 0;		// �}�E�X�I�����j���[���g�p����
config_plugin_obj.togglebutton_26 = sf.menu_mode == 1;		// �E�N���b�N���j���[���g�p����
config_plugin_obj.togglebutton_27 = sf.menu_mode == 2;		// �V�X�e�����j���[���g�p����

@endscript

;�w�i��(���݂̑O�i���C���� - 1), ���b�Z�[�W���C����(���݂̃��b�Z�[�W�� - 1)���g����̂�
;�ǉ��̃��C�����g�������Ƃ���(���݂̑O�i, ���b�Z�[�W���C���� - 2)���g��
;�܂��Alaycount���g���ƃC���f�b�N�X���ς���Ă��܂��̂ōĐݒ肷��
;�w�i�A���b�Z�[�W���C�����ꂼ��C���f�b�N�X��2000100, 2000200�ł�
@laycount layers="&kag.numCharacterLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
@layopt index="&2000000+101" layer="&kag.numCharacterLayers - 2" left=250 top=260
@layopt index="&2000000+200" layer="&'message'+ ( kag.numMessageLayers - 1 )"

@image layer="&kag.numCharacterLayers - 2" storage=samplemessage opacity=&sf.messageopacity


@return


;�I�����̏���
;�E�N���b�N�̐ݒ�������ł���
*config_sub_close
; �E�N���b�N�̐ݒ�
@set_menu
@iscript
//���j���[��L����
kag.displayMenu.enabled=1;
kag.characterMenu.enabled=1;
kag.storeMenu.enabled=1;
kag.restoreMenu.enabled=1;
@endscript
; ���b�Z�[�W�\�����x�̐ݒ�𔽉f���܂�
@delay speed=user cond="kag.chUserMode"
@return

;�e�y�[�W���J�����Ƃ��̃T�u���[�`��
*config_sub_page1
;�T���v���\��
@er
@locate x=260 y=260
@nowait
����͂ɂقւƂ���ʂ��
@endnowait
@layopt layer="&kag.numCharacterLayers - 2" visible=true
@return

*config_sub_page2
@er
@layopt layer="&kag.numCharacterLayers - 2" visible=false
@return

*config_sub_page3
@return


;�e�T�u���[�`���ύX�𑦍��ɔ��f�������Ƃ��͂����ɋL�q����
;�{�^���p�T�u���[�`��
*config_sub_button_00
@eval exp="tf.previous_font_face = kag.chDefaultFace"
@eval exp="kag.onChChangeFontMenuItem()"
@if exp="kag.chDefaultFace == ''"
@eval exp="kag.chDefaultFace = tf.previous_font_face"
@eval exp="kag.setMessageLayerUserFont()"
@endif
@er
@locate x=260 y=260
����͂ɂقւƂ���ʂ��

@jump storage=config.ks target=*return

*config_sub_button_01
@jump storage=config.ks target=*return

*config_sub_button_02
@jump storage=config.ks target=*return

*config_sub_button_03
@jump storage=config.ks target=*return

*config_sub_button_04
;�f�t�H���g�{�^��
@eval exp="kag.onChNonStopToPageBreakItemClick()"
@eval exp="kag.onCh2ndNonStopToPageBreakItemClick()"
@eval exp="kag.onChAntialiasMenuItemClick()"
@iscript

config_plugin_obj.togglebutton_00 = false;
config_plugin_obj.togglebutton_01 = false;
config_plugin_obj.togglebutton_02 = sf.init_antialiase;
config_plugin_obj.togglebutton_03 = sf.chShadow = sf.init_chShadow;
config_plugin_obj.togglebutton_04 = sf.chEdge = sf.init_chEdge;
config_plugin_obj.togglebutton_05 = sf.chBold = sf.init_chBold;

if (config_plugin_obj.nowpage == 1)
{
	tf.config_togglebutton[0].checked = config_plugin_obj.togglebutton_00;
	tf.config_togglebutton[1].checked = config_plugin_obj.togglebutton_01;
	tf.config_togglebutton[2].checked = config_plugin_obj.togglebutton_02;
	tf.config_togglebutton[3].checked = config_plugin_obj.togglebutton_03;
	tf.config_togglebutton[4].checked = config_plugin_obj.togglebutton_04;
	tf.config_togglebutton[5].checked = config_plugin_obj.togglebutton_05;
	tf.config_togglebutton[0].draw();
	tf.config_togglebutton[1].draw();
	tf.config_togglebutton[2].draw();
	tf.config_togglebutton[3].draw();
	tf.config_togglebutton[4].draw();
	tf.config_togglebutton[5].draw();
}

config_plugin_obj.togglebutton_16 = sf.titleAsk = sf.init_titleAsk;
config_plugin_obj.togglebutton_17 = sf.exitAsk = sf.init_exitAsk;
config_plugin_obj.togglebutton_18 = sf.qsaveAsk = sf.init_qsaveAsk;
config_plugin_obj.togglebutton_19 = sf.qloadAsk = sf.init_qloadAsk;
config_plugin_obj.togglebutton_20 = sf.returnAsk = sf.init_returnAsk;
config_plugin_obj.togglebutton_21 = sf.saveAsk = sf.init_saveAsk;
config_plugin_obj.togglebutton_22 = sf.loadAsk = sf.init_loadAsk;
config_plugin_obj.togglebutton_23 = sf.autocontinue = sf.init_autocontinue;
config_plugin_obj.togglebutton_24 = sf.skipcontinue = sf.init_skipcontinue;
sf.menu_mode = sf.init_menu_mode;
config_plugin_obj.togglebutton_25 = sf.menu_mode == 0;
config_plugin_obj.togglebutton_26 = sf.menu_mode == 1;
config_plugin_obj.togglebutton_27 = sf.menu_mode == 2;

if (config_plugin_obj.nowpage == 2)
{
	tf.config_togglebutton[1].checked  = config_plugin_obj.togglebutton_16;
	tf.config_togglebutton[2].checked  = config_plugin_obj.togglebutton_17;
	tf.config_togglebutton[3].checked  = config_plugin_obj.togglebutton_18;
	tf.config_togglebutton[4].checked  = config_plugin_obj.togglebutton_19;
	tf.config_togglebutton[5].checked  = config_plugin_obj.togglebutton_20;
	tf.config_togglebutton[6].checked  = config_plugin_obj.togglebutton_21;
	tf.config_togglebutton[7].checked  = config_plugin_obj.togglebutton_22;
	tf.config_togglebutton[8].checked  = config_plugin_obj.togglebutton_23;
	tf.config_togglebutton[9].checked  = config_plugin_obj.togglebutton_24;
	tf.config_togglebutton[10].checked = config_plugin_obj.togglebutton_25;
	tf.config_togglebutton[11].checked = config_plugin_obj.togglebutton_26;
	tf.config_togglebutton[12].checked = config_plugin_obj.togglebutton_27;
	tf.config_togglebutton[1].draw();
	tf.config_togglebutton[2].draw();
	tf.config_togglebutton[3].draw();
	tf.config_togglebutton[4].draw();
	tf.config_togglebutton[5].draw();
	tf.config_togglebutton[6].draw();
	tf.config_togglebutton[7].draw();
	tf.config_togglebutton[8].draw();
	tf.config_togglebutton[9].draw();
	tf.config_togglebutton[10].draw();
	tf.config_togglebutton[11].draw();
	tf.config_togglebutton[12].draw();
}

config_plugin_obj.slider_00 = sf.init_bgmvolume / 100000;
config_plugin_obj.slider_01 = sf.init_sevolume / 100000;
config_plugin_obj.slider_02 = (100 - sf.init_chspeed)/100;	
config_plugin_obj.slider_03 = (2000 - sf.init_autospeed)/2000;
config_plugin_obj.slider_04 = sf.init_messageopacity / 255;

if (config_plugin_obj.nowpage == 1)
{
	with(tf.config_slider[0]){  .hval = config_plugin_obj.slider_00; .tab.setPos((.width-.tab.width)*.hval, (.height-.tab.height)*(1-.vval)); }
	with(tf.config_slider[1]){  .hval = config_plugin_obj.slider_01; .tab.setPos((.width-.tab.width)*.hval, (.height-.tab.height)*(1-.vval)); }
	with(tf.config_slider[2]){  .hval = config_plugin_obj.slider_02; .tab.setPos((.width-.tab.width)*.hval, (.height-.tab.height)*(1-.vval)); }
	with(tf.config_slider[3]){  .hval = config_plugin_obj.slider_03; .tab.setPos((.width-.tab.width)*.hval, (.height-.tab.height)*(1-.vval)); }
	with(tf.config_slider[4]){  .hval = config_plugin_obj.slider_04; .tab.setPos((.width-.tab.width)*.hval, (.height-.tab.height)*(1-.vval)); }
}

kag.chDefaultFace = sf.init_font;
kag.setMessageLayerUserFont();
@endscript

@bgmopt gvolume="&config_plugin_obj.slider_00*100"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"

@seopt gvolume="&config_plugin_obj.slider_01*100"
@eval exp="&sf.sevolume = kag.se[0].volume2"

@eval exp="kag.userChSpeed=100 - config_plugin_obj.slider_02*100"

@eval exp="&kag.autoModePageWait = 2000 -  config_plugin_obj.slider_03 * 2000;"
@eval exp="&kag.autoModeLineWait = 1000 -  config_plugin_obj.slider_03 * 1000;"

@eval exp="&sf.messageopacity = (config_plugin_obj.slider_04 * 255)"
@eval exp="&SetMessageOpacity_object.foreLay.opacity = sf.messageopacity"
@eval exp="&SetMessageOpacity_object.backLay.opacity = sf.messageopacity"
@jump storage=config.ks target=*return

*config_sub_button_05
@jump storage=config.ks target=*return

*config_sub_button_06
@jump storage=config.ks target=*return

*config_sub_button_07
@jump storage=config.ks target=*return

*config_sub_button_08
@jump storage=config.ks target=*return

*config_sub_button_09
@iscript
config_plugin_obj.togglebutton_02 = sf.init_antialiase;
config_plugin_obj.togglebutton_03 = sf.chShadow = sf.init_chShadow;
config_plugin_obj.togglebutton_04 = sf.chEdge = sf.init_chEdge;
config_plugin_obj.togglebutton_05 = sf.chBold = sf.init_chBold;

if (config_plugin_obj.nowpage == 1)
{
	tf.config_togglebutton[2].checked = config_plugin_obj.togglebutton_02;
	tf.config_togglebutton[3].checked = config_plugin_obj.togglebutton_03;
	tf.config_togglebutton[4].checked = config_plugin_obj.togglebutton_04;
	tf.config_togglebutton[5].checked = config_plugin_obj.togglebutton_05;
	tf.config_togglebutton[2].draw();
	tf.config_togglebutton[3].draw();
	tf.config_togglebutton[4].draw();
	tf.config_togglebutton[5].draw();
}

config_plugin_obj.togglebutton_16 = sf.titleAsk = sf.init_titleAsk;
config_plugin_obj.togglebutton_17 = sf.exitAsk = sf.init_exitAsk;
config_plugin_obj.togglebutton_18 = sf.qsaveAsk = sf.init_qsaveAsk;
config_plugin_obj.togglebutton_19 = sf.qloadAsk = sf.init_qloadAsk;
config_plugin_obj.togglebutton_20 = sf.returnAsk = sf.init_returnAsk;
config_plugin_obj.togglebutton_21 = sf.saveAsk = sf.init_saveAsk;
config_plugin_obj.togglebutton_22 = sf.loadAsk = sf.init_loadAsk;
config_plugin_obj.togglebutton_23 = sf.autocontinue = sf.init_autocontinue;
config_plugin_obj.togglebutton_24 = sf.skipcontinue = sf.init_skipcontinue;
sf.menu_mode = sf.init_menu_mode;
config_plugin_obj.togglebutton_25 = sf.menu_mode == 0;
config_plugin_obj.togglebutton_26 = sf.menu_mode == 1;
config_plugin_obj.togglebutton_27 = sf.menu_mode == 2;

if (config_plugin_obj.nowpage == 2)
{
	tf.config_togglebutton[1].checked  = config_plugin_obj.togglebutton_16;
	tf.config_togglebutton[2].checked  = config_plugin_obj.togglebutton_17;
	tf.config_togglebutton[3].checked  = config_plugin_obj.togglebutton_18;
	tf.config_togglebutton[4].checked  = config_plugin_obj.togglebutton_19;
	tf.config_togglebutton[5].checked  = config_plugin_obj.togglebutton_20;
	tf.config_togglebutton[6].checked  = config_plugin_obj.togglebutton_21;
	tf.config_togglebutton[7].checked  = config_plugin_obj.togglebutton_22;
	tf.config_togglebutton[8].checked  = config_plugin_obj.togglebutton_23;
	tf.config_togglebutton[9].checked  = config_plugin_obj.togglebutton_24;
	tf.config_togglebutton[10].checked = config_plugin_obj.togglebutton_25;
	tf.config_togglebutton[11].checked = config_plugin_obj.togglebutton_26;
	tf.config_togglebutton[12].checked = config_plugin_obj.togglebutton_27;
	tf.config_togglebutton[1].draw();
	tf.config_togglebutton[2].draw();
	tf.config_togglebutton[3].draw();
	tf.config_togglebutton[4].draw();
	tf.config_togglebutton[5].draw();
	tf.config_togglebutton[6].draw();
	tf.config_togglebutton[7].draw();
	tf.config_togglebutton[8].draw();
	tf.config_togglebutton[9].draw();
	tf.config_togglebutton[10].draw();
	tf.config_togglebutton[11].draw();
	tf.config_togglebutton[12].draw();
}

config_plugin_obj.slider_00 = sf.init_bgmvolume / 100000;
config_plugin_obj.slider_01 = sf.init_sevolume / 100000;
config_plugin_obj.slider_02 = (100 - sf.init_chspeed)/100;	
config_plugin_obj.slider_03 = (2000 - sf.init_autospeed)/2000;
config_plugin_obj.slider_04 = sf.init_messageopacity / 255;

if (config_plugin_obj.nowpage == 1)
{
	with(tf.config_slider[0]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 0]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 0][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 0][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 0)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 0); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 0); .updateState(); }
	with(tf.config_slider[1]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 1]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 1][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 1][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 1)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 1); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 1); .updateState(); }
	with(tf.config_slider[2]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 2]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 2][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 2][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 2)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 2); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 2); .updateState(); }
	with(tf.config_slider[3]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 3]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 3][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 3][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 3)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 3); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 3); .updateState(); }
	with(tf.config_slider[4]){  .countpage = 0; .visible = config_plugin_obj.slider_visible[(config_plugin_obj.nowpage - 1)*10 + 4]; .left = config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 4][0]; .top =  config_plugin_obj.slider_pos[(config_plugin_obj.nowpage - 1)*10 + 4][1]; .hval = Scripts.eval('config_plugin_obj.slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 4)); .onchangestorage = 'config_sub.ks'; .onchangetarget = '*config_sub_slider_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 4); .onchangefunc = 'config_plugin_obj.slider_func_' + '%02d'.sprintf((config_plugin_obj.nowpage - 1)*10 + 4); .updateState(); }
}

kag.chDefaultFace = sf.init_font;
kag.setMessageLayerUserFont();
@endscript

@bgmopt gvolume="&config_plugin_obj.slider_00*100"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"

@seopt gvolume="&config_plugin_obj.slider_01*100"
@eval exp="&sf.sevolume = kag.se[0].volume2"

@eval exp="kag.userChSpeed=100 - config_plugin_obj.slider_02*100"

@eval exp="&kag.autoModePageWait = 2000 -  config_plugin_obj.slider_03 * 2000;"
@eval exp="&kag.autoModeLineWait = 1000 -  config_plugin_obj.slider_03 * 1000;"

@eval exp="&sf.messageopacity = (config_plugin_obj.slider_04 * 255)"
@eval exp="&SetMessageOpacity_object.foreLay.opacity = sf.messageopacity"
@eval exp="&SetMessageOpacity_object.backLay.opacity = sf.messageopacity"
@jump storage=config.ks target=*return

*config_sub_button_10
@jump storage=config.ks target=*return

*config_sub_button_11
@jump storage=config.ks target=*return

*config_sub_button_12
@jump storage=config.ks target=*return

*config_sub_button_13
@jump storage=config.ks target=*return

*config_sub_button_14
@jump storage=config.ks target=*return


;�g�O���{�^���p�T�u���[�`��
*config_sub_togglebutton_00
;�y�[�W���܂ň�x�ɕ\��
@eval exp="kag.onChNonStopToPageBreakItemClick()"
@jump storage=config.ks target=*return

*config_sub_togglebutton_01
;���ǃy�[�W���܂ň�x�ɕ\��
@eval exp="kag.onCh2ndNonStopToPageBreakItemClick()"
@jump storage=config.ks target=*return

*config_sub_togglebutton_02
;�A���`�G�C���A�X
@eval exp="kag.onChAntialiasMenuItemClick()"
@er
@locate x=260 y=260
����͂ɂقւƂ���ʂ��
@jump storage=config.ks target=*return

*config_sub_togglebutton_03
;�e
@iscript
// ���ׂẴ��b�Z�[�W���C���� defaultShadow �� defaultEdge�̐ݒ������
for(var i = 0; i < kag.fore.messages.count; i++)
{
	kag.tagHandlers.current(%[layer:'message'+i, page:'back']);
	kag.tagHandlers.deffont(%[shadow:config_plugin_obj.togglebutton_03, edge:false]);
	kag.tagHandlers.resetfont();
	kag.tagHandlers.current(%[layer:'message'+i, page:'fore']);
	kag.tagHandlers.deffont(%[shadow:config_plugin_obj.togglebutton_03, edge:false]);
	kag.tagHandlers.resetfont();
}

sf.chShadow = config_plugin_obj.togglebutton_03 = tf.config_togglebutton[3].checked=kag.fore.messages[0].defaultShadow;
sf.chEdge = config_plugin_obj.togglebutton_04 = tf.config_togglebutton[4].checked=kag.fore.messages[0].defaultEdge;
tf.config_togglebutton[3].draw();
tf.config_togglebutton[4].draw();
@endscript
@er
@locate x=260 y=260
����͂ɂقւƂ���ʂ��
@jump storage=config.ks target=*return

*config_sub_togglebutton_04
;�����
@iscript
// ���ׂẴ��b�Z�[�W���C���� defaultShadow �� defaultEdge�̐ݒ������
for(var i = 0; i < kag.fore.messages.count; i++)
{
	kag.tagHandlers.current(%[layer:'message'+i, page:'back']);
	kag.tagHandlers.deffont(%[edge:config_plugin_obj.togglebutton_04, shadow:false]);
	kag.tagHandlers.resetfont();
	kag.tagHandlers.current(%[layer:'message'+i, page:'fore']);
	kag.tagHandlers.deffont(%[edge:config_plugin_obj.togglebutton_04, shadow:false]);
	kag.tagHandlers.resetfont();
}

sf.chShadow = config_plugin_obj.togglebutton_03 = tf.config_togglebutton[3].checked=kag.fore.messages[0].defaultShadow;
sf.chEdge = config_plugin_obj.togglebutton_04 = tf.config_togglebutton[4].checked=kag.fore.messages[0].defaultEdge;
tf.config_togglebutton[3].draw();
tf.config_togglebutton[4].draw();
@endscript
@er
@locate x=260 y=260
����͂ɂقւƂ���ʂ��
@jump storage=config.ks target=*return

*config_sub_togglebutton_05
;����
@iscript
// ���ׂẴ��b�Z�[�W���C���� defaultBold
for(var i = 0; i < kag.fore.messages.count; i++)
{
	kag.tagHandlers.current(%[layer:'message'+i, page:'back']);
	kag.tagHandlers.deffont(%[bold:config_plugin_obj.togglebutton_05]);
	kag.tagHandlers.resetfont();
	kag.tagHandlers.current(%[layer:'message'+i, page:'fore']);
	kag.tagHandlers.deffont(%[bold:config_plugin_obj.togglebutton_05]);
	kag.tagHandlers.resetfont();
}
sf.chBold = config_plugin_obj.togglebutton_05;
@endscript
@er
@locate x=260 y=260
����͂ɂقւƂ���ʂ��
@jump storage=config.ks target=*return

*config_sub_togglebutton_06
@jump storage=config.ks target=*return

*config_sub_togglebutton_07
@jump storage=config.ks target=*return

*config_sub_togglebutton_08
@jump storage=config.ks target=*return

*config_sub_togglebutton_09
@jump storage=config.ks target=*return

*config_sub_togglebutton_10
@jump storage=config.ks target=*return

*config_sub_togglebutton_11
@jump storage=config.ks target=*return

*config_sub_togglebutton_12
@jump storage=config.ks target=*return

*config_sub_togglebutton_13
@jump storage=config.ks target=*return

*config_sub_togglebutton_14
@jump storage=config.ks target=*return

*config_sub_togglebutton_15
; �E�B���h�E���[�h�́u�t���X�N���[���v���N���b�N�������Ɏ��s�����X�N���v�g
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@jump storage=config.ks target=*return

*config_sub_togglebutton_16
;�^�C�g���ɖ߂���m�F���邩
@eval exp="sf.titleAsk = config_plugin_obj.togglebutton_16"
@jump storage=config.ks target=*return

*config_sub_togglebutton_17
;�Q�[���I�����m�F���邩
@eval exp="sf.exitAsk = config_plugin_obj.togglebutton_17"
@jump storage=config.ks target=*return

*config_sub_togglebutton_18
;�N�C�b�N�Z�[�u���Ɋm�F���邩
@eval exp="sf.qsaveAsk = config_plugin_obj.togglebutton_18"
@jump storage=config.ks target=*return

*config_sub_togglebutton_19
;�N�C�b�N���[�h���Ɋm�F���邩
@eval exp="sf.qloadAsk = config_plugin_obj.togglebutton_19"
@jump storage=config.ks target=*return

*config_sub_togglebutton_20
;�O�̑I�����ɖ߂�Ŋm�F���邩
@eval exp="sf.returnAsk = config_plugin_obj.togglebutton_20"
@jump storage=config.ks target=*return

*config_sub_togglebutton_21
;�Z�[�u�㏑�����Ɋm�F���邩
@eval exp="sf.saveAsk = config_plugin_obj.togglebutton_21"
@jump storage=config.ks target=*return

*config_sub_togglebutton_22
;���[�h���Ɋm�F���邩
@eval exp="sf.loadAsk = config_plugin_obj.togglebutton_22"
@jump storage=config.ks target=*return

*config_sub_togglebutton_23
;�I��������I�[�g���[�h���p�����邩
@eval exp="sf.autocontinue = config_plugin_obj.togglebutton_23"
@jump storage=config.ks target=*return

*config_sub_togglebutton_24
;�I��������X�L�b�v���[�h���p�����邩
@eval exp="sf.skipcontinue = config_plugin_obj.togglebutton_24"
@jump storage=config.ks target=*return

*config_sub_togglebutton_25
;�}�E�X�I�����j���[���g�p����
;���W�I�{�^���ɂ��邽�߂�
;���̏�ő��̃{�^����ύX����
;�z��̐����͂���Ă���̂Œ���( �{�^���ԍ� - 15 X (���݂̃y�[�W - 1) )
@eval exp="sf.menu_mode=0 if config_plugin_obj.togglebutton_25"
@eval exp="config_plugin_obj.togglebutton_25 = tf.config_togglebutton[10].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.togglebutton_26 = tf.config_togglebutton[11].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.togglebutton_27 = tf.config_togglebutton[12].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[10].draw()"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@jump storage=config.ks target=*return

*config_sub_togglebutton_26
;�E�N���b�N���j���[���g�p����
@eval exp="sf.menu_mode=1 if config_plugin_obj.togglebutton_26"
@eval exp="config_plugin_obj.togglebutton_25 = tf.config_togglebutton[10].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.togglebutton_26 = tf.config_togglebutton[11].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.togglebutton_27 = tf.config_togglebutton[12].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[10].draw()"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@jump storage=config.ks target=*return

*config_sub_togglebutton_27
;�V�X�e�����j���[���g�p����
@eval exp="sf.menu_mode=2 if config_plugin_obj.togglebutton_27"
@eval exp="config_plugin_obj.togglebutton_25 = tf.config_togglebutton[10].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.togglebutton_26 = tf.config_togglebutton[11].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.togglebutton_27 = tf.config_togglebutton[12].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[10].draw()"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@jump storage=config.ks target=*return

*config_sub_togglebutton_28
@jump storage=config.ks target=*return

*config_sub_togglebutton_29
@jump storage=config.ks target=*return

*config_sub_togglebutton_30
@jump storage=config.ks target=*return

*config_sub_togglebutton_31
@jump storage=config.ks target=*return

*config_sub_togglebutton_32
@jump storage=config.ks target=*return

*config_sub_togglebutton_33
@jump storage=config.ks target=*return

*config_sub_togglebutton_34
@jump storage=config.ks target=*return

*config_sub_togglebutton_35
@jump storage=config.ks target=*return

*config_sub_togglebutton_36
@jump storage=config.ks target=*return

*config_sub_togglebutton_37
@jump storage=config.ks target=*return

*config_sub_togglebutton_38
@jump storage=config.ks target=*return

*config_sub_togglebutton_39
@jump storage=config.ks target=*return

*config_sub_togglebutton_40
@jump storage=config.ks target=*return

*config_sub_togglebutton_41
@jump storage=config.ks target=*return

*config_sub_togglebutton_42
@jump storage=config.ks target=*return

*config_sub_togglebutton_43
@jump storage=config.ks target=*return

*config_sub_togglebutton_44
@jump storage=config.ks target=*return


;�X���C�_�[�p�T�u���[�`��
*config_sub_slider_00
;BGM
@bgmopt gvolume="&config_plugin_obj.slider_00*100"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"
@jump storage=config.ks target=*return

*config_sub_slider_01
;SE
@seopt gvolume="&config_plugin_obj.slider_01*100"
@eval exp="&sf.sevolume = kag.se[0].volume2"
@jump storage=config.ks target=*return

*config_sub_slider_02
;�������x
@eval exp="kag.userChSpeed=100 - config_plugin_obj.slider_02*100"
@er
@locate x=260 y=260
����͂ɂقւƂ���ʂ��
@jump storage=config.ks target=*return

*config_sub_slider_03
;�I�[�g���x
@eval exp="&kag.autoModePageWait = 2000 -  config_plugin_obj.slider_03 * 2000;"
@eval exp="&kag.autoModeLineWait = 1000 -  config_plugin_obj.slider_03 * 1000;"
@jump storage=config.ks target=*return

*config_sub_slider_04
;���b�Z�[�W�g�Z�x
@eval exp="&sf.messageopacity = (config_plugin_obj.slider_04 * 255)"
@eval exp="&SetMessageOpacity_object.foreLay.opacity = sf.messageopacity"
@eval exp="&SetMessageOpacity_object.backLay.opacity = sf.messageopacity"
@layopt layer="&kag.numCharacterLayers - 2" opacity=&sf.messageopacity
@jump storage=config.ks target=*return

*config_sub_slider_05
@jump storage=config.ks target=*return

*config_sub_slider_06
@jump storage=config.ks target=*return

*config_sub_slider_07
@jump storage=config.ks target=*return

*config_sub_slider_08
@jump storage=config.ks target=*return

*config_sub_slider_09
@jump storage=config.ks target=*return

*config_sub_slider_10
@jump storage=config.ks target=*return

*config_sub_slider_11
@jump storage=config.ks target=*return

*config_sub_slider_12
@jump storage=config.ks target=*return

*config_sub_slider_13
@jump storage=config.ks target=*return

*config_sub_slider_14
@jump storage=config.ks target=*return

*config_sub_slider_15
@jump storage=config.ks target=*return

*config_sub_slider_16
@jump storage=config.ks target=*return

*config_sub_slider_17
@jump storage=config.ks target=*return

*config_sub_slider_18
@jump storage=config.ks target=*return

*config_sub_slider_19
@jump storage=config.ks target=*return

*config_sub_slider_20
@jump storage=config.ks target=*return

*config_sub_slider_21
@jump storage=config.ks target=*return

*config_sub_slider_22
@jump storage=config.ks target=*return

*config_sub_slider_23
@jump storage=config.ks target=*return

*config_sub_slider_24
@jump storage=config.ks target=*return

*config_sub_slider_25
@jump storage=config.ks target=*return

*config_sub_slider_26
@jump storage=config.ks target=*return

*config_sub_slider_27
@jump storage=config.ks target=*return

*config_sub_slider_28
@jump storage=config.ks target=*return

*config_sub_slider_29
@jump storage=config.ks target=*return

