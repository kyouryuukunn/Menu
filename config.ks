*initialize

; �E�N���b�N�ŃR���t�B�O��ʂ������悤�ɉE�N���b�N�̐ݒ��ύX���܂�
@rclick jump=true storage="config.ks" target=*back enabled=true
; �߂邽�߂Ɍ��݂̃��j���[�̐ݒ��ۑ�
@eval exp="config.pre_menu_mode = sf.menu_mode"
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
@laycount layers="&kag.numCharacterLayers + 1" messages="&kag.numMessageLayers + 1"
@layopt index="&2000000+100" layer="&kag.numCharacterLayers - 1"
@layopt index="&2000000+200" layer="&kag.numMessageLayers - 1"
; �w�i
@image layer="&kag.numCharacterLayers-1" storage=&config.back page=fore visible=true

; �{�^���ݒ�
@iscript
config.togglebutton = [];
for (var i = 0; i < 14; i++){
	config.togglebutton[i] = new KToggleButtonLayer(kag, kag.fore.layers[kag.numCharacterLayers-1]);
}
// #0: �t���X�N���[���ɕ\������`�F�b�N�摜
config.togglebutton[0].setOptions( %[visible:config.windowmodeon, left:config.windowmode[0], top:config.windowmode[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*windowmode', unchecktarget:'*windowmode', graphic:config.graphic, checked:kag.fullScreened]);
// #1: title�ɕ\������`�F�b�N�摜
config.togglebutton[1].setOptions( %[visible:config.titleAskon, left:config.titleAsk[0], top:config.titleAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*titleAsk', unchecktarget:'*titleAsk', graphic:config.graphic, checked:sf.titleAsk]);
// #2: exit�ɕ\������`�F�b�N�摜
config.togglebutton[2].setOptions( %[visible:config.exitAskon, left:config.exitAsk[0], top:config.exitAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*exitAsk', unchecktarget:'*exitAsk', graphic:config.graphic, checked:sf.exitAsk]);
// #3: qload�ɕ\������`�F�b�N�摜
config.togglebutton[3].setOptions( %[visible:config.qloadAskon, left:config.qloadAsk[0], top:config.qloadAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*qloadAsk', unchecktarget:'*qloadAsk', graphic:config.graphic, checked:sf.qloadAsk]);
// #4: return�ɕ\������`�F�b�N�摜
config.togglebutton[4].setOptions( %[visible:config.returnAskon, left:config.returnAsk[0], top:config.returnAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*returnAsk', unchecktarget:'*returnAsk', graphic:config.graphic, checked:sf.returnAsk]);
// #5: save�ɕ\������`�F�b�N�摜
config.togglebutton[5].setOptions( %[visible:config.saveAskon, left:config.saveAsk[0], top:config.saveAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*saveAsk', unchecktarget:'*saveAsk', graphic:config.graphic, checked:sf.saveAsk]);
// #6: load�ɕ\������`�F�b�N�摜
config.togglebutton[6].setOptions( %[visible:config.loadAskon, left:config.loadAsk[0], top:config.loadAsk[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*loadAsk', unchecktarget:'*loadAsk', graphic:config.graphic, checked:sf.loadAsk]);
// #7:�u�y�[�W���܂ň�x�ɕ\���v�ɕ\������`�F�b�N�摜
config.togglebutton[7].setOptions( %[visible:config.pagebreakon, left:config.pagebreak[0], top:config.pagebreak[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*pagebreak', unchecktarget:'*pagebreak', graphic:config.graphic, checked:kag.chNonStopToPageBreak]);
// #8: sceneskip�ɕ\������`�F�b�N�摜
config.togglebutton[8].setOptions( %[visible:config.sceneskipon, left:config.sceneskip[0], top:config.sceneskip[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*sceneskip', unchecktarget:'*sceneskip', graphic:config.graphic, checked:sf.sceneskip]);
// #9: autocontinue�ɕ\������`�F�b�N�摜
config.togglebutton[9].setOptions( %[visible:config.autocontinueon, left:config.autocontinue[0], top:config.autocontinue[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*autocontinue', unchecktarget:'*autocontinue', graphic:config.graphic, checked:sf.autocontinue]);
// #10: skipcontinue�ɕ\������`�F�b�N�摜
config.togglebutton[10].setOptions(%[visible:config.skipcontinueon, left:config.skipcontinue[0], top:config.skipcontinue[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*skipcontinue', unchecktarget:'*skipcontinue', graphic:config.graphic, checked:sf.skipcontinue]);


// #11: menu0�ɕ\������`�F�b�N�摜
config.togglebutton[11].setOptions(%[visible:config.menu0on, left:config.menu0[0], top:config.menu0[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*menu0', unchecktarget:'*menu0', graphic:config.graphic, checked:sf.menu_mode == 0]);
// #14: menu1�ɕ\������`�F�b�N�摜
config.togglebutton[12].setOptions(%[visible:config.menu1on, left:config.menu1[0], top:config.menu1[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*menu1', unchecktarget:'*menu1', graphic:config.graphic, checked:sf.menu_mode == 1]);
// #15: menu2�ɕ\������`�F�b�N�摜
config.togglebutton[13].setOptions(%[visible:config.menu2on, left:config.menu2[0], top:config.menu2[1], checkstorage:'config.ks', uncheckstorage:'config.ks', checktarget:'*menu2', unchecktarget:'*menu2', graphic:config.graphic, checked:sf.menu_mode == 2]);
@endscript

; ���b�Z�[�W���C���̐ݒ�����܂�
@history enabled=false output=false
@current layer="&'message' + (kag.numMessageLayers - 1)"
@position opacity=0 marginb=0 marginl=0 marginr=0 margint=0 left=0 top=0 width=&kag.scWidth height=&kag.scHeight visible=true
;����{�^��
@locate x=&config.close_x y=&config.close_y
@button storage=config.ks target=*back graphic=&config.close_button 


; ���X���C�_�[�ݒ�
@iscript
config.slider = new Array();
for (var i=0; i < 5; i++){
	config.slider[i] = new KSliderLayer(kag, kag.fore.layers[kag.numCharacterLayers - 1]);
	with(config.slider[i]){
		.setOptions(%['graphic' => config.slider_base, 'tabgraphic' => config.slider_tab]);
	}
}
// ���X���C�_�[0�̐ݒ� - (BGM���ʒ���)
with(config.slider[0]){
	.visible = config.slider0_on;
	.left = config.slider0[0];
	.top =  config.slider0[1];
	.hval = kag.bgm.buf1.volume2 / 100000;
	.updateState();
	.onchangefunc = 'config.bgmslider';
}
// ���X���C�_�[1�̐ݒ� - (SE���ʒ���)
with(config.slider[1]){
	.visible = config.slider1_on;
	.left = config.slider1[0];
	.top =  config.slider1[1];
	.hval = kag.se[0].volume2 / 100000;
	.updateState();
	.onchangefunc = 'config.seslider';
}
// ���X���C�_�[2�̐ݒ� - (�������x)
with(config.slider[2]){
	.visible = config.slider2_on;
	.left = config.slider2[0];
	.top =  config.slider2[1];
	.hval = (100 - kag.chSpeed)/100;
	.updateState();
	.onchangefunc = 'config.chspeedslider';
}
// ���X���C�_�[3�̐ݒ� - (�I�[�g���[�h���x)
with(config.slider[3]){
	.visible = config.slider3_on;
	.left = config.slider3[0];
	.top =  config.slider3[1];
	.hval = (2000 - kag.autoModePageWait)/2000;
	.updateState();
	.onchangefunc = 'config.autospeedslider';
}
// ���X���C�_�[4�̐ݒ� - (�����x)
with(config.slider[4]){
	.visible = config.slider4_on;
	.left = config.slider4[0];
	.top =  config.slider4[1];
	.hval = sf.messageopacity / 255;
	.updateState();
	.onchangefunc = 'config.messageopacityslider';
}
@endscript

@s
; ��������悪�e�T�u���[�`��

; �E�B���h�E���[�h�́u�t���X�N���[���v���N���b�N�������Ɏ��s�����X�N���v�g
*windowmode
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@s
; �I�[�g���[�h���p�����邩�m�F����
*autocontinue
@if exp="sf.autocontinue==1"
	@eval exp="sf.autocontinue=0"
@elsif exp="sf.autocontinue==0"
	@eval exp="sf.autocontinue=1"
@endif
@s
; �X�L�b�v���p�����邩�m�F����
*skipcontinue
@if exp="sf.skipcontinue==1"
	@eval exp="sf.skipcontinue=0"
@elsif exp="sf.skipcontinue==0"
	@eval exp="sf.skipcontinue=1"
@endif
@s
; �u�y�[�W���܂ň�x�ɕ\���v���N���b�N�������Ɏ��s�����X�N���v�g
*pagebreak
@eval exp="kag.onChNonStopToPageBreakItemClick()"
@s
; �V�[���X�L�b�v�����邩�m�F����
*sceneskip
@if exp="sf.sceneskip==1"
	@eval exp="sf.sceneskip=0"
@elsif exp="sf.sceneskip==0"
	@eval exp="sf.sceneskip=1"
@endif
@s
; �Z�[�u���邩�m�F����
*saveAsk
@if exp="sf.saveAsk==1"
	@eval exp="sf.saveAsk=0"
@elsif exp="sf.saveAsk==0"
	@eval exp="sf.saveAsk=1"
@endif
@s
; ���[�h���邩�m�F����
*loadAsk
@if exp="sf.loadAsk==1"
	@eval exp="sf.loadAsk=0"
@elsif exp="sf.loadAsk==0"
	@eval exp="sf.loadAsk=1"
@endif
@s
; �N�C�b�N���[�h���邩�m�F���� 
*qloadAsk
@if exp="sf.qloadAsk==1"
	@eval exp="sf.qloadAsk=0"
@elsif exp="sf.qloadAsk==0"
	@eval exp="sf.qloadAsk=1"
@endif
@s
; �O�̑I�����ɖ߂邩�m�F����
*returnAsk
@if exp="sf.returnAsk==1"
	@eval exp="sf.returnAsk=0"
@elsif exp="sf.returnAsk==0"
	@eval exp="sf.returnAsk=1"
@endif
@s
; �^�C�g���ɖ߂邩�m�F����
*titleAsk
@if exp="sf.titleAsk==1"
	@eval exp="sf.titleAsk=0"
@elsif exp="sf.titleAsk==0"
	@eval exp="sf.titleAsk=1"
@endif
@s
; �I�����邩�m�F����
*exitAsk
@if exp="sf.exitAsk==1"
	@eval exp="sf.exitAsk=0"
@elsif exp="sf.exitAsk==0"
	@eval exp="sf.exitAsk=1"
@endif
@s

; �E�N���b�N
*menu0
@eval exp="sf.menu_mode=0"
@jump storage=config.ks target=*update_menu
@s

*menu1
@eval exp="sf.menu_mode=1"
@jump storage=config.ks target=*update_menu
@s

*menu2
@eval exp="sf.menu_mode=2"
@jump storage=config.ks target=*update_menu
@s
;���̃{�^���̕\����ς���
*update_menu
@eval exp="config.togglebutton[11].checked=sf.menu_mode == 0 ? 1 : 0"
@eval exp="config.togglebutton[12].checked=sf.menu_mode == 1 ? 1 : 0"
@eval exp="config.togglebutton[13].checked=sf.menu_mode == 2 ? 1 : 0"
@eval exp="config.togglebutton[11].draw()"
@eval exp="config.togglebutton[12].draw()"
@eval exp="config.togglebutton[13].draw()"
@s

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
@return cond="config.pre_menu_mode == 0 || config.pre_menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="config.pre_menu_mode == 1"
