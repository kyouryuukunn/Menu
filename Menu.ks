@iscript
//�����ݒ� ����̂ݎ��s
if (sf.startconfig === void)
{
	//�ݒ�̏�����
	sf.saveAsk = 1; //�Z�[�u�㏑�����Ɋm�F����
	sf.loadAsk = 1; //���[�h���Ɋm�F����
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
	sf.startconfig = 1;
}
//���O�̏I�������ɒu���ւ���
kag.askOnClose=false;
var chose_novel = 1;	//�I�������肩, �O�̑I�����ɖ߂��\��
var in_scene_mode_button_mark = 0; //��z���[�h
var message_base = 'message'; //���b�Z�[�W���C���Ɠ����傫����
			     //�����摜


kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;
@endscript

@call storage=save_mode_init.ks
@call storage=exsystembutton.ks
@call storage=MoveMenu.ks
@call storage=TJSFunctions.ks
@call storage=KLayers.ks

@iscript
kag.lockSnapshot = function() {
	// �X�i�b�v�V���b�g�����b�N����
	// ���߂ăX�i�b�v�V���b�g�����b�N���ꂽ���_�ł̉�ʂ�ۑ�����
	if(snapshotLockCount == 0)
	{
		if(snapshotLayer === void)
			snapshotLayer = new Layer(this, primaryLayer);
		snapshotLayer.setImageSize(scWidth, scHeight);
		snapshotLayer.face = dfAlpha;
		


		//�X�i�b�v�V���b�g�ɕ\�����������Ȃ����C���[���\������Ă���ꍇ�A�ꎞ�I�ɔ�\���ɂ��܂��B
		MoveMenu_object.setObjProp(MoveMenu_object.foreButtons, 'visible', false);
		exsystembutton_object.setObjProp(exsystembutton_object.foreButtons, 'visible', false);
		
		var mes0 = false;
		var lay0 = false;
		
		if (kag.fore.messages[0].visible)
		{
			mes0 = true;
			kag.fore.messages[0].visible = false;
		}
		if (kag.fore.layers[0].visible) //���C��0�Ƀ��b�Z�[�W�g��\�����Ă�̂�
		{
			lay0 = true;
			kag.fore.layers[0].visible = false;
		}
		//�X�i�b�v�V���b�g�쐬
		snapshotLayer.piledCopy(0, 0, kag.fore.base, 0, 0, scWidth, scHeight);
		



		//���C���[�̕\����Ԃ����ɖ߂��܂��B
		if (mes0)
		{
			kag.fore.messages[0].visible = true;
		}
		if (lay0)
		{
			kag.fore.layers[0].visible = true;
		}
		//foreSeen�́A�{�^�����{���\�����ł��������ǂ������L�^���Ă���
		MoveMenu_object.setObjProp(MoveMenu_object.foreButtons, 'visible', MoveMenu_object.foreSeen);
		exsystembutton_object.setObjProp(exsystembutton_object.foreButtons, 'visible', exsystembutton_object.foreSeen);
	}
		snapshotLockCount ++;
} incontextof kag;

kag.onMouseMove=function(x, y, shift){
	with(MoveMenu_object)
	{
		if (.move_menuon && sf.menu_mode == 0)
		{
			if (kag.fore.messages[0].visible == true && kag.historyLayer.visible == false && kag.inStable)
			{
				//�}�E�X�C�x���g�œn�����x��y�̒l�̓E�B���h�E���[�h���ƃt���X�N���[�����[�h���ňقȂ�
				//fore.base.cursorX��fore.base.cursorY�ɂ̓E�B���h�E���[�h���ł��t���X�N���[�����[�h���ł������l������
				x = fore.base.cursorX, y = fore.base.cursorY;
				
				if ( 
					( ( .position == 'right') && ( x >= kag.scWidth - .foreButtons[0].width) && ( x <= kag.scWidth - 10 ) && ( y <= .foreButtons[0].height*.foreButtons.count) ) || 
					( ( .position == 'top' ) && (y <= .foreButtons[0].height) && (y >= 10) )
				   )
				{
					.setOptions(%['forevisible'=>'true','backvisible'=>'true']);
				}
				else
				{
					.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
				}
			}
		}
	}
} incontextof kag;
@endscript

;���b�Z�[�W���C���𓧖���
@position page=fore layer=message0 opacity=0
@position page=back layer=message0 opacity=0
;���b�Z�[�W�g��ݒ�
@image layer=0 storage=&message_base page=fore opacity=&sf.messageopacity left=&kag.fore.messages[0].left top=&kag.fore.messages[0].top
@image layer=0 storage=&message_base page=back opacity=&sf.messageopacity left=&kag.fore.messages[0].left top=&kag.fore.messages[0].top
@layopt layer=0 page=fore autohide=true index=999999
@layopt layer=0 page=back autohide=true index=999999



;�}�N���ݒ�

; �󋵂ɍ��킹�ĉE�N���b�N�ݒ�
@macro name=set_rclick        
; �}�E�X�I�����j���[
@rclick enabled=true call=false jump=false cond="kag.canStore() && sf.menu_mode==0"
; �ʏ�{�^�����j���[
@rclick enabled=true call=false jump=false cond="kag.canStore() && sf.menu_mode==2"
; �E�N���b�N���j���[
@rclick enabled=true call=true  jump=false storage=Menu.ks target="*rclick" cond="kag.canStore() && sf.menu_mode==1"
; �^�C�g��
@rclick enabled=false cond="!kag.canStore()"
@endmacro

; �󋵂ɍ��킹�ă��j���[�ݒ�
@macro name=set_menu
@set_rclick
@eval exp="MoveMenu_object.move_menuon = sf.menu_mode == 0 && kag.canStore() ? 1 : 0"
@exsysbtopt forevisible=true backvisible=true cond="sf.menu_mode == 2 && kag.canStore()"
@exsysbtopt forevisible=false backvisible=false cond="sf.menu_mode != 2 || !kag.canStore()"
@endmacro

; ���j���[����������
@macro name=unset_menu
@rclick enabled=false
@eval exp="MoveMenu_object.move_menuon = 0"
@exsysbtopt forevisible=false backvisible=false
@endmacro

; �󋵂ɍ��킹�ĉE�N���b�N�܂��̓��j���[����߂�
@macro name=myreturn        
@return cond="!kag.canStore() || sf.menu_mode == 0 || sf.menu_mode == 2"
@jump storage=Menu.ks target=*rclick_return cond="sf.menu_mode == 1"
@endmacro

; ��z���[�h�p�Ƀ{�^���𖳌�������
@macro name=in_scene_mode_button        
@eval exp="in_scene_mode_button_mark=1"
@endmacro

; ��z���[�h�p�ɖ����������{�^����L��������
; �^�C�g����ʂȂǁA��z���[�h����߂�ꏊ�ɂ�����
@macro name=out_scene_mode_button        
@eval exp="in_scene_mode_button_mark=0"
@endmacro

;���b�Z�[�W���C���̓����x��ݒ肵�A�\������
@macro name=set_messageopacity
@layopt layer=0 page=fore visible=true opacity=&sf.messageopacity cond="kag.canStore()"
@layopt layer=0 page=back visible=true opacity=&sf.messageopacity cond="kag.canStore()"
@endmacro
; laycount�̑�p
@macro name=laycount2
@laycount *
@layopt layer=0 page=fore autohide=true index=999999
@layopt layer=0 page=back autohide=true index=999999
@endmacro

@return

;�E�N���b�N�T�u���[�`��
*rclick
@eval exp="kag.skipMode_rclick = false"
@rclick enabled=true jump=true storage=Menu.ks target=*rclick_return
@history enabled=false output=false
@sysbtopt forevisible=true
;@if exp="typeof(global.MoveMouseCursorPlugin_object) != 'undefined'"
;	@MoveCursor time=100 x=750 y=10 cond="MoveMenu_object.position=='right'"
;	@MoveCursor time=100 x=30  y=10 cond="MoveMenu_object.position=='top'"
;@else
	@eval exp="kag.fore.base.cursorX=kag.scWidth - MoveMenu_object.foreButtons[0].width/2, kag.fore.base.cursorY=10" cond="MoveMenu_object.position=='right'"
	@eval exp="kag.fore.base.cursorX=MoveMenu_object.foreButtons[0].width/2, kag.fore.base.cursorY=10" cond="MoveMenu_object.position=='top'"
;@endif
@s

*auto
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_rclick
@eval exp="kag.enterAutoMode()"
@return

*skip
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_rclick
@eval exp="kag.skipMode_rclick = true"
@return		

*return
@if exp="kag.historyOfStore.count==0"
	@myreturn
@else
	@if exp="sf.returnAsk==1"
		@if exp="askYesNo('1�O�̑I�����ɖ߂�܂����H')"
			@goback ask=false
		@else
			@myreturn
		@endif
	@else
		@goback ask=false
	@endif
@endif

*hide
@iscript
	kag.fore.layers[0].visible=false;
	var i;
	var elm = %["visible" => false];
	// �S�Ẵ��b�Z�[�W���C�����\���ɂ��܂�
	for(i=0;i<kag.numMessageLayers;i++)
		kag.fore.messages[i].setOptions(elm);
	MoveMenu_object.setOptions(%['forevisible'=>'false','backvisible'=>'false']);
@endscript
@l
@iscript
	kag.fore.messages[0].visible = true;
	kag.fore.layers[0].visible=true;
	MoveMenu_object.setOptions(%['forevisible'=>'true','backvisible'=>'true']);
@endscript
@myreturn

*qload
@myreturn cond="kag.getBookMarkPageName(0) == '(���ݒ�)'"
@if exp="sf.qloadAsk==1"
	@if exp="!askYesNo('�N�C�b�N���[�h���܂����H')"
		@myreturn
	@endif
@endif
@cm
@load place=0

*title
@if exp="sf.titleAsk"
	@if exp="askYesNo('�^�C�g���ɖ߂�܂���?')"
		@gotostart ask=false
	@else
		@myreturn
	@endif
@else
		@gotostart ask=false
@endif

*exit
@eval exp="kag.closeByScript(%[ask:false])"

*rclick_return
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_menu
@return

