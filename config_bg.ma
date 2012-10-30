
; autodisable を false にすることで、クリッカブルマップをクリックしても、
; クリッカブルマップが無効にならないようにします（何回でもクリックできるようにします）
0: autodisable = false;

;autocontinue
13: storage = "config.ks"; target = "*autocontinue"; onenter="kag.fore.layers[12].setPos(410 ,165);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;skipcontinue
5: storage = "config.ks"; target = "*skipcontinue"; onenter="kag.fore.layers[12].setPos(410 ,200);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;pagebreak
6: storage = "config.ks"; target = "*pagebreak"; onenter="kag.fore.layers[12].setPos(740, 165);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;sceneskip
11: storage = "config.ks"; target = "*sceneskip"; onenter="kag.fore.layers[12].setPos(740 ,205);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;menu0
1: storage = "config.ks"; target = "*menu0"; onenter="kag.fore.layers[12].setPos(590 ,305);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;menu1
3: storage = "config.ks"; target = "*menu1"; onenter="kag.fore.layers[12].setPos(590 ,355);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;menu2
10: storage = "config.ks"; target = "*menu2"; onenter="kag.fore.layers[12].setPos(770 ,305);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;saveAsk
8: storage = "config.ks"; target = "*saveAsk"; onenter="kag.fore.layers[12].setPos(160 ,435);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;loadAsk
12: storage = "config.ks"; target = "*loadAsk"; onenter="kag.fore.layers[12].setPos(160 ,475);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;qloadAsk
4: storage = "config.ks"; target = "*qloadAsk"; onenter="kag.fore.layers[12].setPos(440 ,435);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;returnAsk
2: storage = "config.ks"; target = "*returnAsk"; onenter="kag.fore.layers[12].setPos(440 ,475);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;titleAsk
9: storage = "config.ks"; target = "*titleAsk"; onenter="kag.fore.layers[12].setPos(700 ,435);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;exitAsk
7: storage = "config.ks"; target = "*exitAsk"; onenter="kag.fore.layers[12].setPos(700, 475);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;windowmode
15: storage = "config.ks"; target = "*windowmode"; onenter="kag.fore.layers[12].setPos(440 ,525);kag.fore.layers[12].visible=true"; onleave="kag.fore.layers[12].visible=false";

;back
14: storage = "config.ks"; target = "*back"; onenter = "kag.fore.layers[11].visible = true"; onleave = "kag.fore.layers[11].visible = false";

