'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-512.png": "6a96be389847b5cd465c1a9e3a8a6903",
"icons/Icon-maskable-192.png": "6a96be389847b5cd465c1a9e3a8a6903",
"icons/Icon-192.png": "6a96be389847b5cd465c1a9e3a8a6903",
"icons/Icon-512.png": "6a96be389847b5cd465c1a9e3a8a6903",
"index.html": "84f82861633faac5ec668d1280f5d367",
"/": "84f82861633faac5ec668d1280f5d367",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"manifest.json": "3c47eee05d8d86a8af517e2a4ab17b68",
"favicon.png": "6a96be389847b5cd465c1a9e3a8a6903",
"assets/fonts/MaterialIcons-Regular.otf": "d616a75deecd881d328e1f259e710efc",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "7d910eec5be9836256a3588d6648f528",
"assets/assets/images/materials/homework.png": "f6c8cdcf894555889bef4c81a94a386a",
"assets/assets/images/materials/awards.png": "fa0ab26c80860e0239b4def09ae25677",
"assets/assets/images/materials/dice.png": "5c13d9e55588305c1905c2dd472ae73f",
"assets/assets/images/exam/111_society_23.png": "761ba8f0b01bc2b4b92883c600a9206b",
"assets/assets/images/exam/110_math_16.png": "e7d986df47dd8eae6c49a697dae36007",
"assets/assets/images/exam/111_math_19_explanation.png": "1b87fdaa9e952a83e07ce2e2c321a722",
"assets/assets/images/exam/110_nature_40.png": "c8027d06a31c9f43a8cbea06ea29bbed",
"assets/assets/images/exam/112_nature_29-1.png": "e1966484c141d520c0d56cbd4383d084",
"assets/assets/images/exam/112_english_28-29.png": "2cd3c707c307820488afbb8b833ec736",
"assets/assets/images/exam/112_math_19.png": "ea615e5cb09046cb99557b3c1e8d02eb",
"assets/assets/images/exam/111_listening_2.png": "f26d4600e148a1a2a70c268e9836f02f",
"assets/assets/images/exam/110_nature_3.png": "20cc97ab7f4382522dbea275fc5542ab",
"assets/assets/images/exam/112_chinese_27-29.png": "70c910e2bc73fb46c93729beb70770e1",
"assets/assets/images/exam/111_nature_47-48.png": "2b0060f513271bfbfcb0397514ae0cb0",
"assets/assets/images/exam/110_nature_31.png": "301069bad346026fb7ac421df268a4be",
"assets/assets/images/exam/112_listening_18.png": "d115c925008f325c89e963cd927bee96",
"assets/assets/images/exam/112_society_23.png": "bd9e469b0b73b2bb5cf910ac0601aee1",
"assets/assets/images/exam/112_math_24.png": "2ca1755410fc929f4d2cde2eb3baff19",
"assets/assets/images/exam/112_chinese_17.png": "efedb49080fb635d9ca08d39806c03fe",
"assets/assets/images/exam/112_society_11.png": "f4674ca1bc132b22b867adb8a7dc7f4d",
"assets/assets/images/exam/112_society_43.png": "abf5b458d649be8ea4f46d226be4813e",
"assets/assets/images/exam/111_society_24.png": "4cce1582411680be2c09f4383fe9b6ce",
"assets/assets/images/exam/111_listening_1.png": "ebe395988ec66e373701061fa6a6ca47",
"assets/assets/images/exam/111_society_18.png": "8e24dfc2b76c5f3a04681c96dfed61f2",
"assets/assets/images/exam/110_nature_53.png": "963ff6d483f91d3f1cc4819a0a8fcb7c",
"assets/assets/images/exam/111_nature_12.png": "1ae35a924b64441d5e18c4434888128e",
"assets/assets/images/exam/112_society_26.png": "6c732b59870ab666d42154f135cdd369",
"assets/assets/images/exam/111_society_31.png": "6c15df61abace8749ee292e0d2c5a89e",
"assets/assets/images/exam/111_chinese_4.png": "8be5660353c0fc7ed5c07ff48c650415",
"assets/assets/images/exam/111_math_17.png": "9cbeb8860df1933d84fb835f78a55066",
"assets/assets/images/exam/112_nature_41.png": "a65b67ba1472d7967eac14c64641309a",
"assets/assets/images/exam/112_english_1.png": "244e42a5d0633c75e1c8c552330e8a61",
"assets/assets/images/exam/110_nature_36.png": "514bdc5d39ae1c90fa5656ca8ff274a3",
"assets/assets/images/exam/112_nature_6.png": "d41a4d5c20ccf0abb090afe5dfe7da22",
"assets/assets/images/exam/111_society_33.png": "3400eb8f81f15c8709786daaabdb601c",
"assets/assets/images/exam/110_nature_44.png": "899e00aa640d6b036310544a2c7f0d26",
"assets/assets/images/exam/112_chinese_8.png": "b0bd7dcb6032e60fc2ec59cb6fd71550",
"assets/assets/images/exam/111_chinese_1.png": "e85784e9174f0af8220b3a5309434740",
"assets/assets/images/exam/111_nature_21.png": "d13cdb4955aca3ebf1898c10a1e80c1a",
"assets/assets/images/exam/112_english_25.png": "e818f79d145ff775d14311737eb1acb0",
"assets/assets/images/exam/111_math_4_explanation.png": "d2a30fe43dd423bf2be2a7d3a75b5fa0",
"assets/assets/images/exam/112_society_34.png": "45477e73c0627a0a066d0af947309d2f",
"assets/assets/images/exam/112_society_2.png": "629c5ca464b472fd77c11de57e0744b3",
"assets/assets/images/exam/112_society_31.png": "9cd50c76deb9b1b2e462a8f09544ad4e",
"assets/assets/images/exam/110_nature_37.png": "e98e2ee04c30fd1b48ec08aa547be0e3",
"assets/assets/images/exam/111_nature_28.png": "28eb23503e3b289bb6e4cf63b40f13f0",
"assets/assets/images/exam/111_society_38.png": "f3e4e7f8acb6f6178e0c975805a0bc39",
"assets/assets/images/exam/111_nature_49-50.png": "e6ba26468d2d9fd2a3860a849f374573",
"assets/assets/images/exam/112_society_10.png": "c7a64215431ac15abe9827b78d8ffce0",
"assets/assets/images/exam/112_nature_37.png": "945b04497ccf7b87b5ed6a138bcb039f",
"assets/assets/images/exam/112_nature_29-2.png": "0b9764ace08ceefac43317ae897a38d3",
"assets/assets/images/exam/111_nature_34.png": "1685a8f8917ce3c9c36fd07866a3ae02",
"assets/assets/images/exam/110_math_1.png": "3e6c97a275e51b6b83c42064db0956ec",
"assets/assets/images/exam/111_english_33-36.png": "77a7a0fbc535879c0b193a384c850e87",
"assets/assets/images/exam/111_math_24-25.png": "adff299cbb6bde78bb7ac68fb291ca8e",
"assets/assets/images/exam/112_math_21.png": "02116c1e6e349a4025787ed2375c72aa",
"assets/assets/images/exam/112_society_52-54.png": "f8f523425c647f79902b8a1c6424ed0d",
"assets/assets/images/exam/112_society_27.png": "c3a18a8771fa83f1fe5d2d72b03aa676",
"assets/assets/images/exam/111_society_53.png": "cc4ef0a141f0d099adcab6eaae07d77f",
"assets/assets/images/exam/110_nature_28.png": "5b38daf2d95bb569f5118097732f4a8b",
"assets/assets/images/exam/111_math_21_explanation.png": "7b916d1693d4dd1f558a0a99d2289b1f",
"assets/assets/images/exam/112_listening_3.png": "f6e2d520f8293e3618a95d1e93cf0c6a",
"assets/assets/images/exam/112_nature_45-46.png": "2dccb79ee26955a1d58d055f1ea75c59",
"assets/assets/images/exam/111_english_23-24.png": "60a60bc3e20bba0ae8817f1d5c892e28",
"assets/assets/images/exam/112_math_20.png": "45e343900b810226824d7a31df6d2bfe",
"assets/assets/images/exam/112_nature_5.png": "b4435c695ff17bfd58a26b1f60ec4a99",
"assets/assets/images/exam/112_math_3.png": "6dad38a3c14567c147236750d2bbb243",
"assets/assets/images/exam/111_society_15.png": "52c3a7165f46537065ea1ed1dd91747c",
"assets/assets/images/exam/111_society_5.png": "8c2ee3d9ffdca30d98459ca6a28ec332",
"assets/assets/images/exam/110_math_26_explanation.png": "16c8b85e7d22b8662bf52067427cfb1d",
"assets/assets/images/exam/111_math_20.png": "29b7d6fb2e32f28ab423ceee7115d275",
"assets/assets/images/exam/112_chinese_25-26.png": "bf92b6df5dbcf9f903a0da5c958555e2",
"assets/assets/images/exam/111_society_42.png": "ced92aa1cd9c3a3c3f43e06c2f26c9c4",
"assets/assets/images/exam/110_nature_48-49.png": "64e0cf1e29af053098665e3316820ded",
"assets/assets/images/exam/111_english_1.png": "59456931cde33626c405962e9d2322ab",
"assets/assets/images/exam/110_nature_24.png": "ef285058864e67ecc5334ea7ed41331f",
"assets/assets/images/exam/111_society_1.png": "e9242a3ba98753f6c179cdf848240d58",
"assets/assets/images/exam/112_math_23.png": "27158d4bc5a6d56580492d93586b8a95",
"assets/assets/images/exam/111_english_27-29.png": "6ffafc12682192839b6c225aa5e45e42",
"assets/assets/images/exam/112_chinese_9.png": "101e97197104f5011962b87c1af3f492",
"assets/assets/images/exam/111_nature_33.png": "f33ea82b3d23b8eff74f3710e442631b",
"assets/assets/images/exam/110_nature_45.png": "fa4a6c8e701a654b40f5c7f56090cf7d",
"assets/assets/images/exam/111_english_37-39.png": "72d80d1289aa68c8813ce57de04773a7",
"assets/assets/images/exam/112_listening_2.png": "dca5f812951f010d0569fd8caceea1d3",
"assets/assets/images/exam/112_nature_36.png": "c458f9d07ffb5d27dd35238be037d236",
"assets/assets/images/exam/111_nature_43.png": "f7f8430095c3858e8787c3e46c1f1dd2",
"assets/assets/images/exam/110_math_4.png": "065429f67da53a19aa50e9c6a75a7c76",
"assets/assets/images/exam/112_nature_22.png": "3c15a23654220947de5b8c71de07d168",
"assets/assets/images/exam/110_nature_29.png": "dd6925419db25bb03883a6a89653582d",
"assets/assets/images/exam/111_math_16.png": "82b0631b187245a8e2b31622ba5457eb",
"assets/assets/images/exam/112_society_39.png": "2063a81f011699d094a89e719abcdcda",
"assets/assets/images/exam/112_nature_18.png": "6aea8fd8d73e61cfd87713948c1881a9",
"assets/assets/images/exam/111_society_6.png": "b04c1b0ce5856f61b515a2d551ddf412",
"assets/assets/images/exam/110_nature_52-54.png": "4e05636b5fe87bf4251471611c4b8422",
"assets/assets/images/exam/111_math_18.png": "2709feb5074ffa6eb6e598e2de2cd3b9",
"assets/assets/images/exam/112_nature_32-1.png": "83d708d5df5d628110f8709355882219",
"assets/assets/images/exam/111_nature_7.png": "153a36f90be8426ffa60d0fae6b323ab",
"assets/assets/images/exam/111_nature_41.png": "153ab2b30271c6a38f653c949d340562",
"assets/assets/images/exam/111_math_1.png": "381a3113d0dda05430c4df5306102e83",
"assets/assets/images/exam/112_chinese_21.png": "6dc123cf636b076fb8761fb23b991136",
"assets/assets/images/exam/111_society_27.png": "5ded10d42077fb77241ea8c1cd1883f7",
"assets/assets/images/exam/112_nature_13.png": "1ab8e0c62f67085292bbee00bb1fa565",
"assets/assets/images/exam/110_nature_19.png": "0d9adce3a0d83774f93a3077b376ce84",
"assets/assets/images/exam/112_nature_10.png": "48a3a87d78dd5abc526a1ebdf24f16bf",
"assets/assets/images/exam/111_nature_48.png": "b1479be3f6fa021510866f209d6c1107",
"assets/assets/images/exam/111_english_22.png": "d1a84a0d608bb03fa7b666126e0f030c",
"assets/assets/images/exam/111_chinese_25.png": "6b33e4c5038f87cfeb06b2f0438ecbd8",
"assets/assets/images/exam/111_nature_24.png": "283c9314e8899ab34f598382234b77a6",
"assets/assets/images/exam/111_society_41.png": "23b5a019789d6b7ed6551d764e6b692b",
"assets/assets/images/exam/112_math_22.png": "c52be27e6d99bc49c4b5298db410d951",
"assets/assets/images/exam/111_math_23.png": "bd8c029657a0fda5db49423bd8154843",
"assets/assets/images/exam/110_nature_26.png": "d1bfd84f08b70226fa17d6a6538e556a",
"assets/assets/images/exam/111_math_17_explanation.png": "6510715557b6f310db64d88783390977",
"assets/assets/images/exam/110_nature_7.png": "11734355e5beb4f92a7f12b6783f6822",
"assets/assets/images/exam/111_society_13.png": "345784dfadb50246a1917496b3ce9d4d",
"assets/assets/images/exam/111_nature_20.png": "9e967f370c30813b2c99d92ef0968ff3",
"assets/assets/images/exam/111_nature_42-44.png": "f41ef0a162056a2779229511c40c50fe",
"assets/assets/images/exam/110_nature_33.png": "0cd059b8172f888d8065a9741b769b40",
"assets/assets/images/exam/111_chinese_28-29.png": "f05537c96694ce4a6994b600c0fcfc92",
"assets/assets/images/exam/110_math_23.png": "0df42df6ae64b94e9b84cb369989ec63",
"assets/assets/images/exam/112_nature_23.png": "e4a10a0c33dc24b6cc39a73f208c58a8",
"assets/assets/images/exam/112_chinese_38.png": "bde1cb5f7a75ad3203bc2d9dc9a3b335",
"assets/assets/images/exam/111_society_46-48.png": "949b673f9f59cfc33d599d273a4ff1e2",
"assets/assets/images/exam/110_nature_50-51.png": "6fef4d7e0794b2b3107e91ba71a5d759",
"assets/assets/images/exam/112_society_46-48.png": "31227d10765505a82a4e75b9a6b60cfd",
"assets/assets/images/exam/112_nature_11.png": "68ff731dbd2713776a7fcf3a45b60e97",
"assets/assets/images/exam/111_math_11.png": "4b58af70112c77c6c48670ff8797d6f3",
"assets/assets/images/exam/112_nature_20.png": "af39904406c8e001509248f787e19399",
"assets/assets/images/exam/112_nature_2.png": "9b0c10e612ef262fd9589ab4de4e1484",
"assets/assets/images/exam/112_chinese_29.png": "a4520aab6b232d7cb68c8d20b8953755",
"assets/assets/images/exam/112_nature_21.png": "ca2d89d3e5e30ffb5c5b1b092eaf1caa",
"assets/assets/images/exam/111_nature_45-46.png": "e5195c5ac5907f41523b7390d1bed711",
"assets/assets/images/exam/111_nature_15.png": "390c8446dc8893e9477a39e4cc806bfe",
"assets/assets/images/exam/111_society_11.png": "6a2eb58eb02a5ca0c243e5f67a82d798",
"assets/assets/images/exam/111_society_40.png": "037d5d8600b6ed30d33ad3ad07c55922",
"assets/assets/images/exam/112_society_49-51.png": "46f135446b8f0cb91ac247d6cdbb9dcb",
"assets/assets/images/exam/111_math_20_explanation.png": "60e6fdab7b626ff3e43b86130b847535",
"assets/assets/images/exam/112_nature_31.png": "5283d2dc7bca538f8f47225269b4ec08",
"assets/assets/images/exam/111_nature_26.png": "b820d81645d04a3d3663b2a1d61ae50e",
"assets/assets/images/exam/110_math_11.png": "c539fc634e3d3bd627269906b1565499",
"assets/assets/images/exam/110_math_25.png": "cb76eba310ad092499def726b670f93f",
"assets/assets/images/exam/112_nature_17.png": "581ef5224e1ac60379347c2b4f15348c",
"assets/assets/images/exam/111_society_28.png": "5a610ff725f2ddc6a0b0aac2911cb2f3",
"assets/assets/images/exam/110_nature_39.png": "d7f611bd192cf2c6f6c070164717a37b",
"assets/assets/images/exam/111_nature_11.png": "bc452a7a36bc6c19ab762820b60106a9",
"assets/assets/images/exam/112_society_47.png": "4cf195420292f58a791faca8ab0b3029",
"assets/assets/images/exam/112_nature_25.png": "c433c1d507d657c9999c56edacad3b2b",
"assets/assets/images/exam/111_chinese_34-35.png": "56c013517ad113f09731e6a851189193",
"assets/assets/images/exam/112_nature_3.png": "1ab1716cebf22365ac5bf775673e9016",
"assets/assets/images/exam/110_nature_27.png": "cddea55ddd278c5dc57e6bcb8e8dcb9a",
"assets/assets/images/exam/112_math_7.png": "73ffbb6213e4b1582b3d4715a834377d",
"assets/assets/images/exam/112_society_6.png": "46ba004ef9aa0410ea388dea90977816",
"assets/assets/images/exam/111_nature_8.png": "b5fde9b3e90953278d9e1cce06705cc7",
"assets/assets/images/exam/112_english_26-27.png": "7647c56fc57761a27dec493159614994",
"assets/assets/images/exam/111_nature_27.png": "d7a44fdf5dec7206a9c5c8e7b671e57a",
"assets/assets/images/exam/112_society_41.png": "92fece1e4e24f610db6db260e21a11fc",
"assets/assets/images/exam/111_society_2.png": "712fa2ac3cc4e5902eda88e2972b6590",
"assets/assets/images/exam/112_math_18.png": "d97a2f23f9474535f014009455033f50",
"assets/assets/images/exam/112_nature_47-48.png": "97eccef33b800bfbdf4b8ecbd1ed8c96",
"assets/assets/images/exam/111_nature_47.png": "a28699df4b7205a8f82a154058a4479b",
"assets/assets/images/exam/112_math_11.png": "db1fa9e2520484360ae0ea5d81a67436",
"assets/assets/images/exam/112_nature_42.png": "85a7f55c423ca7503019eb332fdb9505",
"assets/assets/images/exam/112_nature_30.png": "efe8d3c809de052a2e9341f0590c71d6",
"assets/assets/images/exam/111_nature_16.png": "15b869c56fc85c56f162d0da515d7a35",
"assets/assets/images/exam/112_nature_32-2.png": "c8f150476668daad24706f1b47c43949",
"assets/assets/images/exam/111_nature_40.png": "8e0264f178ba8d4b7d991353293e0494",
"assets/assets/images/exam/111_nature_23.png": "8ff991ef2c3e08e5a1da169863da32fc",
"assets/assets/images/exam/112_english_30-32.png": "eed32afc0d13c7bd15cdda8e9c9145af",
"assets/assets/images/exam/112_nature_33.png": "96a4f9a4631f50ee87ff94056b5511ad",
"assets/assets/images/exam/112_math_12.png": "8fd56a870f501860ac3271b7bce239f9",
"assets/assets/images/exam/111_society_8.png": "692d28d6a97f382e53a40c671726939f",
"assets/assets/images/exam/111_chinese_11.png": "c5b0db5e969ca456f859b1829f3fc9cd",
"assets/assets/images/exam/112_society_28.png": "7197925026b1e8826251d36a49a73ef1",
"assets/assets/images/exam/112_nature_43-44.png": "ae8e469d02ecd2e2a04712a39c27e8df",
"assets/assets/images/exam/110_nature_12.png": "79ea2883d8c675a6e7654fb7f765b9e6",
"assets/assets/images/exam/111_math_25.png": "1430fadc68b42abf1e86c9692c8769f0",
"assets/assets/images/exam/112_society_15.png": "1115080072f5ee7ec5d26a3dce4deda5",
"assets/assets/images/exam/112_nature_24.png": "840eb17c6b2b0802767d568f283c4aeb",
"assets/assets/images/exam/111_nature_30.png": "ce630e9d3652d615a79f98d142dbab0f",
"assets/assets/images/exam/112_society_19.png": "4e380b076fc30c0620237b270d8aa44c",
"assets/assets/images/exam/110_nature_32.png": "a07b9795c2216bfeb7fb41ea62fa3bda",
"assets/assets/images/exam/111_society_12.png": "540f600f07c0bd9c0558445d681889e1",
"assets/assets/images/exam/112_society_25.png": "a778d8c1c5820cf3ede6c5c6079f83c9",
"assets/assets/images/exam/111_nature_38.png": "3960c7877c1abaa5060806d30263bdce",
"assets/assets/images/exam/110_math_17.png": "3455bd88b970321941cc1738b34c6670",
"assets/assets/images/exam/110_math_9.png": "8de25b040e9ed71161c5a08961d569e9",
"assets/assets/images/exam/110_nature_18.png": "5b908d48ea3834128d5f91debce6c9cf",
"assets/assets/images/exam/111_society_29.png": "28cbe9b9eaa319561dd6de65a901729d",
"assets/assets/images/exam/110_math_19.png": "33f719ce75b75f07da25524ad2bb92ad",
"assets/assets/images/exam/112_society_4.png": "5e6d1336b7222fa0243e28ee8a76d7ec",
"assets/assets/images/exam/112_english_42-43.png": "94819db33f45df4e296ee3aea49a215f",
"assets/assets/images/exam/112_nature_28.png": "54f1d876710679b82d094170347b4c54",
"assets/assets/images/exam/111_listening_example_1.png": "9a33ec00580e0c79bdc6460f8cfd1e80",
"assets/assets/images/exam/111_listening_3.png": "5f2866d7f21cbae939ac78311aebf767",
"assets/assets/images/exam/110_math_15.png": "44eab561650bbd8e59347ca83b791b90",
"assets/assets/images/exam/112_math_14.png": "a2ccda93a62ceb168d54ca5929ee2acd",
"assets/assets/images/exam/111_society_19.png": "29b69169902c3a602fea87773cea5dfb",
"assets/assets/images/exam/112_listening_1.png": "ed8d259972337819aeeae33caa44b32a",
"assets/assets/images/exam/110_nature_22.png": "088a3621ed86a7832bac694e54cdfa61",
"assets/assets/images/exam/110_math_17_explanation.png": "b40538194092037e813dce99fe1ca860",
"assets/assets/images/exam/110_nature_38.png": "3066d646aab9cf47e9ef3bbfcf03c87b",
"assets/assets/images/exam/111_english_40-43.png": "fe6393e28dc886268ba9047313234716",
"assets/assets/images/exam/112_nature_49-50.png": "4dcb6a6038ec2109cb8e3917de7668f7",
"assets/assets/images/exam/112_english_33-35.png": "d74610a90a34c869cfcb9dd7d916a432",
"assets/assets/images/exam/111_society_16.png": "63bf02a6c01d628a4641772515a881e2",
"assets/assets/images/exam/111_chinese_30-31.png": "c4358019a02408e54a3b98a035b672ee",
"assets/assets/images/exam/111_math_15.png": "9fb6ae90ba089a97b6631db2bf57b0af",
"assets/assets/images/exam/112_nature_15.png": "4074c90abaa16674d4bfaf2782fbf8b2",
"assets/assets/images/exam/110_nature_35.png": "ffe889276ccd83c686e13d6a85e0cb7d",
"assets/assets/images/exam/110_nature_43.png": "c542fb4a4f2fcf0c7a2b1c6add9be998",
"assets/assets/images/exam/111_society_52-54.png": "c1eb68b21278ded841a526c5097d8bba",
"assets/assets/images/exam/111_math_14.png": "2c8b5bd169274fac8ba528b9d72d6abf",
"assets/assets/images/exam/112_society_14.png": "98e16ad04193d67e3fadcd05339c9582",
"assets/assets/images/exam/112_math_17.png": "1cf5f1eeaf7bb6c7378ce37b096ca789",
"assets/assets/images/exam/111_nature_25.png": "b180bfaa2cf341561392b04afa22e68c",
"assets/assets/images/exam/112_society_40.png": "5798f2e26bddefb166eed0573316b509",
"assets/assets/images/exam/110_nature_1.png": "623cec12449a14e74a7db031b9276e88",
"assets/assets/images/exam/112_nature_35.png": "2d0e3719fb9dab2a391d7314cf2462e3",
"assets/assets/images/exam/111_math_13.png": "19b02085b20660e17c382e768564f6c7",
"assets/assets/images/exam/112_english_36-38.png": "826b4b3e33fd7244b040aa9b6c6201f9",
"assets/assets/images/exam/111_math_9_explanation.png": "0f869b19050ffcd8ce377a598613d07c",
"assets/assets/images/exam/110_nature_16.png": "7130ea75635d1747ce96d3732428cbaf",
"assets/assets/images/exam/111_chinese_21.png": "f5cb65e5d166bd5a3662ee3ac7891301",
"assets/assets/images/exam/110_nature_42.png": "b80a5c1bb7049d176bae9656e7912649",
"assets/assets/images/exam/111_nature_42.png": "c835699f35ea271112d36789ff3472cc",
"assets/assets/images/exam/111_math_4.png": "49f23030f05368ae154b8375cfa9ffbc",
"assets/assets/images/exam/111_chinese_36.png": "8a1be52284f6721f653b88a4f029dd72",
"assets/assets/images/exam/111_society_20.png": "082366272343a60454d1ff0233d65255",
"assets/assets/images/exam/110_nature_8.png": "7080342c68fa08db22ba753a0a88f35f",
"assets/assets/images/exam/111_english_33.png": "5de587692977a00b14db91d4ed4ea24a",
"assets/assets/images/exam/111_math_21.png": "1e34a6097f67bbac230b9da1847ccb98",
"assets/assets/images/exam/110_nature_20.png": "a6176fc66404a39f39609df096d396f9",
"assets/assets/images/exam/112_math_13.png": "d2e1729fab6557ba3efa6c9b365bdd1f",
"assets/assets/images/exam/111_chinese_26-27.png": "3659415037ad255338d2f97f9a284ef5",
"assets/assets/images/exam/112_nature_7.png": "8e0d7664d7fc29d27f5a0da1af55f05b",
"assets/assets/images/exam/110_nature_17.png": "d52b3c07d9c40bd666e490351c5355e1",
"assets/assets/images/exam/110_nature_11.png": "6d609e5ea16bfc41b562a9cd478d5ab4",
"assets/assets/images/exam/111_english_30-32.png": "0ab39b7ccde5d398083f171248aa3c0b",
"assets/assets/images/exam/111_society_26.png": "c765584cf2600007b3e7aa1a7f15fe48",
"assets/assets/images/exam/112_society_7.png": "76f15184c1acccd6584074bfb8027589",
"assets/assets/images/exam/111_math_19.png": "9cab97038dbc0eae5d7b54a9d93189d9",
"assets/assets/images/exam/112_society_38.png": "acdd1024000a675a96636798890b9f69",
"assets/assets/images/exam/112_english_24-25.png": "3b9f99caff11943a0e3c3a34d5720a7a",
"assets/assets/images/exam/111_society_36.png": "875b3de9f7ec8ca89bd15c1e6595cbe2",
"assets/assets/images/exam/111_society_3.png": "a7bcf11732f48908b3c8e85f19467627",
"assets/assets/images/exam/111_society_43.png": "753559bfc5f53b1387522d185fbb843d",
"assets/assets/images/exam/110_math_21.png": "5c986f0339148f141df2f7235a717335",
"assets/assets/images/exam/110_math_26.png": "aada2b90d5e62ec4812b353dab355454",
"assets/assets/images/exam/111_nature_17.png": "c083c2b4fff82cdeea5a46b746722486",
"assets/assets/images/exam/111_nature_6.png": "53a809254db9d81be35ff90c311c515a",
"assets/assets/images/exam/111_math_13_explanation.png": "a303e0efbc3ac32758bbe79eb732b2c4",
"assets/assets/images/exam/112_nature_14.png": "a2a45650eebd2c97594a26c941aba640",
"assets/assets/images/exam/112_nature_19.png": "b52b7a4f90fb9808972c36c6dc5f27cc",
"assets/assets/images/exam/112_math_8.png": "ce824041a60067997cb01391ae0496a1",
"assets/assets/images/exam/111_nature_35.png": "827c08840855a3d048ae860e016814c4",
"assets/assets/images/exam/110_math_7.png": "487b7c19766df6295eb8616f8e5b2ca7",
"assets/assets/images/exam/112_nature_34.png": "59cc5377a3313102403c13d21db16aa0",
"assets/assets/images/exam/111_nature_39.png": "ab1a1f3b4ab9babf1a83b3c675e9022a",
"assets/assets/images/exam/112_nature_39.png": "5e388dae52e6cb4a0ba4549576bbd055",
"assets/assets/images/exam/111_english_21-22.png": "8dc852049ddad6c420d6d5ed15d5e9a2",
"assets/assets/images/exam/111_society_39.png": "03f35db4936588890a2f000f8c9228c8",
"assets/assets/images/exam/112_chinese_6.png": "95d327c72fbd87a4836be63f947fd2d9",
"assets/assets/images/logo.png": "6a96be389847b5cd465c1a9e3a8a6903",
"assets/assets/audios/exam/112_listening_13.mp3": "6bc0a3b56f79b9fe3c889eb484636c45",
"assets/assets/audios/exam/112_listening_20.mp3": "0d9bf7e3de990e2eaa60c76e6f187626",
"assets/assets/audios/exam/111_listening_2.mp3": "35cddcccf2111a762835c516dcee0977",
"assets/assets/audios/exam/111_listening_13.mp3": "f34bf53207dddbd4b00b676d5974c671",
"assets/assets/audios/exam/111_listening_example_1.mp3": "9dbb449f651e99c76da40476a02b9e3d",
"assets/assets/audios/exam/111_listening_8.mp3": "d95473c6871d95b0f0ed8b7fe40e0857",
"assets/assets/audios/exam/112_listening_6.mp3": "adb1932a532b01b1f68bc63e56386524",
"assets/assets/audios/exam/112_listening_3.mp3": "cf5b4cd2ad6364e17ba58337b4b1a023",
"assets/assets/audios/exam/111_listening_18.mp3": "5a661b75d5cb0b4046f35649748b2584",
"assets/assets/audios/exam/111_listening_5.mp3": "1939a5f537ec5c6c2eea39bb4f87db01",
"assets/assets/audios/exam/112_listening_17.mp3": "cb9d8dffe98e0edf14e825cfe7b0e2b6",
"assets/assets/audios/exam/111_listening_7.mp3": "2b588eb4b7c76c239596670049bd32fc",
"assets/assets/audios/exam/112_listening_4.mp3": "d0acdcd4c630fb3cbd7a1b8edf3f6d8c",
"assets/assets/audios/exam/111_listening_17.mp3": "c63f1fbf7499c2e21bc57af86c004443",
"assets/assets/audios/exam/111_listening_example_3.mp3": "53cbdf6a3d165c8d8ce1338cb777d553",
"assets/assets/audios/exam/111_listening_1.mp3": "c140ae24e44febfad6b7ca5c9ac912c6",
"assets/assets/audios/exam/111_listening_6.mp3": "0c12204b13c5cd6a10129e6835a7218d",
"assets/assets/audios/exam/111_listening_3.mp3": "3f16f00b3206e178ce8e538750f7ad37",
"assets/assets/audios/exam/111_listening_12.mp3": "cf85010c8a1ed686101f189a2b02dba2",
"assets/assets/audios/exam/111_listening_14.mp3": "295da6fc2a397d069c7576c91599de44",
"assets/assets/audios/exam/112_listening_5.mp3": "297abd81410d2e6203aa93599ea5af0f",
"assets/assets/audios/exam/111_listening_20.mp3": "327e2ac5c04c8bc672253abd518807b6",
"assets/assets/audios/exam/111_listening_11.mp3": "4bb9dfdb68a8692428aaf6da0045d3c3",
"assets/assets/audios/exam/111_listening_19.mp3": "63e3053bdfddeaf032d9ad0133d1e9e9",
"assets/assets/audios/exam/111_listening_10.mp3": "45cc09016ffaff915bbf81ff40f88bbe",
"assets/assets/audios/exam/112_listening_14.mp3": "442e4ac96e7e85ebdfc818a954e136b7",
"assets/assets/audios/exam/112_listening_15.mp3": "41d660018aa408d372631273a7676c07",
"assets/assets/audios/exam/111_listening_9.mp3": "34dbe8a5c9d128da27befba48694a996",
"assets/assets/audios/exam/112_listening_10.mp3": "9bd542e1ed0ecaf0a6a55951832408d9",
"assets/assets/audios/exam/111_listening_4.mp3": "85ed030e7670babd5f0acb06321659c8",
"assets/assets/audios/exam/112_listening_21.mp3": "5b25eb09c382d4db71e5d683abcb0eec",
"assets/assets/audios/exam/112_listening_7.mp3": "691d517ad8f03da11593951df9aefc38",
"assets/assets/audios/exam/112_listening_19.mp3": "45d438ef351f24afa81e8cb420454548",
"assets/assets/audios/exam/112_listening_11.mp3": "de7c51851772bc96dc44d2b392d635cf",
"assets/assets/audios/exam/112_listening_12.mp3": "6be781af7906cdd75ee7a5cae8d271fc",
"assets/assets/audios/exam/111_listening_21.mp3": "6253b9d06a9cb8e60b9ca65db05cbc10",
"assets/assets/audios/exam/111_listening_15.mp3": "6965c5ac558f875c23cb6d78a1a0c70a",
"assets/assets/audios/exam/112_listening_18.mp3": "c3d1004da1d2f828c9b86a20bcda990a",
"assets/assets/audios/exam/112_listening_16.mp3": "a24b9de27366ba74a2d37afc69b3bf22",
"assets/assets/audios/exam/111_listening_example_2.mp3": "be59956f1b0b8306a2bc4a53ef326c0b",
"assets/assets/audios/exam/112_listening_1.mp3": "def0fc158a0770204b25885a800d304f",
"assets/assets/audios/exam/112_listening_8.mp3": "30915ee994e0aff62511466a527b5fca",
"assets/assets/audios/exam/111_listening_16.mp3": "206bbacf5a1a6dc183c53b36e593381b",
"assets/assets/audios/exam/112_listening_9.mp3": "d6519cb07d62a20757c6fa28c7387d90",
"assets/assets/audios/exam/112_listening_2.mp3": "0baba8a8cc56c713d79f45dbae2c4f64",
"assets/assets/animations/animation_review.lottie": "d2b417f9cd1ad836d1af41f106ea38a4",
"assets/assets/animations/135507-exam-prep-topics.json": "3d8f891ea3d14c457be516ffb48078d5",
"assets/assets/config.json": "8bb9d1e086337993aa939c7ddbc7f249",
"assets/assets/cap_exams.json": "915743f74a38e00a719342b726508c03",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "bcaf3ba974cf7900b3c158ca593f4971",
"assets/AssetManifest.json": "9d452a238b83fd634ce3d5401d5d70cb",
"assets/NOTICES": "8d57663e10ec37da23c808a8cf53ddf4",
"assets/FontManifest.json": "9d3694b6aa5d83b9d872004a25e3be30",
"version.json": "7c1db5a7263164ad43b8c06f161a8097",
"main.dart.js": "fc4072b3b0909a421209c2a7bac3d91f",
"privacy.html": "c3fb32b427f0ec50ae1929578ee8c78c",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
