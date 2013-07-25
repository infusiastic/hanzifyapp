# encoding: utf-8
# Hanzify Web App
#
# Hanzificator Module
#
# Write any name in Chinese according to the official transliteration rules.
#
# So far, only Russian names are supported.
# 
# Copyright © 2012-2013 Demian Terentev <demian@infusiastic.me>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'strscan'

class Hanzificator
  def initialize
    @common = {
      "а" => "阿",
      "ай" => "艾",
      "аи" => "艾",
      "ан" => "安",
      "ань" => "安",
      "ау" => "奥",
      "ао" => "奥",
      "б" => "布",
      "ба" => "巴",
      "бай" => "拜",
      "бан" => "班",
      "бань" => "班",
      "бау" => "包",
      "бао" => "包",
      "бе" => "别",
      "бё" => "比奥",
      "бен" => "边",
      "бень" => "边",
      "би" => "比",
      "бий" => "比",
      "бь" => "比",
      "бьи" => "比",
      "бин" => "宾",
      "бинь" => "宾",
      "бо" => "博",
      "бон" => "邦",
      "бонь" => "邦",
      "бу" => "布",
      "буй" => "布伊",
      "бун" => "本",
      "бунь" => "本",
      "бы" => "贝",
      "бый" => "贝",
      "бэ" => "贝",
      "бэн" => "本",
      "бэнь" => "本",
      "бын" => "本",
      "бынь" => "本",
      "бю" => "比尤",
      "бью" => "比尤",
      "бя" => "比亚",
      "бян" => "比扬",
      "бянь" => "比扬",
      "в" => "夫",
      "ва" => "瓦",
      "вай" => "瓦伊",
      "ван" => "万",
      "вань" => "万",
      "вау" => "沃",
      "вао" => "沃",
      "ве" => "韦",
      "вен" => "文",
      "вень" => "文",
      "ви" => "维",
      "вий" => "维",
      "вь" => "维",
      "вьи" => "维",
      "вин" => "温",
      "винь" => "温",
      "во" => "沃",
      "вон" => "翁",
      "вонь" => "翁",
      "ву" => "武",
      "вуй" => "维",
      "вун" => "文",
      "вунь" => "文",
      "вы" => "维",
      "вый" => "维",
      "вын" => "文",
      "вынь" => "文",
      "вьё" => "维奥",
      "вэ" => "韦",
      "вю" => "维尤",
      "вью" => "维尤",
      "вя" => "维亚",
      "вян" => "维扬",
      "вянь" => "维扬",
      "г" => "格",
      "га" => "加",
      "гай" => "盖",
      "ган" => "甘",
      "гань" => "甘",
      "гау" => "高",
      "гао" => "高",
      "ге" => "格",
      "ген" => "根",
      "гень" => "根",
      "ги" => "吉",
      "гий" => "吉",
      "гь" => "吉",
      "гьи" => "吉",
      "гин" => "金",
      "гинь" => "金",
      "го" => "戈",
      "гон" => "贡",
      "гонь" => "贡",
      "гу" => "古",
      "гуй" => "圭",
      "гун" => "贡",
      "гунь" => "贡",
      "гын" => "根",
      "гынь" => "根",
      "гьё" => "吉奥",
      "гэ" => "盖",
      "гю" => "久",
      "гью" => "久",
      "гя" => "吉亚",
      "гян" => "吉扬",
      "гянь" => "吉扬",
      "д" => "德",
      "да" => "达",
      "дай" => "代",
      "дан" => "丹",
      "дань" => "丹",
      "дау" => "道",
      "дао" => "道",
      "де" => "杰",
      "дё" => "焦",
      "ден" => "坚",
      "день" => "坚",
      "дж" => "季",
      "джа" => "贾",
      "джай" => "贾伊",
      "джан" => "占",
      "джань" => "占",
      "джау" => "焦",
      "джао" => "焦",
      "дже" => "杰",
      "джен" => "真",
      "джень" => "真",
      "джи" => "吉",
      "джий" => "吉",
      "джин" => "金",
      "джо" => "焦",
      "джон" => "忠",
      "джонь" => "忠",
      "джу" => "朱",
      "джуй" => "朱伊",
      "джун" => "准",
      "джунь" => "准",
      "джю" => "久",
      "ди" => "季",
      "дий" => "季",
      "дь" => "季",
      "дьи" => "季",
      "дин" => "金",
      "динь" => "金",
      "до" => "多",
      "дон" => "东",
      "донь" => "东",
      "ду" => "杜",
      "дуй" => "杜伊",
      "дун" => "敦",
      "дунь" => "敦",
      "ды" => "德",
      "дый" => "德",
      "дэ" => "代",
      "дэн" => "登",
      "дэнь" => "登",
      "дын" => "登",
      "дынь" => "登",
      "дю" => "久",
      "дью" => "久",
      "дя" => "佳",
      "дян" => "江",
      "дянь" => "江",
      "е" => "耶",
      "ё" => "约",
      "йо" => "约",
      "ен" => "延",
      "ень" => "延",
      "ж" => "日",
      "жа" => "扎",
      "жай" => "扎伊",
      "жан" => "然",
      "жань" => "然",
      "жау" => "饶",
      "жао" => "饶",
      "же" => "热",
      "жен" => "任",
      "жень" => "任",
      "жи" => "日",
      "жий" => "日",
      "жь" => "日",
      "жьи" => "日",
      "жин" => "任",
      "жинь" => "任",
      "жо" => "若",
      "жон" => "容",
      "жонь" => "容",
      "жу" => "茹",
      "жуй" => "瑞",
      "жун" => "容",
      "жунь" => "容",
      "жын" => "任",
      "жынь" => "任",
      "жю" => "茹",
      "з" => "兹",
      "дз" => "兹",
      "за" => "扎",
      "дза" => "扎",
      "заи" => "宰",
      "зай" => "宰",
      "дзай" => "宰",
      "зан" => "赞",
      "зань" => "赞",
      "зау" => "藻",
      "зао" => "藻",
      "зё" => ",дзё",
      "зе" => "泽",
      "дзе" => "泽",
      "зен" => "津",
      "зень" => "津",
      "дзен" => "津",
      "зи" => "济",
      "зий" => "济",
      "зь" => "济",
      "зьи" => "济",
      "дзи" => "济",
      "дзь" => "济",
      "дзий" => "济",
      "зин" => "津",
      "зинь" => "津",
      "дзин" => "津",
      "дзинь" => "津",
      "зо" => "佐",
      "дзо" => "佐",
      "зон" => "宗",
      "зонь" => "宗",
      "дзон" => "宗",
      "дзонь" => "宗",
      "зу" => "祖",
      "дзу" => "祖",
      "зуй" => "祖伊",
      "дзуй" => "祖伊",
      "зун" => "尊",
      "зунь" => "尊",
      "зын" => "曾",
      "зынь" => "曾",
      "дзын" => "曾",
      "дзынь" => "曾",
      "зэ" => "泽",
      "зю" => "久",
      "дзю" => "久",
      "зя" => "贾",
      "дзя" => "贾",
      "зян" => "江",
      "дзянь" => "江",
      "и" => "伊",
      "й" => "伊",
      "ий" => "伊",
      "ьи" => "伊",
      "ь" => "伊",
      "ин" => "因",
      "инь" => "因",
      "к" => "克",
      "ка" => "卡",
      "кай" => "凯",
      "кан" => "坎",
      "кань" => "坎",
      "кау" => "考",
      "као" => "考",
      "ке" => "克",
      "кен" => "肯",
      "кень" => "肯",
      "ки" => "基",
      "кий" => "基",
      "кь" => "基",
      "кьи" => "基",
      "кин" => "金",
      "кинь" => "金",
      "ко" => "科",
      "кон" => "孔",
      "конь" => "孔",
      "ку" => "库",
      "куй" => "奎",
      "кун" => "昆",
      "кунь" => "昆",
      "кын" => "肯",
      "кынь" => "肯",
      "кьё" => "基奥",
      "кэ" => "凯",
      "кю" => "丘",
      "кью" => "丘",
      "кя" => "基亚",
      "кян" => "基扬",
      "кянь" => "基扬",
      "л" => "尔",
      "ла" => "拉",
      "лай" => "莱",
      "лан" => "兰",
      "лань" => "兰",
      "лау" => "劳",
      "лао" => "劳",
      "ле" => "列",
      "лё" => "廖",
      "льё" => "廖",
      "лен" => "连",
      "лень" => "连",
      "ли" => "利",
      "лий" => "利",
      "ль" => "利",
      "льи" => "利",
      "лин" => "林",
      "линь" => "林",
      "ло" => "洛",
      "лон" => "隆",
      "лонь" => "隆",
      "лу" => "卢",
      "луй" => "卢伊",
      "лун" => "伦",
      "лунь" => "伦",
      "лы" => "雷",
      "лын" => "伦",
      "лынь" => "伦",
      "лэ" => "莱",
      "лю" => "柳",
      "лью" => "柳",
      "ля" => "利亚",
      "лян" => "良",
      "лянь" => "良",
      "м" => "姆",
      "ма" => "马",
      "май" => "迈",
      "ман" => "曼",
      "мань" => "曼",
      "мау" => "毛",
      "мао" => "毛",
      "ме" => "梅",
      "мё" => "苗",
      "мен" => "缅",
      "мень" => "缅",
      "ми" => "米",
      "мий" => "米",
      "мь" => "米",
      "мьи" => "米",
      "мин" => "明",
      "минь" => "明",
      "мо" => "莫",
      "мон" => "蒙",
      "монь" => "蒙",
      "му" => "穆",
      "муй" => "穆伊",
      "мун" => "蒙",
      "мунь" => "蒙",
      "мы" => "梅",
      "мэ" => "梅",
      "мэн" => "门",
      "мэнь" => "门",
      "мын" => "门",
      "мынь" => "门",
      "мю" => "缪",
      "мью" => "缪",
      "мюн" => "敏",
      "мя" => "米亚",
      "мян" => "米扬",
      "мянь" => "米扬",
      "н" => "恩",
      "на" => "纳",
      "най" => "奈",
      "нан" => "南",
      "нань" => "南",
      "нау" => "瑙",
      "нао" => "瑙",
      "не" => "涅",
      "нё" => "尼奥",
      "нен" => "年",
      "нень" => "年",
      "ни" => "尼",
      "ний" => "尼",
      "нь" => "尼",
      "ньи" => "尼",
      "нин" => "宁",
      "нинь" => "宁",
      "но" => "诺",
      "нон" => "农",
      "нонь" => "农",
      "ну" => "努",
      "нуй" => "努伊",
      "нун" => "嫩",
      "нунь" => "嫩",
      "ны" => "内",
      "нэ" => "内",
      "нэн" => "嫩",
      "нэнь" => "嫩",
      "нын" => "嫩",
      "нынь" => "嫩",
      "ню" => "纽",
      "нью" => "纽",
      "нюн" => "纽恩",
      "ня" => "尼亚",
      "нян" => "尼扬",
      "нянь" => "尼扬",
      "о" => "奥",
      "он" => "翁",
      "онь" => "翁",
      "п" => "普",
      "па" => "帕",
      "пай" => "派",
      "пан" => "潘",
      "пань" => "潘",
      "пау" => "保",
      "пао" => "保",
      "пе" => "佩",
      "пё" => "皮奥",
      "пен" => "片",
      "пень" => "片",
      "пи" => "皮",
      "пий" => "皮",
      "пь" => "皮",
      "пьи" => "皮",
      "пин" => "平",
      "пинь" => "平",
      "по" => "波",
      "пон" => "蓬",
      "понь" => "蓬",
      "пу" => "普",
      "пуй" => "普伊",
      "пун" => "蓬",
      "пунь" => "蓬",
      "пы" => "佩",
      "пый" => "佩",
      "пэ" => "佩",
      "пэн" => "彭",
      "пэнь" => "彭",
      "пын" => "彭",
      "пю" => "皮尤",
      "пью" => "皮尤",
      "пя" => "皮亚",
      "пян" => "皮扬",
      "пянь" => "皮扬",
      "р" => "尔",
      "ра" => "拉",
      "рай" => "赖",
      "ран" => "兰",
      "рань" => "兰",
      "рау" => "劳",
      "рао" => "劳",
      "ре" => "列",
      "рё" => "廖",
      "рьё" => "廖",
      "рен" => "连",
      "рень" => "连",
      "ри" => "里",
      "рий" => "里",
      "рь" => "里",
      "рьи" => "里",
      "рин" => "林",
      "ринь" => "林",
      "ро" => "罗",
      "рон" => "龙",
      "ронь" => "龙",
      "ру" => "鲁",
      "руй" => "鲁伊",
      "рун" => "伦",
      "рунь" => "伦",
      "ры" => "雷",
      "рын" => "伦",
      "рынь" => "伦",
      "рэ" => "雷",
      "рю" => "留",
      "рью" => "留",
      "ря" => "里亚",
      "рян" => "良",
      "рянь" => "良",
      "с" => "斯",
      "са" => "萨",
      "сай" => "赛",
      "сан" => "桑",
      "сань" => "桑",
      "сау" => "绍",
      "сао" => "绍",
      "се" => "谢",
      "сё" => "肖",
      "сен" => "先",
      "сень" => "先",
      "си" => "西",
      "сий" => "西",
      "сь" => "西",
      "сьи" => "西",
      "син" => "辛",
      "синь" => "辛",
      "со" => "索",
      "сон" => "松",
      "сонь" => "松",
      "су" => "苏",
      "суй" => "绥",
      "сун" => "孙",
      "сунь" => "孙",
      "сы" => "瑟",
      "сын" => "森",
      "сынь" => "森",
      "сэ" => "塞",
      "сю" => "休",
      "сью" => "休",
      "сюн" => "雄",
      "сюнь" => "雄",
      "ся" => "夏",
      "сян" => "相",
      "сянь" => "相",
      "т" => "特",
      "та" => "塔",
      "тай" => "泰",
      "тан" => "坦",
      "тань" => "坦",
      "тау" => "陶",
      "тао" => "陶",
      "те" => "捷",
      "тё" => "乔",
      "тен" => "坚",
      "тень" => "坚",
      "ти" => "季",
      "тий" => "季",
      "ть" => "季",
      "тьи" => "季",
      "тин" => "京",
      "тинь" => "京",
      "то" => "托",
      "тон" => "通",
      "тонь" => "通",
      "тся" => "齐亚",
      "ту" => "图",
      "туй" => "图伊",
      "тун" => "通",
      "тунь" => "通",
      "ты" => "特",
      "тый" => "特",
      "тэ" => "泰",
      "тэн" => "滕",
      "тын" => "滕",
      "тынь" => "滕",
      "тю" => "秋",
      "тью" => "秋",
      "тюн" => "琼",
      "тюнь" => "琼",
      "тя" => "佳",
      "тян" => "强",
      "тянь" => "强",
      "у" => "乌",
      "уй" => "维",
      "ун" => "温",
      "унь" => "温",
      "ф" => "夫",
      "фа" => "法",
      "фай" => "法伊",
      "фан" => "凡",
      "фань" => "凡",
      "фау" => "福",
      "фао" => "福",
      "фе" => "费",
      "фё" => "菲奥",
      "фен" => "芬",
      "фень" => "芬",
      "фи" => "菲",
      "фий" => "菲",
      "фь" => "菲",
      "фьи" => "菲",
      "фин" => "丰",
      "финь" => "丰",
      "фо" => "福",
      "фон" => "丰",
      "фонь" => "丰",
      "фу" => "富",
      "фуй" => "富伊",
      "фун" => "丰",
      "фунь" => "丰",
      "фы" => "菲",
      "дзы" => "济",
      "фын" => "芬",
      "фынь" => "芬",
      "фэ" => "费",
      "фю" => "菲尤",
      "фью" => "菲尤",
      "фя" => "菲亚",
      "х" => "赫",
      "ха" => "哈",
      "хай" => "海",
      "хан" => "汉",
      "хань" => "汉",
      "хау" => "豪",
      "хао" => "豪",
      "хе" => "赫",
      "хен" => "亨",
      "хень" => "亨",
      "хи" => "希",
      "хий" => "希",
      "хьи" => "希",
      "хин" => "欣",
      "хинь" => "欣",
      "хо" => "霍",
      "хон" => "洪",
      "хонь" => "洪",
      "ху" => "胡",
      "хуй" => "惠",
      "хун" => "洪",
      "хунь" => "洪",
      "хы" => "黑",
      "хью" => "休",
      "хян" => "希扬",
      "хянь" => "希扬",
      "ц" => "茨",
      "дц" => "茨",
      "дс" => "茨",
      "тц" => "茨",
      "тс" => "茨",
      "ца" => "察",
      "дца" => "察",
      "дса" => "察",
      "тса" => "察",
      "цай" => "采",
      "дцай" => "采",
      "дсай" => "采",
      "тцай" => "采",
      "тсай" => "采",
      "цан" => "灿",
      "цань" => "灿",
      "дцан" => "灿",
      "дцань" => "灿",
      "цау" => "曹",
      "цао" => "曹",
      "це" => "采",
      "дце" => "采",
      "дсе" => "采",
      "тце" => "采",
      "тсе" => "采",
      "цен" => "岑",
      "цень" => "岑",
      "тцен" => "岑",
      "тцень" => "岑",
      "ци" => "齐",
      "ций" => "齐",
      "цьи" => "齐",
      "дси" => "齐",
      "дсий" => "齐",
      "тси" => "齐",
      "цин" => "钦",
      "цинь" => "钦",
      "дцин" => "钦",
      "дцинь" => "钦",
      "дсин" => "钦",
      "дсинь" => "钦",
      "тсин" => "钦",
      "тсинь" => "钦",
      "цо" => "措",
      "дцо" => "措",
      "дсо" => "措",
      "тсо" => "措",
      "цон" => "聪",
      "цонь" => "聪",
      "дсон" => "聪",
      "дсонь" => "聪",
      "тсон" => "聪",
      "тсонь" => "聪",
      "цу" => "楚",
      "дцу" => "楚",
      "дсу" => "楚",
      "тсу" => "楚",
      "цуй" => "崔",
      "дцуй" => "崔",
      "дсуй" => "崔",
      "тцуй" => "崔",
      "тсуй" => "崔",
      "цун" => "聪",
      "цунь" => "聪",
      "тсун" => "聪",
      "тсунь" => "聪",
      "цы" => "齐",
      "дцы" => "齐",
      "дсы" => "齐",
      "тцы" => "齐",
      "тсы" => "齐",
      "цян" => "蔷",
      "цянь" => "蔷",
      "дцян" => "蔷",
      "дцянь" => "蔷",
      "дсян" => "蔷",
      "дсянь" => "蔷",
      "ч" => "奇",
      "тч" => "奇",
      "дч" => "奇",
      "ча" => "恰",
      "тча" => "恰",
      "дча" => "恰",
      "чай" => "柴",
      "тчай" => "柴",
      "дчай" => "柴",
      "чан" => "昌",
      "чань" => "昌",
      "дчан" => "昌",
      "чау" => "乔",
      "чао" => "乔",
      "че" => "切",
      "тче" => "切",
      "дче" => "切",
      "чен" => "琴",
      "чень" => "琴",
      "тчен" => "琴",
      "тчень" => "琴",
      "дчен" => "琴",
      "чи" => "奇",
      "чий" => "奇",
      "чь" => "奇",
      "чьи" => "奇",
      "тчий" => "奇",
      "дчий" => "奇",
      "чин" => "钦",
      "чинь" => "钦",
      "тчин" => "钦",
      "дчин" => "钦",
      "чо" => "乔",
      "чон" => "琼",
      "чонь" => "琼",
      "тчон" => "琼",
      "тчонь" => "琼",
      "чу" => "丘",
      "тчу" => "丘",
      "дчу" => "丘",
      "чуй" => "崔",
      "тчуй" => "崔",
      "дчуй" => "崔",
      "чун" => "春",
      "чунь" => "春",
      "тчун" => "春",
      "тчунь" => "春",
      "дчун" => "春",
      "чян" => "强",
      "тчян" => "强",
      "дчян" => "强",
      "ш" => "什",
      "ша" => "沙",
      "шай" => "沙伊",
      "шан" => "尚",
      "шань" => "尚",
      "шау" => "绍",
      "шао" => "绍",
      "ше" => "舍",
      "шен" => "申",
      "шень" => "申",
      "ши" => "希",
      "ший" => "希",
      "шь" => "希",
      "шьи" => "希",
      "шин" => "申",
      "шинь" => "申",
      "шо" => "绍",
      "шон" => "雄",
      "шонь" => "雄",
      "шу" => "舒",
      "шуй" => "舒伊",
      "шун" => "顺",
      "шунь" => "顺",
      "шьё" => "绍",
      "шью" => "舒",
      "щ" => "希",
      "сч" => "希",
      "ща" => "夏",
      "сча" => "夏",
      "щай" => "夏伊",
      "счай" => "夏伊",
      "щан" => "先",
      "щань" => "先",
      "счан" => "先",
      "щау" => "肖",
      "щао" => "肖",
      "ще" => "谢",
      "сче" => "谢",
      "щен" => "先",
      "щень" => "先",
      "счень" => "先",
      "щи" => "希",
      "щий" => "希",
      "счи" => "希",
      "счий" => "希",
      "щин" => "辛",
      "щинь" => "辛",
      "счин" => "辛",
      "счинь" => "辛",
      "що" => "晓",
      "щон" => "雄",
      "щонь" => "雄",
      "щу" => "休",
      "счу" => "休",
      "щуй" => "休伊",
      "счуй" => "休伊",
      "щун" => "逊",
      "щунь" => "逊",
      "счун" => "逊",
      "счунь" => "逊",
      "ы" => "厄",
      "ый" => "厄",
      "э" => "埃",
      "эй" => "埃",
      "эн" => "恩",
      "энь" => "恩",
      "ын" => "恩",
      "ынь" => "恩",
      "ю" => "尤",
      "ью" => "尤",
      "юн" => "云",
      "юнь" => "云",
      "я" => "亚",
      "ян" => "扬",
      "янь" => "扬",
    }
    @female = {
      '巴' => '芭',
      '瓦' => '娃',
      '代' => '黛',
      '真' => '珍',
      '利' => '莉',
      '林' => '琳',
      '雷' => '蕾',
      '马' => '玛',
      '纳' => '娜',
      '南' => '楠',
      '尼' => '妮',
      '里' => '丽',
      '罗' => '萝',
      '休' => '秀',
      '沙' => '莎',
      '亚' => '娅'
    }
    @initial = {
      '夫' => '弗',
      '耶' => '叶',
      '尔' => '勒',
    }
    @special = {
      '东' => '栋',
      '江' => '姜',
      '西' => '锡',
    }
  end
  
  def hanzify(name, female=false)
    keys = @common.keys.sort.reverse
    regex = /(#{keys.join('|')})/
    name = name.tr('АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ','абвгдеёжзийклмнопрстуфхцчшщъыьэюя')
    raise UnsupportedCharactersException if /[^абвгдеёжзийклмнопрстуфхцчшщъыьэюя ]/ =~ name
    scanner = StringScanner.new(name)
    chinese = ''
    until scanner.eos?
      chinese << @common[scanner.scan(regex)] 
    end
    if @initial.has_key? chinese[0]
      chinese = chinese.sub(chinese[0], @initial[chinese[0]])
    end
    if female
      chinese = chinese.tr(@female.keys.join(''), @female.values.join(''))
    end
    chinese
  end
end

class UnsupportedCharactersException < Exception
end