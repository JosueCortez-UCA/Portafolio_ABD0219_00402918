drop table if exists muchosclientes;
drop table if exists muchosusuarios;

CREATE TABLE muchosclientes (
    id integer NOT NULL,
    nombre character varying(45) NOT NULL,
    apellidos character varying(45) NOT NULL,
    email character varying(50),
    direccion1 character varying(50) NOT NULL,
    direccion2 character varying(50),
    distrito character varying(20) NOT NULL,
    id_ciudad smallint NOT NULL,
    telefono character varying(20) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    creacion date DEFAULT ('now'::text)::date NOT NULL,
    ultima_actualizacion timestamp without time zone DEFAULT now() NOT NULL,
    constraint pk_muchosclientes primary key (id)
);

COPY muchosclientes (id,nombre,apellidos,email,direccion1,direccion2,distrito,id_ciudad,telefono,activo,creacion,ultima_actualizacion) FROM stdin;
524	Jared	Ely	jared.ely@sakilacustomer.org	1003 Qinhuangdao Street		West Java	419	35533115997	t	2006-02-14	2013-05-26 14:49:45.738
1	Mary	Smith	mary.smith@sakilacustomer.org	1913 Hanoi Way		Nagasaki	463	28303384290	t	2006-02-14	2013-05-26 14:49:45.738
2	Patricia	Johnson	patricia.johnson@sakilacustomer.org	1121 Loja Avenue		California	449	838635286649	t	2006-02-14	2013-05-26 14:49:45.738
3	Linda	Williams	linda.williams@sakilacustomer.org	692 Joliet Street		Attika	38	448477190408	t	2006-02-14	2013-05-26 14:49:45.738
4	Barbara	Jones	barbara.jones@sakilacustomer.org	1566 Inegl Manor		Mandalay	349	705814003527	t	2006-02-14	2013-05-26 14:49:45.738
5	Elizabeth	Brown	elizabeth.brown@sakilacustomer.org	53 Idfu Parkway		Nantou	361	10655648674	t	2006-02-14	2013-05-26 14:49:45.738
6	Jennifer	Davis	jennifer.davis@sakilacustomer.org	1795 Santiago de Compostela Way		Texas	295	860452626434	t	2006-02-14	2013-05-26 14:49:45.738
7	Maria	Miller	maria.miller@sakilacustomer.org	900 Santiago de Compostela Parkway		Central Serbia	280	716571220373	t	2006-02-14	2013-05-26 14:49:45.738
8	Susan	Wilson	susan.wilson@sakilacustomer.org	478 Joliet Way		Hamilton	200	657282285970	t	2006-02-14	2013-05-26 14:49:45.738
9	Margaret	Moore	margaret.moore@sakilacustomer.org	613 Korolev Drive		Masqat	329	380657522649	t	2006-02-14	2013-05-26 14:49:45.738
10	Dorothy	Taylor	dorothy.taylor@sakilacustomer.org	1531 Sal Drive		Esfahan	162	648856936185	t	2006-02-14	2013-05-26 14:49:45.738
11	Lisa	Anderson	lisa.anderson@sakilacustomer.org	1542 Tarlac Parkway		Kanagawa	440	635297277345	t	2006-02-14	2013-05-26 14:49:45.738
12	Nancy	Thomas	nancy.thomas@sakilacustomer.org	808 Bhopal Manor		Haryana	582	465887807014	t	2006-02-14	2013-05-26 14:49:45.738
13	Karen	Jackson	karen.jackson@sakilacustomer.org	270 Amroha Parkway		Osmaniye	384	695479687538	t	2006-02-14	2013-05-26 14:49:45.738
14	Betty	White	betty.white@sakilacustomer.org	770 Bydgoszcz Avenue		California	120	517338314235	t	2006-02-14	2013-05-26 14:49:45.738
15	Helen	Harris	helen.harris@sakilacustomer.org	419 Iligan Lane		Madhya Pradesh	76	990911107354	t	2006-02-14	2013-05-26 14:49:45.738
16	Sandra	Martin	sandra.martin@sakilacustomer.org	360 Toulouse Parkway		England	495	949312333307	t	2006-02-14	2013-05-26 14:49:45.738
17	Donna	Thompson	donna.thompson@sakilacustomer.org	270 Toulon Boulevard		Kalmykia	156	407752414682	t	2006-02-14	2013-05-26 14:49:45.738
18	Carol	Garcia	carol.garcia@sakilacustomer.org	320 Brest Avenue		Kaduna	252	747791594069	t	2006-02-14	2013-05-26 14:49:45.738
19	Ruth	Martinez	ruth.martinez@sakilacustomer.org	1417 Lancaster Avenue		Northern Cape	267	272572357893	t	2006-02-14	2013-05-26 14:49:45.738
20	Sharon	Robinson	sharon.robinson@sakilacustomer.org	1688 Okara Way		Nothwest Border Prov	327	144453869132	t	2006-02-14	2013-05-26 14:49:45.738
21	Michelle	Clark	michelle.clark@sakilacustomer.org	262 A Corua (La Corua) Parkway		Dhaka	525	892775750063	t	2006-02-14	2013-05-26 14:49:45.738
22	Laura	Rodriguez	laura.rodriguez@sakilacustomer.org	28 Charlotte Amalie Street		Rabat-Sal-Zammour-Z	443	161968374323	t	2006-02-14	2013-05-26 14:49:45.738
23	Sarah	Lewis	sarah.lewis@sakilacustomer.org	1780 Hino Boulevard		Liepaja	303	902731229323	t	2006-02-14	2013-05-26 14:49:45.738
24	Kimberly	Lee	kimberly.lee@sakilacustomer.org	96 Tafuna Way		Crdoba	128	934730187245	t	2006-02-14	2013-05-26 14:49:45.738
25	Deborah	Walker	deborah.walker@sakilacustomer.org	934 San Felipe de Puerto Plata Street		Sind	472	196495945706	t	2006-02-14	2013-05-26 14:49:45.738
26	Jessica	Hall	jessica.hall@sakilacustomer.org	18 Duisburg Boulevard			121	998009777982	t	2006-02-14	2013-05-26 14:49:45.738
27	Shirley	Allen	shirley.allen@sakilacustomer.org	217 Botshabelo Place		Southern Mindanao	138	665356572025	t	2006-02-14	2013-05-26 14:49:45.738
28	Cynthia	Young	cynthia.young@sakilacustomer.org	1425 Shikarpur Manor		Bihar	346	678220867005	t	2006-02-14	2013-05-26 14:49:45.738
29	Angela	Hernandez	angela.hernandez@sakilacustomer.org	786 Aurora Avenue		Yamaguchi	474	18461860151	t	2006-02-14	2013-05-26 14:49:45.738
30	Melissa	King	melissa.king@sakilacustomer.org	1668 Anpolis Street		Taipei	316	525255540978	t	2006-02-14	2013-05-26 14:49:45.738
31	Brenda	Wright	brenda.wright@sakilacustomer.org	33 Gorontalo Way		West Bengali	257	745994947458	t	2006-02-14	2013-05-26 14:49:45.738
32	Amy	Lopez	amy.lopez@sakilacustomer.org	176 Mandaluyong Place		Uttar Pradesh	239	627705991774	t	2006-02-14	2013-05-26 14:49:45.738
33	Anna	Hill	anna.hill@sakilacustomer.org	127 Purnea (Purnia) Manor		Piemonte	17	911872220378	t	2006-02-14	2013-05-26 14:49:45.738
34	Rebecca	Scott	rebecca.scott@sakilacustomer.org	61 Tama Street		Okayama	284	708403338270	t	2006-02-14	2013-05-26 14:49:45.738
35	Virginia	Green	virginia.green@sakilacustomer.org	391 Callao Drive		Midi-Pyrnes	544	440512153169	t	2006-02-14	2013-05-26 14:49:45.738
36	Kathleen	Adams	kathleen.adams@sakilacustomer.org	334 Munger (Monghyr) Lane		Markazi	31	481183273622	t	2006-02-14	2013-05-26 14:49:45.738
37	Pamela	Baker	pamela.baker@sakilacustomer.org	1440 Fukuyama Loop		Henan	362	912257250465	t	2006-02-14	2013-05-26 14:49:45.738
38	Martha	Gonzalez	martha.gonzalez@sakilacustomer.org	269 Cam Ranh Parkway		Chisinau	115	489783829737	t	2006-02-14	2013-05-26 14:49:45.738
39	Debra	Nelson	debra.nelson@sakilacustomer.org	306 Antofagasta Place		Esprito Santo	569	378318851631	t	2006-02-14	2013-05-26 14:49:45.738
40	Amanda	Carter	amanda.carter@sakilacustomer.org	671 Graz Street		Oriental	353	680768868518	t	2006-02-14	2013-05-26 14:49:45.738
41	Stephanie	Mitchell	stephanie.mitchell@sakilacustomer.org	42 Brindisi Place		Yerevan	586	42384721397	t	2006-02-14	2013-05-26 14:49:45.738
42	Carolyn	Perez	carolyn.perez@sakilacustomer.org	1632 Bislig Avenue		Nonthaburi	394	471675840679	t	2006-02-14	2013-05-26 14:49:45.738
43	Christine	Roberts	christine.roberts@sakilacustomer.org	1447 Imus Way		Tahiti	167	539758313890	t	2006-02-14	2013-05-26 14:49:45.738
44	Marie	Turner	marie.turner@sakilacustomer.org	1998 Halifax Drive		Lipetsk	308	177727722820	t	2006-02-14	2013-05-26 14:49:45.738
45	Janet	Phillips	janet.phillips@sakilacustomer.org	1718 Valencia Street		Antofagasta	27	675292816413	t	2006-02-14	2013-05-26 14:49:45.738
46	Catherine	Campbell	catherine.campbell@sakilacustomer.org	46 Pjatigorsk Lane		Moscow (City)	343	262076994845	t	2006-02-14	2013-05-26 14:49:45.738
47	Frances	Parker	frances.parker@sakilacustomer.org	686 Garland Manor		Cear	247	69493378813	t	2006-02-14	2013-05-26 14:49:45.738
48	Ann	Evans	ann.evans@sakilacustomer.org	909 Garland Manor		Tatarstan	367	705800322606	t	2006-02-14	2013-05-26 14:49:45.738
49	Joyce	Edwards	joyce.edwards@sakilacustomer.org	725 Isesaki Place		Mekka	237	876295323994	t	2006-02-14	2013-05-26 14:49:45.738
50	Diane	Collins	diane.collins@sakilacustomer.org	115 Hidalgo Parkway		Khartum	379	307703950263	t	2006-02-14	2013-05-26 14:49:45.738
51	Alice	Stewart	alice.stewart@sakilacustomer.org	1135 Izumisano Parkway		California	171	171822533480	t	2006-02-14	2013-05-26 14:49:45.738
52	Julie	Sanchez	julie.sanchez@sakilacustomer.org	939 Probolinggo Loop		Galicia	1	680428310138	t	2006-02-14	2013-05-26 14:49:45.738
53	Heather	Morris	heather.morris@sakilacustomer.org	17 Kabul Boulevard		Chiba	355	697760867968	t	2006-02-14	2013-05-26 14:49:45.738
54	Teresa	Rogers	teresa.rogers@sakilacustomer.org	1964 Allappuzha (Alleppey) Street		Yamaguchi	227	920811325222	t	2006-02-14	2013-05-26 14:49:45.738
55	Doris	Reed	doris.reed@sakilacustomer.org	1697 Kowloon and New Kowloon Loop		Moskova	49	499352017190	t	2006-02-14	2013-05-26 14:49:45.738
56	Gloria	Cook	gloria.cook@sakilacustomer.org	1668 Saint Louis Place		Tahiti	397	347487831378	t	2006-02-14	2013-05-26 14:49:45.738
57	Evelyn	Morgan	evelyn.morgan@sakilacustomer.org	943 Tokat Street		Vaduz	560	889318963672	t	2006-02-14	2013-05-26 14:49:45.738
58	Jean	Bell	jean.bell@sakilacustomer.org	1114 Liepaja Street		Sarawak	282	212869228936	t	2006-02-14	2013-05-26 14:49:45.738
59	Cheryl	Murphy	cheryl.murphy@sakilacustomer.org	1213 Ranchi Parkway		Karnataka	350	800024380485	t	2006-02-14	2013-05-26 14:49:45.738
60	Mildred	Bailey	mildred.bailey@sakilacustomer.org	81 Hodeida Way		Rajasthan	231	250767749542	t	2006-02-14	2013-05-26 14:49:45.738
61	Katherine	Rivera	katherine.rivera@sakilacustomer.org	915 Ponce Place		Basel-Stadt	56	1395251317	t	2006-02-14	2013-05-26 14:49:45.738
62	Joan	Cooper	joan.cooper@sakilacustomer.org	1717 Guadalajara Lane		Missouri	441	914090181665	t	2006-02-14	2013-05-26 14:49:45.738
63	Ashley	Richardson	ashley.richardson@sakilacustomer.org	1214 Hanoi Way		Nebraska	306	491001136577	t	2006-02-14	2013-05-26 14:49:45.738
64	Judith	Cox	judith.cox@sakilacustomer.org	1966 Amroha Avenue		Sichuan	139	333489324603	t	2006-02-14	2013-05-26 14:49:45.738
65	Rose	Howard	rose.howard@sakilacustomer.org	698 Otsu Street		Cayenne	105	409983924481	t	2006-02-14	2013-05-26 14:49:45.738
66	Janice	Ward	janice.ward@sakilacustomer.org	1150 Kimchon Manor		Skne ln	321	663449333709	t	2006-02-14	2013-05-26 14:49:45.738
67	Kelly	Torres	kelly.torres@sakilacustomer.org	1586 Guaruj Place		Hunan	579	947233365992	t	2006-02-14	2013-05-26 14:49:45.738
68	Nicole	Peterson	nicole.peterson@sakilacustomer.org	57 Arlington Manor		Madhya Pradesh	475	990214419142	t	2006-02-14	2013-05-26 14:49:45.738
69	Judy	Gray	judy.gray@sakilacustomer.org	1031 Daugavpils Parkway		Bchar	63	107137400143	t	2006-02-14	2013-05-26 14:49:45.738
70	Christina	Ramirez	christina.ramirez@sakilacustomer.org	1124 Buenaventura Drive		Mekka	13	407733804223	t	2006-02-14	2013-05-26 14:49:45.738
71	Kathy	James	kathy.james@sakilacustomer.org	492 Cam Ranh Street		Eastern Visayas	61	565018274456	t	2006-02-14	2013-05-26 14:49:45.738
72	Theresa	Watson	theresa.watson@sakilacustomer.org	89 Allappuzha (Alleppey) Manor		National Capital Reg	517	255800440636	t	2006-02-14	2013-05-26 14:49:45.738
73	Beverly	Brooks	beverly.brooks@sakilacustomer.org	1947 Poos de Caldas Boulevard		Chiayi	114	427454485876	t	2006-02-14	2013-05-26 14:49:45.738
74	Denise	Kelly	denise.kelly@sakilacustomer.org	1206 Dos Quebradas Place		So Paulo	431	241832790687	t	2006-02-14	2013-05-26 14:49:45.738
75	Tammy	Sanders	tammy.sanders@sakilacustomer.org	1551 Rampur Lane		Changhwa	108	251164340471	t	2006-02-14	2013-05-26 14:49:45.738
76	Irene	Price	irene.price@sakilacustomer.org	602 Paarl Street		Pavlodar	402	896314772871	t	2006-02-14	2013-05-26 14:49:45.738
77	Jane	Bennett	jane.bennett@sakilacustomer.org	1692 Ede Loop		So Paulo	30	918711376618	t	2006-02-14	2013-05-26 14:49:45.738
78	Lori	Wood	lori.wood@sakilacustomer.org	936 Salzburg Lane		Uttar Pradesh	425	875756771675	t	2006-02-14	2013-05-26 14:49:45.738
79	Rachel	Barnes	rachel.barnes@sakilacustomer.org	586 Tete Way		Kanagawa	256	18581624103	t	2006-02-14	2013-05-26 14:49:45.738
80	Marilyn	Ross	marilyn.ross@sakilacustomer.org	1888 Kabul Drive		Oyo & Osun	217	701457319790	t	2006-02-14	2013-05-26 14:49:45.738
81	Andrea	Henderson	andrea.henderson@sakilacustomer.org	320 Baiyin Parkway		Mahajanga	319	223664661973	t	2006-02-14	2013-05-26 14:49:45.738
82	Kathryn	Coleman	kathryn.coleman@sakilacustomer.org	927 Baha Blanca Parkway		Krim	479	821972242086	t	2006-02-14	2013-05-26 14:49:45.738
83	Louise	Jenkins	louise.jenkins@sakilacustomer.org	929 Tallahassee Loop		Gauteng	497	800716535041	t	2006-02-14	2013-05-26 14:49:45.738
84	Sara	Perry	sara.perry@sakilacustomer.org	125 Citt del Vaticano Boulevard		Puebla	40	48417642933	t	2006-02-14	2013-05-26 14:49:45.738
85	Anne	Powell	anne.powell@sakilacustomer.org	1557 Ktahya Boulevard		England	88	720998247660	t	2006-02-14	2013-05-26 14:49:45.738
86	Jacqueline	Long	jacqueline.long@sakilacustomer.org	870 Ashqelon Loop		Songkhla	489	135117278909	t	2006-02-14	2013-05-26 14:49:45.738
87	Wanda	Patterson	wanda.patterson@sakilacustomer.org	1740 Portoviejo Avenue		Sucre	480	198123170793	t	2006-02-14	2013-05-26 14:49:45.738
88	Bonnie	Hughes	bonnie.hughes@sakilacustomer.org	1942 Ciparay Parkway		Cheju	113	978987363654	t	2006-02-14	2013-05-26 14:49:45.738
89	Julia	Flores	julia.flores@sakilacustomer.org	1926 El Alto Avenue		Buenos Aires	289	846225459260	t	2006-02-14	2013-05-26 14:49:45.738
90	Ruby	Washington	ruby.washington@sakilacustomer.org	1952 Chatsworth Drive		Guangdong	332	991562402283	t	2006-02-14	2013-05-26 14:49:45.738
91	Lois	Butler	lois.butler@sakilacustomer.org	1370 Le Mans Avenue		Brunei and Muara	53	345679835036	t	2006-02-14	2013-05-26 14:49:45.738
92	Tina	Simmons	tina.simmons@sakilacustomer.org	984 Effon-Alaiye Avenue		Gois	183	132986892228	t	2006-02-14	2013-05-26 14:49:45.738
93	Phyllis	Foster	phyllis.foster@sakilacustomer.org	832 Nakhon Sawan Manor		Inner Mongolia	592	275595571388	t	2006-02-14	2013-05-26 14:49:45.738
94	Norma	Gonzales	norma.gonzales@sakilacustomer.org	152 Kitwe Parkway		Caraga	82	835433605312	t	2006-02-14	2013-05-26 14:49:45.738
95	Paula	Bryant	paula.bryant@sakilacustomer.org	1697 Tanauan Lane		Punjab	399	4764773857	t	2006-02-14	2013-05-26 14:49:45.738
96	Diana	Alexander	diana.alexander@sakilacustomer.org	1308 Arecibo Way		Georgia	41	6171054059	t	2006-02-14	2013-05-26 14:49:45.738
97	Annie	Russell	annie.russell@sakilacustomer.org	1599 Plock Drive		Tete	534	817248913162	t	2006-02-14	2013-05-26 14:49:45.738
98	Lillian	Griffin	lillian.griffin@sakilacustomer.org	669 Firozabad Loop		Abu Dhabi	12	412903167998	t	2006-02-14	2013-05-26 14:49:45.738
99	Emily	Diaz	emily.diaz@sakilacustomer.org	588 Vila Velha Manor		Kyongsangbuk	268	333339908719	t	2006-02-14	2013-05-26 14:49:45.738
100	Robin	Hayes	robin.hayes@sakilacustomer.org	1913 Kamakura Place		Lipetsk	238	942570536750	t	2006-02-14	2013-05-26 14:49:45.738
101	Peggy	Myers	peggy.myers@sakilacustomer.org	733 Mandaluyong Place		Asir	2	196568435814	t	2006-02-14	2013-05-26 14:49:45.738
102	Crystal	Ford	crystal.ford@sakilacustomer.org	659 Vaduz Drive		Ha Darom	34	709935135487	t	2006-02-14	2013-05-26 14:49:45.738
103	Gladys	Hamilton	gladys.hamilton@sakilacustomer.org	1177 Jelets Way		Kwara & Kogi	220	484292626944	t	2006-02-14	2013-05-26 14:49:45.738
104	Rita	Graham	rita.graham@sakilacustomer.org	1386 Yangor Avenue		Provence-Alpes-Cte	543	449216226468	t	2006-02-14	2013-05-26 14:49:45.738
105	Dawn	Sullivan	dawn.sullivan@sakilacustomer.org	454 Nakhon Sawan Boulevard		Funafuti	173	963887147572	t	2006-02-14	2013-05-26 14:49:45.738
106	Connie	Wallace	connie.wallace@sakilacustomer.org	1867 San Juan Bautista Tuxtepec Avenue		Ivanovo	225	547003310357	t	2006-02-14	2013-05-26 14:49:45.738
107	Florence	Woods	florence.woods@sakilacustomer.org	1532 Dzerzinsk Way		Buenos Aires	334	330838016880	t	2006-02-14	2013-05-26 14:49:45.738
108	Tracy	Cole	tracy.cole@sakilacustomer.org	1002 Ahmadnagar Manor		Mxico	213	371490777743	t	2006-02-14	2013-05-26 14:49:45.738
109	Edna	West	edna.west@sakilacustomer.org	682 Junan Way		North West	273	622255216127	t	2006-02-14	2013-05-26 14:49:45.738
110	Tiffany	Jordan	tiffany.jordan@sakilacustomer.org	804 Elista Drive		Hubei	159	379804592943	t	2006-02-14	2013-05-26 14:49:45.738
111	Carmen	Owens	carmen.owens@sakilacustomer.org	1378 Alvorada Avenue		Distrito Federal	102	272234298332	t	2006-02-14	2013-05-26 14:49:45.738
112	Rosa	Reynolds	rosa.reynolds@sakilacustomer.org	793 Cam Ranh Avenue		California	292	824370924746	t	2006-02-14	2013-05-26 14:49:45.738
113	Cindy	Fisher	cindy.fisher@sakilacustomer.org	1079 Tel Aviv-Jaffa Boulevard		Sucre	132	358178933857	t	2006-02-14	2013-05-26 14:49:45.738
114	Grace	Ellis	grace.ellis@sakilacustomer.org	442 Rae Bareli Place		Nordrhein-Westfalen	148	886636413768	t	2006-02-14	2013-05-26 14:49:45.738
115	Wendy	Harrison	wendy.harrison@sakilacustomer.org	1107 Nakhon Sawan Avenue		Mxico	365	867546627903	t	2006-02-14	2013-05-26 14:49:45.738
116	Victoria	Gibson	victoria.gibson@sakilacustomer.org	544 Malm Parkway		Central Java	403	386759646229	t	2006-02-14	2013-05-26 14:49:45.738
117	Edith	Mcdonald	edith.mcdonald@sakilacustomer.org	1967 Sincelejo Place		Gujarat	176	577812616052	t	2006-02-14	2013-05-26 14:49:45.738
118	Kim	Cruz	kim.cruz@sakilacustomer.org	333 Goinia Way		Texas	185	909029256431	t	2006-02-14	2013-05-26 14:49:45.738
119	Sherry	Marshall	sherry.marshall@sakilacustomer.org	1987 Coacalco de Berriozbal Loop		al-Qalyubiya	476	787654415858	t	2006-02-14	2013-05-26 14:49:45.738
120	Sylvia	Ortiz	sylvia.ortiz@sakilacustomer.org	241 Mosul Lane		Risaralda	147	765345144779	t	2006-02-14	2013-05-26 14:49:45.738
121	Josephine	Gomez	josephine.gomez@sakilacustomer.org	211 Chiayi Drive		Uttar Pradesh	164	665993880048	t	2006-02-14	2013-05-26 14:49:45.738
122	Thelma	Murray	thelma.murray@sakilacustomer.org	1175 Tanauan Way		Lima	305	937222955822	t	2006-02-14	2013-05-26 14:49:45.738
123	Shannon	Freeman	shannon.freeman@sakilacustomer.org	117 Boa Vista Way		Uttar Pradesh	566	677976133614	t	2006-02-14	2013-05-26 14:49:45.738
124	Sheila	Wells	sheila.wells@sakilacustomer.org	848 Tafuna Manor		Ktahya	281	614935229095	t	2006-02-14	2013-05-26 14:49:45.738
125	Ethel	Webb	ethel.webb@sakilacustomer.org	569 Baicheng Lane		Gauteng	85	490211944645	t	2006-02-14	2013-05-26 14:49:45.738
126	Ellen	Simpson	ellen.simpson@sakilacustomer.org	1666 Qomsheh Drive		So Paulo	410	582835362905	t	2006-02-14	2013-05-26 14:49:45.738
127	Elaine	Stevens	elaine.stevens@sakilacustomer.org	801 Hagonoy Drive		Smolensk	484	237426099212	t	2006-02-14	2013-05-26 14:49:45.738
128	Marjorie	Tucker	marjorie.tucker@sakilacustomer.org	1050 Garden Grove Avenue		Slaskie	236	973047364353	t	2006-02-14	2013-05-26 14:49:45.738
129	Carrie	Porter	carrie.porter@sakilacustomer.org	1854 Tieli Street		Shandong	302	509492324775	t	2006-02-14	2013-05-26 14:49:45.738
130	Charlotte	Hunter	charlotte.hunter@sakilacustomer.org	758 Junan Lane		Gois	190	935448624185	t	2006-02-14	2013-05-26 14:49:45.738
131	Monica	Hicks	monica.hicks@sakilacustomer.org	1752 So Leopoldo Parkway		Taka-Karpatia	345	252265130067	t	2006-02-14	2013-05-26 14:49:45.738
132	Esther	Crawford	esther.crawford@sakilacustomer.org	898 Belm Manor		Free State	87	707169393853	t	2006-02-14	2013-05-26 14:49:45.738
133	Pauline	Henry	pauline.henry@sakilacustomer.org	261 Saint Louis Way		Coahuila de Zaragoza	541	321944036800	t	2006-02-14	2013-05-26 14:49:45.738
134	Emma	Boyd	emma.boyd@sakilacustomer.org	765 Southampton Drive		al-Qalyubiya	421	23712411567	t	2006-02-14	2013-05-26 14:49:45.738
135	Juanita	Mason	juanita.mason@sakilacustomer.org	943 Johannesburg Avenue		Maharashtra	417	90921003005	t	2006-02-14	2013-05-26 14:49:45.738
136	Anita	Morales	anita.morales@sakilacustomer.org	788 Atinsk Street		Karnataka	211	146497509724	t	2006-02-14	2013-05-26 14:49:45.738
137	Rhonda	Kennedy	rhonda.kennedy@sakilacustomer.org	1749 Daxian Place		Gelderland	29	963369996279	t	2006-02-14	2013-05-26 14:49:45.738
138	Hazel	Warren	hazel.warren@sakilacustomer.org	1587 Sullana Lane		Inner Mongolia	207	468060467018	t	2006-02-14	2013-05-26 14:49:45.738
139	Amber	Dixon	amber.dixon@sakilacustomer.org	1029 Dzerzinsk Manor		Ynlin	542	33173584456	t	2006-02-14	2013-05-26 14:49:45.738
140	Eva	Ramos	eva.ramos@sakilacustomer.org	1666 Beni-Mellal Place		Tennessee	123	9099941466	t	2006-02-14	2013-05-26 14:49:45.738
141	Debbie	Reyes	debbie.reyes@sakilacustomer.org	928 Jaffna Loop		Hiroshima	172	581852137991	t	2006-02-14	2013-05-26 14:49:45.738
142	April	Burns	april.burns@sakilacustomer.org	483 Ljubertsy Parkway		Scotland	149	581174211853	t	2006-02-14	2013-05-26 14:49:45.738
143	Leslie	Gordon	leslie.gordon@sakilacustomer.org	374 Bat Yam Boulevard		Kilis	266	923261616249	t	2006-02-14	2013-05-26 14:49:45.738
144	Clara	Shaw	clara.shaw@sakilacustomer.org	1027 Songkhla Manor		Minsk	340	563660187896	t	2006-02-14	2013-05-26 14:49:45.738
145	Lucille	Holmes	lucille.holmes@sakilacustomer.org	999 Sanaa Loop		Gauteng	491	918032330119	t	2006-02-14	2013-05-26 14:49:45.738
146	Jamie	Rice	jamie.rice@sakilacustomer.org	879 Newcastle Way		Michigan	499	206841104594	t	2006-02-14	2013-05-26 14:49:45.738
147	Joanne	Robertson	joanne.robertson@sakilacustomer.org	1337 Lincoln Parkway		Saitama	555	597815221267	t	2006-02-14	2013-05-26 14:49:45.738
148	Eleanor	Hunt	eleanor.hunt@sakilacustomer.org	1952 Pune Lane		Saint-Denis	442	354615066969	t	2006-02-14	2013-05-26 14:49:45.738
149	Valerie	Black	valerie.black@sakilacustomer.org	782 Mosul Street		Massachusetts	94	885899703621	t	2006-02-14	2013-05-26 14:49:45.738
150	Danielle	Daniels	danielle.daniels@sakilacustomer.org	781 Shimonoseki Drive		Michoacn de Ocampo	202	632316273199	t	2006-02-14	2013-05-26 14:49:45.738
151	Megan	Palmer	megan.palmer@sakilacustomer.org	1560 Jelets Boulevard		Shandong	291	189446090264	t	2006-02-14	2013-05-26 14:49:45.738
152	Alicia	Mills	alicia.mills@sakilacustomer.org	1963 Moscow Place		Assam	354	761379480249	t	2006-02-14	2013-05-26 14:49:45.738
153	Suzanne	Nichols	suzanne.nichols@sakilacustomer.org	456 Escobar Way		Jakarta Raya	232	719202533520	t	2006-02-14	2013-05-26 14:49:45.738
154	Michele	Grant	michele.grant@sakilacustomer.org	798 Cianjur Avenue		Shanxi	590	499408708580	t	2006-02-14	2013-05-26 14:49:45.738
155	Gail	Knight	gail.knight@sakilacustomer.org	185 Novi Sad Place		Bern	72	904253967161	t	2006-02-14	2013-05-26 14:49:45.738
156	Bertha	Ferguson	bertha.ferguson@sakilacustomer.org	1367 Yantai Manor		Ondo & Ekiti	381	889538496300	t	2006-02-14	2013-05-26 14:49:45.738
157	Darlene	Rose	darlene.rose@sakilacustomer.org	1386 Nakhon Sawan Boulevard		Pyongyang-si	420	368899174225	t	2006-02-14	2013-05-26 14:49:45.738
158	Veronica	Stone	veronica.stone@sakilacustomer.org	369 Papeete Way		North Carolina	187	170117068815	t	2006-02-14	2013-05-26 14:49:45.738
159	Jill	Hawkins	jill.hawkins@sakilacustomer.org	1440 Compton Place		North Austria	307	931059836497	t	2006-02-14	2013-05-26 14:49:45.738
160	Erin	Dunn	erin.dunn@sakilacustomer.org	1623 Baha Blanca Manor		Moskova	310	149981248346	t	2006-02-14	2013-05-26 14:49:45.738
161	Geraldine	Perkins	geraldine.perkins@sakilacustomer.org	97 Shimoga Avenue		Tel Aviv	533	177167004331	t	2006-02-14	2013-05-26 14:49:45.738
162	Lauren	Hudson	lauren.hudson@sakilacustomer.org	1740 Le Mans Loop		Pays de la Loire	297	168476538960	t	2006-02-14	2013-05-26 14:49:45.738
163	Cathy	Spencer	cathy.spencer@sakilacustomer.org	1287 Xiangfan Boulevard		Gifu	253	819416131190	t	2006-02-14	2013-05-26 14:49:45.738
164	Joann	Gardner	joann.gardner@sakilacustomer.org	842 Salzburg Lane		Adana	529	697151428760	t	2006-02-14	2013-05-26 14:49:45.738
165	Lorraine	Stephens	lorraine.stephens@sakilacustomer.org	154 Tallahassee Loop		Xinxiang	199	935508855935	t	2006-02-14	2013-05-26 14:49:45.738
166	Lynn	Payne	lynn.payne@sakilacustomer.org	710 San Felipe del Progreso Avenue		Lilongwe	304	843801144113	t	2006-02-14	2013-05-26 14:49:45.738
167	Sally	Pierce	sally.pierce@sakilacustomer.org	1540 Wroclaw Drive		Maharashtra	107	182363341674	t	2006-02-14	2013-05-26 14:49:45.738
168	Regina	Berry	regina.berry@sakilacustomer.org	475 Atinsk Way		Gansu	240	201705577290	t	2006-02-14	2013-05-26 14:49:45.738
169	Erica	Matthews	erica.matthews@sakilacustomer.org	1294 Firozabad Drive		Jiangxi	407	161801569569	t	2006-02-14	2013-05-26 14:49:45.738
170	Beatrice	Arnold	beatrice.arnold@sakilacustomer.org	1877 Ezhou Lane		Rajasthan	550	264541743403	t	2006-02-14	2013-05-26 14:49:45.738
171	Dolores	Wagner	dolores.wagner@sakilacustomer.org	316 Uruapan Street		Perak	223	275788967899	t	2006-02-14	2013-05-26 14:49:45.738
172	Bernice	Willis	bernice.willis@sakilacustomer.org	29 Pyongyang Loop		Batman	58	734780743462	t	2006-02-14	2013-05-26 14:49:45.738
173	Audrey	Ray	audrey.ray@sakilacustomer.org	1010 Klerksdorp Way		Steiermark	186	493008546874	t	2006-02-14	2013-05-26 14:49:45.738
174	Yvonne	Watkins	yvonne.watkins@sakilacustomer.org	1848 Salala Boulevard		Miranda	373	48265851133	t	2006-02-14	2013-05-26 14:49:45.738
175	Annette	Olson	annette.olson@sakilacustomer.org	431 Xiangtan Avenue		Kerala	18	230250973122	t	2006-02-14	2013-05-26 14:49:45.738
176	June	Carroll	june.carroll@sakilacustomer.org	757 Rustenburg Avenue		Skikda	483	506134035434	t	2006-02-14	2013-05-26 14:49:45.738
177	Samantha	Duncan	samantha.duncan@sakilacustomer.org	146 Johannesburg Way		Tamaulipas	330	953689007081	t	2006-02-14	2013-05-26 14:49:45.738
178	Marion	Snyder	marion.snyder@sakilacustomer.org	1891 Rizhao Boulevard		So Paulo	456	391065549876	t	2006-02-14	2013-05-26 14:49:45.738
179	Dana	Hart	dana.hart@sakilacustomer.org	1089 Iwatsuki Avenue		Kirov	270	866092335135	t	2006-02-14	2013-05-26 14:49:45.738
180	Stacy	Cunningham	stacy.cunningham@sakilacustomer.org	1410 Benin City Parkway		Risaralda	405	104150372603	t	2006-02-14	2013-05-26 14:49:45.738
181	Ana	Bradley	ana.bradley@sakilacustomer.org	682 Garden Grove Place		Tennessee	333	72136330362	t	2006-02-14	2013-05-26 14:49:45.738
182	Renee	Lane	renee.lane@sakilacustomer.org	533 al-Ayn Boulevard		California	126	662227486184	t	2006-02-14	2013-05-26 14:49:45.738
183	Ida	Andrews	ida.andrews@sakilacustomer.org	1839 Szkesfehrvr Parkway		Gois	317	947468818183	t	2006-02-14	2013-05-26 14:49:45.738
184	Vivian	Ruiz	vivian.ruiz@sakilacustomer.org	741 Ambattur Manor		Noord-Brabant	438	302590383819	t	2006-02-14	2013-05-26 14:49:45.738
185	Roberta	Harper	roberta.harper@sakilacustomer.org	927 Barcelona Street		Chaharmahal va Bakht	467	951486492670	t	2006-02-14	2013-05-26 14:49:45.738
186	Holly	Fox	holly.fox@sakilacustomer.org	435 0 Way		West Bengali	195	760171523969	t	2006-02-14	2013-05-26 14:49:45.738
187	Brittany	Riley	brittany.riley@sakilacustomer.org	140 Chiayi Parkway		Sumy	506	855863906434	t	2006-02-14	2013-05-26 14:49:45.738
188	Melanie	Armstrong	melanie.armstrong@sakilacustomer.org	1166 Changhwa Street		Caraga	62	650752094490	t	2006-02-14	2013-05-26 14:49:45.738
189	Loretta	Carpenter	loretta.carpenter@sakilacustomer.org	891 Novi Sad Manor		Ontario	383	247646995453	t	2006-02-14	2013-05-26 14:49:45.738
190	Yolanda	Weaver	yolanda.weaver@sakilacustomer.org	605 Rio Claro Parkway		Tabora	513	352469351088	t	2006-02-14	2013-05-26 14:49:45.738
191	Jeanette	Greene	jeanette.greene@sakilacustomer.org	1077 San Felipe de Puerto Plata Place		Rostov-na-Donu	369	812824036424	t	2006-02-14	2013-05-26 14:49:45.738
192	Laurie	Lawrence	laurie.lawrence@sakilacustomer.org	9 San Miguel de Tucumn Manor		Uttar Pradesh	169	956188728558	t	2006-02-14	2013-05-26 14:49:45.738
193	Katie	Elliott	katie.elliott@sakilacustomer.org	447 Surakarta Loop		Nyanza	271	940830176580	t	2006-02-14	2013-05-26 14:49:45.738
194	Kristen	Chavez	kristen.chavez@sakilacustomer.org	345 Oshawa Boulevard		Tokyo-to	204	104491201771	t	2006-02-14	2013-05-26 14:49:45.738
195	Vanessa	Sims	vanessa.sims@sakilacustomer.org	1792 Valle de la Pascua Place		Nordrhein-Westfalen	477	419419591240	t	2006-02-14	2013-05-26 14:49:45.738
196	Alma	Austin	alma.austin@sakilacustomer.org	1074 Binzhou Manor		Baden-Wrttemberg	325	331132568928	t	2006-02-14	2013-05-26 14:49:45.738
197	Sue	Peters	sue.peters@sakilacustomer.org	817 Bradford Loop		Jiangsu	109	264286442804	t	2006-02-14	2013-05-26 14:49:45.738
198	Elsie	Kelley	elsie.kelley@sakilacustomer.org	955 Bamenda Way		Ondo & Ekiti	218	768481779568	t	2006-02-14	2013-05-26 14:49:45.738
199	Beth	Franklin	beth.franklin@sakilacustomer.org	1149 A Corua (La Corua) Boulevard		Haiphong	194	470884141195	t	2006-02-14	2013-05-26 14:49:45.738
200	Jeanne	Lawson	jeanne.lawson@sakilacustomer.org	387 Mwene-Ditu Drive		Ahal	35	764477681869	t	2006-02-14	2013-05-26 14:49:45.738
201	Vicki	Fields	vicki.fields@sakilacustomer.org	68 Molodetno Manor		Nordrhein-Westfalen	575	146640639760	t	2006-02-14	2013-05-26 14:49:45.738
202	Carla	Gutierrez	carla.gutierrez@sakilacustomer.org	642 Nador Drive		Maharashtra	77	369050085652	t	2006-02-14	2013-05-26 14:49:45.738
203	Tara	Ryan	tara.ryan@sakilacustomer.org	1688 Nador Lane		Sulawesi Utara	184	652218196731	t	2006-02-14	2013-05-26 14:49:45.738
204	Rosemary	Schmidt	rosemary.schmidt@sakilacustomer.org	1215 Pyongyang Parkway		Usak	557	646237101779	t	2006-02-14	2013-05-26 14:49:45.738
205	Eileen	Carr	eileen.carr@sakilacustomer.org	1679 Antofagasta Street		Alto Paran	122	905903574913	t	2006-02-14	2013-05-26 14:49:45.738
206	Terri	Vasquez	terri.vasquez@sakilacustomer.org	1304 s-Hertogenbosch Way		Santa Catarina	83	90336226227	t	2006-02-14	2013-05-26 14:49:45.738
207	Gertrude	Castillo	gertrude.castillo@sakilacustomer.org	850 Salala Loop		Kitaa	371	403404780639	t	2006-02-14	2013-05-26 14:49:45.738
208	Lucy	Wheeler	lucy.wheeler@sakilacustomer.org	624 Oshawa Boulevard		West Bengali	51	49677664184	t	2006-02-14	2013-05-26 14:49:45.738
209	Tonya	Chapman	tonya.chapman@sakilacustomer.org	43 Dadu Avenue		Rajasthan	74	95666951770	t	2006-02-14	2013-05-26 14:49:45.738
210	Ella	Oliver	ella.oliver@sakilacustomer.org	751 Lima Loop		Aden	7	756460337785	t	2006-02-14	2013-05-26 14:49:45.738
211	Stacey	Montgomery	stacey.montgomery@sakilacustomer.org	1333 Haldia Street		Jilin	174	408304391718	t	2006-02-14	2013-05-26 14:49:45.738
212	Wilma	Richards	wilma.richards@sakilacustomer.org	660 Jedda Boulevard		Washington	65	168758068397	t	2006-02-14	2013-05-26 14:49:45.738
213	Gina	Williamson	gina.williamson@sakilacustomer.org	1001 Miyakonojo Lane		Taizz	518	584316724815	t	2006-02-14	2013-05-26 14:49:45.738
214	Kristin	Johnston	kristin.johnston@sakilacustomer.org	226 Brest Manor		California	508	785881412500	t	2006-02-14	2013-05-26 14:49:45.738
215	Jessie	Banks	jessie.banks@sakilacustomer.org	1229 Valencia Parkway		Haskovo	498	352679173732	t	2006-02-14	2013-05-26 14:49:45.738
216	Natalie	Meyer	natalie.meyer@sakilacustomer.org	1201 Qomsheh Manor		Gois	28	873492228462	t	2006-02-14	2013-05-26 14:49:45.738
217	Agnes	Bishop	agnes.bishop@sakilacustomer.org	866 Shivapuri Manor		Uttar Pradesh	448	778502731092	t	2006-02-14	2013-05-26 14:49:45.738
218	Vera	Mccoy	vera.mccoy@sakilacustomer.org	1168 Najafabad Parkway		Kabol	251	886649065861	t	2006-02-14	2013-05-26 14:49:45.738
219	Willie	Howell	willie.howell@sakilacustomer.org	1244 Allappuzha (Alleppey) Place		Buenos Aires	567	991802825778	t	2006-02-14	2013-05-26 14:49:45.738
220	Charlene	Alvarez	charlene.alvarez@sakilacustomer.org	1842 Luzinia Boulevard		Zanzibar West	593	706878974831	t	2006-02-14	2013-05-26 14:49:45.738
221	Bessie	Morrison	bessie.morrison@sakilacustomer.org	1926 Gingoog Street		Sisilia	511	469738825391	t	2006-02-14	2013-05-26 14:49:45.738
222	Delores	Hansen	delores.hansen@sakilacustomer.org	810 Palghat (Palakkad) Boulevard		Jaroslavl	235	516331171356	t	2006-02-14	2013-05-26 14:49:45.738
223	Melinda	Fernandez	melinda.fernandez@sakilacustomer.org	1820 Maring Parkway		Punjab	324	99760893676	t	2006-02-14	2013-05-26 14:49:45.738
224	Pearl	Garza	pearl.garza@sakilacustomer.org	60 Poos de Caldas Street		Rajasthan	243	963063788669	t	2006-02-14	2013-05-26 14:49:45.738
225	Arlene	Harvey	arlene.harvey@sakilacustomer.org	1014 Loja Manor		Tamil Nadu	22	460795526514	t	2006-02-14	2013-05-26 14:49:45.738
226	Maureen	Little	maureen.little@sakilacustomer.org	201 Effon-Alaiye Way		Asuncin	37	684192903087	t	2006-02-14	2013-05-26 14:49:45.738
227	Colleen	Burton	colleen.burton@sakilacustomer.org	430 Alessandria Loop		Saarland	439	669828224459	t	2006-02-14	2013-05-26 14:49:45.738
228	Allison	Stanley	allison.stanley@sakilacustomer.org	754 Valencia Place		Phnom Penh	406	594319417514	t	2006-02-14	2013-05-26 14:49:45.738
229	Tamara	Nguyen	tamara.nguyen@sakilacustomer.org	356 Olomouc Manor		Gois	26	22326410776	t	2006-02-14	2013-05-26 14:49:45.738
230	Joy	George	joy.george@sakilacustomer.org	1256 Bislig Boulevard		Botosani	86	479007229460	t	2006-02-14	2013-05-26 14:49:45.738
231	Georgia	Jacobs	georgia.jacobs@sakilacustomer.org	954 Kimchon Place		West Bengali	559	541327526474	t	2006-02-14	2013-05-26 14:49:45.738
232	Constance	Reid	constance.reid@sakilacustomer.org	885 Yingkou Manor		Kaduna	596	588964509072	t	2006-02-14	2013-05-26 14:49:45.738
233	Lillie	Kim	lillie.kim@sakilacustomer.org	1736 Cavite Place		Qina	216	431770603551	t	2006-02-14	2013-05-26 14:49:45.738
234	Claudia	Fuller	claudia.fuller@sakilacustomer.org	346 Skikda Parkway		Hawalli	233	630424482919	t	2006-02-14	2013-05-26 14:49:45.738
235	Jackie	Lynch	jackie.lynch@sakilacustomer.org	98 Stara Zagora Boulevard		Valle	96	610173756082	t	2006-02-14	2013-05-26 14:49:45.738
236	Marcia	Dean	marcia.dean@sakilacustomer.org	1479 Rustenburg Boulevard		Southern Tagalog	527	727785483194	t	2006-02-14	2013-05-26 14:49:45.738
237	Tanya	Gilbert	tanya.gilbert@sakilacustomer.org	647 A Corua (La Corua) Street		Chollanam	357	792557457753	t	2006-02-14	2013-05-26 14:49:45.738
238	Nellie	Garrett	nellie.garrett@sakilacustomer.org	1964 Gijn Manor		Karnataka	473	918119601885	t	2006-02-14	2013-05-26 14:49:45.738
239	Minnie	Romero	minnie.romero@sakilacustomer.org	47 Syktyvkar Lane		West Java	118	63937119031	t	2006-02-14	2013-05-26 14:49:45.738
240	Marlene	Welch	marlene.welch@sakilacustomer.org	1148 Saarbrcken Parkway		Fukushima	226	137773001988	t	2006-02-14	2013-05-26 14:49:45.738
241	Heidi	Larson	heidi.larson@sakilacustomer.org	1103 Bilbays Parkway		Hubei	578	279979529227	t	2006-02-14	2013-05-26 14:49:45.738
242	Glenda	Frazier	glenda.frazier@sakilacustomer.org	1246 Boksburg Parkway		Hebei	422	890283544295	t	2006-02-14	2013-05-26 14:49:45.738
243	Lydia	Burke	lydia.burke@sakilacustomer.org	1483 Pathankot Street		Tucumn	454	686015532180	t	2006-02-14	2013-05-26 14:49:45.738
244	Viola	Hanson	viola.hanson@sakilacustomer.org	582 Papeete Loop		Central Visayas	294	569868543137	t	2006-02-14	2013-05-26 14:49:45.738
245	Courtney	Day	courtney.day@sakilacustomer.org	300 Junan Street		Kyonggi	553	890289150158	t	2006-02-14	2013-05-26 14:49:45.738
246	Marian	Mendoza	marian.mendoza@sakilacustomer.org	829 Grand Prairie Way		Paran	328	741070712873	t	2006-02-14	2013-05-26 14:49:45.738
247	Stella	Moreno	stella.moreno@sakilacustomer.org	1473 Changhwa Parkway		Mxico	124	266798132374	t	2006-02-14	2013-05-26 14:49:45.738
248	Caroline	Bowman	caroline.bowman@sakilacustomer.org	1309 Weifang Street		Florida	520	435785045362	t	2006-02-14	2013-05-26 14:49:45.738
249	Dora	Medina	dora.medina@sakilacustomer.org	1760 Oshawa Manor		Tianjin	535	56257502250	t	2006-02-14	2013-05-26 14:49:45.738
250	Jo	Fowler	jo.fowler@sakilacustomer.org	786 Stara Zagora Way		Oyo & Osun	390	716256596301	t	2006-02-14	2013-05-26 14:49:45.738
251	Vickie	Brewer	vickie.brewer@sakilacustomer.org	1966 Tonghae Street		Anhalt Sachsen	198	567359279425	t	2006-02-14	2013-05-26 14:49:45.738
252	Mattie	Hoffman	mattie.hoffman@sakilacustomer.org	1497 Yuzhou Drive		England	312	246810237916	t	2006-02-14	2013-05-26 14:49:45.738
253	Terry	Carlson	terry.carlson@sakilacustomer.org	752 Ondo Loop		Miyazaki	338	134673576619	t	2006-02-14	2013-05-26 14:49:45.738
254	Maxine	Silva	maxine.silva@sakilacustomer.org	1338 Zalantun Lane		Minas Gerais	413	840522972766	t	2006-02-14	2013-05-26 14:49:45.738
255	Irma	Pearson	irma.pearson@sakilacustomer.org	127 Iwakuni Boulevard		Central Luzon	192	987442542471	t	2006-02-14	2013-05-26 14:49:45.738
256	Mabel	Holland	mabel.holland@sakilacustomer.org	51 Laredo Avenue		Sagaing	342	884536620568	t	2006-02-14	2013-05-26 14:49:45.738
257	Marsha	Douglas	marsha.douglas@sakilacustomer.org	771 Yaound Manor		Sofala	64	245477603573	t	2006-02-14	2013-05-26 14:49:45.738
258	Myrtle	Fleming	myrtle.fleming@sakilacustomer.org	532 Toulon Street		Santiago	460	46871694740	t	2006-02-14	2013-05-26 14:49:45.738
259	Lena	Jensen	lena.jensen@sakilacustomer.org	1027 Banjul Place		West Bengali	197	538241037443	t	2006-02-14	2013-05-26 14:49:45.738
260	Christy	Vargas	christy.vargas@sakilacustomer.org	1158 Mandi Bahauddin Parkway		Shanxi	136	276555730211	t	2006-02-14	2013-05-26 14:49:45.738
261	Deanna	Byrd	deanna.byrd@sakilacustomer.org	862 Xintai Lane		Cagayan Valley	548	265153400632	t	2006-02-14	2013-05-26 14:49:45.738
262	Patsy	Davidson	patsy.davidson@sakilacustomer.org	816 Cayenne Parkway		Manab	414	282874611748	t	2006-02-14	2013-05-26 14:49:45.738
263	Hilda	Hopkins	hilda.hopkins@sakilacustomer.org	1831 Nam Dinh Loop		National Capital Reg	323	322888976727	t	2006-02-14	2013-05-26 14:49:45.738
264	Gwendolyn	May	gwendolyn.may@sakilacustomer.org	446 Kirovo-Tepetsk Lane		Osaka	203	303967439816	t	2006-02-14	2013-05-26 14:49:45.738
265	Jennie	Terry	jennie.terry@sakilacustomer.org	682 Halisahar Place		Severn Morava	378	475553436330	t	2006-02-14	2013-05-26 14:49:45.738
266	Nora	Herrera	nora.herrera@sakilacustomer.org	1587 Loja Manor		Salzburg	447	621625204422	t	2006-02-14	2013-05-26 14:49:45.738
267	Margie	Wade	margie.wade@sakilacustomer.org	1762 Paarl Parkway		Hunan	298	192459639410	t	2006-02-14	2013-05-26 14:49:45.738
268	Nina	Soto	nina.soto@sakilacustomer.org	1519 Ilorin Place		Kerala	395	357445645426	t	2006-02-14	2013-05-26 14:49:45.738
269	Cassandra	Walters	cassandra.walters@sakilacustomer.org	920 Kumbakonam Loop		California	446	685010736240	t	2006-02-14	2013-05-26 14:49:45.738
270	Leah	Curtis	leah.curtis@sakilacustomer.org	906 Goinia Way		Wielkopolskie	255	701767622697	t	2006-02-14	2013-05-26 14:49:45.738
271	Penny	Neal	penny.neal@sakilacustomer.org	1675 Xiangfan Manor		Tamil Nadu	283	271149517630	t	2006-02-14	2013-05-26 14:49:45.738
272	Kay	Caldwell	kay.caldwell@sakilacustomer.org	85 San Felipe de Puerto Plata Drive		Shandong	584	170739645687	t	2006-02-14	2013-05-26 14:49:45.738
273	Priscilla	Lowe	priscilla.lowe@sakilacustomer.org	144 South Hill Loop		Guanajuato	445	45387294817	t	2006-02-14	2013-05-26 14:49:45.738
274	Naomi	Jennings	naomi.jennings@sakilacustomer.org	1884 Shikarpur Avenue		Haryana	263	959949395183	t	2006-02-14	2013-05-26 14:49:45.738
275	Carole	Barnett	carole.barnett@sakilacustomer.org	1980 Kamjanets-Podilskyi Street		Illinois	404	874337098891	t	2006-02-14	2013-05-26 14:49:45.738
276	Brandy	Graves	brandy.graves@sakilacustomer.org	1944 Bamenda Way		Michigan	573	75975221996	t	2006-02-14	2013-05-26 14:49:45.738
277	Olga	Jimenez	olga.jimenez@sakilacustomer.org	556 Baybay Manor		Oyo & Osun	374	363982224739	t	2006-02-14	2013-05-26 14:49:45.738
278	Billie	Horton	billie.horton@sakilacustomer.org	457 Tongliao Loop		Bursa	222	880756161823	t	2006-02-14	2013-05-26 14:49:45.738
279	Dianne	Shelton	dianne.shelton@sakilacustomer.org	600 Bradford Street		East Azerbaidzan	514	117592274996	t	2006-02-14	2013-05-26 14:49:45.738
280	Tracey	Barrett	tracey.barrett@sakilacustomer.org	1006 Santa Brbara dOeste Manor		Ondo & Ekiti	389	85059738746	t	2006-02-14	2013-05-26 14:49:45.738
281	Leona	Obrien	leona.obrien@sakilacustomer.org	1308 Sumy Loop		Fujian	175	583021225407	t	2006-02-14	2013-05-26 14:49:45.738
282	Jenny	Castro	jenny.castro@sakilacustomer.org	1405 Chisinau Place		Ponce	411	62781725285	t	2006-02-14	2013-05-26 14:49:45.738
283	Felicia	Sutton	felicia.sutton@sakilacustomer.org	226 Halifax Street		Xinxiang	277	790651020929	t	2006-02-14	2013-05-26 14:49:45.738
284	Sonia	Gregory	sonia.gregory@sakilacustomer.org	1279 Udine Parkway		Edo & Delta	69	195003555232	t	2006-02-14	2013-05-26 14:49:45.738
285	Miriam	Mckinney	miriam.mckinney@sakilacustomer.org	1336 Benin City Drive		Shiga	386	341242939532	t	2006-02-14	2013-05-26 14:49:45.738
286	Velma	Lucas	velma.lucas@sakilacustomer.org	1155 Liaocheng Place		Oyo & Osun	152	558236142492	t	2006-02-14	2013-05-26 14:49:45.738
287	Becky	Miles	becky.miles@sakilacustomer.org	1993 Tabuk Lane		Tamil Nadu	522	648482415405	t	2006-02-14	2013-05-26 14:49:45.738
288	Bobbie	Craig	bobbie.craig@sakilacustomer.org	86 Higashiosaka Lane		Guanajuato	563	957128697225	t	2006-02-14	2013-05-26 14:49:45.738
289	Violet	Rodriquez	violet.rodriquez@sakilacustomer.org	1912 Allende Manor		Kowloon and New Kowl	279	172262454487	t	2006-02-14	2013-05-26 14:49:45.738
290	Kristina	Chambers	kristina.chambers@sakilacustomer.org	544 Tarsus Boulevard		Gurico	562	892523334	t	2006-02-14	2013-05-26 14:49:45.738
291	Toni	Holt	toni.holt@sakilacustomer.org	1936 Cuman Avenue		Virginia	433	976798660411	t	2006-02-14	2013-05-26 14:49:45.738
292	Misty	Lambert	misty.lambert@sakilacustomer.org	1192 Tongliao Street		Sharja	470	350970907017	t	2006-02-14	2013-05-26 14:49:45.738
293	Mae	Fletcher	mae.fletcher@sakilacustomer.org	44 Najafabad Way		Baskimaa	146	96604821070	t	2006-02-14	2013-05-26 14:49:45.738
294	Shelly	Watts	shelly.watts@sakilacustomer.org	32 Pudukkottai Lane		Ohio	140	967274728547	t	2006-02-14	2013-05-26 14:49:45.738
295	Daisy	Bates	daisy.bates@sakilacustomer.org	661 Chisinau Lane		Pietari	274	816436065431	t	2006-02-14	2013-05-26 14:49:45.738
296	Ramona	Hale	ramona.hale@sakilacustomer.org	951 Stara Zagora Manor		Punjab	400	429925609431	t	2006-02-14	2013-05-26 14:49:45.738
297	Sherri	Rhodes	sherri.rhodes@sakilacustomer.org	922 Vila Velha Loop		Maharashtra	9	510737228015	t	2006-02-14	2013-05-26 14:49:45.738
298	Erika	Pena	erika.pena@sakilacustomer.org	898 Jining Lane		Pohjois-Pohjanmaa	387	161643343536	t	2006-02-14	2013-05-26 14:49:45.738
299	James	Gannon	james.gannon@sakilacustomer.org	1635 Kuwana Boulevard		Hiroshima	205	710603868323	t	2006-02-14	2013-05-26 14:49:45.738
300	John	Farnsworth	john.farnsworth@sakilacustomer.org	41 El Alto Parkway		Maharashtra	398	51917807050	t	2006-02-14	2013-05-26 14:49:45.738
301	Robert	Baughman	robert.baughman@sakilacustomer.org	1883 Maikop Lane		Kaliningrad	254	96110042435	t	2006-02-14	2013-05-26 14:49:45.738
302	Michael	Silverman	michael.silverman@sakilacustomer.org	1908 Gaziantep Place		Liaoning	536	108053751300	t	2006-02-14	2013-05-26 14:49:45.738
303	William	Satterfield	william.satterfield@sakilacustomer.org	687 Alessandria Parkway		Sanaa	455	407218522294	t	2006-02-14	2013-05-26 14:49:45.738
304	David	Royal	david.royal@sakilacustomer.org	827 Yuncheng Drive		Callao	99	504434452842	t	2006-02-14	2013-05-26 14:49:45.738
305	Richard	Mccrary	richard.mccrary@sakilacustomer.org	913 Coacalco de Berriozbal Loop		Texas	33	262088367001	t	2006-02-14	2013-05-26 14:49:45.738
306	Charles	Kowalski	charles.kowalski@sakilacustomer.org	715 So Bernardo do Campo Lane		Kedah	507	181179321332	t	2006-02-14	2013-05-26 14:49:45.738
307	Joseph	Joy	joseph.joy@sakilacustomer.org	1354 Siegen Street		Rio de Janeiro	25	573441801529	t	2006-02-14	2013-05-26 14:49:45.738
308	Thomas	Grigsby	thomas.grigsby@sakilacustomer.org	1191 Sungai Petani Boulevard		Missouri	262	983259819766	t	2006-02-14	2013-05-26 14:49:45.738
309	Christopher	Greco	christopher.greco@sakilacustomer.org	1224 Huejutla de Reyes Boulevard		Lombardia	91	806016930576	t	2006-02-14	2013-05-26 14:49:45.738
310	Daniel	Cabral	daniel.cabral@sakilacustomer.org	543 Bergamo Avenue		Minas Gerais	215	103602195112	t	2006-02-14	2013-05-26 14:49:45.738
311	Paul	Trout	paul.trout@sakilacustomer.org	746 Joliet Lane		Kursk	286	688485191923	t	2006-02-14	2013-05-26 14:49:45.738
312	Mark	Rinehart	mark.rinehart@sakilacustomer.org	780 Kimberley Way		Tabuk	515	824396883951	t	2006-02-14	2013-05-26 14:49:45.738
313	Donald	Mahon	donald.mahon@sakilacustomer.org	1774 Yaound Place		Hubei	166	613124286867	t	2006-02-14	2013-05-26 14:49:45.738
314	George	Linton	george.linton@sakilacustomer.org	1957 Yantai Lane		So Paulo	490	704948322302	t	2006-02-14	2013-05-26 14:49:45.738
315	Kenneth	Gooden	kenneth.gooden@sakilacustomer.org	1542 Lubumbashi Boulevard		Tel Aviv	57	508800331065	t	2006-02-14	2013-05-26 14:49:45.738
316	Steven	Curley	steven.curley@sakilacustomer.org	651 Pathankot Loop		Maharashtra	336	139378397418	t	2006-02-14	2013-05-26 14:49:45.738
317	Edward	Baugh	edward.baugh@sakilacustomer.org	1359 Zhoushan Parkway		Streymoyar	545	46568045367	t	2006-02-14	2013-05-26 14:49:45.738
318	Brian	Wyman	brian.wyman@sakilacustomer.org	1769 Iwaki Lane		Kujawsko-Pomorskie	97	556100547674	t	2006-02-14	2013-05-26 14:49:45.738
319	Ronald	Weiner	ronald.weiner@sakilacustomer.org	1145 Vilnius Manor		Mxico	451	674805712553	t	2006-02-14	2013-05-26 14:49:45.738
320	Anthony	Schwab	anthony.schwab@sakilacustomer.org	1892 Nabereznyje Telny Lane		Tutuila	516	478229987054	t	2006-02-14	2013-05-26 14:49:45.738
321	Kevin	Schuler	kevin.schuler@sakilacustomer.org	470 Boksburg Street		Central	81	908029859266	t	2006-02-14	2013-05-26 14:49:45.738
322	Jason	Morrissey	jason.morrissey@sakilacustomer.org	1427 A Corua (La Corua) Place		Buenos Aires	45	972574862516	t	2006-02-14	2013-05-26 14:49:45.738
323	Matthew	Mahan	matthew.mahan@sakilacustomer.org	479 San Felipe del Progreso Avenue		Morelos	130	869051782691	t	2006-02-14	2013-05-26 14:49:45.738
324	Gary	Coy	gary.coy@sakilacustomer.org	867 Benin City Avenue		Henan	591	168884817145	t	2006-02-14	2013-05-26 14:49:45.738
325	Timothy	Bunn	timothy.bunn@sakilacustomer.org	981 Kumbakonam Place		Distrito Federal	89	829116184079	t	2006-02-14	2013-05-26 14:49:45.738
326	Jose	Andrew	jose.andrew@sakilacustomer.org	1016 Iwakuni Street		St George	269	961370847344	t	2006-02-14	2013-05-26 14:49:45.738
327	Larry	Thrasher	larry.thrasher@sakilacustomer.org	663 Baha Blanca Parkway		Adana	5	834418779292	t	2006-02-14	2013-05-26 14:49:45.738
328	Jeffrey	Spear	jeffrey.spear@sakilacustomer.org	1860 Taguig Loop		West Java	119	38158430589	t	2006-02-14	2013-05-26 14:49:45.738
329	Frank	Waggoner	frank.waggoner@sakilacustomer.org	1816 Bydgoszcz Loop		Dhaka	234	965273813662	t	2006-02-14	2013-05-26 14:49:45.738
330	Scott	Shelley	scott.shelley@sakilacustomer.org	587 Benguela Manor		Illinois	42	165450987037	t	2006-02-14	2013-05-26 14:49:45.738
331	Eric	Robert	eric.robert@sakilacustomer.org	430 Kumbakonam Drive		Santa F	457	105470691550	t	2006-02-14	2013-05-26 14:49:45.738
332	Stephen	Qualls	stephen.qualls@sakilacustomer.org	1838 Tabriz Lane		Dhaka	143	38988715447	t	2006-02-14	2013-05-26 14:49:45.738
333	Andrew	Purdy	andrew.purdy@sakilacustomer.org	431 Szkesfehrvr Avenue		Baki	48	119501405123	t	2006-02-14	2013-05-26 14:49:45.738
334	Raymond	Mcwhorter	raymond.mcwhorter@sakilacustomer.org	503 Sogamoso Loop		Sumqayit	505	834626715837	t	2006-02-14	2013-05-26 14:49:45.738
335	Gregory	Mauldin	gregory.mauldin@sakilacustomer.org	507 Smolensk Loop		Sousse	492	80303246192	t	2006-02-14	2013-05-26 14:49:45.738
336	Joshua	Mark	joshua.mark@sakilacustomer.org	1920 Weifang Avenue		Uttar Pradesh	427	869507847714	t	2006-02-14	2013-05-26 14:49:45.738
337	Jerry	Jordon	jerry.jordon@sakilacustomer.org	124 al-Manama Way		Hiroshima	382	647899404952	t	2006-02-14	2013-05-26 14:49:45.738
338	Dennis	Gilman	dennis.gilman@sakilacustomer.org	1443 Mardan Street		Western Cape	392	231383037471	t	2006-02-14	2013-05-26 14:49:45.738
339	Walter	Perryman	walter.perryman@sakilacustomer.org	1909 Benguela Lane		Henan	581	624138001031	t	2006-02-14	2013-05-26 14:49:45.738
340	Patrick	Newsom	patrick.newsom@sakilacustomer.org	68 Ponce Parkway		Hanoi	201	870635127812	t	2006-02-14	2013-05-26 14:49:45.738
341	Peter	Menard	peter.menard@sakilacustomer.org	1217 Konotop Avenue		Gelderland	151	718917251754	t	2006-02-14	2013-05-26 14:49:45.738
342	Harold	Martino	harold.martino@sakilacustomer.org	1293 Nam Dinh Way		Roraima	84	697656479977	t	2006-02-14	2013-05-26 14:49:45.738
343	Douglas	Graf	douglas.graf@sakilacustomer.org	785 Vaduz Street		Baja California	335	895616862749	t	2006-02-14	2013-05-26 14:49:45.738
344	Henry	Billingsley	henry.billingsley@sakilacustomer.org	1516 Escobar Drive		Tongatapu	370	64536069371	t	2006-02-14	2013-05-26 14:49:45.738
345	Carl	Artis	carl.artis@sakilacustomer.org	1628 Nagareyama Lane		Central	453	20064292617	t	2006-02-14	2013-05-26 14:49:45.738
346	Arthur	Simpkins	arthur.simpkins@sakilacustomer.org	1157 Nyeri Loop		Adygea	320	262744791493	t	2006-02-14	2013-05-26 14:49:45.738
347	Ryan	Salisbury	ryan.salisbury@sakilacustomer.org	1673 Tangail Drive		Daugavpils	137	627924259271	t	2006-02-14	2013-05-26 14:49:45.738
348	Roger	Quintanilla	roger.quintanilla@sakilacustomer.org	381 Kabul Way		Taipei	209	55477302294	t	2006-02-14	2013-05-26 14:49:45.738
349	Joe	Gilliland	joe.gilliland@sakilacustomer.org	953 Hodeida Street		Southern Tagalog	221	53912826864	t	2006-02-14	2013-05-26 14:49:45.738
350	Juan	Fraley	juan.fraley@sakilacustomer.org	469 Nakhon Sawan Street		Tuvassia	531	689199636560	t	2006-02-14	2013-05-26 14:49:45.738
351	Jack	Foust	jack.foust@sakilacustomer.org	1378 Beira Loop		Krasnojarsk	597	840957664136	t	2006-02-14	2013-05-26 14:49:45.738
352	Albert	Crouse	albert.crouse@sakilacustomer.org	1641 Changhwa Place		Nord-Ouest	52	256546485220	t	2006-02-14	2013-05-26 14:49:45.738
353	Jonathan	Scarborough	jonathan.scarborough@sakilacustomer.org	1698 Southport Loop		Hidalgo	393	754358349853	t	2006-02-14	2013-05-26 14:49:45.738
354	Justin	Ngo	justin.ngo@sakilacustomer.org	519 Nyeri Manor		So Paulo	461	764680915323	t	2006-02-14	2013-05-26 14:49:45.738
355	Terry	Grissom	terry.grissom@sakilacustomer.org	619 Hunuco Avenue		Shimane	331	142596392389	t	2006-02-14	2013-05-26 14:49:45.738
356	Gerald	Fultz	gerald.fultz@sakilacustomer.org	45 Aparecida de Goinia Place		Madhya Pradesh	464	650496654258	t	2006-02-14	2013-05-26 14:49:45.738
357	Keith	Rico	keith.rico@sakilacustomer.org	482 Kowloon and New Kowloon Manor		Bratislava	90	738968474939	t	2006-02-14	2013-05-26 14:49:45.738
358	Samuel	Marlow	samuel.marlow@sakilacustomer.org	604 Bern Place		Jharkhand	429	620719383725	t	2006-02-14	2013-05-26 14:49:45.738
359	Willie	Markham	willie.markham@sakilacustomer.org	1623 Kingstown Drive		Buenos Aires	20	296394569728	t	2006-02-14	2013-05-26 14:49:45.738
360	Ralph	Madrigal	ralph.madrigal@sakilacustomer.org	1009 Zanzibar Lane		Arecibo	32	102396298916	t	2006-02-14	2013-05-26 14:49:45.738
361	Lawrence	Lawton	lawrence.lawton@sakilacustomer.org	114 Jalib al-Shuyukh Manor		Centre	585	845378657301	t	2006-02-14	2013-05-26 14:49:45.738
362	Nicholas	Barfield	nicholas.barfield@sakilacustomer.org	1163 London Parkway		Par	66	675120358494	t	2006-02-14	2013-05-26 14:49:45.738
363	Roy	Whiting	roy.whiting@sakilacustomer.org	1658 Jastrzebie-Zdrj Loop		Central	372	568367775448	t	2006-02-14	2013-05-26 14:49:45.738
364	Benjamin	Varney	benjamin.varney@sakilacustomer.org	817 Laredo Avenue		Jalisco	188	151249681135	t	2006-02-14	2013-05-26 14:49:45.738
365	Bruce	Schwarz	bruce.schwarz@sakilacustomer.org	1565 Tangail Manor		Okinawa	377	634445428822	t	2006-02-14	2013-05-26 14:49:45.738
366	Brandon	Huey	brandon.huey@sakilacustomer.org	1912 Emeishan Drive		Balikesir	50	99883471275	t	2006-02-14	2013-05-26 14:49:45.738
367	Adam	Gooch	adam.gooch@sakilacustomer.org	230 Urawa Drive		Andhra Pradesh	8	166898395731	t	2006-02-14	2013-05-26 14:49:45.738
368	Harry	Arce	harry.arce@sakilacustomer.org	1922 Miraj Way		Esfahan	356	320471479776	t	2006-02-14	2013-05-26 14:49:45.738
369	Fred	Wheat	fred.wheat@sakilacustomer.org	433 Florencia Street		Chihuahua	250	561729882725	t	2006-02-14	2013-05-26 14:49:45.738
370	Wayne	Truong	wayne.truong@sakilacustomer.org	1049 Matamoros Parkway		Karnataka	191	960505250340	t	2006-02-14	2013-05-26 14:49:45.738
371	Billy	Poulin	billy.poulin@sakilacustomer.org	1061 Ede Avenue		Southern Tagalog	98	333390595558	t	2006-02-14	2013-05-26 14:49:45.738
372	Steve	Mackenzie	steve.mackenzie@sakilacustomer.org	154 Oshawa Manor		East Java	415	440365973660	t	2006-02-14	2013-05-26 14:49:45.738
373	Louis	Leone	louis.leone@sakilacustomer.org	1191 Tandil Drive		Southern Tagalog	523	45554316010	t	2006-02-14	2013-05-26 14:49:45.738
374	Jeremy	Hurtado	jeremy.hurtado@sakilacustomer.org	1133 Rizhao Avenue		Pernambuco	572	600264533987	t	2006-02-14	2013-05-26 14:49:45.738
375	Aaron	Selby	aaron.selby@sakilacustomer.org	1519 Santiago de los Caballeros Loop		East Kasai	348	409315295763	t	2006-02-14	2013-05-26 14:49:45.738
376	Randy	Gaither	randy.gaither@sakilacustomer.org	1618 Olomouc Manor		Kurgan	285	96846695220	t	2006-02-14	2013-05-26 14:49:45.738
377	Howard	Fortner	howard.fortner@sakilacustomer.org	220 Hidalgo Drive		Kermanshah	265	342720754566	t	2006-02-14	2013-05-26 14:49:45.738
378	Eugene	Culpepper	eugene.culpepper@sakilacustomer.org	686 Donostia-San Sebastin Lane		Guangdong	471	71857599858	t	2006-02-14	2013-05-26 14:49:45.738
379	Carlos	Coughlin	carlos.coughlin@sakilacustomer.org	97 Mogiljov Lane		Gujarat	73	924815207181	t	2006-02-14	2013-05-26 14:49:45.738
380	Russell	Brinson	russell.brinson@sakilacustomer.org	1642 Charlotte Amalie Drive		Slaskie	549	821476736117	t	2006-02-14	2013-05-26 14:49:45.738
381	Bobby	Boudreau	bobby.boudreau@sakilacustomer.org	1368 Maracabo Boulevard			493	934352415130	t	2006-02-14	2013-05-26 14:49:45.738
382	Victor	Barkley	victor.barkley@sakilacustomer.org	401 Sucre Boulevard		New Hampshire	322	486395999608	t	2006-02-14	2013-05-26 14:49:45.738
383	Martin	Bales	martin.bales@sakilacustomer.org	368 Hunuco Boulevard		Namibe	360	106439158941	t	2006-02-14	2013-05-26 14:49:45.738
384	Ernest	Stepp	ernest.stepp@sakilacustomer.org	500 Lincoln Parkway		Jiangsu	210	550306965159	t	2006-02-14	2013-05-26 14:49:45.738
385	Phillip	Holm	phillip.holm@sakilacustomer.org	102 Chapra Drive		Ibaragi	521	776031833752	t	2006-02-14	2013-05-26 14:49:45.738
386	Todd	Tan	todd.tan@sakilacustomer.org	1793 Meixian Place		Hmelnytskyi	258	619966287415	t	2006-02-14	2013-05-26 14:49:45.738
387	Jesse	Schilling	jesse.schilling@sakilacustomer.org	514 Ife Way		Shaba	315	900235712074	t	2006-02-14	2013-05-26 14:49:45.738
388	Craig	Morrell	craig.morrell@sakilacustomer.org	717 Changzhou Lane		Southern Tagalog	104	426255288071	t	2006-02-14	2013-05-26 14:49:45.738
389	Alan	Kahn	alan.kahn@sakilacustomer.org	753 Ilorin Avenue		Sichuan	157	464511145118	t	2006-02-14	2013-05-26 14:49:45.738
390	Shawn	Heaton	shawn.heaton@sakilacustomer.org	1337 Mit Ghamr Avenue		Nakhon Sawan	358	175283210378	t	2006-02-14	2013-05-26 14:49:45.738
391	Clarence	Gamez	clarence.gamez@sakilacustomer.org	767 Pyongyang Drive		Osaka	229	667736124769	t	2006-02-14	2013-05-26 14:49:45.738
392	Sean	Douglass	sean.douglass@sakilacustomer.org	614 Pak Kret Street		Addis Abeba	6	47808359842	t	2006-02-14	2013-05-26 14:49:45.738
393	Philip	Causey	philip.causey@sakilacustomer.org	954 Lapu-Lapu Way		Moskova	278	737229003916	t	2006-02-14	2013-05-26 14:49:45.738
394	Chris	Brothers	chris.brothers@sakilacustomer.org	331 Bydgoszcz Parkway		Asturia	181	537374465982	t	2006-02-14	2013-05-26 14:49:45.738
395	Johnny	Turpin	johnny.turpin@sakilacustomer.org	1152 Citrus Heights Manor		al-Qadarif	15	765957414528	t	2006-02-14	2013-05-26 14:49:45.738
396	Earl	Shanks	earl.shanks@sakilacustomer.org	168 Cianjur Manor		Saitama	228	679095087143	t	2006-02-14	2013-05-26 14:49:45.738
397	Jimmy	Schrader	jimmy.schrader@sakilacustomer.org	616 Hagonoy Avenue		Krasnojarsk	39	604177838256	t	2006-02-14	2013-05-26 14:49:45.738
398	Antonio	Meek	antonio.meek@sakilacustomer.org	1190 0 Place		Rio Grande do Sul	44	841876514789	t	2006-02-14	2013-05-26 14:49:45.738
399	Danny	Isom	danny.isom@sakilacustomer.org	734 Bchar Place		Punjab	375	280578750435	t	2006-02-14	2013-05-26 14:49:45.738
400	Bryan	Hardison	bryan.hardison@sakilacustomer.org	530 Lausanne Lane		Texas	135	775235029633	t	2006-02-14	2013-05-26 14:49:45.738
401	Tony	Carranza	tony.carranza@sakilacustomer.org	454 Patiala Lane		Fukushima	276	794553031307	t	2006-02-14	2013-05-26 14:49:45.738
402	Luis	Yanez	luis.yanez@sakilacustomer.org	1346 Mysore Drive		Bretagne	92	516647474029	t	2006-02-14	2013-05-26 14:49:45.738
403	Mike	Way	mike.way@sakilacustomer.org	990 Etawah Loop		Tamil Nadu	564	206169448769	t	2006-02-14	2013-05-26 14:49:45.738
404	Stanley	Scroggins	stanley.scroggins@sakilacustomer.org	1266 Laredo Parkway		Saitama	380	1483365694	t	2006-02-14	2013-05-26 14:49:45.738
405	Leonard	Schofield	leonard.schofield@sakilacustomer.org	88 Nagaon Manor		Buenos Aires	524	779461480495	t	2006-02-14	2013-05-26 14:49:45.738
406	Nathan	Runyon	nathan.runyon@sakilacustomer.org	264 Bhimavaram Manor		St Thomas	111	302526949177	t	2006-02-14	2013-05-26 14:49:45.738
407	Dale	Ratcliff	dale.ratcliff@sakilacustomer.org	1639 Saarbrcken Drive		North West	437	328494873422	t	2006-02-14	2013-05-26 14:49:45.738
408	Manuel	Murrell	manuel.murrell@sakilacustomer.org	692 Amroha Drive		Northern	230	359478883004	t	2006-02-14	2013-05-26 14:49:45.738
409	Rodney	Moeller	rodney.moeller@sakilacustomer.org	1936 Lapu-Lapu Parkway		Bauchi & Gombe	141	653436985797	t	2006-02-14	2013-05-26 14:49:45.738
410	Curtis	Irby	curtis.irby@sakilacustomer.org	432 Garden Grove Street		Ontario	430	615964523510	t	2006-02-14	2013-05-26 14:49:45.738
411	Norman	Currier	norman.currier@sakilacustomer.org	1445 Carmen Parkway		West Java	117	598912394463	t	2006-02-14	2013-05-26 14:49:45.738
412	Allen	Butterfield	allen.butterfield@sakilacustomer.org	791 Salinas Street		Punjab	208	129953030512	t	2006-02-14	2013-05-26 14:49:45.738
413	Marvin	Yee	marvin.yee@sakilacustomer.org	126 Acua Parkway		West Bengali	71	480039662421	t	2006-02-14	2013-05-26 14:49:45.738
414	Vincent	Ralston	vincent.ralston@sakilacustomer.org	397 Sunnyvale Avenue		Guanajuato	19	680851640676	t	2006-02-14	2013-05-26 14:49:45.738
415	Glenn	Pullen	glenn.pullen@sakilacustomer.org	992 Klerksdorp Loop		Utrecht	23	855290087237	t	2006-02-14	2013-05-26 14:49:45.738
416	Jeffery	Pinson	jeffery.pinson@sakilacustomer.org	966 Arecibo Loop		Sind	134	15273765306	t	2006-02-14	2013-05-26 14:49:45.738
417	Travis	Estep	travis.estep@sakilacustomer.org	289 Santo Andr Manor		al-Sharqiya	16	214976066017	t	2006-02-14	2013-05-26 14:49:45.738
418	Jeff	East	jeff.east@sakilacustomer.org	437 Chungho Drive		Puerto Plata	450	491271355190	t	2006-02-14	2013-05-26 14:49:45.738
419	Chad	Carbone	chad.carbone@sakilacustomer.org	1948 Bayugan Parkway		Bihar	264	987306329957	t	2006-02-14	2013-05-26 14:49:45.738
420	Jacob	Lance	jacob.lance@sakilacustomer.org	1866 al-Qatif Avenue		California	155	546793516940	t	2006-02-14	2013-05-26 14:49:45.738
421	Lee	Hawks	lee.hawks@sakilacustomer.org	1661 Abha Drive		Tamil Nadu	416	270456873752	t	2006-02-14	2013-05-26 14:49:45.738
422	Melvin	Ellington	melvin.ellington@sakilacustomer.org	1557 Cape Coral Parkway		Hubei	293	368284120423	t	2006-02-14	2013-05-26 14:49:45.738
423	Alfred	Casillas	alfred.casillas@sakilacustomer.org	1727 Matamoros Place		Sawhaj	465	129673677866	t	2006-02-14	2013-05-26 14:49:45.738
424	Kyle	Spurlock	kyle.spurlock@sakilacustomer.org	1269 Botosani Manor		Guangdong	468	736517327853	t	2006-02-14	2013-05-26 14:49:45.738
425	Francis	Sikes	francis.sikes@sakilacustomer.org	355 Vitria de Santo Anto Way		Oaxaca	452	548003849552	t	2006-02-14	2013-05-26 14:49:45.738
426	Bradley	Motley	bradley.motley@sakilacustomer.org	1596 Acua Parkway		Jharkhand	418	157133457169	t	2006-02-14	2013-05-26 14:49:45.738
427	Jesus	Mccartney	jesus.mccartney@sakilacustomer.org	259 Ipoh Drive		So Paulo	189	419009857119	t	2006-02-14	2013-05-26 14:49:45.738
428	Herbert	Kruger	herbert.kruger@sakilacustomer.org	1823 Hoshiarpur Lane		Komi	510	307133768620	t	2006-02-14	2013-05-26 14:49:45.738
429	Frederick	Isbell	frederick.isbell@sakilacustomer.org	1404 Taguig Drive		Okayama	547	572068624538	t	2006-02-14	2013-05-26 14:49:45.738
430	Ray	Houle	ray.houle@sakilacustomer.org	740 Udaipur Lane		Nizni Novgorod	150	497288595103	t	2006-02-14	2013-05-26 14:49:45.738
431	Joel	Francisco	joel.francisco@sakilacustomer.org	287 Cuautla Boulevard		Chuquisaca	501	82619513349	t	2006-02-14	2013-05-26 14:49:45.738
432	Edwin	Burk	edwin.burk@sakilacustomer.org	1766 Almirante Brown Street		KwaZulu-Natal	364	617567598243	t	2006-02-14	2013-05-26 14:49:45.738
433	Don	Bone	don.bone@sakilacustomer.org	596 Huixquilucan Place		Nampula	351	342709348083	t	2006-02-14	2013-05-26 14:49:45.738
434	Eddie	Tomlin	eddie.tomlin@sakilacustomer.org	1351 Aparecida de Goinia Parkway		Northern Mindanao	391	959834530529	t	2006-02-14	2013-05-26 14:49:45.738
435	Ricky	Shelby	ricky.shelby@sakilacustomer.org	722 Bradford Lane		Shandong	249	746251338300	t	2006-02-14	2013-05-26 14:49:45.738
436	Troy	Quigley	troy.quigley@sakilacustomer.org	983 Santa F Way		British Colombia	565	145720452260	t	2006-02-14	2013-05-26 14:49:45.738
437	Randall	Neumann	randall.neumann@sakilacustomer.org	1245 Ibirit Way		La Romana	290	331888642162	t	2006-02-14	2013-05-26 14:49:45.738
438	Barry	Lovelace	barry.lovelace@sakilacustomer.org	1836 Korla Parkway		Copperbelt	272	689681677428	t	2006-02-14	2013-05-26 14:49:45.738
439	Alexander	Fennell	alexander.fennell@sakilacustomer.org	231 Kaliningrad Place		Lombardia	70	575081026569	t	2006-02-14	2013-05-26 14:49:45.738
440	Bernard	Colby	bernard.colby@sakilacustomer.org	495 Bhimavaram Lane		Maharashtra	144	82088937724	t	2006-02-14	2013-05-26 14:49:45.738
441	Mario	Cheatham	mario.cheatham@sakilacustomer.org	1924 Shimonoseki Drive		Batna	59	406784385440	t	2006-02-14	2013-05-26 14:49:45.738
442	Leroy	Bustamante	leroy.bustamante@sakilacustomer.org	105 Dzerzinsk Manor		Inner Mongolia	540	240776414296	t	2006-02-14	2013-05-26 14:49:45.738
443	Francisco	Skidmore	francisco.skidmore@sakilacustomer.org	614 Denizli Parkway		Rio Grande do Sul	486	876491807547	t	2006-02-14	2013-05-26 14:49:45.738
444	Marcus	Hidalgo	marcus.hidalgo@sakilacustomer.org	1289 Belm Boulevard		Tartumaa	530	237368926031	t	2006-02-14	2013-05-26 14:49:45.738
445	Micheal	Forman	micheal.forman@sakilacustomer.org	203 Tambaram Street		Buenos Aires	161	411549550611	t	2006-02-14	2013-05-26 14:49:45.738
446	Theodore	Culp	theodore.culp@sakilacustomer.org	1704 Tambaram Manor		West Bengali	554	39463554936	t	2006-02-14	2013-05-26 14:49:45.738
447	Clifford	Bowens	clifford.bowens@sakilacustomer.org	207 Cuernavaca Loop		Tatarstan	352	782900030287	t	2006-02-14	2013-05-26 14:49:45.738
448	Miguel	Betancourt	miguel.betancourt@sakilacustomer.org	319 Springs Loop		Baijeri	160	72524459905	t	2006-02-14	2013-05-26 14:49:45.738
449	Oscar	Aquino	oscar.aquino@sakilacustomer.org	956 Nam Dinh Manor		Kerman	481	474047727727	t	2006-02-14	2013-05-26 14:49:45.738
450	Jay	Robb	jay.robb@sakilacustomer.org	1947 Paarl Way		Central Java	509	834061016202	t	2006-02-14	2013-05-26 14:49:45.738
451	Jim	Rea	jim.rea@sakilacustomer.org	814 Simferopol Loop		Sinaloa	154	524567129902	t	2006-02-14	2013-05-26 14:49:45.738
452	Tom	Milner	tom.milner@sakilacustomer.org	535 Ahmadnagar Manor		Abu Dhabi	3	985109775584	t	2006-02-14	2013-05-26 14:49:45.738
453	Calvin	Martel	calvin.martel@sakilacustomer.org	138 Caracas Boulevard		Zulia	326	974433019532	t	2006-02-14	2013-05-26 14:49:45.738
454	Alex	Gresham	alex.gresham@sakilacustomer.org	251 Florencia Drive		Michoacn de Ocampo	556	118011831565	t	2006-02-14	2013-05-26 14:49:45.738
455	Jon	Wiles	jon.wiles@sakilacustomer.org	659 Gatineau Boulevard		La Paz	153	205524798287	t	2006-02-14	2013-05-26 14:49:45.738
456	Ronnie	Ricketts	ronnie.ricketts@sakilacustomer.org	1889 Valparai Way		Ziguinchor	600	670370974122	t	2006-02-14	2013-05-26 14:49:45.738
457	Bill	Gavin	bill.gavin@sakilacustomer.org	1485 Bratislava Place		Illinois	435	924663855568	t	2006-02-14	2013-05-26 14:49:45.738
458	Lloyd	Dowd	lloyd.dowd@sakilacustomer.org	935 Aden Boulevard		Central Java	532	335052544020	t	2006-02-14	2013-05-26 14:49:45.738
459	Tommy	Collazo	tommy.collazo@sakilacustomer.org	76 Kermanshah Manor		Esfahan	423	762361821578	t	2006-02-14	2013-05-26 14:49:45.738
460	Leon	Bostic	leon.bostic@sakilacustomer.org	734 Tanshui Avenue		Caquet	170	366776723320	t	2006-02-14	2013-05-26 14:49:45.738
461	Derek	Blakely	derek.blakely@sakilacustomer.org	118 Jaffna Loop		Northern Mindanao	182	325526730021	t	2006-02-14	2013-05-26 14:49:45.738
462	Warren	Sherrod	warren.sherrod@sakilacustomer.org	1621 Tongliao Avenue		Irkutsk	558	209342540247	t	2006-02-14	2013-05-26 14:49:45.738
463	Darrell	Power	darrell.power@sakilacustomer.org	1844 Usak Avenue		Nova Scotia	196	164414772677	t	2006-02-14	2013-05-26 14:49:45.738
464	Jerome	Kenyon	jerome.kenyon@sakilacustomer.org	1872 Toulon Loop		OHiggins	428	928809465153	t	2006-02-14	2013-05-26 14:49:45.738
465	Floyd	Gandy	floyd.gandy@sakilacustomer.org	1088 Ibirit Place		Jalisco	595	49084281333	t	2006-02-14	2013-05-26 14:49:45.738
466	Leo	Ebert	leo.ebert@sakilacustomer.org	1322 Mosul Parkway		Shandong	145	268053970382	t	2006-02-14	2013-05-26 14:49:45.738
467	Alvin	Deloach	alvin.deloach@sakilacustomer.org	1447 Chatsworth Place		Chihuahua	129	769370126331	t	2006-02-14	2013-05-26 14:49:45.738
468	Tim	Cary	tim.cary@sakilacustomer.org	1257 Guadalajara Street		Karnataka	78	195337700615	t	2006-02-14	2013-05-26 14:49:45.738
469	Wesley	Bull	wesley.bull@sakilacustomer.org	1469 Plock Lane		Galicia	388	622884741180	t	2006-02-14	2013-05-26 14:49:45.738
470	Gordon	Allard	gordon.allard@sakilacustomer.org	434 Ourense (Orense) Manor		Hodeida	206	562370137426	t	2006-02-14	2013-05-26 14:49:45.738
471	Dean	Sauer	dean.sauer@sakilacustomer.org	270 Tambaram Parkway		Gauteng	244	248446668735	t	2006-02-14	2013-05-26 14:49:45.738
472	Greg	Robins	greg.robins@sakilacustomer.org	1786 Salinas Place		Nam Ha	359	206060652238	t	2006-02-14	2013-05-26 14:49:45.738
473	Jorge	Olivares	jorge.olivares@sakilacustomer.org	1078 Stara Zagora Drive		Aceh	301	932992626595	t	2006-02-14	2013-05-26 14:49:45.738
474	Dustin	Gillette	dustin.gillette@sakilacustomer.org	1854 Okara Boulevard		Drenthe	158	131912793873	t	2006-02-14	2013-05-26 14:49:45.738
475	Pedro	Chestnut	pedro.chestnut@sakilacustomer.org	421 Yaound Street		Sumy	385	726875628268	t	2006-02-14	2013-05-26 14:49:45.738
476	Derrick	Bourque	derrick.bourque@sakilacustomer.org	1153 Allende Way		Qubec	179	856872225376	t	2006-02-14	2013-05-26 14:49:45.738
477	Dan	Paine	dan.paine@sakilacustomer.org	808 Naala-Porto Parkway		England	500	553452430707	t	2006-02-14	2013-05-26 14:49:45.738
478	Lewis	Lyman	lewis.lyman@sakilacustomer.org	632 Usolje-Sibirskoje Parkway		Ha Darom	36	667648979883	t	2006-02-14	2013-05-26 14:49:45.738
479	Zachary	Hite	zachary.hite@sakilacustomer.org	98 Pyongyang Boulevard		Ohio	11	191958435142	t	2006-02-14	2013-05-26 14:49:45.738
480	Corey	Hauser	corey.hauser@sakilacustomer.org	984 Novoterkassk Loop		Gaziantep	180	435118527255	t	2006-02-14	2013-05-26 14:49:45.738
481	Herman	Devore	herman.devore@sakilacustomer.org	64 Korla Street		Mwanza	347	510383179153	t	2006-02-14	2013-05-26 14:49:45.738
482	Maurice	Crawley	maurice.crawley@sakilacustomer.org	1785 So Bernardo do Campo Street		Veracruz	125	684529463244	t	2006-02-14	2013-05-26 14:49:45.738
483	Vernon	Chapa	vernon.chapa@sakilacustomer.org	698 Jelets Boulevard		Denizli	142	975185523021	t	2006-02-14	2013-05-26 14:49:45.738
484	Roberto	Vu	roberto.vu@sakilacustomer.org	1297 Alvorada Parkway		Ningxia	587	508348602835	t	2006-02-14	2013-05-26 14:49:45.738
485	Clyde	Tobias	clyde.tobias@sakilacustomer.org	1909 Dayton Avenue		Guangdong	469	702955450528	t	2006-02-14	2013-05-26 14:49:45.738
486	Glen	Talbert	glen.talbert@sakilacustomer.org	1789 Saint-Denis Parkway		Coahuila de Zaragoza	4	936806643983	t	2006-02-14	2013-05-26 14:49:45.738
487	Hector	Poindexter	hector.poindexter@sakilacustomer.org	185 Mannheim Lane		Stavropol	408	589377568313	t	2006-02-14	2013-05-26 14:49:45.738
488	Shane	Millard	shane.millard@sakilacustomer.org	184 Mandaluyong Street		Baja California Sur	288	488425406814	t	2006-02-14	2013-05-26 14:49:45.738
489	Ricardo	Meador	ricardo.meador@sakilacustomer.org	591 Sungai Petani Drive		Okayama	376	37247325001	t	2006-02-14	2013-05-26 14:49:45.738
490	Sam	Mcduffie	sam.mcduffie@sakilacustomer.org	656 Matamoros Drive		Boyac	487	17305839123	t	2006-02-14	2013-05-26 14:49:45.738
491	Rick	Mattox	rick.mattox@sakilacustomer.org	775 ostka Drive		al-Daqahliya	337	171973024401	t	2006-02-14	2013-05-26 14:49:45.738
492	Lester	Kraus	lester.kraus@sakilacustomer.org	1013 Tabuk Boulevard		West Bengali	261	158399646978	t	2006-02-14	2013-05-26 14:49:45.738
493	Brent	Harkins	brent.harkins@sakilacustomer.org	319 Plock Parkway		Istanbul	504	854259976812	t	2006-02-14	2013-05-26 14:49:45.738
494	Ramon	Choate	ramon.choate@sakilacustomer.org	1954 Kowloon and New Kowloon Way		Chimborazo	434	898559280434	t	2006-02-14	2013-05-26 14:49:45.738
495	Charlie	Bess	charlie.bess@sakilacustomer.org	362 Rajkot Lane		Gansu	47	962020153680	t	2006-02-14	2013-05-26 14:49:45.738
496	Tyler	Wren	tyler.wren@sakilacustomer.org	1060 Tandil Lane		Shandong	432	211256301880	t	2006-02-14	2013-05-26 14:49:45.738
497	Gilbert	Sledge	gilbert.sledge@sakilacustomer.org	1515 Korla Way		England	589	959467760895	t	2006-02-14	2013-05-26 14:49:45.738
498	Gene	Sanborn	gene.sanborn@sakilacustomer.org	1416 San Juan Bautista Tuxtepec Avenue		Zufar	444	144206758053	t	2006-02-14	2013-05-26 14:49:45.738
499	Marc	Outlaw	marc.outlaw@sakilacustomer.org	1 Valle de Santiago Avenue		Apulia	93	465897838272	t	2006-02-14	2013-05-26 14:49:45.738
500	Reginald	Kinder	reginald.kinder@sakilacustomer.org	519 Brescia Parkway		East Java	318	793996678771	t	2006-02-14	2013-05-26 14:49:45.738
501	Ruben	Geary	ruben.geary@sakilacustomer.org	414 Mandaluyong Street		Lubelskie	314	52709222667	t	2006-02-14	2013-05-26 14:49:45.738
502	Brett	Cornwell	brett.cornwell@sakilacustomer.org	1197 Sokoto Boulevard		West Bengali	478	868602816371	t	2006-02-14	2013-05-26 14:49:45.738
503	Angel	Barclay	angel.barclay@sakilacustomer.org	496 Celaya Drive		Nagano	552	759586584889	t	2006-02-14	2013-05-26 14:49:45.738
504	Nathaniel	Adam	nathaniel.adam@sakilacustomer.org	786 Matsue Way		Illinois	245	111177206479	t	2006-02-14	2013-05-26 14:49:45.738
505	Rafael	Abney	rafael.abney@sakilacustomer.org	48 Maracabo Place		Central Luzon	519	82671830126	t	2006-02-14	2013-05-26 14:49:45.738
506	Leslie	Seward	leslie.seward@sakilacustomer.org	1152 al-Qatif Lane		Kalimantan Barat	412	131370665218	t	2006-02-14	2013-05-26 14:49:45.738
507	Edgar	Rhoads	edgar.rhoads@sakilacustomer.org	1269 Ipoh Avenue		Eskisehir	163	402630109080	t	2006-02-14	2013-05-26 14:49:45.738
508	Milton	Howland	milton.howland@sakilacustomer.org	758 Korolev Parkway		Andhra Pradesh	568	441628280920	t	2006-02-14	2013-05-26 14:49:45.738
509	Raul	Fortier	raul.fortier@sakilacustomer.org	1747 Rustenburg Place		Bihar	110	442673923363	t	2006-02-14	2013-05-26 14:49:45.738
510	Ben	Easter	ben.easter@sakilacustomer.org	886 Tonghae Place		Volgograd	259	711928348157	t	2006-02-14	2013-05-26 14:49:45.738
511	Chester	Benner	chester.benner@sakilacustomer.org	1574 Goinia Boulevard		Heilongjiang	502	59634255214	t	2006-02-14	2013-05-26 14:49:45.738
512	Cecil	Vines	cecil.vines@sakilacustomer.org	548 Uruapan Street		Ontario	312	879347453467	t	2006-02-14	2013-05-26 14:49:45.738
513	Duane	Tubbs	duane.tubbs@sakilacustomer.org	962 Tama Loop			583	282667506728	t	2006-02-14	2013-05-26 14:49:45.738
514	Franklin	Troutman	franklin.troutman@sakilacustomer.org	1778 Gijn Manor		Hubei	594	288910576761	t	2006-02-14	2013-05-26 14:49:45.738
515	Andre	Rapp	andre.rapp@sakilacustomer.org	568 Dhule (Dhulia) Loop		Coquimbo	127	602101369463	t	2006-02-14	2013-05-26 14:49:45.738
516	Elmer	Noe	elmer.noe@sakilacustomer.org	1768 Udine Loop		Battambang	60	448876499197	t	2006-02-14	2013-05-26 14:49:45.738
517	Brad	Mccurdy	brad.mccurdy@sakilacustomer.org	608 Birgunj Parkway		Taipei	116	627425618482	t	2006-02-14	2013-05-26 14:49:45.738
518	Gabriel	Harder	gabriel.harder@sakilacustomer.org	680 A Corua (La Corua) Manor		Sivas	482	158326114853	t	2006-02-14	2013-05-26 14:49:45.738
519	Ron	Deluca	ron.deluca@sakilacustomer.org	1949 Sanya Street		Gumma	224	132100972047	t	2006-02-14	2013-05-26 14:49:45.738
520	Mitchell	Westmoreland	mitchell.westmoreland@sakilacustomer.org	617 Klerksdorp Place		Khanh Hoa	366	574973479129	t	2006-02-14	2013-05-26 14:49:45.738
521	Roland	South	roland.south@sakilacustomer.org	1993 0 Loop		Liaoning	588	25865528181	t	2006-02-14	2013-05-26 14:49:45.738
522	Arnold	Havens	arnold.havens@sakilacustomer.org	1176 Southend-on-Sea Manor		Southern Tagalog	458	236679267178	t	2006-02-14	2013-05-26 14:49:45.738
523	Harvey	Guajardo	harvey.guajardo@sakilacustomer.org	600 Purnea (Purnia) Avenue		Nghe An	571	638409958875	t	2006-02-14	2013-05-26 14:49:45.738
525	Adrian	Clary	adrian.clary@sakilacustomer.org	1986 Sivas Place		Friuli-Venezia Giuli	551	182059202712	t	2006-02-14	2013-05-26 14:49:45.738
526	Karl	Seal	karl.seal@sakilacustomer.org	1427 Tabuk Place		Florida	101	214756839122	t	2006-02-14	2013-05-26 14:49:45.738
527	Cory	Meehan	cory.meehan@sakilacustomer.org	556 Asuncin Way		Mogiljov	339	338244023543	t	2006-02-14	2013-05-26 14:49:45.738
528	Claude	Herzog	claude.herzog@sakilacustomer.org	486 Ondo Parkway		Benguela	67	105882218332	t	2006-02-14	2013-05-26 14:49:45.738
529	Erik	Guillen	erik.guillen@sakilacustomer.org	635 Brest Manor		Andhra Pradesh	75	80593242951	t	2006-02-14	2013-05-26 14:49:45.738
530	Darryl	Ashcraft	darryl.ashcraft@sakilacustomer.org	166 Jinchang Street		Buenos Aires	165	717566026669	t	2006-02-14	2013-05-26 14:49:45.738
531	Jamie	Waugh	jamie.waugh@sakilacustomer.org	958 Sagamihara Lane		Mie	287	427274926505	t	2006-02-14	2013-05-26 14:49:45.738
532	Neil	Renner	neil.renner@sakilacustomer.org	1817 Livorno Way		Khanh Hoa	100	478380208348	t	2006-02-14	2013-05-26 14:49:45.738
533	Jessie	Milam	jessie.milam@sakilacustomer.org	1332 Gaziantep Lane		Shandong	80	383353187467	t	2006-02-14	2013-05-26 14:49:45.738
534	Christian	Jung	christian.jung@sakilacustomer.org	949 Allende Lane		Uttar Pradesh	24	122981120653	t	2006-02-14	2013-05-26 14:49:45.738
535	Javier	Elrod	javier.elrod@sakilacustomer.org	195 Ilorin Street		Chari-Baguirmi	363	8912935608	t	2006-02-14	2013-05-26 14:49:45.738
536	Fernando	Churchill	fernando.churchill@sakilacustomer.org	193 Bhusawal Place		Kang-won	539	745267607502	t	2006-02-14	2013-05-26 14:49:45.738
537	Clinton	Buford	clinton.buford@sakilacustomer.org	43 Vilnius Manor		Colorado	42	484500282381	t	2006-02-14	2013-05-26 14:49:45.738
538	Ted	Breaux	ted.breaux@sakilacustomer.org	183 Haiphong Street		Jilin	46	488600270038	t	2006-02-14	2013-05-26 14:49:45.738
539	Mathew	Bolin	mathew.bolin@sakilacustomer.org	163 Augusta-Richmond County Loop		Carabobo	561	754579047924	t	2006-02-14	2013-05-26 14:49:45.738
540	Tyrone	Asher	tyrone.asher@sakilacustomer.org	191 Jos Azueta Parkway		Ruse	436	932156667696	t	2006-02-14	2013-05-26 14:49:45.738
541	Darren	Windham	darren.windham@sakilacustomer.org	379 Lublin Parkway		Toscana	309	921960450089	t	2006-02-14	2013-05-26 14:49:45.738
542	Lonnie	Tirado	lonnie.tirado@sakilacustomer.org	1658 Cuman Loop		Sumatera Selatan	396	784907335610	t	2006-02-14	2013-05-26 14:49:45.738
543	Lance	Pemberton	lance.pemberton@sakilacustomer.org	454 Qinhuangdao Drive		Tadla-Azilal	68	786270036240	t	2006-02-14	2013-05-26 14:49:45.738
544	Cody	Nolen	cody.nolen@sakilacustomer.org	1715 Okayama Street		So Paulo	485	169352919175	t	2006-02-14	2013-05-26 14:49:45.738
545	Julio	Noland	julio.noland@sakilacustomer.org	182 Nukualofa Drive		Sumy	275	426346224043	t	2006-02-14	2013-05-26 14:49:45.738
546	Kelly	Knott	kelly.knott@sakilacustomer.org	390 Wroclaw Way		Hainan	462	357593328658	t	2006-02-14	2013-05-26 14:49:45.738
547	Kurt	Emmons	kurt.emmons@sakilacustomer.org	1421 Quilmes Lane		Ishikawa	260	135407755975	t	2006-02-14	2013-05-26 14:49:45.738
548	Allan	Cornish	allan.cornish@sakilacustomer.org	947 Trshavn Place		Central Luzon	528	50898428626	t	2006-02-14	2013-05-26 14:49:45.738
549	Nelson	Christenson	nelson.christenson@sakilacustomer.org	1764 Jalib al-Shuyukh Parkway		Galicia	459	84794532510	t	2006-02-14	2013-05-26 14:49:45.738
550	Guy	Brownlee	guy.brownlee@sakilacustomer.org	346 Cam Ranh Avenue		Zhejiang	599	978430786151	t	2006-02-14	2013-05-26 14:49:45.738
551	Clayton	Barbee	clayton.barbee@sakilacustomer.org	1407 Pachuca de Soto Place		Rio Grande do Sul	21	380077794770	t	2006-02-14	2013-05-26 14:49:45.738
552	Hugh	Waldrop	hugh.waldrop@sakilacustomer.org	904 Clarksville Drive		Zhejiang	193	955349440539	t	2006-02-14	2013-05-26 14:49:45.738
553	Max	Pitt	max.pitt@sakilacustomer.org	1917 Kumbakonam Parkway		Vojvodina	368	698182547686	t	2006-02-14	2013-05-26 14:49:45.738
554	Dwayne	Olvera	dwayne.olvera@sakilacustomer.org	1447 Imus Place		Gujarat	426	62127829280	t	2006-02-14	2013-05-26 14:49:45.738
555	Dwight	Lombardi	dwight.lombardi@sakilacustomer.org	1497 Fengshan Drive		KwaZulu-Natal	112	368738360376	t	2006-02-14	2013-05-26 14:49:45.738
556	Armando	Gruber	armando.gruber@sakilacustomer.org	869 Shikarpur Way		England	496	590764256785	t	2006-02-14	2013-05-26 14:49:45.738
557	Felix	Gaffney	felix.gaffney@sakilacustomer.org	1059 Yuncheng Avenue		Vilna	570	107092893983	t	2006-02-14	2013-05-26 14:49:45.738
558	Jimmie	Eggleston	jimmie.eggleston@sakilacustomer.org	505 Madiun Boulevard		Dolnoslaskie	577	970638808606	t	2006-02-14	2013-05-26 14:49:45.738
559	Everett	Banda	everett.banda@sakilacustomer.org	1741 Hoshiarpur Boulevard		al-Sharqiya	79	855066328617	t	2006-02-14	2013-05-26 14:49:45.738
560	Jordan	Archuleta	jordan.archuleta@sakilacustomer.org	1229 Varanasi (Benares) Manor		Buenos Aires	43	817740355461	t	2006-02-14	2013-05-26 14:49:45.738
561	Ian	Still	ian.still@sakilacustomer.org	1894 Boa Vista Way		Texas	178	239357986667	t	2006-02-14	2013-05-26 14:49:45.738
562	Wallace	Slone	wallace.slone@sakilacustomer.org	1342 Sharja Way		Sokoto & Kebbi & Zam	488	946114054231	t	2006-02-14	2013-05-26 14:49:45.738
563	Ken	Prewitt	ken.prewitt@sakilacustomer.org	1342 Abha Boulevard		Bukarest	95	997453607116	t	2006-02-14	2013-05-26 14:49:45.738
564	Bob	Pfeiffer	bob.pfeiffer@sakilacustomer.org	415 Pune Avenue		Shandong	580	203202500108	t	2006-02-14	2013-05-26 14:49:45.738
565	Jaime	Nettles	jaime.nettles@sakilacustomer.org	1746 Faaa Way		Huanuco	214	863080561151	t	2006-02-14	2013-05-26 14:49:45.738
566	Casey	Mena	casey.mena@sakilacustomer.org	539 Hami Way		Tokat	538	525518075499	t	2006-02-14	2013-05-26 14:49:45.738
567	Alfredo	Mcadams	alfredo.mcadams@sakilacustomer.org	1407 Surakarta Manor		Moskova	466	324346485054	t	2006-02-14	2013-05-26 14:49:45.738
568	Alberto	Henning	alberto.henning@sakilacustomer.org	502 Mandi Bahauddin Parkway		Anzotegui	55	618156722572	t	2006-02-14	2013-05-26 14:49:45.738
569	Dave	Gardiner	dave.gardiner@sakilacustomer.org	1052 Pathankot Avenue		Sichuan	299	128499386727	t	2006-02-14	2013-05-26 14:49:45.738
570	Ivan	Cromwell	ivan.cromwell@sakilacustomer.org	1351 Sousse Lane		Coahuila de Zaragoza	341	203804046132	t	2006-02-14	2013-05-26 14:49:45.738
571	Johnnie	Chisholm	johnnie.chisholm@sakilacustomer.org	1501 Pangkal Pinang Avenue		Mazowieckie	409	770864062795	t	2006-02-14	2013-05-26 14:49:45.738
572	Sidney	Burleson	sidney.burleson@sakilacustomer.org	1405 Hagonoy Avenue		Slaskie	133	867287719310	t	2006-02-14	2013-05-26 14:49:45.738
573	Byron	Box	byron.box@sakilacustomer.org	521 San Juan Bautista Tuxtepec Place		Qaraghandy	598	844018348565	t	2006-02-14	2013-05-26 14:49:45.738
574	Julian	Vest	julian.vest@sakilacustomer.org	923 Tangail Boulevard		Tokyo-to	10	315528269898	t	2006-02-14	2013-05-26 14:49:45.738
575	Isaac	Oglesby	isaac.oglesby@sakilacustomer.org	186 Skikda Lane		Morelos	131	14465669789	t	2006-02-14	2013-05-26 14:49:45.738
576	Morris	Mccarter	morris.mccarter@sakilacustomer.org	1568 Celaya Parkway		Kaohsiung	168	278669994384	t	2006-02-14	2013-05-26 14:49:45.738
577	Clifton	Malcolm	clifton.malcolm@sakilacustomer.org	1489 Kakamigahara Lane		Taipei	526	29341849811	t	2006-02-14	2013-05-26 14:49:45.738
578	Willard	Lumpkin	willard.lumpkin@sakilacustomer.org	1819 Alessandria Loop		Campeche	103	377633994405	t	2006-02-14	2013-05-26 14:49:45.738
579	Daryl	Larue	daryl.larue@sakilacustomer.org	1208 Tama Loop		Ninawa	344	954786054144	t	2006-02-14	2013-05-26 14:49:45.738
580	Ross	Grey	ross.grey@sakilacustomer.org	951 Springs Lane		Central Mindanao	219	165164761435	t	2006-02-14	2013-05-26 14:49:45.738
581	Virgil	Wofford	virgil.wofford@sakilacustomer.org	760 Miyakonojo Drive		Guerrero	246	294449058179	t	2006-02-14	2013-05-26 14:49:45.738
582	Andy	Vanhorn	andy.vanhorn@sakilacustomer.org	966 Asuncin Way		Hidalgo	212	995527378381	t	2006-02-14	2013-05-26 14:49:45.738
583	Marshall	Thorn	marshall.thorn@sakilacustomer.org	1584 Ljubertsy Lane		England	494	285710089439	t	2006-02-14	2013-05-26 14:49:45.738
584	Salvador	Teel	salvador.teel@sakilacustomer.org	247 Jining Parkway		Banjul	54	170115379190	t	2006-02-14	2013-05-26 14:49:45.738
585	Perry	Swafford	perry.swafford@sakilacustomer.org	773 Dallas Manor		Buenos Aires	424	914466027044	t	2006-02-14	2013-05-26 14:49:45.738
586	Kirk	Stclair	kirk.stclair@sakilacustomer.org	1923 Stara Zagora Lane		Nantou	546	182178609211	t	2006-02-14	2013-05-26 14:49:45.738
587	Sergio	Stanfield	sergio.stanfield@sakilacustomer.org	1402 Zanzibar Boulevard		Guanajuato	106	387448063440	t	2006-02-14	2013-05-26 14:49:45.738
588	Marion	Ocampo	marion.ocampo@sakilacustomer.org	1464 Kursk Parkway		Shandong	574	338758048786	t	2006-02-14	2013-05-26 14:49:45.738
589	Tracy	Herrmann	tracy.herrmann@sakilacustomer.org	1074 Sanaa Parkway		Loja	311	154124128457	t	2006-02-14	2013-05-26 14:49:45.738
590	Seth	Hannon	seth.hannon@sakilacustomer.org	1759 Niznekamsk Avenue		al-Manama	14	864392582257	t	2006-02-14	2013-05-26 14:49:45.738
591	Kent	Arsenault	kent.arsenault@sakilacustomer.org	32 Liaocheng Way		Minas Gerais	248	410877354933	t	2006-02-14	2013-05-26 14:49:45.738
592	Terrance	Roush	terrance.roush@sakilacustomer.org	42 Fontana Avenue		Fejr	512	437829801725	t	2006-02-14	2013-05-26 14:49:45.738
593	Rene	Mcalister	rene.mcalister@sakilacustomer.org	1895 Zhezqazghan Drive		California	177	137809746111	t	2006-02-14	2013-05-26 14:49:45.738
594	Eduardo	Hiatt	eduardo.hiatt@sakilacustomer.org	1837 Kaduna Parkway		Inner Mongolia	241	640843562301	t	2006-02-14	2013-05-26 14:49:45.738
595	Terrence	Gunderson	terrence.gunderson@sakilacustomer.org	844 Bucuresti Place		Liaoning	242	935952366111	t	2006-02-14	2013-05-26 14:49:45.738
596	Enrique	Forsythe	enrique.forsythe@sakilacustomer.org	1101 Bucuresti Boulevard		West Greece	401	199514580428	t	2006-02-14	2013-05-26 14:49:45.738
597	Freddie	Duggan	freddie.duggan@sakilacustomer.org	1103 Quilmes Boulevard		Piura	503	644021380889	t	2006-02-14	2013-05-26 14:49:45.738
598	Wade	Delvalle	wade.delvalle@sakilacustomer.org	1331 Usak Boulevard		Vaud	296	145308717464	t	2006-02-14	2013-05-26 14:49:45.738
599	Austin	Cintron	austin.cintron@sakilacustomer.org	1325 Fukuyama Street		Heilongjiang	537	288241215394	t	2006-02-14	2013-05-26 14:49:45.738
\.

update muchosclientes set activo = false where id between 60 and 150;

create table muchosusuarios
(
  id serial not null,
  some_date date not null,
  user_type text not null,
  some_ts timestamp not null, 
  some_number integer not null, 
  some_data text, 
  some_flag boolean,
  constraint pk_muchosusuarios primary key (id)
);

insert into muchosusuarios (some_date, user_type, some_ts, some_number, some_data, some_flag)
select current_date, 
       case (random() * 4 + 1)::int
         when 1 then 'Super'
         when 2 then 'Hiper'
         when 3 then 'Mega'
         when 4 then 'Golden'
         when 5 then 'Platinum'
       end, 
       clock_timestamp(),
       42, 
       rpad(md5(random()::text), (random() * 200 + 1)::int, md5(random()::text)), 
       (random() + 1)::int = 1
from generate_series(1,4e6 - 10000) as t(i)
union all 
select current_date, 
       'Standard',
       clock_timestamp(),
       42, 
       rpad(md5(random()::text), (random() * 200 + 1)::int, md5(random()::text)), 
       (random() + 1)::int = 1
from generate_series(1,10000) as t(i);
