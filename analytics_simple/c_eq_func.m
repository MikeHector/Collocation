function c_eq = c_eq_func(in1,in2)
%C_EQ_FUNC
%    C_EQ = C_EQ_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.1.
%    21-Oct-2018 13:03:45

apex_height = in2(:,12);
apex_velocity = in2(:,13);
c = in2(:,2);
g = in2(:,10);
k = in2(:,3);
m = in2(:,1);
transmission_ankle = in2(:,9);
x1 = in1(1,:);
x2 = in1(2,:);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
x7 = in1(7,:);
x8 = in1(8,:);
x9 = in1(9,:);
x10 = in1(10,:);
x11 = in1(11,:);
x12 = in1(12,:);
x13 = in1(13,:);
x14 = in1(14,:);
x15 = in1(15,:);
x16 = in1(16,:);
x17 = in1(17,:);
x18 = in1(18,:);
x19 = in1(19,:);
x20 = in1(20,:);
x21 = in1(21,:);
x22 = in1(22,:);
x23 = in1(23,:);
x24 = in1(24,:);
x25 = in1(25,:);
x26 = in1(26,:);
x27 = in1(27,:);
x28 = in1(28,:);
x29 = in1(29,:);
x30 = in1(30,:);
x31 = in1(31,:);
x32 = in1(32,:);
x33 = in1(33,:);
x34 = in1(34,:);
x35 = in1(35,:);
x36 = in1(36,:);
x37 = in1(37,:);
x38 = in1(38,:);
x39 = in1(39,:);
x40 = in1(40,:);
x41 = in1(41,:);
x42 = in1(42,:);
x43 = in1(43,:);
x44 = in1(44,:);
x45 = in1(45,:);
x46 = in1(46,:);
x47 = in1(47,:);
x48 = in1(48,:);
x49 = in1(49,:);
x50 = in1(50,:);
x51 = in1(51,:);
x52 = in1(52,:);
x53 = in1(53,:);
x54 = in1(54,:);
x55 = in1(55,:);
x56 = in1(56,:);
x57 = in1(57,:);
x58 = in1(58,:);
x59 = in1(59,:);
x60 = in1(60,:);
x61 = in1(61,:);
x62 = in1(62,:);
x63 = in1(63,:);
x64 = in1(64,:);
x65 = in1(65,:);
x66 = in1(66,:);
x67 = in1(67,:);
x68 = in1(68,:);
x69 = in1(69,:);
x70 = in1(70,:);
x71 = in1(71,:);
x72 = in1(72,:);
x73 = in1(73,:);
x74 = in1(74,:);
x75 = in1(75,:);
x76 = in1(76,:);
x77 = in1(77,:);
x78 = in1(78,:);
x79 = in1(79,:);
x80 = in1(80,:);
x81 = in1(81,:);
x82 = in1(82,:);
x83 = in1(83,:);
x84 = in1(84,:);
x85 = in1(85,:);
x86 = in1(86,:);
x87 = in1(87,:);
x88 = in1(88,:);
x89 = in1(89,:);
x90 = in1(90,:);
x91 = in1(91,:);
x92 = in1(92,:);
x93 = in1(93,:);
x94 = in1(94,:);
x95 = in1(95,:);
x96 = in1(96,:);
x97 = in1(97,:);
x98 = in1(98,:);
x99 = in1(99,:);
x100 = in1(100,:);
x101 = in1(101,:);
x102 = in1(102,:);
x103 = in1(103,:);
x104 = in1(104,:);
x105 = in1(105,:);
x106 = in1(106,:);
x107 = in1(107,:);
x108 = in1(108,:);
x109 = in1(109,:);
x110 = in1(110,:);
x111 = in1(111,:);
x112 = in1(112,:);
x113 = in1(113,:);
x114 = in1(114,:);
x115 = in1(115,:);
x116 = in1(116,:);
x117 = in1(117,:);
x118 = in1(118,:);
x119 = in1(119,:);
x120 = in1(120,:);
x121 = in1(121,:);
x122 = in1(122,:);
x123 = in1(123,:);
x124 = in1(124,:);
x125 = in1(125,:);
x126 = in1(126,:);
x127 = in1(127,:);
x128 = in1(128,:);
x129 = in1(129,:);
x130 = in1(130,:);
x131 = in1(131,:);
x132 = in1(132,:);
x133 = in1(133,:);
x134 = in1(134,:);
x135 = in1(135,:);
x136 = in1(136,:);
x137 = in1(137,:);
x138 = in1(138,:);
x139 = in1(139,:);
x140 = in1(140,:);
x141 = in1(141,:);
x142 = in1(142,:);
x143 = in1(143,:);
x144 = in1(144,:);
x145 = in1(145,:);
x146 = in1(146,:);
x147 = in1(147,:);
x148 = in1(148,:);
x149 = in1(149,:);
x150 = in1(150,:);
x151 = in1(151,:);
x152 = in1(152,:);
x153 = in1(153,:);
x154 = in1(154,:);
x155 = in1(155,:);
x156 = in1(156,:);
x157 = in1(157,:);
x158 = in1(158,:);
x159 = in1(159,:);
x160 = in1(160,:);
x161 = in1(161,:);
x162 = in1(162,:);
x163 = in1(163,:);
x164 = in1(164,:);
x165 = in1(165,:);
x166 = in1(166,:);
x167 = in1(167,:);
x168 = in1(168,:);
x169 = in1(169,:);
x170 = in1(170,:);
x171 = in1(171,:);
x172 = in1(172,:);
x173 = in1(173,:);
x174 = in1(174,:);
x175 = in1(175,:);
x176 = in1(176,:);
x177 = in1(177,:);
x178 = in1(178,:);
x179 = in1(179,:);
x180 = in1(180,:);
x181 = in1(181,:);
x182 = in1(182,:);
x183 = in1(183,:);
x184 = in1(184,:);
x185 = in1(185,:);
x186 = in1(186,:);
x187 = in1(187,:);
x188 = in1(188,:);
x189 = in1(189,:);
x190 = in1(190,:);
x191 = in1(191,:);
x192 = in1(192,:);
x193 = in1(193,:);
x194 = in1(194,:);
x195 = in1(195,:);
x196 = in1(196,:);
x197 = in1(197,:);
x198 = in1(198,:);
x199 = in1(199,:);
x200 = in1(200,:);
x201 = in1(201,:);
x202 = in1(202,:);
x203 = in1(203,:);
x204 = in1(204,:);
x205 = in1(205,:);
x206 = in1(206,:);
x207 = in1(207,:);
x208 = in1(208,:);
x209 = in1(209,:);
x210 = in1(210,:);
x211 = in1(211,:);
x212 = in1(212,:);
x213 = in1(213,:);
x214 = in1(214,:);
x215 = in1(215,:);
x216 = in1(216,:);
x217 = in1(217,:);
x218 = in1(218,:);
x219 = in1(219,:);
x220 = in1(220,:);
x221 = in1(221,:);
x222 = in1(222,:);
x223 = in1(223,:);
x224 = in1(224,:);
x225 = in1(225,:);
x226 = in1(226,:);
x227 = in1(227,:);
x228 = in1(228,:);
x229 = in1(229,:);
x230 = in1(230,:);
x231 = in1(231,:);
x232 = in1(232,:);
x233 = in1(233,:);
x234 = in1(234,:);
x235 = in1(235,:);
x236 = in1(236,:);
x237 = in1(237,:);
x238 = in1(238,:);
x239 = in1(239,:);
x240 = in1(240,:);
x241 = in1(241,:);
c_eq = [x1-x2+x241.*(x91+x92).*(1.0./6.0e1);x31-x32+x241.*(x121+x122).*(1.0./6.0e1);x61-x62+x241.*(x151+x152).*(1.0./6.0e1);x91-x92+x241.*((x1.*1.0./sqrt(x1.^2+x31.^2).*(c.*(x151-1.0./sqrt(x1.^2+x31.^2).*(x1.*x91+x31.*x121))+k.*(x61-sqrt(x1.^2+x31.^2))))./m+(x2.*1.0./sqrt(x2.^2+x32.^2).*(c.*(x152-1.0./sqrt(x2.^2+x32.^2).*(x2.*x92+x32.*x122))+k.*(x62-sqrt(x2.^2+x32.^2))))./m-(transmission_ankle.*x31.*x211)./(m.*(x1.^2+x31.^2))-(transmission_ankle.*x32.*x212)./(m.*(x2.^2+x32.^2))).*(1.0./6.0e1);x121-x122+x241.*(g.*-2.0+(x31.*1.0./sqrt(x1.^2+x31.^2).*(c.*(x151-1.0./sqrt(x1.^2+x31.^2).*(x1.*x91+x31.*x121))+k.*(x61-sqrt(x1.^2+x31.^2))))./m+(x32.*1.0./sqrt(x2.^2+x32.^2).*(c.*(x152-1.0./sqrt(x2.^2+x32.^2).*(x2.*x92+x32.*x122))+k.*(x62-sqrt(x2.^2+x32.^2))))./m+(transmission_ankle.*x1.*x211)./(m.*(x1.^2+x31.^2))+(transmission_ankle.*x2.*x212)./(m.*(x2.^2+x32.^2))).*(1.0./6.0e1);x151-x152+x241.*(x181+x182).*(1.0./6.0e1);x2-x3+x241.*(x92+x93).*(1.0./6.0e1);x32-x33+x241.*(x122+x123).*(1.0./6.0e1);x62-x63+x241.*(x152+x153).*(1.0./6.0e1);x92-x93+x241.*((x2.*1.0./sqrt(x2.^2+x32.^2).*(c.*(x152-1.0./sqrt(x2.^2+x32.^2).*(x2.*x92+x32.*x122))+k.*(x62-sqrt(x2.^2+x32.^2))))./m+(x3.*1.0./sqrt(x3.^2+x33.^2).*(c.*(x153-1.0./sqrt(x3.^2+x33.^2).*(x3.*x93+x33.*x123))+k.*(x63-sqrt(x3.^2+x33.^2))))./m-(transmission_ankle.*x32.*x212)./(m.*(x2.^2+x32.^2))-(transmission_ankle.*x33.*x213)./(m.*(x3.^2+x33.^2))).*(1.0./6.0e1);x122-x123+x241.*(g.*-2.0+(x32.*1.0./sqrt(x2.^2+x32.^2).*(c.*(x152-1.0./sqrt(x2.^2+x32.^2).*(x2.*x92+x32.*x122))+k.*(x62-sqrt(x2.^2+x32.^2))))./m+(x33.*1.0./sqrt(x3.^2+x33.^2).*(c.*(x153-1.0./sqrt(x3.^2+x33.^2).*(x3.*x93+x33.*x123))+k.*(x63-sqrt(x3.^2+x33.^2))))./m+(transmission_ankle.*x2.*x212)./(m.*(x2.^2+x32.^2))+(transmission_ankle.*x3.*x213)./(m.*(x3.^2+x33.^2))).*(1.0./6.0e1);x152-x153+x241.*(x182+x183).*(1.0./6.0e1);x3-x4+x241.*(x93+x94).*(1.0./6.0e1);x33-x34+x241.*(x123+x124).*(1.0./6.0e1);x63-x64+x241.*(x153+x154).*(1.0./6.0e1);x93-x94+x241.*((x3.*1.0./sqrt(x3.^2+x33.^2).*(c.*(x153-1.0./sqrt(x3.^2+x33.^2).*(x3.*x93+x33.*x123))+k.*(x63-sqrt(x3.^2+x33.^2))))./m+(x4.*1.0./sqrt(x4.^2+x34.^2).*(c.*(x154-1.0./sqrt(x4.^2+x34.^2).*(x4.*x94+x34.*x124))+k.*(x64-sqrt(x4.^2+x34.^2))))./m-(transmission_ankle.*x33.*x213)./(m.*(x3.^2+x33.^2))-(transmission_ankle.*x34.*x214)./(m.*(x4.^2+x34.^2))).*(1.0./6.0e1);x123-x124+x241.*(g.*-2.0+(x33.*1.0./sqrt(x3.^2+x33.^2).*(c.*(x153-1.0./sqrt(x3.^2+x33.^2).*(x3.*x93+x33.*x123))+k.*(x63-sqrt(x3.^2+x33.^2))))./m+(x34.*1.0./sqrt(x4.^2+x34.^2).*(c.*(x154-1.0./sqrt(x4.^2+x34.^2).*(x4.*x94+x34.*x124))+k.*(x64-sqrt(x4.^2+x34.^2))))./m+(transmission_ankle.*x3.*x213)./(m.*(x3.^2+x33.^2))+(transmission_ankle.*x4.*x214)./(m.*(x4.^2+x34.^2))).*(1.0./6.0e1);x153-x154+x241.*(x183+x184).*(1.0./6.0e1);x4-x5+x241.*(x94+x95).*(1.0./6.0e1);x34-x35+x241.*(x124+x125).*(1.0./6.0e1);x64-x65+x241.*(x154+x155).*(1.0./6.0e1);x94-x95+x241.*((x4.*1.0./sqrt(x4.^2+x34.^2).*(c.*(x154-1.0./sqrt(x4.^2+x34.^2).*(x4.*x94+x34.*x124))+k.*(x64-sqrt(x4.^2+x34.^2))))./m+(x5.*1.0./sqrt(x5.^2+x35.^2).*(c.*(x155-1.0./sqrt(x5.^2+x35.^2).*(x5.*x95+x35.*x125))+k.*(x65-sqrt(x5.^2+x35.^2))))./m-(transmission_ankle.*x34.*x214)./(m.*(x4.^2+x34.^2))-(transmission_ankle.*x35.*x215)./(m.*(x5.^2+x35.^2))).*(1.0./6.0e1);x124-x125+x241.*(g.*-2.0+(x34.*1.0./sqrt(x4.^2+x34.^2).*(c.*(x154-1.0./sqrt(x4.^2+x34.^2).*(x4.*x94+x34.*x124))+k.*(x64-sqrt(x4.^2+x34.^2))))./m+(x35.*1.0./sqrt(x5.^2+x35.^2).*(c.*(x155-1.0./sqrt(x5.^2+x35.^2).*(x5.*x95+x35.*x125))+k.*(x65-sqrt(x5.^2+x35.^2))))./m+(transmission_ankle.*x4.*x214)./(m.*(x4.^2+x34.^2))+(transmission_ankle.*x5.*x215)./(m.*(x5.^2+x35.^2))).*(1.0./6.0e1);x154-x155+x241.*(x184+x185).*(1.0./6.0e1);x5-x6+x241.*(x95+x96).*(1.0./6.0e1);x35-x36+x241.*(x125+x126).*(1.0./6.0e1);x65-x66+x241.*(x155+x156).*(1.0./6.0e1);x95-x96+x241.*((x5.*1.0./sqrt(x5.^2+x35.^2).*(c.*(x155-1.0./sqrt(x5.^2+x35.^2).*(x5.*x95+x35.*x125))+k.*(x65-sqrt(x5.^2+x35.^2))))./m+(x6.*1.0./sqrt(x6.^2+x36.^2).*(c.*(x156-1.0./sqrt(x6.^2+x36.^2).*(x6.*x96+x36.*x126))+k.*(x66-sqrt(x6.^2+x36.^2))))./m-(transmission_ankle.*x35.*x215)./(m.*(x5.^2+x35.^2))-(transmission_ankle.*x36.*x216)./(m.*(x6.^2+x36.^2))).*(1.0./6.0e1);x125-x126+x241.*(g.*-2.0+(x35.*1.0./sqrt(x5.^2+x35.^2).*(c.*(x155-1.0./sqrt(x5.^2+x35.^2).*(x5.*x95+x35.*x125))+k.*(x65-sqrt(x5.^2+x35.^2))))./m+(x36.*1.0./sqrt(x6.^2+x36.^2).*(c.*(x156-1.0./sqrt(x6.^2+x36.^2).*(x6.*x96+x36.*x126))+k.*(x66-sqrt(x6.^2+x36.^2))))./m+(transmission_ankle.*x5.*x215)./(m.*(x5.^2+x35.^2))+(transmission_ankle.*x6.*x216)./(m.*(x6.^2+x36.^2))).*(1.0./6.0e1);x155-x156+x241.*(x185+x186).*(1.0./6.0e1);x6-x7+x241.*(x96+x97).*(1.0./6.0e1);x36-x37+x241.*(x126+x127).*(1.0./6.0e1);x66-x67+x241.*(x156+x157).*(1.0./6.0e1);x96-x97+x241.*((x6.*1.0./sqrt(x6.^2+x36.^2).*(c.*(x156-1.0./sqrt(x6.^2+x36.^2).*(x6.*x96+x36.*x126))+k.*(x66-sqrt(x6.^2+x36.^2))))./m+(x7.*1.0./sqrt(x7.^2+x37.^2).*(c.*(x157-1.0./sqrt(x7.^2+x37.^2).*(x7.*x97+x37.*x127))+k.*(x67-sqrt(x7.^2+x37.^2))))./m-(transmission_ankle.*x36.*x216)./(m.*(x6.^2+x36.^2))-(transmission_ankle.*x37.*x217)./(m.*(x7.^2+x37.^2))).*(1.0./6.0e1);x126-x127+x241.*(g.*-2.0+(x36.*1.0./sqrt(x6.^2+x36.^2).*(c.*(x156-1.0./sqrt(x6.^2+x36.^2).*(x6.*x96+x36.*x126))+k.*(x66-sqrt(x6.^2+x36.^2))))./m+(x37.*1.0./sqrt(x7.^2+x37.^2).*(c.*(x157-1.0./sqrt(x7.^2+x37.^2).*(x7.*x97+x37.*x127))+k.*(x67-sqrt(x7.^2+x37.^2))))./m+(transmission_ankle.*x6.*x216)./(m.*(x6.^2+x36.^2))+(transmission_ankle.*x7.*x217)./(m.*(x7.^2+x37.^2))).*(1.0./6.0e1);x156-x157+x241.*(x186+x187).*(1.0./6.0e1);x7-x8+x241.*(x97+x98).*(1.0./6.0e1);x37-x38+x241.*(x127+x128).*(1.0./6.0e1);x67-x68+x241.*(x157+x158).*(1.0./6.0e1);x97-x98+x241.*((x7.*1.0./sqrt(x7.^2+x37.^2).*(c.*(x157-1.0./sqrt(x7.^2+x37.^2).*(x7.*x97+x37.*x127))+k.*(x67-sqrt(x7.^2+x37.^2))))./m+(x8.*1.0./sqrt(x8.^2+x38.^2).*(c.*(x158-1.0./sqrt(x8.^2+x38.^2).*(x8.*x98+x38.*x128))+k.*(x68-sqrt(x8.^2+x38.^2))))./m-(transmission_ankle.*x37.*x217)./(m.*(x7.^2+x37.^2))-(transmission_ankle.*x38.*x218)./(m.*(x8.^2+x38.^2))).*(1.0./6.0e1);x127-x128+x241.*(g.*-2.0+(x37.*1.0./sqrt(x7.^2+x37.^2).*(c.*(x157-1.0./sqrt(x7.^2+x37.^2).*(x7.*x97+x37.*x127))+k.*(x67-sqrt(x7.^2+x37.^2))))./m+(x38.*1.0./sqrt(x8.^2+x38.^2).*(c.*(x158-1.0./sqrt(x8.^2+x38.^2).*(x8.*x98+x38.*x128))+k.*(x68-sqrt(x8.^2+x38.^2))))./m+(transmission_ankle.*x7.*x217)./(m.*(x7.^2+x37.^2))+(transmission_ankle.*x8.*x218)./(m.*(x8.^2+x38.^2))).*(1.0./6.0e1);x157-x158+x241.*(x187+x188).*(1.0./6.0e1);x8-x9+x241.*(x98+x99).*(1.0./6.0e1);x38-x39+x241.*(x128+x129).*(1.0./6.0e1);x68-x69+x241.*(x158+x159).*(1.0./6.0e1);x98-x99+x241.*((x8.*1.0./sqrt(x8.^2+x38.^2).*(c.*(x158-1.0./sqrt(x8.^2+x38.^2).*(x8.*x98+x38.*x128))+k.*(x68-sqrt(x8.^2+x38.^2))))./m+(x9.*1.0./sqrt(x9.^2+x39.^2).*(c.*(x159-1.0./sqrt(x9.^2+x39.^2).*(x9.*x99+x39.*x129))+k.*(x69-sqrt(x9.^2+x39.^2))))./m-(transmission_ankle.*x38.*x218)./(m.*(x8.^2+x38.^2))-(transmission_ankle.*x39.*x219)./(m.*(x9.^2+x39.^2))).*(1.0./6.0e1);x128-x129+x241.*(g.*-2.0+(x38.*1.0./sqrt(x8.^2+x38.^2).*(c.*(x158-1.0./sqrt(x8.^2+x38.^2).*(x8.*x98+x38.*x128))+k.*(x68-sqrt(x8.^2+x38.^2))))./m+(x39.*1.0./sqrt(x9.^2+x39.^2).*(c.*(x159-1.0./sqrt(x9.^2+x39.^2).*(x9.*x99+x39.*x129))+k.*(x69-sqrt(x9.^2+x39.^2))))./m+(transmission_ankle.*x8.*x218)./(m.*(x8.^2+x38.^2))+(transmission_ankle.*x9.*x219)./(m.*(x9.^2+x39.^2))).*(1.0./6.0e1);x158-x159+x241.*(x188+x189).*(1.0./6.0e1);x9-x10+x241.*(x99+x100).*(1.0./6.0e1);x39-x40+x241.*(x129+x130).*(1.0./6.0e1);x69-x70+x241.*(x159+x160).*(1.0./6.0e1);x99-x100+x241.*((x9.*1.0./sqrt(x9.^2+x39.^2).*(c.*(x159-1.0./sqrt(x9.^2+x39.^2).*(x9.*x99+x39.*x129))+k.*(x69-sqrt(x9.^2+x39.^2))))./m+(x10.*1.0./sqrt(x10.^2+x40.^2).*(c.*(x160-1.0./sqrt(x10.^2+x40.^2).*(x10.*x100+x40.*x130))+k.*(x70-sqrt(x10.^2+x40.^2))))./m-(transmission_ankle.*x39.*x219)./(m.*(x9.^2+x39.^2))-(transmission_ankle.*x40.*x220)./(m.*(x10.^2+x40.^2))).*(1.0./6.0e1);x129-x130+x241.*(g.*-2.0+(x39.*1.0./sqrt(x9.^2+x39.^2).*(c.*(x159-1.0./sqrt(x9.^2+x39.^2).*(x9.*x99+x39.*x129))+k.*(x69-sqrt(x9.^2+x39.^2))))./m+(x40.*1.0./sqrt(x10.^2+x40.^2).*(c.*(x160-1.0./sqrt(x10.^2+x40.^2).*(x10.*x100+x40.*x130))+k.*(x70-sqrt(x10.^2+x40.^2))))./m+(transmission_ankle.*x9.*x219)./(m.*(x9.^2+x39.^2))+(transmission_ankle.*x10.*x220)./(m.*(x10.^2+x40.^2))).*(1.0./6.0e1);x159-x160+x241.*(x189+x190).*(1.0./6.0e1);x10-x11+x241.*(x100+x101).*(1.0./6.0e1);x40-x41+x241.*(x130+x131).*(1.0./6.0e1);x70-x71+x241.*(x160+x161).*(1.0./6.0e1);x100-x101+x241.*((x10.*1.0./sqrt(x10.^2+x40.^2).*(c.*(x160-1.0./sqrt(x10.^2+x40.^2).*(x10.*x100+x40.*x130))+k.*(x70-sqrt(x10.^2+x40.^2))))./m+(x11.*1.0./sqrt(x11.^2+x41.^2).*(c.*(x161-1.0./sqrt(x11.^2+x41.^2).*(x11.*x101+x41.*x131))+k.*(x71-sqrt(x11.^2+x41.^2))))./m-(transmission_ankle.*x40.*x220)./(m.*(x10.^2+x40.^2))-(transmission_ankle.*x41.*x221)./(m.*(x11.^2+x41.^2))).*(1.0./6.0e1);x130-x131+x241.*(g.*-2.0+(x40.*1.0./sqrt(x10.^2+x40.^2).*(c.*(x160-1.0./sqrt(x10.^2+x40.^2).*(x10.*x100+x40.*x130))+k.*(x70-sqrt(x10.^2+x40.^2))))./m+(x41.*1.0./sqrt(x11.^2+x41.^2).*(c.*(x161-1.0./sqrt(x11.^2+x41.^2).*(x11.*x101+x41.*x131))+k.*(x71-sqrt(x11.^2+x41.^2))))./m+(transmission_ankle.*x10.*x220)./(m.*(x10.^2+x40.^2))+(transmission_ankle.*x11.*x221)./(m.*(x11.^2+x41.^2))).*(1.0./6.0e1);x160-x161+x241.*(x190+x191).*(1.0./6.0e1);x11-x12+x241.*(x101+x102).*(1.0./6.0e1);x41-x42+x241.*(x131+x132).*(1.0./6.0e1);x71-x72+x241.*(x161+x162).*(1.0./6.0e1);x101-x102+x241.*((x11.*1.0./sqrt(x11.^2+x41.^2).*(c.*(x161-1.0./sqrt(x11.^2+x41.^2).*(x11.*x101+x41.*x131))+k.*(x71-sqrt(x11.^2+x41.^2))))./m+(x12.*1.0./sqrt(x12.^2+x42.^2).*(c.*(x162-1.0./sqrt(x12.^2+x42.^2).*(x12.*x102+x42.*x132))+k.*(x72-sqrt(x12.^2+x42.^2))))./m-(transmission_ankle.*x41.*x221)./(m.*(x11.^2+x41.^2))-(transmission_ankle.*x42.*x222)./(m.*(x12.^2+x42.^2))).*(1.0./6.0e1);x131-x132+x241.*(g.*-2.0+(x41.*1.0./sqrt(x11.^2+x41.^2).*(c.*(x161-1.0./sqrt(x11.^2+x41.^2).*(x11.*x101+x41.*x131))+k.*(x71-sqrt(x11.^2+x41.^2))))./m+(x42.*1.0./sqrt(x12.^2+x42.^2).*(c.*(x162-1.0./sqrt(x12.^2+x42.^2).*(x12.*x102+x42.*x132))+k.*(x72-sqrt(x12.^2+x42.^2))))./m+(transmission_ankle.*x11.*x221)./(m.*(x11.^2+x41.^2))+(transmission_ankle.*x12.*x222)./(m.*(x12.^2+x42.^2))).*(1.0./6.0e1);x161-x162+x241.*(x191+x192).*(1.0./6.0e1);x12-x13+x241.*(x102+x103).*(1.0./6.0e1);x42-x43+x241.*(x132+x133).*(1.0./6.0e1);x72-x73+x241.*(x162+x163).*(1.0./6.0e1);x102-x103+x241.*((x12.*1.0./sqrt(x12.^2+x42.^2).*(c.*(x162-1.0./sqrt(x12.^2+x42.^2).*(x12.*x102+x42.*x132))+k.*(x72-sqrt(x12.^2+x42.^2))))./m+(x13.*1.0./sqrt(x13.^2+x43.^2).*(c.*(x163-1.0./sqrt(x13.^2+x43.^2).*(x13.*x103+x43.*x133))+k.*(x73-sqrt(x13.^2+x43.^2))))./m-(transmission_ankle.*x42.*x222)./(m.*(x12.^2+x42.^2))-(transmission_ankle.*x43.*x223)./(m.*(x13.^2+x43.^2))).*(1.0./6.0e1);x132-x133+x241.*(g.*-2.0+(x42.*1.0./sqrt(x12.^2+x42.^2).*(c.*(x162-1.0./sqrt(x12.^2+x42.^2).*(x12.*x102+x42.*x132))+k.*(x72-sqrt(x12.^2+x42.^2))))./m+(x43.*1.0./sqrt(x13.^2+x43.^2).*(c.*(x163-1.0./sqrt(x13.^2+x43.^2).*(x13.*x103+x43.*x133))+k.*(x73-sqrt(x13.^2+x43.^2))))./m+(transmission_ankle.*x12.*x222)./(m.*(x12.^2+x42.^2))+(transmission_ankle.*x13.*x223)./(m.*(x13.^2+x43.^2))).*(1.0./6.0e1);x162-x163+x241.*(x192+x193).*(1.0./6.0e1);x13-x14+x241.*(x103+x104).*(1.0./6.0e1);x43-x44+x241.*(x133+x134).*(1.0./6.0e1);x73-x74+x241.*(x163+x164).*(1.0./6.0e1);x103-x104+x241.*((x13.*1.0./sqrt(x13.^2+x43.^2).*(c.*(x163-1.0./sqrt(x13.^2+x43.^2).*(x13.*x103+x43.*x133))+k.*(x73-sqrt(x13.^2+x43.^2))))./m+(x14.*1.0./sqrt(x14.^2+x44.^2).*(c.*(x164-1.0./sqrt(x14.^2+x44.^2).*(x14.*x104+x44.*x134))+k.*(x74-sqrt(x14.^2+x44.^2))))./m-(transmission_ankle.*x43.*x223)./(m.*(x13.^2+x43.^2))-(transmission_ankle.*x44.*x224)./(m.*(x14.^2+x44.^2))).*(1.0./6.0e1);x133-x134+x241.*(g.*-2.0+(x43.*1.0./sqrt(x13.^2+x43.^2).*(c.*(x163-1.0./sqrt(x13.^2+x43.^2).*(x13.*x103+x43.*x133))+k.*(x73-sqrt(x13.^2+x43.^2))))./m+(x44.*1.0./sqrt(x14.^2+x44.^2).*(c.*(x164-1.0./sqrt(x14.^2+x44.^2).*(x14.*x104+x44.*x134))+k.*(x74-sqrt(x14.^2+x44.^2))))./m+(transmission_ankle.*x13.*x223)./(m.*(x13.^2+x43.^2))+(transmission_ankle.*x14.*x224)./(m.*(x14.^2+x44.^2))).*(1.0./6.0e1);x163-x164+x241.*(x193+x194).*(1.0./6.0e1);x14-x15+x241.*(x104+x105).*(1.0./6.0e1);x44-x45+x241.*(x134+x135).*(1.0./6.0e1);x74-x75+x241.*(x164+x165).*(1.0./6.0e1);x104-x105+x241.*((x14.*1.0./sqrt(x14.^2+x44.^2).*(c.*(x164-1.0./sqrt(x14.^2+x44.^2).*(x14.*x104+x44.*x134))+k.*(x74-sqrt(x14.^2+x44.^2))))./m+(x15.*1.0./sqrt(x15.^2+x45.^2).*(c.*(x165-1.0./sqrt(x15.^2+x45.^2).*(x15.*x105+x45.*x135))+k.*(x75-sqrt(x15.^2+x45.^2))))./m-(transmission_ankle.*x44.*x224)./(m.*(x14.^2+x44.^2))-(transmission_ankle.*x45.*x225)./(m.*(x15.^2+x45.^2))).*(1.0./6.0e1);x134-x135+x241.*(g.*-2.0+(x44.*1.0./sqrt(x14.^2+x44.^2).*(c.*(x164-1.0./sqrt(x14.^2+x44.^2).*(x14.*x104+x44.*x134))+k.*(x74-sqrt(x14.^2+x44.^2))))./m+(x45.*1.0./sqrt(x15.^2+x45.^2).*(c.*(x165-1.0./sqrt(x15.^2+x45.^2).*(x15.*x105+x45.*x135))+k.*(x75-sqrt(x15.^2+x45.^2))))./m+(transmission_ankle.*x14.*x224)./(m.*(x14.^2+x44.^2))+(transmission_ankle.*x15.*x225)./(m.*(x15.^2+x45.^2))).*(1.0./6.0e1);x164-x165+x241.*(x194+x195).*(1.0./6.0e1);x15-x16+x241.*(x105+x106).*(1.0./6.0e1);x45-x46+x241.*(x135+x136).*(1.0./6.0e1);x75-x76+x241.*(x165+x166).*(1.0./6.0e1);x105-x106+x241.*((x15.*1.0./sqrt(x15.^2+x45.^2).*(c.*(x165-1.0./sqrt(x15.^2+x45.^2).*(x15.*x105+x45.*x135))+k.*(x75-sqrt(x15.^2+x45.^2))))./m+(x16.*1.0./sqrt(x16.^2+x46.^2).*(c.*(x166-1.0./sqrt(x16.^2+x46.^2).*(x16.*x106+x46.*x136))+k.*(x76-sqrt(x16.^2+x46.^2))))./m-(transmission_ankle.*x45.*x225)./(m.*(x15.^2+x45.^2))-(transmission_ankle.*x46.*x226)./(m.*(x16.^2+x46.^2))).*(1.0./6.0e1);x135-x136+x241.*(g.*-2.0+(x45.*1.0./sqrt(x15.^2+x45.^2).*(c.*(x165-1.0./sqrt(x15.^2+x45.^2).*(x15.*x105+x45.*x135))+k.*(x75-sqrt(x15.^2+x45.^2))))./m+(x46.*1.0./sqrt(x16.^2+x46.^2).*(c.*(x166-1.0./sqrt(x16.^2+x46.^2).*(x16.*x106+x46.*x136))+k.*(x76-sqrt(x16.^2+x46.^2))))./m+(transmission_ankle.*x15.*x225)./(m.*(x15.^2+x45.^2))+(transmission_ankle.*x16.*x226)./(m.*(x16.^2+x46.^2))).*(1.0./6.0e1);x165-x166+x241.*(x195+x196).*(1.0./6.0e1);x16-x17+x241.*(x106+x107).*(1.0./6.0e1);x46-x47+x241.*(x136+x137).*(1.0./6.0e1);x76-x77+x241.*(x166+x167).*(1.0./6.0e1);x106-x107+x241.*((x16.*1.0./sqrt(x16.^2+x46.^2).*(c.*(x166-1.0./sqrt(x16.^2+x46.^2).*(x16.*x106+x46.*x136))+k.*(x76-sqrt(x16.^2+x46.^2))))./m+(x17.*1.0./sqrt(x17.^2+x47.^2).*(c.*(x167-1.0./sqrt(x17.^2+x47.^2).*(x17.*x107+x47.*x137))+k.*(x77-sqrt(x17.^2+x47.^2))))./m-(transmission_ankle.*x46.*x226)./(m.*(x16.^2+x46.^2))-(transmission_ankle.*x47.*x227)./(m.*(x17.^2+x47.^2))).*(1.0./6.0e1);x136-x137+x241.*(g.*-2.0+(x46.*1.0./sqrt(x16.^2+x46.^2).*(c.*(x166-1.0./sqrt(x16.^2+x46.^2).*(x16.*x106+x46.*x136))+k.*(x76-sqrt(x16.^2+x46.^2))))./m+(x47.*1.0./sqrt(x17.^2+x47.^2).*(c.*(x167-1.0./sqrt(x17.^2+x47.^2).*(x17.*x107+x47.*x137))+k.*(x77-sqrt(x17.^2+x47.^2))))./m+(transmission_ankle.*x16.*x226)./(m.*(x16.^2+x46.^2))+(transmission_ankle.*x17.*x227)./(m.*(x17.^2+x47.^2))).*(1.0./6.0e1);x166-x167+x241.*(x196+x197).*(1.0./6.0e1);x17-x18+x241.*(x107+x108).*(1.0./6.0e1);x47-x48+x241.*(x137+x138).*(1.0./6.0e1);x77-x78+x241.*(x167+x168).*(1.0./6.0e1);x107-x108+x241.*((x17.*1.0./sqrt(x17.^2+x47.^2).*(c.*(x167-1.0./sqrt(x17.^2+x47.^2).*(x17.*x107+x47.*x137))+k.*(x77-sqrt(x17.^2+x47.^2))))./m+(x18.*1.0./sqrt(x18.^2+x48.^2).*(c.*(x168-1.0./sqrt(x18.^2+x48.^2).*(x18.*x108+x48.*x138))+k.*(x78-sqrt(x18.^2+x48.^2))))./m-(transmission_ankle.*x47.*x227)./(m.*(x17.^2+x47.^2))-(transmission_ankle.*x48.*x228)./(m.*(x18.^2+x48.^2))).*(1.0./6.0e1);x137-x138+x241.*(g.*-2.0+(x47.*1.0./sqrt(x17.^2+x47.^2).*(c.*(x167-1.0./sqrt(x17.^2+x47.^2).*(x17.*x107+x47.*x137))+k.*(x77-sqrt(x17.^2+x47.^2))))./m+(x48.*1.0./sqrt(x18.^2+x48.^2).*(c.*(x168-1.0./sqrt(x18.^2+x48.^2).*(x18.*x108+x48.*x138))+k.*(x78-sqrt(x18.^2+x48.^2))))./m+(transmission_ankle.*x17.*x227)./(m.*(x17.^2+x47.^2))+(transmission_ankle.*x18.*x228)./(m.*(x18.^2+x48.^2))).*(1.0./6.0e1);x167-x168+x241.*(x197+x198).*(1.0./6.0e1);x18-x19+x241.*(x108+x109).*(1.0./6.0e1);x48-x49+x241.*(x138+x139).*(1.0./6.0e1);x78-x79+x241.*(x168+x169).*(1.0./6.0e1);x108-x109+x241.*((x18.*1.0./sqrt(x18.^2+x48.^2).*(c.*(x168-1.0./sqrt(x18.^2+x48.^2).*(x18.*x108+x48.*x138))+k.*(x78-sqrt(x18.^2+x48.^2))))./m+(x19.*1.0./sqrt(x19.^2+x49.^2).*(c.*(x169-1.0./sqrt(x19.^2+x49.^2).*(x19.*x109+x49.*x139))+k.*(x79-sqrt(x19.^2+x49.^2))))./m-(transmission_ankle.*x48.*x228)./(m.*(x18.^2+x48.^2))-(transmission_ankle.*x49.*x229)./(m.*(x19.^2+x49.^2))).*(1.0./6.0e1);x138-x139+x241.*(g.*-2.0+(x48.*1.0./sqrt(x18.^2+x48.^2).*(c.*(x168-1.0./sqrt(x18.^2+x48.^2).*(x18.*x108+x48.*x138))+k.*(x78-sqrt(x18.^2+x48.^2))))./m+(x49.*1.0./sqrt(x19.^2+x49.^2).*(c.*(x169-1.0./sqrt(x19.^2+x49.^2).*(x19.*x109+x49.*x139))+k.*(x79-sqrt(x19.^2+x49.^2))))./m+(transmission_ankle.*x18.*x228)./(m.*(x18.^2+x48.^2))+(transmission_ankle.*x19.*x229)./(m.*(x19.^2+x49.^2))).*(1.0./6.0e1);x168-x169+x241.*(x198+x199).*(1.0./6.0e1);x19-x20+x241.*(x109+x110).*(1.0./6.0e1);x49-x50+x241.*(x139+x140).*(1.0./6.0e1);x79-x80+x241.*(x169+x170).*(1.0./6.0e1);x109-x110+x241.*((x19.*1.0./sqrt(x19.^2+x49.^2).*(c.*(x169-1.0./sqrt(x19.^2+x49.^2).*(x19.*x109+x49.*x139))+k.*(x79-sqrt(x19.^2+x49.^2))))./m+(x20.*1.0./sqrt(x20.^2+x50.^2).*(c.*(x170-1.0./sqrt(x20.^2+x50.^2).*(x20.*x110+x50.*x140))+k.*(x80-sqrt(x20.^2+x50.^2))))./m-(transmission_ankle.*x49.*x229)./(m.*(x19.^2+x49.^2))-(transmission_ankle.*x50.*x230)./(m.*(x20.^2+x50.^2))).*(1.0./6.0e1);x139-x140+x241.*(g.*-2.0+(x49.*1.0./sqrt(x19.^2+x49.^2).*(c.*(x169-1.0./sqrt(x19.^2+x49.^2).*(x19.*x109+x49.*x139))+k.*(x79-sqrt(x19.^2+x49.^2))))./m+(x50.*1.0./sqrt(x20.^2+x50.^2).*(c.*(x170-1.0./sqrt(x20.^2+x50.^2).*(x20.*x110+x50.*x140))+k.*(x80-sqrt(x20.^2+x50.^2))))./m+(transmission_ankle.*x19.*x229)./(m.*(x19.^2+x49.^2))+(transmission_ankle.*x20.*x230)./(m.*(x20.^2+x50.^2))).*(1.0./6.0e1);x169-x170+x241.*(x199+x200).*(1.0./6.0e1);x20-x21+x241.*(x110+x111).*(1.0./6.0e1);x50-x51+x241.*(x140+x141).*(1.0./6.0e1);x80-x81+x241.*(x170+x171).*(1.0./6.0e1);x110-x111+x241.*((x20.*1.0./sqrt(x20.^2+x50.^2).*(c.*(x170-1.0./sqrt(x20.^2+x50.^2).*(x20.*x110+x50.*x140))+k.*(x80-sqrt(x20.^2+x50.^2))))./m+(x21.*1.0./sqrt(x21.^2+x51.^2).*(c.*(x171-1.0./sqrt(x21.^2+x51.^2).*(x21.*x111+x51.*x141))+k.*(x81-sqrt(x21.^2+x51.^2))))./m-(transmission_ankle.*x50.*x230)./(m.*(x20.^2+x50.^2))-(transmission_ankle.*x51.*x231)./(m.*(x21.^2+x51.^2))).*(1.0./6.0e1);x140-x141+x241.*(g.*-2.0+(x50.*1.0./sqrt(x20.^2+x50.^2).*(c.*(x170-1.0./sqrt(x20.^2+x50.^2).*(x20.*x110+x50.*x140))+k.*(x80-sqrt(x20.^2+x50.^2))))./m+(x51.*1.0./sqrt(x21.^2+x51.^2).*(c.*(x171-1.0./sqrt(x21.^2+x51.^2).*(x21.*x111+x51.*x141))+k.*(x81-sqrt(x21.^2+x51.^2))))./m+(transmission_ankle.*x20.*x230)./(m.*(x20.^2+x50.^2))+(transmission_ankle.*x21.*x231)./(m.*(x21.^2+x51.^2))).*(1.0./6.0e1);x170-x171+x241.*(x200+x201).*(1.0./6.0e1);x21-x22+x241.*(x111+x112).*(1.0./6.0e1);x51-x52+x241.*(x141+x142).*(1.0./6.0e1);x81-x82+x241.*(x171+x172).*(1.0./6.0e1);x111-x112+x241.*((x21.*1.0./sqrt(x21.^2+x51.^2).*(c.*(x171-1.0./sqrt(x21.^2+x51.^2).*(x21.*x111+x51.*x141))+k.*(x81-sqrt(x21.^2+x51.^2))))./m+(x22.*1.0./sqrt(x22.^2+x52.^2).*(c.*(x172-1.0./sqrt(x22.^2+x52.^2).*(x22.*x112+x52.*x142))+k.*(x82-sqrt(x22.^2+x52.^2))))./m-(transmission_ankle.*x51.*x231)./(m.*(x21.^2+x51.^2))-(transmission_ankle.*x52.*x232)./(m.*(x22.^2+x52.^2))).*(1.0./6.0e1);x141-x142+x241.*(g.*-2.0+(x51.*1.0./sqrt(x21.^2+x51.^2).*(c.*(x171-1.0./sqrt(x21.^2+x51.^2).*(x21.*x111+x51.*x141))+k.*(x81-sqrt(x21.^2+x51.^2))))./m+(x52.*1.0./sqrt(x22.^2+x52.^2).*(c.*(x172-1.0./sqrt(x22.^2+x52.^2).*(x22.*x112+x52.*x142))+k.*(x82-sqrt(x22.^2+x52.^2))))./m+(transmission_ankle.*x21.*x231)./(m.*(x21.^2+x51.^2))+(transmission_ankle.*x22.*x232)./(m.*(x22.^2+x52.^2))).*(1.0./6.0e1);x171-x172+x241.*(x201+x202).*(1.0./6.0e1);x22-x23+x241.*(x112+x113).*(1.0./6.0e1);x52-x53+x241.*(x142+x143).*(1.0./6.0e1);x82-x83+x241.*(x172+x173).*(1.0./6.0e1);x112-x113+x241.*((x22.*1.0./sqrt(x22.^2+x52.^2).*(c.*(x172-1.0./sqrt(x22.^2+x52.^2).*(x22.*x112+x52.*x142))+k.*(x82-sqrt(x22.^2+x52.^2))))./m+(x23.*1.0./sqrt(x23.^2+x53.^2).*(c.*(x173-1.0./sqrt(x23.^2+x53.^2).*(x23.*x113+x53.*x143))+k.*(x83-sqrt(x23.^2+x53.^2))))./m-(transmission_ankle.*x52.*x232)./(m.*(x22.^2+x52.^2))-(transmission_ankle.*x53.*x233)./(m.*(x23.^2+x53.^2))).*(1.0./6.0e1);x142-x143+x241.*(g.*-2.0+(x52.*1.0./sqrt(x22.^2+x52.^2).*(c.*(x172-1.0./sqrt(x22.^2+x52.^2).*(x22.*x112+x52.*x142))+k.*(x82-sqrt(x22.^2+x52.^2))))./m+(x53.*1.0./sqrt(x23.^2+x53.^2).*(c.*(x173-1.0./sqrt(x23.^2+x53.^2).*(x23.*x113+x53.*x143))+k.*(x83-sqrt(x23.^2+x53.^2))))./m+(transmission_ankle.*x22.*x232)./(m.*(x22.^2+x52.^2))+(transmission_ankle.*x23.*x233)./(m.*(x23.^2+x53.^2))).*(1.0./6.0e1);x172-x173+x241.*(x202+x203).*(1.0./6.0e1);x23-x24+x241.*(x113+x114).*(1.0./6.0e1);x53-x54+x241.*(x143+x144).*(1.0./6.0e1);x83-x84+x241.*(x173+x174).*(1.0./6.0e1);x113-x114+x241.*((x23.*1.0./sqrt(x23.^2+x53.^2).*(c.*(x173-1.0./sqrt(x23.^2+x53.^2).*(x23.*x113+x53.*x143))+k.*(x83-sqrt(x23.^2+x53.^2))))./m+(x24.*1.0./sqrt(x24.^2+x54.^2).*(c.*(x174-1.0./sqrt(x24.^2+x54.^2).*(x24.*x114+x54.*x144))+k.*(x84-sqrt(x24.^2+x54.^2))))./m-(transmission_ankle.*x53.*x233)./(m.*(x23.^2+x53.^2))-(transmission_ankle.*x54.*x234)./(m.*(x24.^2+x54.^2))).*(1.0./6.0e1);x143-x144+x241.*(g.*-2.0+(x53.*1.0./sqrt(x23.^2+x53.^2).*(c.*(x173-1.0./sqrt(x23.^2+x53.^2).*(x23.*x113+x53.*x143))+k.*(x83-sqrt(x23.^2+x53.^2))))./m+(x54.*1.0./sqrt(x24.^2+x54.^2).*(c.*(x174-1.0./sqrt(x24.^2+x54.^2).*(x24.*x114+x54.*x144))+k.*(x84-sqrt(x24.^2+x54.^2))))./m+(transmission_ankle.*x23.*x233)./(m.*(x23.^2+x53.^2))+(transmission_ankle.*x24.*x234)./(m.*(x24.^2+x54.^2))).*(1.0./6.0e1);x173-x174+x241.*(x203+x204).*(1.0./6.0e1);x24-x25+x241.*(x114+x115).*(1.0./6.0e1);x54-x55+x241.*(x144+x145).*(1.0./6.0e1);x84-x85+x241.*(x174+x175).*(1.0./6.0e1);x114-x115+x241.*((x24.*1.0./sqrt(x24.^2+x54.^2).*(c.*(x174-1.0./sqrt(x24.^2+x54.^2).*(x24.*x114+x54.*x144))+k.*(x84-sqrt(x24.^2+x54.^2))))./m+(x25.*1.0./sqrt(x25.^2+x55.^2).*(c.*(x175-1.0./sqrt(x25.^2+x55.^2).*(x25.*x115+x55.*x145))+k.*(x85-sqrt(x25.^2+x55.^2))))./m-(transmission_ankle.*x54.*x234)./(m.*(x24.^2+x54.^2))-(transmission_ankle.*x55.*x235)./(m.*(x25.^2+x55.^2))).*(1.0./6.0e1);x144-x145+x241.*(g.*-2.0+(x54.*1.0./sqrt(x24.^2+x54.^2).*(c.*(x174-1.0./sqrt(x24.^2+x54.^2).*(x24.*x114+x54.*x144))+k.*(x84-sqrt(x24.^2+x54.^2))))./m+(x55.*1.0./sqrt(x25.^2+x55.^2).*(c.*(x175-1.0./sqrt(x25.^2+x55.^2).*(x25.*x115+x55.*x145))+k.*(x85-sqrt(x25.^2+x55.^2))))./m+(transmission_ankle.*x24.*x234)./(m.*(x24.^2+x54.^2))+(transmission_ankle.*x25.*x235)./(m.*(x25.^2+x55.^2))).*(1.0./6.0e1);x174-x175+x241.*(x204+x205).*(1.0./6.0e1);x25-x26+x241.*(x115+x116).*(1.0./6.0e1);x55-x56+x241.*(x145+x146).*(1.0./6.0e1);x85-x86+x241.*(x175+x176).*(1.0./6.0e1);x115-x116+x241.*((x25.*1.0./sqrt(x25.^2+x55.^2).*(c.*(x175-1.0./sqrt(x25.^2+x55.^2).*(x25.*x115+x55.*x145))+k.*(x85-sqrt(x25.^2+x55.^2))))./m+(x26.*1.0./sqrt(x26.^2+x56.^2).*(c.*(x176-1.0./sqrt(x26.^2+x56.^2).*(x26.*x116+x56.*x146))+k.*(x86-sqrt(x26.^2+x56.^2))))./m-(transmission_ankle.*x55.*x235)./(m.*(x25.^2+x55.^2))-(transmission_ankle.*x56.*x236)./(m.*(x26.^2+x56.^2))).*(1.0./6.0e1);x145-x146+x241.*(g.*-2.0+(x55.*1.0./sqrt(x25.^2+x55.^2).*(c.*(x175-1.0./sqrt(x25.^2+x55.^2).*(x25.*x115+x55.*x145))+k.*(x85-sqrt(x25.^2+x55.^2))))./m+(x56.*1.0./sqrt(x26.^2+x56.^2).*(c.*(x176-1.0./sqrt(x26.^2+x56.^2).*(x26.*x116+x56.*x146))+k.*(x86-sqrt(x26.^2+x56.^2))))./m+(transmission_ankle.*x25.*x235)./(m.*(x25.^2+x55.^2))+(transmission_ankle.*x26.*x236)./(m.*(x26.^2+x56.^2))).*(1.0./6.0e1);x175-x176+x241.*(x205+x206).*(1.0./6.0e1);x26-x27+x241.*(x116+x117).*(1.0./6.0e1);x56-x57+x241.*(x146+x147).*(1.0./6.0e1);x86-x87+x241.*(x176+x177).*(1.0./6.0e1);x116-x117+x241.*((x26.*1.0./sqrt(x26.^2+x56.^2).*(c.*(x176-1.0./sqrt(x26.^2+x56.^2).*(x26.*x116+x56.*x146))+k.*(x86-sqrt(x26.^2+x56.^2))))./m+(x27.*1.0./sqrt(x27.^2+x57.^2).*(c.*(x177-1.0./sqrt(x27.^2+x57.^2).*(x27.*x117+x57.*x147))+k.*(x87-sqrt(x27.^2+x57.^2))))./m-(transmission_ankle.*x56.*x236)./(m.*(x26.^2+x56.^2))-(transmission_ankle.*x57.*x237)./(m.*(x27.^2+x57.^2))).*(1.0./6.0e1);x146-x147+x241.*(g.*-2.0+(x56.*1.0./sqrt(x26.^2+x56.^2).*(c.*(x176-1.0./sqrt(x26.^2+x56.^2).*(x26.*x116+x56.*x146))+k.*(x86-sqrt(x26.^2+x56.^2))))./m+(x57.*1.0./sqrt(x27.^2+x57.^2).*(c.*(x177-1.0./sqrt(x27.^2+x57.^2).*(x27.*x117+x57.*x147))+k.*(x87-sqrt(x27.^2+x57.^2))))./m+(transmission_ankle.*x26.*x236)./(m.*(x26.^2+x56.^2))+(transmission_ankle.*x27.*x237)./(m.*(x27.^2+x57.^2))).*(1.0./6.0e1);x176-x177+x241.*(x206+x207).*(1.0./6.0e1);x27-x28+x241.*(x117+x118).*(1.0./6.0e1);x57-x58+x241.*(x147+x148).*(1.0./6.0e1);x87-x88+x241.*(x177+x178).*(1.0./6.0e1);x117-x118+x241.*((x27.*1.0./sqrt(x27.^2+x57.^2).*(c.*(x177-1.0./sqrt(x27.^2+x57.^2).*(x27.*x117+x57.*x147))+k.*(x87-sqrt(x27.^2+x57.^2))))./m+(x28.*1.0./sqrt(x28.^2+x58.^2).*(c.*(x178-1.0./sqrt(x28.^2+x58.^2).*(x28.*x118+x58.*x148))+k.*(x88-sqrt(x28.^2+x58.^2))))./m-(transmission_ankle.*x57.*x237)./(m.*(x27.^2+x57.^2))-(transmission_ankle.*x58.*x238)./(m.*(x28.^2+x58.^2))).*(1.0./6.0e1);x147-x148+x241.*(g.*-2.0+(x57.*1.0./sqrt(x27.^2+x57.^2).*(c.*(x177-1.0./sqrt(x27.^2+x57.^2).*(x27.*x117+x57.*x147))+k.*(x87-sqrt(x27.^2+x57.^2))))./m+(x58.*1.0./sqrt(x28.^2+x58.^2).*(c.*(x178-1.0./sqrt(x28.^2+x58.^2).*(x28.*x118+x58.*x148))+k.*(x88-sqrt(x28.^2+x58.^2))))./m+(transmission_ankle.*x27.*x237)./(m.*(x27.^2+x57.^2))+(transmission_ankle.*x28.*x238)./(m.*(x28.^2+x58.^2))).*(1.0./6.0e1);x177-x178+x241.*(x207+x208).*(1.0./6.0e1);x28-x29+x241.*(x118+x119).*(1.0./6.0e1);x58-x59+x241.*(x148+x149).*(1.0./6.0e1);x88-x89+x241.*(x178+x179).*(1.0./6.0e1);x118-x119+x241.*((x28.*1.0./sqrt(x28.^2+x58.^2).*(c.*(x178-1.0./sqrt(x28.^2+x58.^2).*(x28.*x118+x58.*x148))+k.*(x88-sqrt(x28.^2+x58.^2))))./m+(x29.*1.0./sqrt(x29.^2+x59.^2).*(c.*(x179-1.0./sqrt(x29.^2+x59.^2).*(x29.*x119+x59.*x149))+k.*(x89-sqrt(x29.^2+x59.^2))))./m-(transmission_ankle.*x58.*x238)./(m.*(x28.^2+x58.^2))-(transmission_ankle.*x59.*x239)./(m.*(x29.^2+x59.^2))).*(1.0./6.0e1);x148-x149+x241.*(g.*-2.0+(x58.*1.0./sqrt(x28.^2+x58.^2).*(c.*(x178-1.0./sqrt(x28.^2+x58.^2).*(x28.*x118+x58.*x148))+k.*(x88-sqrt(x28.^2+x58.^2))))./m+(x59.*1.0./sqrt(x29.^2+x59.^2).*(c.*(x179-1.0./sqrt(x29.^2+x59.^2).*(x29.*x119+x59.*x149))+k.*(x89-sqrt(x29.^2+x59.^2))))./m+(transmission_ankle.*x28.*x238)./(m.*(x28.^2+x58.^2))+(transmission_ankle.*x29.*x239)./(m.*(x29.^2+x59.^2))).*(1.0./6.0e1);x178-x179+x241.*(x208+x209).*(1.0./6.0e1);x29-x30+x241.*(x119+x120).*(1.0./6.0e1);x59-x60+x241.*(x149+x150).*(1.0./6.0e1);x89-x90+x241.*(x179+x180).*(1.0./6.0e1);x119-x120+x241.*((x29.*1.0./sqrt(x29.^2+x59.^2).*(c.*(x179-1.0./sqrt(x29.^2+x59.^2).*(x29.*x119+x59.*x149))+k.*(x89-sqrt(x29.^2+x59.^2))))./m+(x30.*1.0./sqrt(x30.^2+x60.^2).*(c.*(x180-1.0./sqrt(x30.^2+x60.^2).*(x30.*x120+x60.*x150))+k.*(x90-sqrt(x30.^2+x60.^2))))./m-(transmission_ankle.*x59.*x239)./(m.*(x29.^2+x59.^2))-(transmission_ankle.*x60.*x240)./(m.*(x30.^2+x60.^2))).*(1.0./6.0e1);x149-x150+x241.*(g.*-2.0+(x59.*1.0./sqrt(x29.^2+x59.^2).*(c.*(x179-1.0./sqrt(x29.^2+x59.^2).*(x29.*x119+x59.*x149))+k.*(x89-sqrt(x29.^2+x59.^2))))./m+(x60.*1.0./sqrt(x30.^2+x60.^2).*(c.*(x180-1.0./sqrt(x30.^2+x60.^2).*(x30.*x120+x60.*x150))+k.*(x90-sqrt(x30.^2+x60.^2))))./m+(transmission_ankle.*x29.*x239)./(m.*(x29.^2+x59.^2))+(transmission_ankle.*x30.*x240)./(m.*(x30.^2+x60.^2))).*(1.0./6.0e1);x179-x180+x241.*(x209+x210).*(1.0./6.0e1);x61-sqrt(x1.^2+x31.^2);apex_velocity.^2.*m.*(-1.0./2.0)+m.*(x91.^2+x121.^2).*(1.0./2.0)-apex_height.*g.*m+g.*m.*x31;apex_velocity.^2.*m.*(-1.0./2.0)+m.*(x120.^2+x150.^2).*(1.0./2.0)-apex_height.*g.*m+g.*m.*x60;-apex_velocity+x91;-apex_velocity+x120;c.*(x180-1.0./sqrt(x30.^2+x60.^2).*(x30.*x120+x60.*x150))+k.*(x90-sqrt(x30.^2+x60.^2))];
