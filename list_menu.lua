
-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )

local scene = composer.newScene()
-- Require the widget library
local widget = require( "widget" )

local itemSelected 
-- CREATE OBJECTS
function scene:create( event )
  local sceneGroup = self.view
  
 -- this variable is for to know if back button is for either going back to mainmenu or going back from text to listview. if variable true then we can go back to mainmenu
  local goBackToMainMenu = true
  local idOfShowText

--Box to underlay our audio status text
-- gradient same as buttons 
--[[
local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {255/255,230/255,70/255},
  color2 = { 235/255, 205/255, 25/255 }, --green color taken from a background pci
  direction = "down"
}

--]]

local gradient = {
  type = 'gradient',
  --color1 = { 1, 1, 1 }, 
  color1 = {255/255,200/255,22/255},
  color2 = {235/255, 205/255, 25/255 }, --green color taken from a background pci
  direction = "down"
}
 
local statusBoxHeight = 100
local statusBox = display.newRect( display.contentCenterX, display.screenOriginY, display.actualContentWidth, statusBoxHeight )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.9
--Create a text object to show the current status
local statusText = display.newText( "Info haigusest", statusBox.x, statusBox.y+25, native.systemFontBold, 18 )
statusText:setTextColor( 0, 0, 0 )

------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar ) 

-- Import the widget library

-- create a constant for the left spacing of the row content
local LEFT_PADDING = 10

--Set the background to white
display.setDefault( "background", 1, 1, 1 )

--Create a group to hold our widgets & images
--local widgetGroup = display.newGroup()

local data = {}

data[1] = {}
data[1].title = "Skisofreenia"
data[1].subtitle =""
data[1].text="Psühhoos on aju haigus, millesse sageli haigestuvad noored, kes on alustamas on iseseisvat elu. Kuna Eestis räägitakse sellest haigusest vähe, siis enamasti jõuavad need noored psühhiaatri või psühholoogi vastuvõtule siis, kui sümptomid on kestnud juba aastaid. On välja uuritud, et mida kauem inimene selle haiguse sümptomite käes kannatab, seda suuremat mõju avaldab see tema ajule, seda halvemini on haigus ravitav ja seda tõenäolisemalt jääb haigus krooniliseks ning hakkab siis kandma skisofreenia nime.\nEsmaseid psühhootilise häire diagnoosiga inimesi lisandub Eestis iga aasta ligikaudu 600, skisofreeniat esineb 1 protsendil inimestest.\n\nKriitiline iga esmase psühhoosi tekkeks on 18-25. Tegemist on perioodiga, kus kujunevad välja tähtsamad sotsiaalsed suhted, omandatakse elukutset, pannakse alus iseseisvale elule. Psühhoosi haigestumine katkestab selle protsessi ning õige sekkumise puudumisel on tagajärjed elukestvad. Õigeaegse ning kohase ravisekkumise korral on võimalik elada inimväärset elu, tegeleda õppimise või tööga, viia ellu oma unistusi ja plaane.\nIlmselgelt on väga oluline, et inimesed teaksid, kuidas psühhoosi ära tunda ning kuidas sellega toimida.\n\n\n\n"


data[2] = {}
data[2].title = "Psühhoosi sümptomid"
data[2].subtitle = ""
data[2].text="Psühhoosi spetsiifilised sümptomid:\n\nPsühhoosi sümptomid, nagu taju häired või luulumõtted ei ole psühhoosi käes kannatava inimese jaoks enamasti haiguse märgiks. Kuna haige on aju, mille ülesandeks on panna kokku mõistlik pilt meid ümbritsevast reaalsusest ja sisemaailmast, ei ole psühhoosi puhkemisel inimesel reeglina võimalik eristada teiste jaoks üheselt arusaadavat reaalsust oma sisemaailma nähtustest ja objektidest.\nAju täidab oma funktsiooni vigadega ning inimesel puudub võimalus seda tajuda.\n\nPsühhoosi sümptomid jagatakse laias laastus kaheks – positiivseteks ja negatiivseteks sümptomiteks. See määratlus ei tähenda, et ühed sümptomid oleksid head ja kasulikud ja teised halvad. Positiivne tähendab siinkohal, et tegemist on millegagi, mis on lisaks või ülearu võrreldes tavaolekuga ning negatiivne viitab millelegi, mida on vähem või mis on puudu.\n\nPositiivsed sümptomid\n-Kuulmistajuhäired: inimene kuuleb hääli, mida teised ei kuule. Tavaliselt on inimene veendunud, et hääled tulevad kuskilt mujalt kui tema pea seest või on talle pähe pandud või suunatud. Enamasti on räägivad hääled midagi negatiivset, sunnivad inimest midagi tegema või tegemata jätma või kommenteerivad inimese tegevust.\n\nVahel võib kuulmisaisting muutuda, inimene usub, et kuulis, et hüütakse tema nime või tema kohta midagi mõnitavat, kuid teised kuulevad midagi hoopis erinevat.\n\n- Haistmismeele häired: inimene tunneb lõhnu, mida teised ei tunne, tavaliselt on sellised lõhnad ebameeldivad või ootamatus kohas. Vahel võib olla tunne, et keegi nagu annab mingi eesmärgiga neid lõhnu nuusutada.\n\n- Maitsmismeele häired: inimene tunneb et asjadel on imelik või ebameeldiv maitse, näiteks, et joogiveel on tugev rauamaitse või kõik maitseb ühte moodi.\n\n- Nägemistaju häired: inimene näeb asju, mida teised ei näe. Tegemist võib olla mõne ebameeldiva ja hirmutava pildiga, näiteks tundub, et keegi musta riietatud kuju seisab voodi ees.\n\n- Puutetundlikkuse häired: inimene tunneb oma kehas, nahal või naha all kummalisi tundmusi, näiteks tunne, et putukad ronivad naha all.\n\n- Kehataju häired: inimene võib tajuda, et mõni tema keha osa või organ on muundunud või ei tööta nagu vaja lähedaste või arstide vastupidised kinnitused seda usku ümber ei lükka.\n\n- Enesetaju häired: inimene võib tunda, et teda nagu ei olekski olemas, ta on ennast ära kaotanud või et ta on muutunud kellekski teiseks, võidakse tajuda end robotlikuna, sama võib tunda näiteks oma lähedaste suhtes, näiteks, et abikaasa ei ole tegelikult tema, vaid hoopis keegi, kes teda teeskleb.\n\nAju teeb trikke\nAju võib trikke teha aegajalt meie kõigiga, võib ju olla, et tundub, justkui keegi hüüaks tänaval meie nime, aga tegelikult hüütakse hoopis midagi muud või kedagi samanimelist. Väsinuna võib tulla ette, et tundub justkui keegi helistaks uksekella või et muusika taustal tundub nagu telefon heliseks. Samuti ei pruugi olla võõras tunne, et mõni putukas, näiteks puuk ronib meie peal või hammustab, eriti kui puukidest on olnud juttu ja viibitakse nende elupiirkonnas.\n\n- Mõtlemishäired:\nKõige tavalisem mõtlemishäire on luululine mõtlemine, mille puhul inimene näeb seoseid teiste jaoks seostamatute asjade vahel.\nParanoilist luulu iseloomustab kahtlustamine ja usaldamatus, inimene võib uskuda, et teda jälgitakse või jälitatakse, näiteks võib tunduda, et inimese kohta räägitakse midagi televiisoris, tema tuppa on paigutatud kaamerad, isegi, et inimest soovitakse tappa või röövida.\nMõjutusluulu iseloomustab uskumus, et inimese mõtteid mõjutatakse või, et tema saab teiste mõtteid mõjutada, näiteks telepaatilisel teel või kasvõi interneti kaudu.\nSuurusluulu iseloomustab tunne, et ollakse keegi eriliselt tark, andekas või kuulus, näiteks omatakse mingeid erilisi võimeid, näiteks teiste tervendamise võime, omatakse tohutuid varandusi, samuti kui tuntakse end süüdi ja vastutavana mõne ühiskonda vapustanud sündmuse eest.\nMõtlemine on iseäralik \n\nMõnel määral võib selliseid nähtusi ette tulla igal inimesel, näiteks võib armunud olles leida teiste jaoks arusaamatuid seoseid enda ja kallima vahel. Võime olla kahtlustavad võõraste vastu, kes meie ukse taga midagi sehkendavad. Vahel võib jääda uskuma, et mõtlemisest mõne lähedase inimese peale piisab, et ta samal hetkel meile helistaks.\n\nPsühhoosi tunnused tekivad enamasti ajapikku ja nendest elamustest vahel inimesed pikka aega ei räägi, sest nad saavad aru, et teiste jaoks oleks see ehmatav või kummaline. Need elamused on mõistagi ka kannataja enda jaoks hirmutavad ja kurnavad. Meelepettelised elamused on nende kogeja jaokstäiesti reaalsed, tema jaoks ei ole muutused toimunud mitte psüühikas, vaid ümbritsevas maailmas, seetõttu on psühhoosi põdeval inimesel ka raske tunnetada, et tegemist on haigusega.\n\nNegatiivsed sümptomid:\nNegatiivseid sümptome iseloomustab millegi ärakadumine või langus, mõnevõrra meenutab negatiivne sümptomaatika depressiooniseisundit ning vahel on raske neid teineteisest eristada.\n\nAktiivsuse ja energiataseme langus: inimene muutub varasemaga võrreldes passiivseks ja loiuks, vajab palju und ja vahel istub või lebab lihtsalt niisama, ilma midagi tegemata.\n\nTundeelu häired: sageli võivad emotsioonid justkui ära kaduda või tuimeneda, miski ei tekita sügavat rõõmu või kurbust. Meeleolu võib olla ühtlaselt rõhutud või ükskõikne.Vaimsete võimete langus: kehvemaks võivad muutuda tähelepanu ja keskendumisvõime ning samuti ka mälu.\n\nSuhtlemisraskused: kuna suhtlemine nõuab mõningast energiat ning emotsionaalset huvitatust, siis negatiivse sümptomaatika korral jäävad sageli napiks ka kontaktid teiste inimestega, see omakorda süvendab üksioleku ja võõrandumise tunnet ning vähendab võimalust tunda erinevaid tundeid.\nEnesetapumõtted: kuna negatiivseid sümptoome on raske taluda, võib tekkida sügav lootusetusetunne ning veendumus, et midagi kunagi ei parane. Seoses haigeks jäämise ning tavalise elu elamise ajutise katkemise võib langeda ka enesehinnang ning puudu jääda eneseusust. Need asjaolud omakorda võivad tekitada enesetapumõtteid ning viia ka katsetele endalt elu võtta.\n"


data[3] = {}
data[3].title = "Diagnoosid"
data[3].subtitle = ""
data[3].text="Diagnoosid psühhootiliste sümptomite avaldumise korral \nEsimese psühhoosi episoodi järel on vahel raske määratleda, mis inimese diagnoosiks täpsemalt kujuneb. Seda näitab aeg, kuidas inimene paraneb, kas osa sümptomitest jääb püsima, kas episoodid korduvad. Kuigi diagnoose on võrdlemisi piiratud hulgal, on inimesed, kes diagnoositud võivad saada, väga erinevad ja igaühel on oma isiklikud iseärasused, mis hoolimata haigusest alles jäävad. See tähendab, et lisaks haigele osale on olemas ka terve osa. Samuti võib erinevaid sümptoome esineda erineval hulgal, erinevates kombinatsioonides ning erineva kestusega.\n\nÄge psühhootiline episood\nPsühhoosi sümptomitega episood, mis esineb ühekordselt.\n\nSkisofreenia\nSkisofreenia on krooniline haigus, mille puhul psühhoosi episoodid jäävad korduma.\n\nSkisoafektiivne häire\nSelle häire puhul esineb nii psühhoosi kui meeleoluhäire sümptome.\n\nLuululine häire\nLuululise häire puhul on esiplaanil luulumõtted. Luulumõtted või ka laiemad süsteemid püsivad reeglina pika aja jooksul muutumatutena.\n"


data[4] = {}
data[4].title = "Psühhoosi põhjused"
data[4].subtitle = ""
data[4].text="Nagu paljude teiste haiguste puhul, ei ole teada psühhoosi kindlaid tekkemehhanisme, tavaliselt on vaja mitme ohufaktori koostoimet.\n\n– Psüühikahäire suguvõsas. Uuringute kohaselt  on 11% skisofreeniasse haigestunutest üks vanematest sama haigust põdenud, ühemunakaksikutel on mõlemal võimalus haigestumiseks 40%. Põhimõtteliselt võib tekkida psühhoos igal inimesel, sõltumata tema geneetikast, intellektist, rahvusest soost või vanusest. \n\n- Kriisid elus ja stressivad sündmused. Sageli tekib esmakordne psühhoosi episood arengu faasis, kus inimesel on käsil iseseisvumisega seotud kriis. Nagu teisigi haigusi, või ka psühhoosi vallandada stressi tekitav sündmus, mis on seotud mõne elumuutusega, koormuse tõusuga, pingeliste suhetega.\n\n- Keskkonna tegurid. On leitud, et suurem võimalus psühhoosi haigestuda on neil, kes on kasvanud linnakeskkonnas ning teise põlvkonna immigrantidel.\n\n- Meelemürkide kasutamine. Erinevad narkootilised ained, nagu hallutsionogeensed seened, amfetamiin, kokaiin, aga ka alkohol ja kanep võivad olla psühhoosi vallandavateks teguriteks.\n\nUuringutes on leitud, et geneetilise eelsoodumusega inimestel võib juba ühekordne kanepi suitsetamine psühhoosi vallandada. Uuringud näitavad, et 25% inimestel on väga suur risk pärast kanepi suitsetamist psühhoosi haigestuda, 50% on risk mõõdukas ja 25% väike. Need protsendid jaotuvad vastavalt ensüüm katehhool-o-metüültransferaasi (COMT) geeni alleelidele. Rutiinselt, lihtsalt teadmiseks selle geeni alleelide esinemist inimesel välja ei selgitata ning seetõttu ei saa me teada, milline on meie risk haigestuda psühhoosi peale kanepi suitsetamist. Kanepi suitsetamine selles olukorras on õnnemäng.\n\nKanepi suitsetamisega seotud psühhoos ei ole kergem, lühiajalisem või parema prognoosiga kui muudest faktoritest tingitud psühhootiline häire. Ka see psühhoos mõjub rängalt inimese toimetulekule, ravi kestab aastaid ning psühhoos võib korduda.\n\n-Aju ja virgatsained. Psühhoosi on uuringutes seostatud eelkõige virgatsaine dopamiiniga, selle taseme muutustega frontaalsagaras ja basaalganglionides. Haigestumise risk on suurem neil, kellel on varases arengus tekkinud ajukahjustus.\n\n-Peresuhete iseloom\nOn leitud, et haigestunute perekonnas on sagedasem kriitiline, halvustav või isegi vaenulik suhtlemisstiil, samuti on leitud ignoreerivat, vähese soojusega suhtlemist."


data[5] = {}
data[5].title = "Paranemine ja ravi"
data[5].subtitle = ""
data[5].text="Paranemine ja ravi\n\nRavisekkumised sõltuvad psühhoosi sümptomitest ja haiguse faasist. Psühhootiline häire vajab psühhiaatrilist medikemantooset ravi. Mida varem ravi algab, seda parem on prognoos.\n\nPsühhoosist paranemine on pikaajaline ning vaevaline protsess nii inimese enda kui ka tema pereliikmete jaoks. Kuigi adekvaatse ravi korral taandub sümptomaatika järk-järgult mõne kuuga, kestab kriitiline periood, kus raskendatud on inimese toimetulek, langenud on elukvaliteet ning püsib oht episoodi kordumiseks, aasta või kauemgi.\n\nPraeguses Eestis algab psühhoosi ravi enamasti haiglas, selle põhjuseks on asjaolu, et ravile pöördudes on inimeste seisund sedavõrd raske, et kodus ravida ei ole võimalik. Samuti on Eestis puudulikud võimalused päevakeskuste osas, kus oleks võimalik psühhoosi seisundis inimeste seisundit jälgida ja ravida.\n\nRavimid\n\nPsühhoosi ravis kasutatakse antipsühhootikume. Antipsühhootikumide  mõjutavad kesknärvisüsteemi dopamiini süsteemi. Uuemat tüüpi antipsühhootikumid mõjutavad vähemal määral ka serotoniini süsteemi teatud aju piirkondades. Psühhoosi positiivsete sümptome leevendav toime ilmneb dopamiini 2 tüüpi retseptorite blokeerimise kaudu ning see omadus on ühine kõigie antipsühhootikumidele.\n\nPsühhoteraapia\n\nPsühhoteraapia vorm ja sagedus oleneb nii seisundist kui inimese isiklikest eelistustest ja vajadustest kui tervishoiusüsteemi võimalustest. Koos oma ravimeeskonna ja pereliikmetega saab otsustada, milline teraapia antud ajas valida.\n\nPerekonnapsühhoteraapia ja perekonna teavitamine haiguse kohta\n\nOn leitud, et akuutne kriis perekonnas kestab ligikaudu pool aastat, selle aja jooksul kohanetakse haiguse kohaloluga peres, tehakse ümberkorraldusi nii praktilises elus kui üldisemates arusaamades. Selle aja jooksul on kindlasti vaja toetust pereliikmetele, teha neile kättesaadavaks kohane info, arutada nendega käesolevaid raskusi. Vahel vajavad ka pereliikmed psühhiaatrilist abi või kogu pere pikemaajalist pereteraapiat.\n\nGrupipsühhoteraapia\n\nGrupis saab toetust üksteiselt, saab arutada teemasid, mis on ühised psühhoosi põdenute puhul. Toetusgrupis võib käia nii haiglas olles kui ka edaspidi.\n\nIndividuaalne teraapia\n\nIndividuaalne teraapia võib olla toetav psühhoteraapia, kus tegeldakse käesoleval hetkel oluliste teemade ja probleemidega. Kognitiivne käitumisteraapia pakub võimalusi valida konkreetne probleem, millega tegeleda, psühhodünaamilise teraapiaga saab alustada kui seisund on selleks piisavalt stabiilne.\n\nLoovteraapia\n\nLoovteraapia pakub võimalusi ennast väljendada ka juhtudel, kus oma siseelust kõnelemine ja selle üle arutlemine on raske.\n\nKognitiivne remediatsioon\n\nPsühhoosi negatiivne sümptomaatika tingib vaimsete võimete langust, samuti asjaolu, et haigena ei ole reeglina võimalust oma tavapärasel viisil aju kasutada ning seda vormis hoida.\n\nKognitiivse remediatsiooni ülesandeks on aju treenida – nagu füüsiline keha ja lihased, nii võib ka ajutegevus halveneda ja kängu jääda, kui sellega püsivalt ei tegele.\n\nKognitiivne remediatsioon võimaldab parendada vaimse tegevuse valdkondi, mis haiguse tõttu või varemgi on kehvaks jäänud, näiteks keskendumisvõimet ja mälu.\n\n"


data[6] = {}
data[6].title = "Kuidas end aidata?"
data[6].subtitle = ""
data[6].text="Kuidas end ise aidata?\n\nLooge enda ümber rahulik ja pingevaba keskkond – arendage oma suhteid lähedastega\nHead suhted perekonnas vähendavad pingeid ja loovad kodus rahuliku ja tasakaaluka õhkkonna. Seda on tervenemiseks hädasti tarvis. Seepärast arutage peresuhete üle ka oma ravimeeskonnaga.\n\nVähendage võimalusi haiguse uueks ägenemiseks – ärge tarvitage alkoholi ega narkootikume.\n\nAlkoholi ja ravimite koos tarvitamine võib tekitada ebameeldivaid, hirmutavaid ja tervisele ohtlikke seisundeid. Ravimite mõju võib alkoholi mõjul tugevneda või väheneda. Narkootikumid võivad kergesti põhjustada haiguse ägenemist ning ka ravimite toime ei pruugi olla enam piisav.\n\nHoolitsege oma tervise eest järjepidevalt – tarvitage ravimeid nii, nagu arst on määranud.\n\nRavimite võtmise annuseid ja sagedust ei tohi iseseisvalt muuta. Kui on mõte seda teha, tuleb kindlasti nõu pidada oma raviarstiga. Kui te ei võta ravimeid arsti määratud korra järgi, võib haigus ägeneda ning seisund halveneda. Iga uue ägenemise järel on paranemisprotsess aeganõudvam ning vaevalisem.\n\nKasutage ära võimalusi, mida pakuvad ravimeeskonna liikmed, proovige teha nendega koostööd.\n\nVestlustel oma ravimeeskonna, arsti või psühholoogiga katsuge olla avameelne. Kui tekivad ebameeldivad kõrvaltoimed ravimitest, tasub selle üle kindlasti arutada, et leida sobivam lahendus. \n\nOma sümptome või raskusi seoses haigestumisega tasub jagada, sel juhul saadakse teist paremini aru ning osatakse muuta ravi sobivamaks või leida ühiselt vahendeid, mis tooksid leevendust. \n\nKüsige nippe ja nõuandeid, kuidas paranemine kulgeks kiiremini, ning mida saaksite teha, et end paremini tunda. \n\n"


data[7] = {}
data[7].title = "Kuidas olla toeks?"
data[7].subtitle = ""
data[7].text="Viige end oma lähedase inimese haiguse ja seisundiga kurssi.\n\nTutvuge kättesaadava informatsiooniga haiguse ja paranemise kohta. Mida paremini olete asjaoludega kursis, seda kergemini oskate lahendada ettesattuvaid probleeme. Suurem teadlikkus on rohuks ka teadmatusest tulenevate hirmude ja ärevuse vastu ja aitab ette valmistuda võimalikeks raskusteks.\n\nInformatsiooni saab küsida näiteks ravimeeskonnalt, otsida kirjandust erinevatest allikatest, osaleda pereliikmetele mõeldud tugigruppides või koolitustel.\n\nTehke tihedat koostööd oma lähedase ravimeeskonnaga.\n\nParanemise juures on oluline, et oleks võimalik leida arst ja psühholoog, keda on võimalik usaldada. Sellisel juhul saab jagada omavahel teavet, arutada, kuidas kõige paremini aidata, võtta vastu soovitusi ja nõuandeid. Ravimeeskonnale on oluline teada, mis teie kõrvalt näete, millised sümptomid, mõtted või tunded haigestunud inimese elu häirivad. Vahel ei suuda haiguse käes kannataja ise neid olulisi teemasid välja tuua. Mida täpsemini raviarst seisundiga kursis on, seda paremini saab ta ravi planeerida. Kui mõnda teemat on raske käsitleda ühisel vestlusel, saab küsida eraldi vestluse aega ning rääkida arstiga nelja silma all.\n\nJuhul, kui Teie perele satub arst või psühholoog, kellega usalduslikku suhet ei teki, tuleks otsida keegi, kes paremini sobib.\n\nPsühhootilisse häiresse haigestunud inimesel võib esineda paranemise jooksul ka tagasilangusi ning seisundi ägenemist ja seetõttu tuleks märgata ka tagasilanguse tunnuseid. Kuna psühhoosi puhul on häiritud reaalsuse taju, ei pruugi inimene ise märgata, et tema sees on midagi muutunud, kuid seda võivad märgata lähedased.\n\n Märgid, mis võivad viidata tagasilangusele on näiteks:\n\n-Muutused unereziimis (märgatavalt vähenenud või suurenenud unevajadus).\n\n-Muutused toitumises (vähe söömine või ebatavaline valivus toidu suhtes.\n\n-Isikliku hügieeni või riietumise hooletusse jätmine.\n\n-Endasse tõmbumine, suhtlemise vähenemine.\n\n-Meeleolu ja energiataseme oluline langus või kõrgenemine.\n\n-Muutumine kergesti ärrituvaks.\n\n-Teised varasema haiguse episoodiga seotud sümptoomid.\n\nHea oleks, kui võimalikke tagasilanguse sümptoome saaks arutada koos haigestunud inimesega ja ravimeeskonnaga.\n\nOluline oleks ka aru saada, millised tegurid on olnud haiguse vallandajateks ning sarnaste olukordade puhul olla eriti tähelepanelik oma lähedase suhtes. Näiteks kui esimene haigestumine oli seotud raskustega koolis, konfliktidega tööl, välismaareisi või suhte purunemisega.\n\nJuhul, kui hakkate võimalikke tagasilanguse tunnuseid märkama, võtke esimesel võimalusel ühendust raviarsti või teiste ravimeeskonna liikmetega.\n\nMida varem tagasilangus ära tunda, seda väiksem on võimalus, et toimub uus haiguse ägenemine ning tuleb haiglaravile minna.\n\nAidake oma lähedasel regulaarselt ravimeid tarvitada. Psühhootilisse häiresse haigestumise puhul on kõrge risk põdeda korduvaid haigusepisoode. Regulaarne ravimite tarvitamine aitab seda riski oluliselt vähendada. Vahel võib inimene ravimid unustada ning on tarvis seda talle meelde tuletada. Meelde tuletamise puhul on vaja silmas pidada, et seda tuleb teha piisava taktitundega. Vastasel juhul võib see paista inimese ellu sekkumise või liigse kontrollimisena ning tekitada protesti ravimite vastu.\n\nProovige elukeskkond võimalikult pingevabaks muuta\n\nVältige erutavaid või ärritavaid olukordi kodus. Kõige parem kui elukorraldus on lihtne ja regulaarne, isegi rutiinne. Päev-päevalt korduvad ja tuttavad tegevused loovad turvalise ja rahuliku keskkonna.\n\nKatsuge ise rahu säilitada.\n\nKuigi vahel võib olla keeruline säilitada rahu keerulises olukorras, on ärritumine nakkav ning mõjutab ka haigestunu vaimset tervist.\n\nHaigestunud lähedasega ei asu vaielda tema kummalisena tunduvate mõtete üle ega püüda kummutada tema ilmselt väärasid tajusid. Need on haiguse sümptomid, mis taanduvad aegamisi ja mille vaidlustamine neid ümber ei lükka.\n\nEsitage oma lähedasele nõudmisi, mis on talle antud hetkel jõukohased.\n\nPärast ägedat psühhoosi episoodi võib inimesel olla raske tegevusi algatada, kuid jõukohane tegutsemine aitab paranemisele kaasa. Arutage koos ravimeeskonnaga, millised tegevused on parajad.\n\nOlge järjekindel ning toetav.\n\nJõukohaste tegevuste planeerimisel ning nende läbiviimise julgustamisel või nõudmisel olge järjekindel. Katsuge sõnastada oma palved positiivses võtmes, näiteks „Ehk teed seda niimoodi“ või „Nüüd tuleb teha seda“, mitte „ Ära tee nii“ või „Ära seda küll tee“. Positiivses sõnastuses esitatud juhiseid on lihtsam täita.\n\nÕppige toime tulema kriisiolukordadega.\n\nPsühhoosi ja skisofreeniasse haigestumine on teatavat sorti kriisiolukord. Väiksemaid või suuremaid kriise võib ette tulla ka paranemise faasis.\n\nMida vältida?\n\nVältida tuleks oma lähedase peale hääle tõstmist või karjumist. Kuigi võib tunduda, et talle räägitav jutt ei jõua kohale, ei ole hääle tõstmisest abi. Inimene ei ole ju jäänud kurdiks, vaid teda segavad psühhoosi sümptoomid.\n\nVältida tuleks ka kritiseerimist ning etteheiteid. Kriisis inimene ei pruugi just kõige mõistlikumalt arutleda suuta ning kriitika ei aita tal muutuda mõistlikumaks, ratsionaalsemaks.\n\nKatsuge vältida ka käitumist, mille puhul aimate, et see võib teie lähedast ärritada. Ärge looge temaga pikka silmsidet ning ärge vaielge ka teiste inimestega selle üle, mida teha.\n\nKuidas kriisi korral käituda?\n\nJuhul kui kriis on juba täies hoos ning seisund ägenenud, on kõige parem lahendus pöörduda haiglasse. Kui võimalik, võtke koheselt ühendust raviarstiga ning kirjeldage talle olukorda. Kui raviarsti ei ole võimalik kätte saada, on mõistlik toimida nagu iga teise ägeda haigusseisundi korral – kutsuda kiirabi.\n\nMõnikord võib juhtuda, et äge psühhoos toob kaasa ka füüsiline vigastuse ohu. Psühhoosis inimene võib käituda lähtuvalt oma meelepetetest, võib olla vihane või hirmul ja segaduses ning midagi lõhkuda või endale või teistele viga teha.\n\nSellisel juhul tuleb teha kõik endast olenev, et kaitsta ennast ning kriisis inimest vigastuste eest. Võib lahkuda ruumist või proovida paigutada kriisis inimene kindlalt turvalisse keskkonda ning abi kutsuda. Viga saamise ohu korral on sageli lisaks kiirabile vaja kasutada ka politsei abi.\n\nKui õnnestub kriisis inimest iseseisvalt haiglasse abi saama toimetada, ei tasu seda teha üksi, vaid kutsuda keegi usaldusväärne inimene kaasa.\n\nKriisikäitumise plaan\n\nRaviarsti telefoninumber peaks olema kergesti leitavas kohas, et vajadusel temaga kiiresti kontakti võtta.\nMõelge läbi, keda kriisi sattunud inimene usaldab ning kelle abi saab kasutada kriisi puhkemisel või oma lähedase haiglasse toimetamisel ägeda seisundi tekkimisel.\n Uurige, kellele oma lähedastest saate ükskõik millisel ajal helistada abi ja toetuse saamiseks.\n Kui teil on lapsed või teised pereliikmed, kelle eest hoolt kannate, siis uurige, kelle hoolde saaks neid kriisiolukorras jätta.\n Arutage kriisi tekkimise võimalust, plaani ning käitumist ka oma haigestunud lähedasega. Juhul kui kriis tekib, on plaan inimesele teada ning selle ümber toimuv on seetõttu vähem hirmutav.\n\nEnesevigastamine ning enesetapu risk\n\n Psühhootilisse häiresse haigestunud inimestel on enesetapu risk keskmisest kõrgem. Negatiivne sümptomaatika on sarnane depressioonile, meeleolu ning energiatase on madalad. Võib tekkida lootusetusetunne oma tuleviku ja paranemise suhtes, raske on kohaneda mõttega, et ollakse haigestunud. Enesetapukatseid võidakse teha ka meelepetete tõttu, mõnikord võivad „hääled“ peas rääkida, et inimene peab endale viga tegema.\n\nEnesetapumõtteid, mida inimene teile räägib, tuleb tõsiselt võtta. Mõnikord ei pruugita neid mõtteid ka avaldada, kuid sellele võib viidata surmast ja suremisest rääkimine, oma asjade ära andmine, testamendi koostamine. Samuti kui inimene on lootusetu, ei näe endal tulevikku, usub, et tal ei ole mingit väärtust, et ta ei ole kellelegi vajalik.\n\nKui midagi ülalmainitut märkate, rääkige sellest esimesel võimalusel oma ravimeeskonna liikmetega.\n\nHoolitsege enda eest\n\nTõsiselt häiritud lähedase eest hoolitsemine on keeruline väljakutse. Hoolitsejatel tuleb kindlasti tähelepanu pöörata ka endale, et vältida üleväsimuse ja kurnatuse tekkimist.\n\nHoolitsege oma tervise eest, harrastage tervislikke eluviise. Sööge tervislikult ja regulaarselt, katsuge piisavalt magada, olge füüsiliselt aktiivne. Kontrollige oma tervist regulaarselt ka perearsti juures.\n\nÕppige kasutama lõdvestustehnikaid.\n\nPlaneerige oma päeva ka tegevusi, mis ei ole seotud oma lähedase eest hoolitsemise ega muude kohustustega, võtke ette midagi endale meeldivat.\n\nVõimalusel võtke endale hoolitsemisest puhkust, katsuge leida kasvõi mõned päevad, kus keegi teine saaks teie lähedase eest hoolt kanda.\n\nVältige enesesüüdistusi ning kasutut enesekriitikat. Haigestumises ei ole mitte keegi isiklikult süüdi, tegemist on õnnetute asjaolude kokkulangemisega.\n\nKõnelege oma muredest ja kurbusest teistega, kes teid mõistavad.\n\n"


data[8] = {}
data[8].title = "Müüdid ja reaalsus"
data[8].subtitle = ""
data[8].text="Müüdid ja reaalsus\n\nMüüt: Skisofreenia tähendab isiksuse lõhestumist\nReaalsus: Tavateadmiste järgi arvatakse vahel , et skisofreenia tähendab isiksuse lõhestumist. See määratlus ei ole just kõige täpsem. Pigem on tekkinud lõhe inimese ja reaalsuse vahel, psühhoos kõige lihtsamini öeldes tähendab, et inimene on kaotanud tavapärase kontakti reaalsusega.\n\nMüüt: Skisofreenia tähendab hull, tähendab loll\nReaalsus: Sageli kohtab arvamust, et hullumeelsus või psüühikahäire tähendab vähest intellekti. Keskmisest madalama intellekti ja vaimsete võimetega inimesed võivad küll psühhootilisse häiresse haigestuda, kuid suur osa selle häirega inimesi on siiski normaalsete vaimsete võimetega, ägedas seisundis võib olla raske neid võimeid kasutada.\n\nMüüt: Psühhoos tähendab vägivaldset laamendamist\nReaalsus: Uuringud näitavad, et vägivaldsus psühhootilise häirega inimeste hulgas ei ole kõrgem kui tavapopulatsioonis. Tavaliselt on psühhootilises seisundis inimesed pigem hirmul ja segaduses ning võivad endale viga teha.\n\nMüüt: Psühhoosi haigestudes või skisofreenia diagnoosi saades on elu läbi\nReaalsus: Kuigi psühhoosi sümptomid häirivad elu olulisel määral, on see reeglina seisund, mis möödub. Isegi kui kõik sümptomid ei taandu, on võimalik õppida nendega toime tulema. Skisofreenia diagnoosi korral suudavad paljud inimesed siiski tegeleda ka millegi uue õppimise või tööga. Kaasaegse raviga, mis hõlmab nii ravimeid, psühhoteraapiat kui sotsiaalset kaasamist paraneb kolmandik kuni pooled inimestest.\n\nMüüt: Antipsühhootikumid teevad inimestest zombid\nReaalsus: Antipsühhootikumide võtmisega võidakse sageli seostada uimasust, tegutsemistahte ja energia puudust, mõtete vähesust. Tegelikult on selle taga kas skisofreenia negatiivne sümptomaatika või liialt suured ravimi annused. Ideaaljuhul ei tohiks ravimeid tarvitav inimene nende otsest mõju igapäevaselt üldse märgata. Antipsühhootikumid ei tekita sõltuvust ega muuda inimese sisemist olemust ega isiksust.\n\nMüüt:  Teatud inimesed on hullud ja teatud inimesed on normaalsed\nReaalsus: Tegelikkuses on kõigis inimestes pisut psühhootilisust, mõnel on see teatud ajal või kohas lihtsalt enam väljendunud. Näiteks on arvatavasti paljudel inimestel jäänud mõni viisijupp pähe „kummitama“ ning mängib seal päris selgelt. Sama nähtuse äärmuslik väljendus on aga olukord, kus inimene tajub, et naabrinaise hääl peas pidevalt õiendab ja kommenteerib tema tegevust.\n\nMüüt: Skisofreenia on puhtalt pärilik või lihtsalt halva kasvatuse tagajärg\nReaalsus: Nagu paljude teiste häirete puhul, koosneb skisofreenia väljendumine mitmetest tingimustest. Kui inimesel on kellelgi pereliikmetest sarnane diagnoos, siis on tal haigestumiseks kõrgenenud risk. Kahemunakaksikute uuringud on näidanud, et kui ühel kaksikul on skisofreenia diagnoos, siis teise haigestumise tõenäosus on ligikaudu 40%.\n\nTeatud suhtemustrite puhul perekondades on leitud, et skisofreeniasse haigestumise risk on kõrgem, kuid ka nendes peredes ei haigestu kõik lapsed, vaid väikesem osa. Seega on skisofreenia põhjusteks erinevate pärilike ja keskkonna tingimuste kokkulangemine.\n\nMüüt: Psühhootilisest häirest vabanemiseks tuleb end lihtsalt kokku võtta\nReaalsus: Mõned psühhoosi sümptomid võivad paista tavalise laiskuse või asjatu veiderdamisena. Kahjuks ei piisa nendest vabanemiseks siiski ainult tahtejõust, vaid tuleb kasutada ka teisi vahendeid nagu ravimid, sobiv teraapia, teiste toetus ja tervislikud eluviisid.\n\nMüüt: Kõik psühhootilise häirega inimesed näevad nägemusi või kuulevad hääli\nReaalsus: Spetsiifiliste sümptomite alalehel on kirjeldatud psühhootiliste häirete erinevaid sümptome. Kuna iga inimene on ainulaadne, siis on just temal väljendunud sümptomite komplekt samuti isemoodi. Mõnel inimesel on rohkem meelepetteid, teisel enam tahtetust ning mõttekäigu probleeme. Sümptomid muutuvad ka sõltuvalt ajast ning erinevatest kogemustest.\n\nMüüt: Psühhootilist häiret põdenud inimene ei saa enam kunagi normaalset elu elada\nReaalsus: Märkimisväärne osa inimestest paraneb psühhoosist väga hästi, neil ei pruugi psühhoosi episoodid korduda ning aasta pärast kriisi on sellest säilinud vaid mõned hägusad mälestused. Paljudel juhtudel siiski sedavõrd sujuvalt ei lähe, kuid see ei tähenda, et kogu elu keerleks ainult haiguse ümber. Ka mitmeid psühhoosi episoode läbi teinud inimesed suudavad minna edasi õppima, tööle, luua perekonda ning leida sõpru.\n\n"

--for i=1, 8 do
--    table.insert(data, data[i])
--end



-- Forward reference for our back button & tableview
local backButton, list

-- Handle row rendering
local function onRowRender( event )
    local phase = event.phase
    local row = event.row
    local id = row.index
    -- in graphics 2.0, the group contentWidth / contentHeight are initially 0, and expand once elements are inserted into the group.
    -- in order to use contentHeight properly, we cache the variable before inserting objects into the group

    local groupContentHeight = row.contentHeight


    local rowTitle = display.newText( row, data[id].title,0,0, native.systemFontBold, 18 )
    rowTitle:setFillColor(0,0,0)
    -- in Graphics 2.0, the row.x is the center of the row, no longer the top left.
    rowTitle.x = LEFT_PADDING + 10

    -- we also set the anchorX of the text to 0, so the object is x-anchored at the left
    rowTitle.anchorX = 0

    rowTitle.y = groupContentHeight * 0.4

    local rowSubTitle = display.newText( row, data[id].subtitle,0,0, native.systemFontBold, 12 )
    rowSubTitle:setFillColor(.2,.2,.2)
    -- in Graphics 2.0, the row.x is the center of the row, no longer the top left.
    rowSubTitle.x = LEFT_PADDING + 10

    -- we also set the anchorX of the text to 0, so the object is x-anchored at the left
    rowSubTitle.anchorX = 0

    rowSubTitle.y = groupContentHeight * 0.7
-- see tekitab double lines
    local rowArrow = display.newImage( row, "images/listItemBg.png",false )
    rowArrow.x = row.contentWidth - 30 --row.contenctwidth -  size of listItemBG+padding
    rowArrow.y = groupContentHeight * 0.5

    -- we set the image anchorX to 1, so the object is x-anchored at the right
    rowArrow.anchorX = 1
    --data[id]=row.index
   
end

-- Hande row touch events
local function onRowTouch( event )

    local phase = event.phase
    local row = event.target
    local id = row.index

    if "press" == phase then
        print( "Pressed row: " .. row.index )

    elseif "release" == phase then

--Text to show which item we selected display.screenOriginY display.contentCenterY
itemSelected = native.newTextBox( display.contentCenterX, 0, display.actualContentWidth, display.actualContentHeight-70 )
local fontSize = 14
--itemSelected.font = native.newFont( "Arial",  fontSize )
itemSelected.font = native.newFont(native.systemFont, fontSize)
itemSelected.isEditable=false
--itemSelected:setFillColor(0,0,0)
itemSelected.x = display.contentWidth + itemSelected.contentWidth * 0.5
itemSelected.y = display.contentCenterY +25
--widgetGroup:insert( itemSelected )
sceneGroup:insert(itemSelected)
itemSelected.hasBackground = false



       idOfShowText = id
        nextTextButton.isVisible = true
           backTextButton.isVisible = true
        -- Show next button or not?
        shownextTextButton()
        -- Update the item selected text
        itemSelected.text = data[id].text
        itemSelected:toFront()

      	statusText:removeSelf()
      	statusText = display.newText( data[id].title, statusBox.x, statusBox.y+25, native.systemFontBold, 16 )
      	statusText:setTextColor( 0, 0, 0 )
        sceneGroup:insert(statusText) 


     --   backButton:toFront()
        --Transition out the list, transition in the item selected text and the back button

        -- The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
        transition.to( list, { x = - list.contentWidth * 0.5, time = 250, transition = easing.outExpo } )
        transition.to( itemSelected, { x = display.contentCenterX, time = 250, transition = easing.outExpo } )
        transition.to( backButton, { alpha = 1, time = 250, transition = easing.outQuad } )

        goBackToMainMenu = false

        print( "Tapped and/or Released row: " .. row.index )
    end
end




-- Create a tableView
list = widget.newTableView
{
    --top = 25,
   top = statusBox.y+50, -- padding
    width = display.actualContentWidth, 
    height = display.actualContentHeight-40,
    hideBackground = true,


    onRowRender = onRowRender,
    onRowTouch = onRowTouch,
    rowTouchDelay=5,
}

--Insert widgets/images into a group
--widgetGroup:insert( list )





--Handle the back button release event
function onBackRelease()
    --Transition in the list, transition out the item selected text and the back button
 print("backtomainmenu")
if (goBackToMainMenu == true) then

  if(itemSelected ~=nil) then
   itemSelected = nil
  -- itemSelected.removeSelf()

 end

  print("backtomainmenu")
  composer.gotoScene( "mainmenu", "crossFade", 100 )

else

  -- The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
   nextTextButton.isVisible = false
   backTextButton.isVisible = false
  transition.to( list, { x = list.contentWidth * 0.5, time = 250, transition = easing.outExpo } )
  transition.to( itemSelected, { x = display.actualContentWidth + itemSelected.contentWidth * 0.5, time = 250, transition = easing.outExpo } )
  transition.to( backButton, { alpha = 1, time = 250, transition = easing.outQuad } )
  goBackToMainMenu = true
  statusText:removeSelf()    
  statusText = display.newText( "Info haigusest", statusBox.x, statusBox.y+25, native.systemFontBold, 16 )
  statusText:setTextColor( 0, 0, 0 )
  sceneGroup:insert(statusText)




 end
end



for i = 1, 8 do

    local isCategory = false
    local rowHeight = 70
    local rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
 --   local lineColor = { 0.5, 0.5, 0.5 }

 
    -- Insert a row into the tableView
    list:insertRow(
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
           -- lineColor = lineColor
        }
    )
end






 backButton = widget.newButton
{
  defaultFile = "images/back_button.png",
  overFile = "images/back_buttonOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  
  onRelease = onBackRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
backButton.x = 30; backButton.y = statusBox.y+25

-- next text



function shownextTextButton()
nextTextButton.isVisible = true
backTextButton.isVisible = true


  if (idOfShowText == 1 ) then

      backTextButton.isVisible = false
 --     nextTextButton.isVisible = true


   end -- if end

  --or idOfShowText = 1 
  if (table.maxn(data) == idOfShowText )then

    nextTextButton.isVisible = false
  --  backTextButton.isVisible = true

   end -- if end
end


--Handle the back button release event
function backTextButtonRelease()
    --Transition in the list, transition out the item selected text and the back button
   
   
    if (idOfShowText ~= 1) then
     idOfShowText = idOfShowText - 1
   end

    shownextTextButton()

    statusText.text = data[idOfShowText].title
    itemSelected.text = data[idOfShowText].text

end


--Handle the back button release event
function nextTextButtonRelease()
    --Transition in the list, transition out the item selected text and the back button
    idOfShowText = idOfShowText + 1
    shownextTextButton()
    statusText.text = data[idOfShowText].title
    itemSelected.text = data[idOfShowText].text

end
-------------------------------------------------------------------




 backTextButton = widget.newButton
{
  defaultFile = "images/backarrow.png",
  overFile = "images/backarrowOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  
  onRelease = backTextButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
 backTextButton.x = display.actualContentWidth-60;  backTextButton.y = statusBox.y+25
 -- nextButton should not be visible in listview
 --nextTextButton.isVisible = false
  backTextButton.isVisible = false



-------------------------------------------------------------------
 nextTextButton = widget.newButton
{
  defaultFile = "images/arrow.png",
  overFile = "images/arrowOver.png",
  label = "",
  --emboss = true,
  -- white and grey, default= normal. over= pressed
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 1 } },
  
  onRelease = nextTextButtonRelease,
}
-- 20 on siis Y, et täpselt olla samas kohas. ja 30 selleks, et pilt ise on umbes 60 pixlit+paddingud ja seetõttu on selline arv.
 nextTextButton.x = display.actualContentWidth-20;  nextTextButton.y = statusBox.y+25
 -- nextButton should not be visible in listview
 nextTextButton.isVisible = false


--------------------------------------

-------------------------------------

--[[
function onTouchEvent(event)
  local swipeLength = math.abs(event.x - event.xStart) 
  print(event.phase, swipeLength)
  local t = event.target
  local phase = event.phase
  if "began" == phase then
    return true
  elseif "moved" == phase then
  elseif "ended" == phase or "cancelled" == phase then
    if event.xStart > event.x and swipeLength > 40 then 

     

    nextTextButtonRelease()
      print("Swiped Left")
        elseif event.xStart < event.x and swipeLength > 40 then 
            print( "Swiped Right" )

            backTextButtonRelease()
    end 
  end
end
itemSelected:addEventListener( "touch", onTouchEvent )
--]]


  --  sceneGroup:insert()
  sceneGroup:insert( nextTextButton)
  sceneGroup:insert( backTextButton)

  sceneGroup:insert(backButton)
  sceneGroup:insert(statusBox)
  sceneGroup:insert(statusText)
  sceneGroup:insert(list)
end




function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--background:removeSelf()
		--background = nil


		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end
--[[
function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then
    onBackRelease()
   end
  return true -- to Override physical back button
end
Runtime:addEventListener( "key", onKeyEvent )

--]]

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

--scene:addEventListener( "touch", on )



-----------------------------------------------------------------------------------------

return scene
