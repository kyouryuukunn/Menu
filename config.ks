*initialize

; �E�N���b�N�ŃR���t�B�O��ʂ������悤�ɉE�N���b�N�̐ݒ��ύX���܂�
@rclick jump=true storage="config.ks" target=*back enabled=true
@eval exp="tf.pre_menu_mode = sf.menu_mode"
; ���݂̏�Ԃ���������̞x�ɕۑ����Ă����܂�
@tempsave place=0

@iscript
// �V�X�e���{�^�����g���Ă��āA���b�Z�[�W���C�����\������Ă��鎞�� onMessageHiddenStateChanged ���Ăяo���܂�
if(typeof(global.exsystembutton_object) != "undefined" && kag.fore.messages[0].visible)
	exsystembutton_object.onMessageHiddenStateChanged(true);
var i;
var elm = %["visible" => false];
// �S�Ă̑O�i���C�����\���ɂ��܂�
for(i=0;i<kag.numCharacterLayers;i++)
	kag.fore.layers[i].setOptions(elm);
// �S�Ẵ��b�Z�[�W���C�����\���ɂ��܂�
for(i=0;i<kag.numMessageLayers;i++)
	kag.fore.messages[i].setOptions(elm);

@endscript

; �w�i���C���ɉ摜�i�N���b�J�u���}�b�v�j��ǂݍ��݂܂�
@image layer=base storage="config_bg" page=fore

; ���C����K�v�Ȑ��i�O�i���C���~16,�j�m�ۂ��܂�
@laycount layers=16 messages="&kag.numMessageLayers + 1"

; �O�i���C���ɉ摜��ǂݍ��݂܂�
; #0: �t���X�N���[���ɕ\������`�F�b�N�摜
@image layer=0 storage="checked" page=fore visible=false top=525 left=440
; #1: title�ɕ\������`�F�b�N�摜
@image layer=1 storage="checked" page=fore visible=false top=435 left=700
; #2: exit�ɕ\������`�F�b�N�摜
@image layer=2 storage="checked" page=fore visible=false top=475 left=700
; #3: qload�ɕ\������`�F�b�N�摜
@image layer=3 storage="checked" page=fore visible=false top=435 left=440
; #4: return�ɕ\������`�F�b�N�摜
@image layer=4 storage="checked" page=fore visible=false top=475 left=440
; #5: save�ɕ\������`�F�b�N�摜
@image layer=5 storage="checked" page=fore visible=false top=435 left=160
; #6: load�ɕ\������`�F�b�N�摜
@image layer=6 storage="checked" page=fore visible=false top=475 left=160
; #7:�u�y�[�W���܂ň�x�ɕ\���v�ɕ\������`�F�b�N�摜
@image layer=7 storage="checked" page=fore visible=false top=165 left=740 
; #8: sceneskip�ɕ\������`�F�b�N�摜
@image layer=8 storage="checked" page=fore visible=false top=205 left=740 
; #9: autocontinue�ɕ\������`�F�b�N�摜
@image layer=9 storage="checked" page=fore visible=false top=165 left=410 
; #10: skipcontinue�ɕ\������`�F�b�N�摜
@image layer=10 storage="checked" page=fore visible=false top=200  left=410 
; #11:�uBack�v�̃��[���I�[�o�[�p�摜
@image layer=11 storage="back_ro" page=fore visible=false top=520 left=680 
; #12:�ucheck�v�̃��[���I�[�o�[�p�摜
@image layer=12 storage="check_ro" page=fore visible=false opacity=160
; #13: menu0�ɕ\������`�F�b�N�摜
@image layer=13 storage="checked" page=fore visible=false top=305  left=590
; #14: menu1�ɕ\������`�F�b�N�摜
@image layer=14 storage="checked" page=fore visible=false top=355  left=590
; #14: menu2�ɕ\������`�F�b�N�摜
@image layer=15 storage="checked" page=fore visible=false top=305  left=770

; ���b�Z�[�W���C���̐ݒ�����܂�
@history enabled=false output=false
@current layer="&'message' + (kag.numMessageLayers - 1)"
; ���X���C�_�[�ݒ�
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
; ���X���C�_�[�̒l������z��
@eval exp="f.slider = [ (int)(kag.bgm.buf1.volume2 / 1000), (int)(kag.se[0].volume2 / 1000), (int)(100 - kag.chSpeed),(int)(2000 - kag.autoModePageWait)/20, (int)(sf.messageopacity / 2.55)]"

; ���X���C�_�[�̐�
@setSliderCount sliders="5"

; ���X���C�_�[0�̐ݒ� - (BGM���ʒ���)
@setSliderImages slider="0" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="0" page="fore" visible="true" left="190" top="305" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ���X���C�_�[1�̐ݒ� - (SE���ʒ���)
@setSliderImages slider="1" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="1" page="fore" visible="true" left="190" top="345" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ���X���C�_�[2�̐ݒ� - (�������x)
@setSliderImages slider="2" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="2" page="fore" visible="true" left="450" top="70" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ���X���C�_�[3�̐ݒ� - (�I�[�g���[�h���x)
@setSliderImages slider="3" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="3" page="fore" visible="true" left="450" top="100" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"
; ���X���C�_�[4�̐ݒ� - (�����x)
@setSliderImages slider="4" forebase="base_white" forethumb="thumb_gray"
@setSliderOptions slider="4" page="fore" visible="true" left="450" top="130" changing="203" max="100" min="0" visible="true" scale="2" hit="true" cursor="true"

; ���X���C�_�̒l�������ݒ�
@setSliderValue slider="0" value="&f.slider[0]"
@setSliderValue slider="1" value="&f.slider[1]"
@setSliderValue slider="2" value="&f.slider[2]"
@setSliderValue slider="3" value="&f.slider[3]"
@setSliderValue slider="4" value="&f.slider[4]"

@setSliderEnabled enabled="true"

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
@eval exp="global.AltEnterFullScreen_obj.toggleFullScreen()"
@call target=*update_windowmode
@s

; �E�B���h�E���[�h�̃`�F�b�N�{�b�N�X�̕\�����X�V���܂�
*update_windowmode
@layopt layer=0 page=fore visible="&kag.fullScreened ? true : false"
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
@layopt layer=9 visible=&sf.autocontinue
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
[layopt layer=7 page=fore visible="&kag.chNonStopToPageBreak"]
[return]

*update_skipcontinue
@layopt layer=10 visible=&sf.skipcontinue
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
@layopt layer=8 visible=&sf.sceneskip
@return
; �E�N���b�N
*menu0
@eval exp="sf.menu_mode=0"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu0
@layopt layer=13 visible="&sf.menu_mode == 0"
@return

*menu1
@eval exp="sf.menu_mode=1"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu1
@layopt layer=14 visible="&sf.menu_mode == 1"
@return

*menu2
@eval exp="sf.menu_mode=2"
@call target=*update_menu0
@call target=*update_menu1
@call target=*update_menu2
@s
*update_menu2
@layopt layer=15 visible="&sf.menu_mode == 2"
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
@layopt layer=5 visible=&sf.saveAsk
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
@layopt layer=6 visible=&sf.loadAsk
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
@layopt layer=3 visible=&sf.qloadAsk
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
@layopt layer=4 visible=&sf.returnAsk
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
@layopt layer=1 visible=&sf.titleAsk
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
@layopt layer=2 visible=&sf.exitAsk
@return

; �R���t�B�O��ʂ���܂�
*back
; �X���C�_�[�𔽉f���܂�
[getSliderValue slider="0" name="f.slider[0]"]
[getSliderValue slider="1" name="f.slider[1]"]
[getSliderValue slider="2" name="f.slider[2]"]
[getSliderValue slider="3" name="f.slider[3]"]
[getSliderValue slider="4" name="f.slider[4]"]
; ��BGM���ʒ����̃X���C�_���������Ƃ��̏���
@bgmopt gvolume="&f.slider[0]"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"
; ��SE���ʒ����̃X���C�_���������Ƃ��̏���
@iscript
	var elm = %['gvolume' => f.slider[1] ];
	for(var i=0;i<kag.numSEBuffers;i++)
		kag.se[i].setOptions(elm);
@endscript
@eval exp="sf.sevolume = kag.se[0].volume2"
; �������x
@eval exp="kag.userChSpeed=( 100 - f.slider[2] )"
; �I�[�g���x
[eval exp="kag.autoModePageWait = 2000 -  f.slider[3] * 20"]
[eval exp="kag.autoModeLineWait = 1000 -  f.slider[3] * 10"]
; ���b�Z�[�W���C���̔Z�x
[eval exp="sf.messageopacity = (int)(f.slider[4] * 2.55)"]


; �R���t�B�O��ʕ\���O�̏�Ԃ𕜌����܂�(�A�� BGM �͕������܂���)
@tempload place=0 bgm=false
; ���b�Z�[�W�����̏o�́E�\����L���ɂ��܂�
@history output=true enabled=true cond="kag.canStore()"
; ���b�Z�[�W�\�����x�̐ݒ�𔽉f���܂�
@delay speed=user cond="kag.chUserMode"
; ���b�Z�[�W���C���̔Z�x
@set_messageopacity


@iscript
// �V�X�e���{�^�����g���Ă��āA�R���t�B�O��ʂ�\������O�Ƀ��b�Z�[�W���C�����\������Ă������� onMessageHiddenStateChanged ���Ăяo���܂�
if(typeof(global.MoveMenu_object) != "undefined" && kag.fore.messages[0].visible)
	MoveMenu_object.onMessageHiddenStateChanged(false);
@endscript

; �E�N���b�N���f�t�H���g�̓���i���b�Z�[�W�E�B���h�E�����j�ɖ߂��܂�
@current layer=message0
@set_menu
@return cond="!kag.canStore()"
@return cond="tf.pre_menu_mode == 0 || tf.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="tf.pre_menu_mode == 1"
