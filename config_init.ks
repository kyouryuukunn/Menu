@return cond="typeof(global.config_plugin_obj) != 'undefined'"
@call storage=KLayers.ks

@iscript
if (sf.config_init === void)
{
//�����ݒ� ����̂ݐݒ肵�������ڂ�ݒ�
//���������������遫------------------------------------------------------- 
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
//���������������遪------------------------------------------------------- 
}

//���������������遫------------------------------------------------------- 
//���O�̏I�������ɒu���ւ���
kag.askOnClose=false;

kag.bgm.buf1.volume2 = sf.bgmvolume;
kag.se[0].volume2 = sf.sevolume;
//���������������遪------------------------------------------------------- 

//config_plugin�N���X�ɕK�v�ȕϐ��A�֐����܂Ƃ߂�
class config_plugin{


//���������������遫------------------------------------------------------- 
	//�����y�[�W���g���Ȃ��Ȃ�2�y�[�W�ڂ���󗓂ɂ���
	var back = ['config_bg', 'black', 'black'];  // 1, 2, 3�y�[�W�̔w�i(���������ɂ͒��O�̃Q�[����ʂ�\��)
	var slider_base = 'slider_base'; // �X���C�_�[�̔w�i
	var slider_tab = 'slider_tab';   // �X���C�_�[�̂܂�(�{�^���Ɠ����\��)
	var graphic = 'graphic';		//�g�O���{�^���̉摜���w��(�ڂ�����KLayers.txt��KToggleButtonLayer���Q��, basegraphic�͂���Ȃ����ۂ�)
	
	var close_button = 'config_close'; //����{�^��
	var close_x = kag.scWidth - 100;   //����{�^����x���W
	var close_y = kag.scHeight - 50;  //����{�^����y���W
	
	var nowpage = 1; //���݂̃y�[�W
	//�����y�[�W���g���Ȃ��Ȃ�K���ȉ摜���w�肵�Ĕ�\���ɂ���
	//(�g�O���{�^���Ɠ����`��)
	//�y�[�W1�̃{�^��
	var page1_button = 'graphic';  //�؁[�W1�{�^��
	var page1_visible = 0; //�؁[�W1�{�^����\�����邩
	var page1_pos = [kag.scWidth-300, 0];   //�؁[�W1�{�^���̍��W
	
	//�y�[�W2�̃{�^��
	var page2_button = 'graphic';  //�؁[�W2�{�^��
	var page2_visible = 0; 		   //�؁[�W2�{�^����\�����邩
	var page2_pos = [kag.scWidth-200, 0];   //�؁[�W2�{�^���̍��W
	
	//�y�[�W3�̃{�^��
	var page3_button = 'graphic';  //�؁[�W3�{�^��
	var page3_visible = 0; 		    //�؁[�W3�{�^����\�����邩
	var page3_pos = [kag.scWidth-100, 0];   //�؁[�W3�{�^���̍��W
	
	//�J�n���ɌĂ΂��T�u���[�`��
	var start_sub_label	= '*config_sub_start'; //���x����
	var start_sub_storage	= 'config_sub.ks'; //�t�@�C����
	//�I�����ɌĂ΂��T�u���[�`��
	var close_sub_label	= '*config_sub_close'; //���x����
	var close_sub_storage	= 'config_sub.ks'; //�t�@�C����
	
	// �e�{�^���A�X���C�_�[�̑��삷��ϐ�
	//�{�^����1�y�[�W15�Â�
	//�X���C�_�[��1�؁[�W10�Â���
	
	// �{�^���̓g�O���{�^���ɍ��킹��0��1���Ƃ�
	//1�y�[�W��
	var button_00 = 0;
	var button_01 = 0;
	var button_02 = 0;
	var button_03 = 0;
	var button_04 = 0;
	var button_05 = 0;
	var button_06 = 0;
	var button_07 = 0;
	var button_08 = 0;
	var button_09 = 0;
	var button_10 = 0;
	var button_11 = 0;
	var button_12 = 0;
	var button_13 = 0;
	var button_14 = 0;
	//2�y�[�W��
	var button_15 = 0;
	var button_16 = 0;
	var button_17 = 0;
	var button_18 = 0;
	var button_19 = 0;
	var button_20 = 0;
	var button_21 = 0;
	var button_22 = 0;
	var button_23 = 0;
	var button_24 = 0;
	var button_25 = 0;
	var button_26 = 0;
	var button_27 = 0;
	var button_28 = 0;
	var button_29 = 0;
	//3�y�[�W��
	var button_30 = 0;
	var button_31 = 0;
	var button_32 = 0;
	var button_33 = 0;
	var button_34 = 0;
	var button_35 = 0;
	var button_36 = 0;
	var button_37 = 0;
	var button_38 = 0;
	var button_39 = 0;
	var button_40 = 0;
	var button_41 = 0;
	var button_42 = 0;
	var button_43 = 0;
	var button_44 = 0;
	
	// �X���C�_�[�̑��삷��ϐ��́A
	//�X���C�_�[�ɍ��킹��0�`1�܂ŕω�����
	//1�y�[�W��
	var slider_00 = 0;
	var slider_01 = 0;
	var slider_02 = 0;
	var slider_03 = 0;
	var slider_04 = 0;
	var slider_05 = 0;
	var slider_06 = 0;
	var slider_07 = 0;
	var slider_08 = 0;
	var slider_09 = 0;
	//2�y�[�W��
	var slider_10 = 0;
	var slider_11 = 0;
	var slider_12 = 0;
	var slider_13 = 0;
	var slider_14 = 0;
	var slider_15 = 0;
	var slider_16 = 0;
	var slider_17 = 0;
	var slider_18 = 0;
	var slider_19 = 0;
	//3�y�[�W��
	var slider_20 = 0;
	var slider_21 = 0;
	var slider_22 = 0;
	var slider_23 = 0;
	var slider_24 = 0;
	var slider_25 = 0;
	var slider_26 = 0;
	var slider_27 = 0;
	var slider_28 = 0;
	var slider_29 = 0;

	//�e�{�^���A�X���C�_�[��\�����邩
	var button_visible = [
				 1,  //00 
				 1,  //01 
				 1,  //02 
				 1,  //03 
				 1,  //04 
				 1,  //05 
				 1,  //06 
				 1,  //07 
				 1,  //08 
				 1,  //09 
				 1,  //10 
				 1,  //11 
				 1,  //12 
				 1,  //13 
				 0,  //14 
				 0,  //15 
				 0,  //16 
				 0,  //17 
				 0,  //18 
				 0,  //19 
				 0,  //20 
				 0,  //21 
				 0,  //22 
				 0,  //23 
				 0,  //24 
				 0,  //25 
				 0,  //26 
				 0,  //27 
				 0,  //28 
				 0,  //29 
				 0,  //30 
				 0,  //31 
				 0,  //32 
				 0,  //33 
				 0,  //34 
				 0,  //35 
				 0,  //36 
				 0,  //37 
				 0,  //38 
				 0,  //39 
				 0,  //40 
				 0,  //41 
				 0,  //42 
				 0,  //43 
				 0   //44 
			];

	var slider_visible = [
				1,  //00
				1,  //01
				1,  //02
				1,  //03
				1,  //04
				0,  //05
				0,  //06
				0,  //07
				0,  //08
				0,  //09
				0,  //10
				0,  //11
				0,  //12
				0,  //13
				0,  //14
				0,  //15
				0,  //16
				0,  //17
				0,  //18
				0,  //19
				0,  //20
				0,  //21
				0,  //22
				0,  //23
				0,  //24
				0,  //25
				0,  //26
				0,  //27
				0,  //28
				0   //29
			];

	// �e�{�^���A�X���C�_�[�̍��W��ݒ�
	var button_pos = [
				[340, 525],  //00
				[680, 435],  //01
				[680, 475],  //02
				[420, 435],  //03
				[420, 475],  //04
				[140, 435],  //05
				[140, 475],  //06
				[740, 165],  //07
				[740, 205],  //08
				[390, 165],  //09
				[390, 200],  //10
				[570, 305],  //11
				[570, 355],  //12
				[750, 305],  //13
				[0, 0],      //14
				[0, 0],      //15
				[0, 0],      //16
				[0, 0],      //17
				[0, 0],      //18
				[0, 0],      //19
				[0, 0],      //20
				[0, 0],      //21
				[0, 0],      //22
				[0, 0],      //23
				[0, 0],      //24
				[0, 0],      //25
				[0, 0],      //26
				[0, 0],      //27
				[0, 0],      //28
				[0, 0],      //29
				[0, 0],      //30
				[0, 0],      //31
				[0, 0],      //32
				[0, 0],      //33
				[0, 0],      //34
				[0, 0],      //35
				[0, 0],      //36
				[0, 0],      //37
				[0, 0],      //38
				[0, 0],      //39
				[0, 0],      //40
				[0, 0],      //41
				[0, 0],      //42
				[0, 0],      //43
				[0, 0]       //44
			];
	
	var slider_pos = [
				[190, 305],  //00
				[190, 345],  //01
				[450, 70],   //02
				[450, 100],  //03
				[450, 130],  //04
				[0, 0],      //05
				[0, 0],      //06
				[0, 0],      //07
				[0, 0],      //08
				[0, 0],      //09
				[0, 0],      //10
				[0, 0],      //11
				[0, 0],      //12
				[0, 0],      //13
				[0, 0],      //14
				[0, 0],      //15
				[0, 0],      //16
				[0, 0],      //17
				[0, 0],      //18
				[0, 0],      //19
				[0, 0],      //20
				[0, 0],      //21
				[0, 0],      //22
				[0, 0],      //23
				[0, 0],      //24
				[0, 0],      //25
				[0, 0],      //26
				[0, 0],      //27
				[0, 0],      //28
				[0, 0]       //29
			];
//���������������遪------------------------------------------------------- 
	
	//�X���C�_�[�����삳��鎞��
	//�Ăт������֐�(�����K�v�Ȃ�ݒ肷��)
	function slider_func_00(hval,vval,drag) {slider_00 = hval;}
	function slider_func_01(hval,vval,drag) {slider_01 = hval;}
	function slider_func_02(hval,vval,drag) {slider_02 = hval;}
	function slider_func_03(hval,vval,drag) {slider_03 = hval;}
	function slider_func_04(hval,vval,drag) {slider_04 = hval;}
	function slider_func_05(hval,vval,drag) {slider_05 = hval;}
	function slider_func_06(hval,vval,drag) {slider_06 = hval;}
	function slider_func_07(hval,vval,drag) {slider_07 = hval;}
	function slider_func_08(hval,vval,drag) {slider_08 = hval;}
	function slider_func_09(hval,vval,drag) {slider_09 = hval;}
	function slider_func_10(hval,vval,drag) {slider_10 = hval;}
	function slider_func_11(hval,vval,drag) {slider_11 = hval;}
	function slider_func_12(hval,vval,drag) {slider_12 = hval;}
	function slider_func_13(hval,vval,drag) {slider_13 = hval;}
	function slider_func_14(hval,vval,drag) {slider_14 = hval;}
	function slider_func_15(hval,vval,drag) {slider_15 = hval;}
	function slider_func_16(hval,vval,drag) {slider_16 = hval;}
	function slider_func_17(hval,vval,drag) {slider_17 = hval;}
	function slider_func_18(hval,vval,drag) {slider_18 = hval;}
	function slider_func_19(hval,vval,drag) {slider_19 = hval;}
	function slider_func_20(hval,vval,drag) {slider_20 = hval;}
	function slider_func_21(hval,vval,drag) {slider_21 = hval;}
	function slider_func_22(hval,vval,drag) {slider_22 = hval;}
	function slider_func_23(hval,vval,drag) {slider_23 = hval;}
	function slider_func_24(hval,vval,drag) {slider_24 = hval;}
	function slider_func_25(hval,vval,drag) {slider_25 = hval;}
	function slider_func_26(hval,vval,drag) {slider_26 = hval;}
	function slider_func_27(hval,vval,drag) {slider_27 = hval;}
	function slider_func_28(hval,vval,drag) {slider_28 = hval;}
	function slider_func_29(hval,vval,drag) {slider_29 = hval;}
}

var config_plugin_obj = new config_plugin();
@endscript

@return
