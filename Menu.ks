@iscript
var chose_novel = 1;	//�I�������肩, �O�̑I�����ɖ߂��\��
var in_scene_mode_button_mark = 0; //��z���[�h
@endscript

@call storage=SetMessageOpacity.ks
@call storage=save_mode_init.ks
@call storage=config_init.ks
@call storage=exsystembutton.ks
@call storage=MoveMenu.ks
@call storage=TJSFunctions.ks
@call storage=KLayers.ks

@iscript
//exsystembutton_object��MoveMenu_object����������v���O�C��
class MenuPlugin extends KAGPlugin{
	//2�̌�ɌĂ΂�Ȃ��Ƃ܂����񂾂��A�o�^���ɌĂ΂��̂��H
	function onRestore(elm, clear, tempelm){
		//�󋵂ɍ��킹�ĉE�N���b�N��ݒ�
		if  ( kag.canStore() && (sf.menu_mode == 0 || sf.menu_mode == 2) ){
		//�}�E�X�I���܂��̓V�X�e�����j���[���L���Ȃ�A�E�N���b�N�Ŕw�i��\��
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => false, 'jump' => false]);
		}else if (kag.canStore() && sf.menu_mode == 1){
		//�E�N���b�N���j���[���L���Ȃ�A�E�N���b�N�Ń��j���[�\��
			kag.tagHandlers.rclick(%['enabled' => true, 'call' => true, 'jump' => false, 'storage' => 'Menu.ks', 'target' => '*rclick']);
		}else if (!kag.canStore()){
		//�Z�[�u�s�Ȃ�^�C�g���Ɣ��f���ĉE�N���b�N�֎~
			kag.tagHandlers.rclick(%['enabled' => false]);
		}
		//�}�E�X�I�����j���[��ݒ�
		MoveMenu_object.move_menuon = sf.menu_mode == 0 && kag.canStore() ? 1 : 0;
		//�V�X�e�����j���[��ݒ�
		if (kag.canStore() && sf.menu_mode == 2) exsystembutton_object.setOptions(%['forevisible'=>true, 'backvisible'=>true]);
		if (sf.menu_mode != 2) exsystembutton_object.setOptions(%['forevisible'=>false, 'backvisible'=>false]);
	}
}
kag.addPlugin(global.Menu_object = new MenuPlugin());
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
		SetMessageOpacity_object.foreLay.visible=false;
		
		var mes0 = false;
		
		if (kag.fore.messages[0].visible)
		{
			mes0 = true;
			kag.fore.messages[0].visible = false;
		}
		//�X�i�b�v�V���b�g�쐬
		snapshotLayer.piledCopy(0, 0, kag.fore.base, 0, 0, scWidth, scHeight);
		
		//���C���[�̕\����Ԃ����ɖ߂��܂��B
		if (mes0)
		{
			kag.fore.messages[0].visible = true;
		}
		//foreSeen�́A�{�^�����{���\�����ł��������ǂ������L�^���Ă���
		MoveMenu_object.setObjProp(MoveMenu_object.foreButtons, 'visible', MoveMenu_object.foreSeen);
		exsystembutton_object.setObjProp(exsystembutton_object.foreButtons, 'visible', exsystembutton_object.foreSeen);
		SetMessageOpacity_object.setOptions(%[visible:SetMessageOpacity_object.foreSeen]);
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
@SetMessageOpacity page=fore visible=false opacity=&sf.messageopacity
@SetMessageOpacity page=back visible=false opacity=&sf.messageopacity



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

@return

;�E�N���b�N�T�u���[�`��----------------------------------------------------- 
*rclick
@eval exp="kag.skipMode_rclick = false"
@rclick enabled=true jump=true storage=Menu.ks target=*rclick_return
@history enabled=false output=false
@sysbtopt forevisible=true
@if exp="typeof(global.MoveMouseCursorPlugin_object) != 'undefined'"
	@MoveCursor time=100 x=750 y=10 cond="MoveMenu_object.position=='right'"
	@MoveCursor time=100 x=30  y=10 cond="MoveMenu_object.position=='top'"
@else
	@eval exp="kag.fore.base.cursorX=kag.scWidth - MoveMenu_object.foreButtons[0].width/2, kag.fore.base.cursorY=10" cond="MoveMenu_object.position=='right'"
	@eval exp="kag.fore.base.cursorX=MoveMenu_object.foreButtons[0].width/2, kag.fore.base.cursorY=10" cond="MoveMenu_object.position=='top'"
@endif
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
@goback ask=false
@myreturn

*hide
@iscript
	// �V�X�e���{�^�����g���Ă��āA���b�Z�[�W���C�����\������Ă��鎞�� onMessageHiddenStateChanged ���Ăяo���܂�
	if(typeof(global.exsystembutton_object) != "undefined")
		exsystembutton_object.onMessageHiddenStateChanged(true);
	if(typeof(global.MoveMenu_object) != "undefined")
		MoveMenu_object.onMessageHiddenStateChanged(true);
	if (typeof(global.SetMessageOpacity_object) != 'undefined')
		SetMessageOpacity_object.onMessageHiddenStateChanged(true);
	// �S�Ẵ��b�Z�[�W���C�����\���ɂ��܂�
	for(var i=0;i<kag.numMessageLayers;i++)
		kag.fore.messages[i].setOptions(%["visible" => false]);
@endscript
@p
@iscript
	kag.fore.messages[0].visible = true;
	if(typeof(global.exsystembutton_object) != "undefined" && sf.menu_mode == 2)
		exsystembutton_object.onMessageHiddenStateChanged(false);
	if (typeof(global.SetMessageOpacity_object) != 'undefined')
		SetMessageOpacity_object.onMessageHiddenStateChanged(false);
@endscript
@myreturn

*qsave
@if exp="sf.qsaveAsk"
	@if exp="!askYesNo('�N�C�b�N�Z�[�u���܂����H')"
		@myreturn
	@endif
@endif
@save place=0
@myreturn

*qload
@myreturn cond="kag.getBookMarkPageName(0) == '(���ݒ�)'"
@if exp="sf.qloadAsk"
	@if exp="!askYesNo('�N�C�b�N���[�h���܂����H')"
		@myreturn
	@endif
@endif
@cm
@load place=0

*title
@gotostart ask=true
@myreturn


*exit
@eval exp="kag.closeByScript(%[ask:false])"

*rclick_return
@sysbtopt forevisible=false
@history enabled=true output=true
@current layer=message0
@set_menu
@return

