;�J�n���̏���
*config_sub_start
; �߂邽�߂Ɍ��݂̃��j���[�̐ݒ��ۑ�
@eval exp="tf.pre_menu_mode = sf.menu_mode"
@iscript
config_plugin_obj.button_01 = kag.fullScreened; // #0: �E�B�h�E���[�h
config_plugin_obj.button_02 = sf.titleAsk; // #1: �^�C�g���ɖ߂���m�F���邩
config_plugin_obj.button_03 = sf.exitAsk; // #2: �Q�[���I�����m�F���邩
config_plugin_obj.button_04 = sf.qloadAsk; // #3: �N�C�b�N���[�h���Ɋm�F���邩
config_plugin_obj.button_05 = sf.returnAsk; // #4: �O�̑I�����ɖ߂�Ŋm�F���邩
config_plugin_obj.button_06 = sf.saveAsk; // #5: �Z�[�u�㏑�����Ɋm�F���邩
config_plugin_obj.button_07 = sf.loadAsk; // #6: ���[�h���Ɋm�F���邩
config_plugin_obj.button_08 = sf.pagebreak; // #7:�u�y�[�W���܂ň�x�ɕ\���v
config_plugin_obj.button_09 = sf.sceneskip; // #8: �V�[�����̃X�L�b�v�����邩
config_plugin_obj.button_10 = sf.autocontinue; // #9: �I��������I�[�g���[�h���p�����邩
config_plugin_obj.button_11 = sf.skipcontinue; // #10: �I��������X�L�b�v���[�h���p�����邩
config_plugin_obj.button_12 = sf.menu_mode == 0; // #11: �}�E�X�I�����j���[���g�p����
config_plugin_obj.button_13 = sf.menu_mode == 1; // #12: �E�N���b�N���j���[���g�p����
config_plugin_obj.button_14 = sf.menu_mode == 2; // #13: �V�X�e�����j���[���g�p����

config_plugin_obj.slider_01 = kag.bgm.buf1.volume2 / 100000;
config_plugin_obj.slider_02 = kag.se[0].volume2 / 100000;
config_plugin_obj.slider_03 = (100 - kag.chSpeed)/100;
config_plugin_obj.slider_04 = (2000 - kag.autoModePageWait)/2000;
config_plugin_obj.slider_05 = sf.messageopacity / 255;
@endscript

@return


;�I�����̏���
;�E�N���b�N�̐ݒ�������ł���
*config_sub_close
@iscript
// �ϐ��̕ύX�𔽉f����
sf.titleAsk		=	config_plugin_obj.button_02; // #1: �^�C�g���ɖ߂���m�F���邩
sf.exitAsk		=	config_plugin_obj.button_03; // #2: �Q�[���I�����m�F���邩
sf.qloadAsk		=	config_plugin_obj.button_04; // #3: �N�C�b�N���[�h���Ɋm�F���邩
sf.returnAsk		=	config_plugin_obj.button_05; // #4: �O�̑I�����ɖ߂�Ŋm�F���邩
sf.saveAsk		=	config_plugin_obj.button_06; // #5: �Z�[�u�㏑�����Ɋm�F���邩
sf.loadAsk		=	config_plugin_obj.button_07; // #6: ���[�h���Ɋm�F���邩
sf.pagebreak		=	config_plugin_obj.button_08; // #7:�u�y�[�W���܂ň�x�ɕ\���v
sf.sceneskip		=	config_plugin_obj.button_09; // #8: �V�[�����̃X�L�b�v�����邩
sf.autocontinue		=	config_plugin_obj.button_10; // #9: �I��������I�[�g���[�h���p�����邩
sf.skipcontinue		=	config_plugin_obj.button_11; // #10: �I��������X�L�b�v���[�h���p�����邩
@endscript

@set_menu
; ���b�Z�[�W�����̏o�́E�\����L���ɂ��܂�
@history output=true enabled=true cond="kag.canStore()"
; ���b�Z�[�W�\�����x�̐ݒ�𔽉f���܂�
@delay speed=user cond="kag.chUserMode"

@return


;�e�T�u���[�`���ύX�𑦍��ɔ��f�������Ƃ��͂����ɋL�q����
*config_sub_button_01
; �E�B���h�E���[�h�́u�t���X�N���[���v���N���b�N�������Ɏ��s�����X�N���v�g
@eval exp="kag.fullScreened ? kag.onWindowedMenuItemClick() : kag.onFullScreenMenuItemClick()"
@jump storage=config.ks target=*return

*config_sub_button_02
@jump storage=config.ks target=*return
*config_sub_button_03
@jump storage=config.ks target=*return
*config_sub_button_04
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
@jump storage=config.ks target=*return
*config_sub_button_10
@jump storage=config.ks target=*return
*config_sub_button_11
@jump storage=config.ks target=*return
*config_sub_button_12
;���W�I�{�^���ɂ��邽�߂�
;���̏�ő��̃{�^����ύX����
;�z��̐����͂ЂƂ���Ă���̂Œ���
@eval exp="sf.menu_mode=0 if config_plugin_obj.button_12"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_14 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_13
@eval exp="sf.menu_mode=1 if config_plugin_obj.button_13"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_14 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_14
@eval exp="sf.menu_mode=2 if config_plugin_obj.button_14"
@eval exp="config_plugin_obj.button_12 = tf.config_togglebutton[11].checked=sf.menu_mode == 0"
@eval exp="config_plugin_obj.button_13 = tf.config_togglebutton[12].checked=sf.menu_mode == 1"
@eval exp="config_plugin_obj.button_14 = tf.config_togglebutton[13].checked=sf.menu_mode == 2"
@eval exp="tf.config_togglebutton[11].draw()"
@eval exp="tf.config_togglebutton[12].draw()"
@eval exp="tf.config_togglebutton[13].draw()"
@jump storage=config.ks target=*return
*config_sub_button_15
@jump storage=config.ks target=*return
*config_sub_button_16
@jump storage=config.ks target=*return
*config_sub_button_17
@jump storage=config.ks target=*return
*config_sub_button_18
@jump storage=config.ks target=*return
*config_sub_button_19
@jump storage=config.ks target=*return
*config_sub_button_20
@jump storage=config.ks target=*return
*config_sub_button_21
@jump storage=config.ks target=*return
*config_sub_button_22
@jump storage=config.ks target=*return
*config_sub_button_23
@jump storage=config.ks target=*return
*config_sub_button_24
@jump storage=config.ks target=*return
*config_sub_button_25
@jump storage=config.ks target=*return
*config_sub_button_26
@jump storage=config.ks target=*return
*config_sub_button_27
@jump storage=config.ks target=*return
*config_sub_button_28
@jump storage=config.ks target=*return
*config_sub_button_29
@jump storage=config.ks target=*return
*config_sub_button_30
@jump storage=config.ks target=*return
*config_sub_button_31
@jump storage=config.ks target=*return
*config_sub_button_32
@jump storage=config.ks target=*return
*config_sub_button_33
@jump storage=config.ks target=*return
*config_sub_button_34
@jump storage=config.ks target=*return
*config_sub_button_35
@jump storage=config.ks target=*return
*config_sub_button_36
@jump storage=config.ks target=*return
*config_sub_button_37
@jump storage=config.ks target=*return
*config_sub_button_38
@jump storage=config.ks target=*return
*config_sub_button_39
@jump storage=config.ks target=*return
*config_sub_button_40
@jump storage=config.ks target=*return
*config_sub_button_41
@jump storage=config.ks target=*return
*config_sub_button_42
@jump storage=config.ks target=*return
*config_sub_button_43
@jump storage=config.ks target=*return
*config_sub_button_44
@jump storage=config.ks target=*return
*config_sub_button_45
@jump storage=config.ks target=*return

;�X���C�_�[�p�T�u���[�`��
*config_sub_slider_01
@bgmopt gvolume="&config_plugin_obj.slider_01*100"
@eval exp="sf.bgmvolume = kag.bgm.buf1.volume2"
@jump storage=config.ks target=*return
*config_sub_slider_02
@seopt gvolume="&config_plugin_obj.slider_02*100"
@eval exp="&sf.sevolume = kag.se[0].volume2"
@jump storage=config.ks target=*return
*config_sub_slider_03
@eval exp="kag.userChSpeed=100 - config_plugin_obj.slider_03*100"
@jump storage=config.ks target=*return
*config_sub_slider_04
@eval exp="&kag.autoModePageWait = 2000 -  config_plugin_obj.slider_04 * 2000;"
@eval exp="&kag.autoModeLineWait = 1000 -  config_plugin_obj.slider_04 * 1000;"
@jump storage=config.ks target=*return
*config_sub_slider_05
@eval exp="&sf.messageopacity = (config_plugin_obj.slider_05 * 255)"
@eval exp="&SetMessageOpacity_object.foreLay.opacity = sf.messageopacity"
@eval exp="&SetMessageOpacity_object.backLay.opacity = sf.messageopacity"
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
*config_sub_slider_30
@jump storage=config.ks target=*return
