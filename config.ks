*initialize

; �E�N���b�N�ŃR���t�B�O��ʂ������悤�ɉE�N���b�N�̐ݒ��ύX���܂�
@rclick jump=true storage="config.ks" target=*back enabled=true
; �߂邽�߂Ɍ��݂̃��j���[�̐ݒ��ۑ�
@eval exp="tf.pre_menu_mode = sf.menu_mode"
; ���݂̏�Ԃ���������̞x�ɕۑ����Ă����܂�
@tempsave place=0

@iscript
// �V�X�e���{�^�����g���Ă���Ȃ����
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(true);
//SetMessageOpacity���g���Ă���Ȃ����
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(true);
// �S�Ẵ��b�Z�[�W���C�����\���ɂ��܂�
for(var i=0;i<kag.numMessageLayers;i++)
	kag.fore.messages[i].setOptions(%["visible" => false]);
//�}�E�X�𒆐S�Ɉړ�
kag.fore.base.cursorX = kag.scWidth/2;
kag.fore.base.cursorY = kag.scHeight/2;
@endscript


; ���C����K�v�Ȑ��m�ۂ��܂�
@laycount layers="&kag.numCharacterLayers + 17" messages="&kag.numMessageLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
@layopt index="&2000000+101" layer="&kag.numCharacterLayers - 2"
@layopt index="&2000000+102" layer="&kag.numCharacterLayers - 3"
@layopt index="&2000000+103" layer="&kag.numCharacterLayers - 4"
@layopt index="&2000000+104" layer="&kag.numCharacterLayers - 5"
@layopt index="&2000000+105" layer="&kag.numCharacterLayers - 6"
@layopt index="&2000000+106" layer="&kag.numCharacterLayers - 7"
@layopt index="&2000000+107" layer="&kag.numCharacterLayers - 8"
@layopt index="&2000000+108" layer="&kag.numCharacterLayers - 9"
@layopt index="&2000000+109" layer="&kag.numCharacterLayers - 10"
@layopt index="&2000000+110" layer="&kag.numCharacterLayers - 11"
@layopt index="&2000000+111" layer="&kag.numCharacterLayers - 12"
@layopt index="&2000000+112" layer="&kag.numCharacterLayers - 13"
@layopt index="&2000000+113" layer="&kag.numCharacterLayers - 14"
@layopt index="&2000000+114" layer="&kag.numCharacterLayers - 15"
@layopt index="&2000000+115" layer="&kag.numCharacterLayers - 16"
@layopt index="&2000000+116" layer="&kag.numCharacterLayers - 17"
@layopt index="&2000000+117" layer="&'message' + (kag.numMessageLayers-1)"
; �w�i
@image layer="&kag.numCharacterLayers-1" storage="config_bg" page=fore visible=true

; �O�i���C���ɉ摜��ǂݍ��݂܂�
; #0: �t���X�N���[���ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 2" storage="checked" page=fore visible=false top=525 left=440
; #1: title�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 3" storage="checked" page=fore visible=false top=435 left=700
; #2: exit�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 4" storage="checked" page=fore visible=false top=475 left=700
; #3: qload�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 5" storage="checked" page=fore visible=false top=435 left=440
; #4: return�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 6" storage="checked" page=fore visible=false top=475 left=440
; #5: save�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 7" storage="checked" page=fore visible=false top=435 left=160
; #6: load�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 8" storage="checked" page=fore visible=false top=475 left=160
; #7:�u�y�[�W���܂ň�x�ɕ\���v�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 9" storage="checked" page=fore visible=false top=165 left=740 
; #8: sceneskip�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 10" storage="checked" page=fore visible=false top=205 left=740 
; #9: autocontinue�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 11" storage="checked" page=fore visible=false top=165 left=410 
; #10: skipcontinue�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 12" storage="checked" page=fore visible=false top=200  left=410 
; #11:�uBack�v�̃��[���I�[�o�[�p�摜
@image layer="&kag.numCharacterLayers - 13" storage="back_ro" page=fore visible=false top=520 left=680 
; #12:�ucheck�v�̃��[���I�[�o�[�p�摜
@image layer="&kag.numCharacterLayers - 14" storage="check_ro" page=fore visible=false opacity=160
; #13: menu0�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 15" storage="checked" page=fore visible=false top=305  left=590
; #14: menu1�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 16" storage="checked" page=fore visible=false top=355  left=590
; #14: menu2�ɕ\������`�F�b�N�摜
@image layer="&kag.numCharacterLayers - 17" storage="checked" page=fore visible=false top=305  left=770

; ���b�Z�[�W���C���̐ݒ�����܂�
@history enabled=false output=false
@current layer="&'message' + (kag.numMessageLayers - 1)"
@position opacity=0 marginb=0 marginl=0 marginr=0 margint=0 left=0 top=0 width=&kag.scWidth height=&kag.scHeight visible=true
; ���X���C�_�[�ݒ�
@iscript
//�֐��̐ݒ�
function config_bgmslider(hval,vval,drag){
	kag.tagHandlers.bgmopt(%['gvolume' => hval*100]);
	sf.bgmvolume = kag.bgm.buf1.volume2;
};
function config_seslider(hval,vval,drag){
	for(var i=0;i<kag.numSEBuffers;i++)
		kag.se[i].setOptions(%['gvolume' => hval*100 ]);
	sf.sevolume = kag.se[0].volume2;
};
function config_chspeed(hval,vval,drag){ 
	kag.userChSpeed=( 100 - hval*100 );
};
function config_autospeed(hval,vval,drag){
	// �I�[�g���x
	kag.autoModePageWait = 2000 -  hval * 2000;
	kag.autoModeLineWait = 1000 -  hval * 1000;
};
function config_messageopacity(hval,vval,drag){
	sf.messageopacity = (hval * 255);
	SetMessageOpacity_object.foreLay.opacity = sf.messageopacity;
	SetMessageOpacity_object.backLay.opacity = sf.messageopacity;
};
tf.slider = new Array();
for (var i=0; i < 5; i++){
	tf.slider[i] = new KSliderLayer(kag, kag.fore.layers[kag.numCharacterLayers - 1]);
	with(tf.slider[i]){
		.setOptions(%['graphic' => 'slider_base', 'tabgraphic' => 'slider_tab']);
	}
}
// ���X���C�_�[0�̐ݒ� - (BGM���ʒ���)
with(tf.slider[0]){
	.left = 190;
	.top = 305;
	.hval = kag.bgm.buf1.volume2 / 100000;
	.updateState();
	.onchangefunc = 'config_bgmslider';
}
// ���X���C�_�[1�̐ݒ� - (SE���ʒ���)
with(tf.slider[1]){
	.left = 190;
	.top = 345;
	.hval = kag.se[0].volume2 / 100000;
	.updateState();
	.onchangefunc = 'config_seslider';
}
// ���X���C�_�[2�̐ݒ� - (�������x)
with(tf.slider[2]){
	.left = 450;
	.top = 70;
	.hval = (100 - kag.chSpeed)/100;
	.updateState();
	.onchangefunc = 'config_chspeed';
}
// ���X���C�_�[3�̐ݒ� - (�I�[�g���[�h���x)
with(tf.slider[3]){
	.left = 450;
	.top = 100;
	.hval = (2000 - kag.autoModePageWait)/2000;
	.updateState();
	.onchangefunc = 'config_autospeed';
}
// ���X���C�_�[4�̐ݒ� - (�����x)
with(tf.slider[4]){
	.left = 450;
	.top = 130;
	.hval = sf.messageopacity / 255;
	.updateState();
	.onchangefunc = 'config_messageopacity';
}
@endscript

; �e���ڂ̕\�������������܂�
@call target=*update_autocontinue
@call target=*update_skipcontinue
@call target=*update_pagebreak
@call target=*update_sceneskip
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@call target=*update_save
@call target=*update_load
@call target=*update_qload
@call target=*update_return
@call target=*update_title
@call target=*update_exit
@call target=*update_windowmode

; ���[�U�̑����҂��܂�
@s

; �E�B���h�E���[�h�́u�t���X�N���[���v���N���b�N�������Ɏ��s�����X�N���v�g
*windowmode
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@call target=*update_windowmode
@s

; �E�B���h�E���[�h�̃`�F�b�N�{�b�N�X�̕\�����X�V���܂�
*update_windowmode
@layopt layer="&kag.numCharacterLayers - 2" page=fore visible="&kag.fullScreened ? true : false"
@return


; �I�[�g���[�h���p�����邩�m�F����
*autocontinue
@if exp="sf.autocontinue==1"
	@eval exp="sf.autocontinue=0"
@elsif exp="sf.autocontinue==0"
	@eval exp="sf.autocontinue=1"
@endif
@call target=*update_autocontinue
@s

*update_autocontinue
@layopt layer="&kag.numCharacterLayers - 11" visible=&sf.autocontinue
@return
; �X�L�b�v���p�����邩�m�F����
*skipcontinue
@if exp="sf.skipcontinue==1"
	@eval exp="sf.skipcontinue=0"
@elsif exp="sf.skipcontinue==0"
	@eval exp="sf.skipcontinue=1"
@endif
@call target=*update_skipcontinue
@s

; �u�y�[�W���܂ň�x�ɕ\���v���N���b�N�������Ɏ��s�����X�N���v�g
*pagebreak
[eval exp="kag.onChNonStopToPageBreakItemClick()"]
[call target=*update_pagebreak]
[s]

;�u�y�[�W���܂ň�x�ɕ\���v�̃`�F�b�N�{�b�N�X�̕\�����X�V���܂�
*update_pagebreak
[layopt layer="&kag.numCharacterLayers - 9" page=fore visible="&kag.chNonStopToPageBreak"]
[return]

*update_skipcontinue
@layopt layer="&kag.numCharacterLayers - 12" visible=&sf.skipcontinue
@return
; �V�[���X�L�b�v�����邩�m�F����
*sceneskip
@if exp="sf.sceneskip==1"
	@eval exp="sf.sceneskip=0"
@elsif exp="sf.sceneskip==0"
	@eval exp="sf.sceneskip=1"
@endif
@call target=*update_sceneskip
@s
*update_sceneskip
@layopt layer="&kag.numCharacterLayers - 10" visible=&sf.sceneskip
@return
; �E�N���b�N
*menu0
@eval exp="sf.menu_mode=0"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu0
@layopt layer="&kag.numCharacterLayers - 15" visible="&sf.menu_mode == 0"
@return

*menu1
@eval exp="sf.menu_mode=1"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu1
@layopt layer="&kag.numCharacterLayers - 16" visible="&sf.menu_mode == 1"
@return

*menu2
@eval exp="sf.menu_mode=2"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu2
@layopt layer="&kag.numCharacterLayers - 17" visible="&sf.menu_mode == 2"
@return

; �Z�[�u���邩�m�F����
*saveAsk
@if exp="sf.saveAsk==1"
	@eval exp="sf.saveAsk=0"
@elsif exp="sf.saveAsk==0"
	@eval exp="sf.saveAsk=1"
@endif
@call target=*update_save
@s

*update_save
@layopt layer="&kag.numCharacterLayers - 7" visible=&sf.saveAsk
@return
; ���[�h���邩�m�F����
*loadAsk
@if exp="sf.loadAsk==1"
	@eval exp="sf.loadAsk=0"
@elsif exp="sf.loadAsk==0"
	@eval exp="sf.loadAsk=1"
@endif
@call target=*update_load
@s

*update_load
@layopt layer="&kag.numCharacterLayers - 8" visible=&sf.loadAsk
@return
; �N�C�b�N���[�h���邩�m�F���� 
*qloadAsk
@if exp="sf.qloadAsk==1"
	@eval exp="sf.qloadAsk=0"
@elsif exp="sf.qloadAsk==0"
	@eval exp="sf.qloadAsk=1"
@endif
@call target=*update_qload
@s

*update_qload
@layopt layer="&kag.numCharacterLayers - 5" visible=&sf.qloadAsk
@return
; �O�̑I�����ɖ߂邩�m�F����
*returnAsk
@if exp="sf.returnAsk==1"
	@eval exp="sf.returnAsk=0"
@elsif exp="sf.returnAsk==0"
	@eval exp="sf.returnAsk=1"
@endif
@call target=*update_return
@s

*update_return
@layopt layer="&kag.numCharacterLayers - 6" visible=&sf.returnAsk
@return
; �^�C�g���ɖ߂邩�m�F����
*titleAsk
@if exp="sf.titleAsk==1"
	@eval exp="sf.titleAsk=0"
@elsif exp="sf.titleAsk==0"
	@eval exp="sf.titleAsk=1"
@endif
@call target=*update_title
@s

*update_title
@layopt layer="&kag.numCharacterLayers - 3" visible=&sf.titleAsk
@return
; �I�����邩�m�F����
*exitAsk
@if exp="sf.exitAsk==1"
	@eval exp="sf.exitAsk=0"
@elsif exp="sf.exitAsk==0"
	@eval exp="sf.exitAsk=1"
@endif
@call target=*update_exit
@s

*update_exit
@layopt layer="&kag.numCharacterLayers - 4" visible=&sf.exitAsk
@return

; �R���t�B�O��ʂ���܂�
*back

; �R���t�B�O��ʕ\���O�̏�Ԃ𕜌����܂�(�A�� BGM �͕������܂���)
@tempload place=0 bgm=false
; ���b�Z�[�W�����̏o�́E�\����L���ɂ��܂�
@history output=true enabled=true cond="kag.canStore()"
; ���b�Z�[�W�\�����x�̐ݒ�𔽉f���܂�
@delay speed=user cond="kag.chUserMode"

@iscript
// �V�X�e���{�^�����g���Ă��āA�R���t�B�O��ʂ�\������O�Ƀ��b�Z�[�W���C�����\������Ă������� onMessageHiddenStateChanged ���Ăяo���܂�
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(false);
if (typeof(global.SetMessageOpacity_object) != 'undefined' && kag.fore.messages[0].visible)
	SetMessageOpacity_object.onMessageHiddenStateChanged(false);
@endscript

; �E�N���b�N���f�t�H���g�̓���i���b�Z�[�W�E�B���h�E�����j�ɖ߂��܂�
@current layer=message0
@set_menu
@return cond="!kag.canStore()"
@return cond="tf.pre_menu_mode == 0 || tf.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="tf.pre_menu_mode == 1"
