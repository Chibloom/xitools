---@enum Weaponskill
return {
    [  1] = { name = 'Combo', attr = { 'Impaction' } },
    [  2] = { name = 'Shoulder Tackle', attr = { 'Reverberation', 'Impaction' } },
    [  3] = { name = 'One Inch Punch', attr = { 'Compression' } },
    [  4] = { name = 'Backhand Blow', attr = { 'Detonation' } },
    [  5] = { name = 'Raging Fists', attr = { 'Impaction' } },
    [  6] = { name = 'Spinning Attack', attr = { 'Liquefaction', 'Impaction' } },
    [  7] = { name = 'Howling Fists', attr = { 'Transfixion', 'Impaction' } },
    [  8] = { name = 'Dragon Kick', attr = { 'Fragmentation' } },
    [  9] = { name = 'Asuran Fists', attr = { 'Gravitation', 'Liquefaction' } },
    [ 10] = { name = 'Final Heaven', attr = { 'Light', 'Fusion' } },
    [ 11] = { name = 'Ascetic\'s Fury', attr = { 'Fusion', 'Transfixion' } },
    [ 12] = { name = 'Stringing Pummel', attr = { 'Gravitation', 'Liquefaction' } },
    [ 13] = { name = 'Tornado Kick', attr = { 'Induration', 'Impaction', 'Detonation' } },
    [ 14] = { name = 'Victory Smite', attr = { 'Light', 'Fragmentation' } },
    [ 15] = { name = 'Shijin Spiral', attr = { 'Fusion', 'Reverberation' } },
    [ 16] = { name = 'Wasp Sting', attr = { 'Scission' } },
    [ 17] = { name = 'Viper Bite', attr = { 'Scission' } },
    [ 18] = { name = 'Shadowstitch', attr = { 'Reverberation' } },
    [ 19] = { name = 'Gust Slash', attr = { 'Detonation' } },
    [ 20] = { name = 'Cyclone', attr = { 'Detonation', 'Impaction' } },
    [ 21] = { name = 'Energy Steal', attr = {} },
    [ 22] = { name = 'Energy Drain', attr = {} },
    [ 23] = { name = 'Dancing Edge', attr = { 'Scission', 'Detonation' } },
    [ 24] = { name = 'Shark Bite', attr = { 'Fragmentation' } },
    [ 25] = { name = 'Evisceration', attr = { 'Gravitation', 'Transfixion' } },
    [ 26] = { name = 'Mercy Stroke', attr = { 'Darkness', 'Gravitation' } },
    [ 27] = { name = 'Mandalic Stab', attr = { 'Fusion', 'Compression' } },
    [ 28] = { name = 'Mordant Rime', attr = { 'Fragmentation', 'Distortion' } },
    [ 29] = { name = 'Pyrrhic Kleos', attr = { 'Distortion', 'Scission' } },
    [ 30] = { name = 'Aeolian Edge', attr = { 'Impaction', 'Scission', 'Detonation' } },
    [ 31] = { name = 'Rudra\'s Storm', attr = { 'Darkness', 'Distortion' } },
    [ 32] = { name = 'Fast Blade', attr = { 'Scission' } },
    [ 33] = { name = 'Burning Blade', attr = { 'Liquefaction' } },
    [ 34] = { name = 'Red Lotus Blade', attr = { 'Liquefaction', 'Detonation' } },
    [ 35] = { name = 'Flat Blade', attr = { 'Impaction' } },
    [ 36] = { name = 'Shining Blade', attr = { 'Scission' } },
    [ 37] = { name = 'Seraph Blade', attr = { 'Scission', 'Transfixion' } },  -- gained transfixion
    [ 38] = { name = 'Circle Blade', attr = { 'Reverberation', 'Impaction' } },
    [ 39] = { name = 'Spirits Within', attr = {} },
    [ 40] = { name = 'Vorpal Blade', attr = { 'Scission', 'Impaction' } },
    [ 41] = { name = 'Swift Blade', attr = { 'Gravitation' } },
    [ 42] = { name = 'Savage Blade', attr = { 'Fragmentation', 'Scission' } },
    [ 43] = { name = 'Knights of Round', attr = { 'Light', 'Fusion' } },
    [ 44] = { name = 'Death Blossom', attr = { 'Fragmentation', 'Distortion' } },
    [ 45] = { name = 'Atonement', attr = { 'Fusion', 'Reverberation' } },
    [ 46] = { name = 'Expiacion', attr = { 'Distortion', 'Scission' } },
    [ 47] = { name = 'Sanguine Blade', attr = {} },
    [ 48] = { name = 'Hard Slash', attr = { 'Scission' } },
    [ 49] = { name = 'Power Slash', attr = { 'Transfixion' } },
    [ 50] = { name = 'Frostbite', attr = { 'Induration' } },
    [ 51] = { name = 'Freezebite', attr = { 'Induration', 'Detonation' } },
    [ 52] = { name = 'Shockwave', attr = { 'Reverberation' } },
    [ 53] = { name = 'Crescent Moon', attr = { 'Scission' } },
    [ 54] = { name = 'Sickle Moon', attr = { 'Scission', 'Impaction' } },
    [ 55] = { name = 'Spinning Slash', attr = { 'Fragmentation' } },
    [ 56] = { name = 'Ground Strike', attr = { 'Fragmentation', 'Distortion' } },
    [ 57] = { name = 'Scourge', attr = { 'Light', 'Fusion' } },
    [ 58] = { name = 'Herculean Slash', attr = { 'Induration', 'Impaction', 'Detonation' } },
    [ 59] = { name = 'Torcleaver', attr = { 'Light', 'Distortion' } },
    [ 60] = { name = 'Resolution', attr = { 'Fragmentation', 'Scission' } },
    [ 64] = { name = 'Raging Axe', attr = { 'Detonation' } }, -- lost impaction
    [ 65] = { name = 'Smash Axe', attr = { 'Induration', 'Reverberation' } },
    [ 66] = { name = 'Gale Axe', attr = { 'Detonation' } },
    [ 67] = { name = 'Avalanche Axe', attr = { 'Induration' } }, -- lost both for induration
    [ 68] = { name = 'Spinning Axe', attr = { 'Liquefaction', 'Scission' } }, -- lost impaction
    [ 69] = { name = 'Rampage', attr = { 'Scission' } },
    [ 70] = { name = 'Calamity', attr = { 'Scission', 'Impaction' } },
    [ 71] = { name = 'Mistral Axe', attr = { 'Fusion' } },
    [ 72] = { name = 'Decimation', attr = { 'Fusion', 'Detonation' } },  -- reverbation to detonation
    [ 73] = { name = 'Onslaught', attr = { 'Darkness', 'Gravitation' } },
    [ 74] = { name = 'Primal Rend', attr = { 'Gravitation', 'Reverberation' } },
    [ 75] = { name = 'Bora Axe', attr = { 'Scission', 'Detonation' } },
    [ 76] = { name = 'Cloudsplitter', attr = { 'Darkness', 'Fragmentation' } },
    [ 77] = { name = 'Ruinator', attr = { 'Distortion', 'Detonation' } },
    [ 80] = { name = 'Shield Break', attr = { 'Impaction' } },
    [ 81] = { name = 'Iron Tempest', attr = { 'Scission' } },
    [ 82] = { name = 'Sturmwind', attr = { 'Reverberation', 'Scission' } },
    [ 83] = { name = 'Armor Break', attr = { 'Impaction' } },
    [ 84] = { name = 'Keen Edge', attr = { 'Compression' } },
    [ 85] = { name = 'Weapon Break', attr = { 'Impaction' } },
    [ 86] = { name = 'Raging Rush', attr = { 'Induration', 'Reverberation' } },
    [ 87] = { name = 'Full Break', attr = { 'Distortion' } },
    [ 88] = { name = 'Steel Cyclone', attr = { 'Distortion', 'Detonation' } },
    [ 89] = { name = 'Metatron Torment', attr = { 'Light', 'Fusion' } },
    [ 90] = { name = 'King\'s Justice', attr = { 'Fragmentation', 'Scission' } },
    [ 91] = { name = 'Fell Cleave', attr = { 'Impaction', 'Detonation', 'Scission' } },
    [ 92] = { name = 'Ukko\'s Fury', attr = { 'Light', 'Fragmentation' } },
    [ 93] = { name = 'Upheaval', attr = { 'Fusion', 'Compression' } },
    [ 96] = { name = 'Slice', attr = { 'Scission' } },
    [ 97] = { name = 'Dark Harvest', attr = { 'Compression' } }, -- reverberation to compresison
    [ 98] = { name = 'Shadow of Death', attr = { 'Induration', 'Reverberation' } },
    [ 99] = { name = 'Nightmare Scythe', attr = { 'Compression', 'Scission' } },
    [100] = { name = 'Spinning Scythe', attr = { 'Reverberation', 'Scission' } },
    [101] = { name = 'Vorpal Scythe', attr = { 'Transfixion', 'Scission' } },
    [102] = { name = 'Guillotine', attr = { 'Induration' } },
    [103] = { name = 'Cross Reaper', attr = { 'Distortion' } },
    [104] = { name = 'Spiral Hell', attr = { 'Gravitation', 'Scission' } }, --may have been changed distortion to gravitaiton, dunno not on wiki
    [105] = { name = 'Catastrophe', attr = { 'Darkness', 'Gravitation' } },
    [106] = { name = 'Insurgency', attr = { 'Fusion', 'Compression' } },
    [107] = { name = 'Infernal Scythe', attr = { 'Compression', 'Reverberation' } },
    [108] = { name = 'Quietus', attr = { 'Darkness', 'Distortion' } },
    [109] = { name = 'Entropy', attr = { 'Gravitation', 'Reverberation' } },
    [112] = { name = 'Double Thrust', attr = { 'Transfixion' } },
    [113] = { name = 'Thunder Thrust', attr = { 'Transfixion', 'Impaction' } },
    [114] = { name = 'Raiden Thrust', attr = { 'Transfixion', 'Impaction' } },
    [115] = { name = 'Leg Sweep', attr = { 'Impaction' } },
    [116] = { name = 'Penta-Thrust', attr = { 'Compression' } },
    [117] = { name = 'Vorpal Thrust', attr = { 'Reverberation', 'Transfixion' } },
    [118] = { name = 'Skewer', attr = { 'Impaction' } }, -- lost Transfixion
    [119] = { name = 'Wheeling Thrust', attr = { 'Fusion' } },
    [120] = { name = 'Impulse Drive', attr = { 'Gravitation', 'Induration' } },
    [121] = { name = 'Geirskogul', attr = { 'Light', 'Distortion' } },
    [122] = { name = 'Drakesbane', attr = { 'Fusion', 'Transfixion' } },
    [123] = { name = 'Sonic Thrust', attr = { 'Transfixion', 'Scission' } },
    [124] = { name = 'Camlann\'s Torment', attr = { 'Light', 'Fragmentation' } },
    [125] = { name = 'Stardiver', attr = { 'Gravitation', 'Transfixion' } },
    [128] = { name = 'Blade: Rin', attr = { 'Transfixion' } },
    [129] = { name = 'Blade: Retsu', attr = { 'Scission' } },
    [130] = { name = 'Blade: Teki', attr = { 'Reverberation' } },
    [131] = { name = 'Blade: To', attr = { 'Induration', 'Detonation' } },
    [132] = { name = 'Blade: Chi', attr = { 'Transfixion', 'Impaction' } },
    [133] = { name = 'Blade: Ei', attr = { 'Compression' } },
    [134] = { name = 'Blade: Jin', attr = { 'Detonation', 'Impaction' } },
    [135] = { name = 'Blade: Ten', attr = { 'Gravitation' } },
    [136] = { name = 'Blade: Ku', attr = { 'Gravitation', 'Transfixion' } },
    [137] = { name = 'Blade: Metsu', attr = { 'Darkness', 'Fragmentation' } },
    [138] = { name = 'Blade: Kamu', attr = { 'Fragmentation', 'Compression' } },
    [139] = { name = 'Blade: Yu', attr = { 'Reverberation', 'Scission' } },
    [140] = { name = 'Blade: Hi', attr = { 'Darkness', 'Gravitation' } },
    [141] = { name = 'Blade: Shun', attr = { 'Fusion', 'Impaction' } },
    [144] = { name = 'Tachi: Enpi', attr = { 'Transfixion', 'Scission' } },
    [145] = { name = 'Tachi: Hobaku', attr = { 'Induration' } },
    [146] = { name = 'Tachi: Goten', attr = { 'Transfixion', 'Impaction' } },
    [147] = { name = 'Tachi: Kagero', attr = { 'Liquefaction' } },
    [148] = { name = 'Tachi: Jinpu', attr = { 'Scission', 'Detonation' } },
    [149] = { name = 'Tachi: Koki', attr = { 'Reverberation', 'Impaction' } },
    [150] = { name = 'Tachi: Yukikaze', attr = { 'Induration', 'Detonation' } },
    [151] = { name = 'Tachi: Gekko', attr = { 'Distortion', 'Reverberation' } },
    [152] = { name = 'Tachi: Kasha', attr = { 'Fusion', 'Compression' } },
    [153] = { name = 'Tachi: Kaiten', attr = { 'Light', 'Fragmentation' } },
    [154] = { name = 'Tachi: Rana', attr = { 'Gravitation', 'Induration' } },
    [155] = { name = 'Tachi: Ageha', attr = { 'Compression', 'Scission' } },
    [156] = { name = 'Tachi: Fudo', attr = { 'Light', 'Distortion' } },
    [157] = { name = 'Tachi: Shoha', attr = { 'Fragmentation', 'Compression' } },
    [160] = { name = 'Shining Strike', attr = { 'Transfixion' } },  -- impaction to transfixion
    [161] = { name = 'Seraph Strike', attr = { 'Scission' } }, -- impaction to scission
    [162] = { name = 'Brainshaker', attr = { 'Reverberation' } },
    [163] = { name = 'Starlight', attr = {} },
    [164] = { name = 'Moonlight', attr = {} },
    [165] = { name = 'Skullbreaker', attr = { 'Induration', 'Reverberation' } },
    [166] = { name = 'True Strike', attr = { 'Detonation', 'Impaction' } },
    [167] = { name = 'Judgement', attr = { 'Impaction' } },
    [168] = { name = 'Hexa Strike', attr = { 'Fusion' } },
    [169] = { name = 'Black Halo', attr = { 'Fragmentation', 'Compression' } },
    [170] = { name = 'Randgrith', attr = { 'Light', 'Fragmentation' } },
    [171] = { name = 'Mystic Boon', attr = {} },
    [172] = { name = 'Flash Nova', attr = { 'Induration', 'Reverberation' } },
    [173] = { name = 'Dagan', attr = {} },
    [174] = { name = 'Realmrazer', attr = { 'Fusion', 'Impaction' } },
    [176] = { name = 'Heavy Swing', attr = { 'Impaction' } },
    [177] = { name = 'Rock Crusher', attr = { 'Impaction' } },
    [178] = { name = 'Earth Crusher', attr = { 'Detonation', 'Impaction' } },
    [179] = { name = 'Starburst', attr = { 'Compression', 'Transfixion' } }, -- reverberation to transfixion
    [180] = { name = 'Sunburst', attr = { 'Transfixion', 'Reverberation' } }, -- compresison to transfixion
    [181] = { name = 'Shell Crusher', attr = { 'Detonation' } },
    [182] = { name = 'Full Swing', attr = { 'Liquefaction', 'Impaction' } },
    [183] = { name = 'Spirit Taker', attr = {} },
    [184] = { name = 'Retribution', attr = { 'Gravitation', 'Reverberation' } },
    [185] = { name = 'Gate of Tartarus', attr = { 'Darkness', 'Distortion' } },
    [186] = { name = 'Vidohunir', attr = { 'Fragmentation', 'Distortion' } },
    [187] = { name = 'Garland of Bliss', attr = { 'Fusion', 'Reverberation' } },
    [188] = { name = 'Omniscience', attr = { 'Gravitation', 'Transfixion' } },
    [189] = { name = 'Cataclysm', attr = { 'Compression', 'Reverberation' } },
    [190] = { name = 'Myrkr', attr = {} },
    [191] = { name = 'Shattersoul', attr = { 'Gravitation', 'Induration' } },
    [192] = { name = 'Flaming Arrow', attr = { 'Liquefaction', 'Transfixion' } },
    [193] = { name = 'Piercing Arrow', attr = { 'Induration', 'Transfixion' } }, -- Reveberation to induration
    [194] = { name = 'Dulling Arrow', attr = { 'Liquefaction', 'Transfixion' } },
    [196] = { name = 'Sidewinder', attr = { 'Reverberation', 'Transfixion', 'Detonation' } },
    [197] = { name = 'Blast Arrow', attr = { 'Induration', 'Transfixion' } },
    [198] = { name = 'Arching Arrow', attr = { 'Fusion' } },
    [199] = { name = 'Empyreal Arrow', attr = { 'Fusion', 'Transfixion' } },
    [200] = { name = 'Namas Arrow', attr = { 'Light', 'Distortion' } },
    [201] = { name = 'Refulgent Arrow', attr = { 'Reverberation', 'Transfixion' } },
    [202] = { name = 'Jishnu\'s Radiance', attr = { 'Light', 'Fusion' } },
    [203] = { name = 'Apex Arrow', attr = { 'Fragmentation', 'Transfixion' } },
    [208] = { name = 'Hot Shot', attr = { 'Liquefaction', 'Transfixion' } },
    [209] = { name = 'Split Shot', attr = { 'Reverberation', 'Transfixion' } },
    [210] = { name = 'Sniper Shot', attr = { 'Liquefaction', 'Transfixion' } },
    [212] = { name = 'Slug Shot', attr = { 'Reverberation', 'Transfixion', 'Detonation' } },
    [213] = { name = 'Blast Shot', attr = { 'Induration', 'Transfixion' } },
    [214] = { name = 'Heavy Shot', attr = { 'Fusion' } },
    [215] = { name = 'Detonator', attr = { 'Fusion', 'Transfixion' } },
    [216] = { name = 'Coronach', attr = { 'Darkness', 'Fragmentation' } },
    [217] = { name = 'Trueflight', attr = { 'Fragmentation', 'Scission' } },
    [218] = { name = 'Leaden Salute', attr = { 'Gravitation', 'Transfixion' } },
    [219] = { name = 'Numbing Shot', attr = { 'Impaction', 'Detonation' } },
    [220] = { name = 'Wildfire', attr = { 'Darkness', 'Gravitation' } },
    [221] = { name = 'Last Stand', attr = { 'Fusion', 'Reverberation' } },
    [224] = { name = 'Exenterator', attr = { 'Fragmentation', 'Scission' } },
    [225] = { name = 'Chant du Cygne', attr = { 'Light', 'Distortion' } },
    [226] = { name = 'Requiescat', attr = { 'Gravitation', 'Scission' } },
    [238] = { name = 'Uriel Blade', attr = { 'Light', 'Fragmentation' } },
    [239] = { name = 'Glory Slash', attr = { 'Light', 'Fusion' } },
    [240] = { name = 'Tartarus Torpor', attr = {} },
}
