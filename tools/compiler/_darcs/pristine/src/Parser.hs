module Parser where

import qualified Scmlex as Lex
import Exptype

-- parser produced by Happy Version 1.15

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34
	= HappyTerminal Lex.Token
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34

action_0 (35) = happyShift action_14
action_0 (51) = happyShift action_15
action_0 (53) = happyShift action_16
action_0 (54) = happyShift action_17
action_0 (55) = happyShift action_18
action_0 (56) = happyShift action_19
action_0 (57) = happyShift action_20
action_0 (4) = happyGoto action_2
action_0 (5) = happyGoto action_3
action_0 (6) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (9) = happyGoto action_6
action_0 (13) = happyGoto action_7
action_0 (16) = happyGoto action_8
action_0 (20) = happyGoto action_9
action_0 (22) = happyGoto action_10
action_0 (24) = happyGoto action_11
action_0 (25) = happyGoto action_12
action_0 (26) = happyGoto action_13
action_0 _ = happyReduce_1

action_1 _ = happyFail

action_2 (58) = happyAccept
action_2 _ = happyFail

action_3 (35) = happyShift action_14
action_3 (51) = happyShift action_15
action_3 (53) = happyShift action_16
action_3 (54) = happyShift action_17
action_3 (55) = happyShift action_18
action_3 (56) = happyShift action_19
action_3 (57) = happyShift action_20
action_3 (4) = happyGoto action_41
action_3 (5) = happyGoto action_3
action_3 (6) = happyGoto action_4
action_3 (8) = happyGoto action_5
action_3 (9) = happyGoto action_6
action_3 (13) = happyGoto action_7
action_3 (16) = happyGoto action_8
action_3 (20) = happyGoto action_9
action_3 (22) = happyGoto action_10
action_3 (24) = happyGoto action_11
action_3 (25) = happyGoto action_12
action_3 (26) = happyGoto action_13
action_3 _ = happyReduce_1

action_4 _ = happyReduce_3

action_5 _ = happyReduce_6

action_6 _ = happyReduce_14

action_7 _ = happyReduce_7

action_8 _ = happyReduce_8

action_9 _ = happyReduce_5

action_10 _ = happyReduce_4

action_11 _ = happyReduce_9

action_12 _ = happyReduce_10

action_13 _ = happyReduce_11

action_14 (35) = happyShift action_30
action_14 (40) = happyShift action_31
action_14 (41) = happyShift action_32
action_14 (42) = happyShift action_33
action_14 (43) = happyShift action_34
action_14 (44) = happyShift action_35
action_14 (45) = happyShift action_36
action_14 (46) = happyShift action_37
action_14 (47) = happyShift action_38
action_14 (48) = happyShift action_39
action_14 (51) = happyShift action_15
action_14 (52) = happyShift action_40
action_14 (53) = happyShift action_16
action_14 (54) = happyShift action_17
action_14 (55) = happyShift action_18
action_14 (56) = happyShift action_19
action_14 (57) = happyShift action_20
action_14 (6) = happyGoto action_28
action_14 (8) = happyGoto action_5
action_14 (9) = happyGoto action_6
action_14 (13) = happyGoto action_7
action_14 (14) = happyGoto action_29
action_14 (16) = happyGoto action_8
action_14 (20) = happyGoto action_9
action_14 (24) = happyGoto action_11
action_14 (25) = happyGoto action_12
action_14 (26) = happyGoto action_13
action_14 _ = happyFail

action_15 (35) = happyShift action_22
action_15 (53) = happyShift action_23
action_15 (54) = happyShift action_24
action_15 (55) = happyShift action_25
action_15 (56) = happyShift action_26
action_15 (57) = happyShift action_27
action_15 (10) = happyGoto action_21
action_15 _ = happyFail

action_16 _ = happyReduce_44

action_17 _ = happyReduce_18

action_18 _ = happyReduce_15

action_19 _ = happyReduce_17

action_20 _ = happyReduce_16

action_21 _ = happyReduce_19

action_22 (35) = happyShift action_22
action_22 (53) = happyShift action_23
action_22 (54) = happyShift action_24
action_22 (55) = happyShift action_25
action_22 (56) = happyShift action_26
action_22 (57) = happyShift action_27
action_22 (10) = happyGoto action_60
action_22 (11) = happyGoto action_61
action_22 _ = happyReduce_28

action_23 _ = happyReduce_25

action_24 _ = happyReduce_24

action_25 _ = happyReduce_21

action_26 _ = happyReduce_23

action_27 _ = happyReduce_22

action_28 _ = happyReduce_33

action_29 (15) = happyGoto action_59
action_29 _ = happyReduce_34

action_30 (35) = happyShift action_30
action_30 (41) = happyShift action_32
action_30 (42) = happyShift action_33
action_30 (43) = happyShift action_34
action_30 (44) = happyShift action_35
action_30 (45) = happyShift action_36
action_30 (46) = happyShift action_37
action_30 (47) = happyShift action_38
action_30 (48) = happyShift action_39
action_30 (51) = happyShift action_15
action_30 (52) = happyShift action_40
action_30 (53) = happyShift action_16
action_30 (54) = happyShift action_17
action_30 (55) = happyShift action_18
action_30 (56) = happyShift action_19
action_30 (57) = happyShift action_20
action_30 (6) = happyGoto action_28
action_30 (8) = happyGoto action_5
action_30 (9) = happyGoto action_6
action_30 (13) = happyGoto action_7
action_30 (14) = happyGoto action_29
action_30 (16) = happyGoto action_8
action_30 (20) = happyGoto action_9
action_30 (24) = happyGoto action_11
action_30 (25) = happyGoto action_12
action_30 (26) = happyGoto action_13
action_30 _ = happyFail

action_31 (35) = happyShift action_58
action_31 (53) = happyShift action_16
action_31 (20) = happyGoto action_57
action_31 _ = happyFail

action_32 (35) = happyShift action_56
action_32 (53) = happyShift action_16
action_32 (17) = happyGoto action_54
action_32 (20) = happyGoto action_55
action_32 _ = happyFail

action_33 (35) = happyShift action_30
action_33 (51) = happyShift action_15
action_33 (53) = happyShift action_16
action_33 (54) = happyShift action_17
action_33 (55) = happyShift action_18
action_33 (56) = happyShift action_19
action_33 (57) = happyShift action_20
action_33 (6) = happyGoto action_53
action_33 (8) = happyGoto action_5
action_33 (9) = happyGoto action_6
action_33 (13) = happyGoto action_7
action_33 (16) = happyGoto action_8
action_33 (20) = happyGoto action_9
action_33 (24) = happyGoto action_11
action_33 (25) = happyGoto action_12
action_33 (26) = happyGoto action_13
action_33 _ = happyFail

action_34 (53) = happyShift action_16
action_34 (20) = happyGoto action_52
action_34 _ = happyFail

action_35 (35) = happyShift action_51
action_35 (27) = happyGoto action_48
action_35 (28) = happyGoto action_49
action_35 (30) = happyGoto action_50
action_35 _ = happyFail

action_36 (35) = happyShift action_30
action_36 (51) = happyShift action_15
action_36 (53) = happyShift action_16
action_36 (54) = happyShift action_17
action_36 (55) = happyShift action_18
action_36 (56) = happyShift action_19
action_36 (57) = happyShift action_20
action_36 (6) = happyGoto action_47
action_36 (8) = happyGoto action_5
action_36 (9) = happyGoto action_6
action_36 (13) = happyGoto action_7
action_36 (16) = happyGoto action_8
action_36 (20) = happyGoto action_9
action_36 (24) = happyGoto action_11
action_36 (25) = happyGoto action_12
action_36 (26) = happyGoto action_13
action_36 _ = happyFail

action_37 (35) = happyShift action_30
action_37 (51) = happyShift action_15
action_37 (53) = happyShift action_16
action_37 (54) = happyShift action_17
action_37 (55) = happyShift action_18
action_37 (56) = happyShift action_19
action_37 (57) = happyShift action_20
action_37 (6) = happyGoto action_44
action_37 (7) = happyGoto action_46
action_37 (8) = happyGoto action_5
action_37 (9) = happyGoto action_6
action_37 (13) = happyGoto action_7
action_37 (16) = happyGoto action_8
action_37 (20) = happyGoto action_9
action_37 (24) = happyGoto action_11
action_37 (25) = happyGoto action_12
action_37 (26) = happyGoto action_13
action_37 _ = happyReduce_12

action_38 (35) = happyShift action_30
action_38 (51) = happyShift action_15
action_38 (53) = happyShift action_16
action_38 (54) = happyShift action_17
action_38 (55) = happyShift action_18
action_38 (56) = happyShift action_19
action_38 (57) = happyShift action_20
action_38 (6) = happyGoto action_44
action_38 (7) = happyGoto action_45
action_38 (8) = happyGoto action_5
action_38 (9) = happyGoto action_6
action_38 (13) = happyGoto action_7
action_38 (16) = happyGoto action_8
action_38 (20) = happyGoto action_9
action_38 (24) = happyGoto action_11
action_38 (25) = happyGoto action_12
action_38 (26) = happyGoto action_13
action_38 _ = happyReduce_12

action_39 (35) = happyShift action_43
action_39 _ = happyFail

action_40 (35) = happyShift action_22
action_40 (53) = happyShift action_23
action_40 (54) = happyShift action_24
action_40 (55) = happyShift action_25
action_40 (56) = happyShift action_26
action_40 (57) = happyShift action_27
action_40 (10) = happyGoto action_42
action_40 _ = happyFail

action_41 _ = happyReduce_2

action_42 (36) = happyShift action_91
action_42 _ = happyFail

action_43 (35) = happyShift action_90
action_43 (33) = happyGoto action_88
action_43 (34) = happyGoto action_89
action_43 _ = happyReduce_70

action_44 (35) = happyShift action_30
action_44 (51) = happyShift action_15
action_44 (53) = happyShift action_16
action_44 (54) = happyShift action_17
action_44 (55) = happyShift action_18
action_44 (56) = happyShift action_19
action_44 (57) = happyShift action_20
action_44 (6) = happyGoto action_44
action_44 (7) = happyGoto action_87
action_44 (8) = happyGoto action_5
action_44 (9) = happyGoto action_6
action_44 (13) = happyGoto action_7
action_44 (16) = happyGoto action_8
action_44 (20) = happyGoto action_9
action_44 (24) = happyGoto action_11
action_44 (25) = happyGoto action_12
action_44 (26) = happyGoto action_13
action_44 _ = happyReduce_12

action_45 (36) = happyShift action_86
action_45 _ = happyFail

action_46 (36) = happyShift action_85
action_46 _ = happyFail

action_47 (35) = happyShift action_84
action_47 (28) = happyGoto action_81
action_47 (31) = happyGoto action_82
action_47 (32) = happyGoto action_83
action_47 _ = happyReduce_67

action_48 (35) = happyShift action_51
action_48 (27) = happyGoto action_79
action_48 (28) = happyGoto action_49
action_48 (29) = happyGoto action_80
action_48 _ = happyReduce_62

action_49 _ = happyReduce_60

action_50 (36) = happyShift action_78
action_50 _ = happyFail

action_51 (35) = happyShift action_30
action_51 (38) = happyShift action_77
action_51 (51) = happyShift action_15
action_51 (53) = happyShift action_16
action_51 (54) = happyShift action_17
action_51 (55) = happyShift action_18
action_51 (56) = happyShift action_19
action_51 (57) = happyShift action_20
action_51 (6) = happyGoto action_76
action_51 (8) = happyGoto action_5
action_51 (9) = happyGoto action_6
action_51 (13) = happyGoto action_7
action_51 (16) = happyGoto action_8
action_51 (20) = happyGoto action_9
action_51 (24) = happyGoto action_11
action_51 (25) = happyGoto action_12
action_51 (26) = happyGoto action_13
action_51 _ = happyFail

action_52 (35) = happyShift action_30
action_52 (51) = happyShift action_15
action_52 (53) = happyShift action_16
action_52 (54) = happyShift action_17
action_52 (55) = happyShift action_18
action_52 (56) = happyShift action_19
action_52 (57) = happyShift action_20
action_52 (6) = happyGoto action_75
action_52 (8) = happyGoto action_5
action_52 (9) = happyGoto action_6
action_52 (13) = happyGoto action_7
action_52 (16) = happyGoto action_8
action_52 (20) = happyGoto action_9
action_52 (24) = happyGoto action_11
action_52 (25) = happyGoto action_12
action_52 (26) = happyGoto action_13
action_52 _ = happyFail

action_53 (35) = happyShift action_30
action_53 (51) = happyShift action_15
action_53 (53) = happyShift action_16
action_53 (54) = happyShift action_17
action_53 (55) = happyShift action_18
action_53 (56) = happyShift action_19
action_53 (57) = happyShift action_20
action_53 (6) = happyGoto action_74
action_53 (8) = happyGoto action_5
action_53 (9) = happyGoto action_6
action_53 (13) = happyGoto action_7
action_53 (16) = happyGoto action_8
action_53 (20) = happyGoto action_9
action_53 (24) = happyGoto action_11
action_53 (25) = happyGoto action_12
action_53 (26) = happyGoto action_13
action_53 _ = happyFail

action_54 (35) = happyShift action_14
action_54 (51) = happyShift action_15
action_54 (53) = happyShift action_16
action_54 (54) = happyShift action_17
action_54 (55) = happyShift action_18
action_54 (56) = happyShift action_19
action_54 (57) = happyShift action_20
action_54 (4) = happyGoto action_72
action_54 (5) = happyGoto action_3
action_54 (6) = happyGoto action_4
action_54 (8) = happyGoto action_5
action_54 (9) = happyGoto action_6
action_54 (13) = happyGoto action_7
action_54 (16) = happyGoto action_8
action_54 (20) = happyGoto action_9
action_54 (21) = happyGoto action_73
action_54 (22) = happyGoto action_10
action_54 (24) = happyGoto action_11
action_54 (25) = happyGoto action_12
action_54 (26) = happyGoto action_13
action_54 _ = happyReduce_1

action_55 _ = happyReduce_37

action_56 (53) = happyShift action_16
action_56 (18) = happyGoto action_69
action_56 (19) = happyGoto action_70
action_56 (20) = happyGoto action_71
action_56 _ = happyReduce_40

action_57 (35) = happyShift action_30
action_57 (51) = happyShift action_15
action_57 (53) = happyShift action_16
action_57 (54) = happyShift action_17
action_57 (55) = happyShift action_18
action_57 (56) = happyShift action_19
action_57 (57) = happyShift action_20
action_57 (6) = happyGoto action_68
action_57 (8) = happyGoto action_5
action_57 (9) = happyGoto action_6
action_57 (13) = happyGoto action_7
action_57 (16) = happyGoto action_8
action_57 (20) = happyGoto action_9
action_57 (24) = happyGoto action_11
action_57 (25) = happyGoto action_12
action_57 (26) = happyGoto action_13
action_57 _ = happyFail

action_58 (53) = happyShift action_16
action_58 (20) = happyGoto action_67
action_58 _ = happyFail

action_59 (35) = happyShift action_30
action_59 (36) = happyShift action_66
action_59 (51) = happyShift action_15
action_59 (53) = happyShift action_16
action_59 (54) = happyShift action_17
action_59 (55) = happyShift action_18
action_59 (56) = happyShift action_19
action_59 (57) = happyShift action_20
action_59 (6) = happyGoto action_65
action_59 (8) = happyGoto action_5
action_59 (9) = happyGoto action_6
action_59 (13) = happyGoto action_7
action_59 (16) = happyGoto action_8
action_59 (20) = happyGoto action_9
action_59 (24) = happyGoto action_11
action_59 (25) = happyGoto action_12
action_59 (26) = happyGoto action_13
action_59 _ = happyFail

action_60 (35) = happyShift action_22
action_60 (53) = happyShift action_23
action_60 (54) = happyShift action_24
action_60 (55) = happyShift action_25
action_60 (56) = happyShift action_26
action_60 (57) = happyShift action_27
action_60 (10) = happyGoto action_60
action_60 (11) = happyGoto action_64
action_60 _ = happyReduce_28

action_61 (36) = happyShift action_62
action_61 (37) = happyShift action_63
action_61 _ = happyFail

action_62 _ = happyReduce_26

action_63 (35) = happyShift action_22
action_63 (53) = happyShift action_23
action_63 (54) = happyShift action_24
action_63 (55) = happyShift action_25
action_63 (56) = happyShift action_26
action_63 (57) = happyShift action_27
action_63 (10) = happyGoto action_113
action_63 _ = happyFail

action_64 _ = happyReduce_29

action_65 _ = happyReduce_35

action_66 _ = happyReduce_32

action_67 (53) = happyShift action_16
action_67 (18) = happyGoto action_111
action_67 (19) = happyGoto action_112
action_67 (20) = happyGoto action_71
action_67 _ = happyReduce_40

action_68 (36) = happyShift action_110
action_68 _ = happyFail

action_69 (36) = happyShift action_109
action_69 _ = happyFail

action_70 (37) = happyShift action_108
action_70 _ = happyFail

action_71 (37) = happyReduce_42
action_71 (53) = happyShift action_16
action_71 (18) = happyGoto action_106
action_71 (19) = happyGoto action_107
action_71 (20) = happyGoto action_71
action_71 _ = happyReduce_40

action_72 _ = happyReduce_45

action_73 (36) = happyShift action_105
action_73 _ = happyFail

action_74 (35) = happyShift action_30
action_74 (51) = happyShift action_15
action_74 (53) = happyShift action_16
action_74 (54) = happyShift action_17
action_74 (55) = happyShift action_18
action_74 (56) = happyShift action_19
action_74 (57) = happyShift action_20
action_74 (6) = happyGoto action_104
action_74 (8) = happyGoto action_5
action_74 (9) = happyGoto action_6
action_74 (13) = happyGoto action_7
action_74 (16) = happyGoto action_8
action_74 (20) = happyGoto action_9
action_74 (24) = happyGoto action_11
action_74 (25) = happyGoto action_12
action_74 (26) = happyGoto action_13
action_74 _ = happyFail

action_75 (36) = happyShift action_103
action_75 _ = happyFail

action_76 (35) = happyShift action_30
action_76 (36) = happyShift action_101
action_76 (39) = happyShift action_102
action_76 (51) = happyShift action_15
action_76 (53) = happyShift action_16
action_76 (54) = happyShift action_17
action_76 (55) = happyShift action_18
action_76 (56) = happyShift action_19
action_76 (57) = happyShift action_20
action_76 (6) = happyGoto action_100
action_76 (8) = happyGoto action_5
action_76 (9) = happyGoto action_6
action_76 (13) = happyGoto action_7
action_76 (16) = happyGoto action_8
action_76 (20) = happyGoto action_9
action_76 (24) = happyGoto action_11
action_76 (25) = happyGoto action_12
action_76 (26) = happyGoto action_13
action_76 _ = happyFail

action_77 (35) = happyShift action_30
action_77 (51) = happyShift action_15
action_77 (53) = happyShift action_16
action_77 (54) = happyShift action_17
action_77 (55) = happyShift action_18
action_77 (56) = happyShift action_19
action_77 (57) = happyShift action_20
action_77 (6) = happyGoto action_99
action_77 (8) = happyGoto action_5
action_77 (9) = happyGoto action_6
action_77 (13) = happyGoto action_7
action_77 (16) = happyGoto action_8
action_77 (20) = happyGoto action_9
action_77 (24) = happyGoto action_11
action_77 (25) = happyGoto action_12
action_77 (26) = happyGoto action_13
action_77 _ = happyFail

action_78 _ = happyReduce_52

action_79 (35) = happyShift action_51
action_79 (27) = happyGoto action_79
action_79 (28) = happyGoto action_49
action_79 (29) = happyGoto action_98
action_79 _ = happyReduce_62

action_80 _ = happyReduce_64

action_81 _ = happyReduce_66

action_82 (35) = happyShift action_84
action_82 (28) = happyGoto action_81
action_82 (31) = happyGoto action_82
action_82 (32) = happyGoto action_97
action_82 _ = happyReduce_67

action_83 (36) = happyShift action_96
action_83 _ = happyFail

action_84 (35) = happyShift action_95
action_84 (38) = happyShift action_77
action_84 _ = happyFail

action_85 _ = happyReduce_54

action_86 _ = happyReduce_55

action_87 _ = happyReduce_13

action_88 (35) = happyShift action_90
action_88 (33) = happyGoto action_88
action_88 (34) = happyGoto action_94
action_88 _ = happyReduce_70

action_89 (36) = happyShift action_93
action_89 _ = happyFail

action_90 (53) = happyShift action_16
action_90 (20) = happyGoto action_92
action_90 _ = happyFail

action_91 _ = happyReduce_20

action_92 (35) = happyShift action_30
action_92 (51) = happyShift action_15
action_92 (53) = happyShift action_16
action_92 (54) = happyShift action_17
action_92 (55) = happyShift action_18
action_92 (56) = happyShift action_19
action_92 (57) = happyShift action_20
action_92 (6) = happyGoto action_124
action_92 (8) = happyGoto action_5
action_92 (9) = happyGoto action_6
action_92 (13) = happyGoto action_7
action_92 (16) = happyGoto action_8
action_92 (20) = happyGoto action_9
action_92 (24) = happyGoto action_11
action_92 (25) = happyGoto action_12
action_92 (26) = happyGoto action_13
action_92 _ = happyFail

action_93 (35) = happyShift action_14
action_93 (51) = happyShift action_15
action_93 (53) = happyShift action_16
action_93 (54) = happyShift action_17
action_93 (55) = happyShift action_18
action_93 (56) = happyShift action_19
action_93 (57) = happyShift action_20
action_93 (4) = happyGoto action_72
action_93 (5) = happyGoto action_3
action_93 (6) = happyGoto action_4
action_93 (8) = happyGoto action_5
action_93 (9) = happyGoto action_6
action_93 (13) = happyGoto action_7
action_93 (16) = happyGoto action_8
action_93 (20) = happyGoto action_9
action_93 (21) = happyGoto action_123
action_93 (22) = happyGoto action_10
action_93 (24) = happyGoto action_11
action_93 (25) = happyGoto action_12
action_93 (26) = happyGoto action_13
action_93 _ = happyReduce_1

action_94 _ = happyReduce_71

action_95 (35) = happyShift action_22
action_95 (53) = happyShift action_23
action_95 (54) = happyShift action_24
action_95 (55) = happyShift action_25
action_95 (56) = happyShift action_26
action_95 (57) = happyShift action_27
action_95 (10) = happyGoto action_60
action_95 (11) = happyGoto action_122
action_95 _ = happyReduce_28

action_96 _ = happyReduce_53

action_97 _ = happyReduce_68

action_98 _ = happyReduce_63

action_99 (35) = happyShift action_30
action_99 (51) = happyShift action_15
action_99 (53) = happyShift action_16
action_99 (54) = happyShift action_17
action_99 (55) = happyShift action_18
action_99 (56) = happyShift action_19
action_99 (57) = happyShift action_20
action_99 (6) = happyGoto action_44
action_99 (7) = happyGoto action_121
action_99 (8) = happyGoto action_5
action_99 (9) = happyGoto action_6
action_99 (13) = happyGoto action_7
action_99 (16) = happyGoto action_8
action_99 (20) = happyGoto action_9
action_99 (24) = happyGoto action_11
action_99 (25) = happyGoto action_12
action_99 (26) = happyGoto action_13
action_99 _ = happyReduce_12

action_100 (35) = happyShift action_30
action_100 (51) = happyShift action_15
action_100 (53) = happyShift action_16
action_100 (54) = happyShift action_17
action_100 (55) = happyShift action_18
action_100 (56) = happyShift action_19
action_100 (57) = happyShift action_20
action_100 (6) = happyGoto action_44
action_100 (7) = happyGoto action_120
action_100 (8) = happyGoto action_5
action_100 (9) = happyGoto action_6
action_100 (13) = happyGoto action_7
action_100 (16) = happyGoto action_8
action_100 (20) = happyGoto action_9
action_100 (24) = happyGoto action_11
action_100 (25) = happyGoto action_12
action_100 (26) = happyGoto action_13
action_100 _ = happyReduce_12

action_101 _ = happyReduce_58

action_102 (35) = happyShift action_30
action_102 (51) = happyShift action_15
action_102 (53) = happyShift action_16
action_102 (54) = happyShift action_17
action_102 (55) = happyShift action_18
action_102 (56) = happyShift action_19
action_102 (57) = happyShift action_20
action_102 (6) = happyGoto action_119
action_102 (8) = happyGoto action_5
action_102 (9) = happyGoto action_6
action_102 (13) = happyGoto action_7
action_102 (16) = happyGoto action_8
action_102 (20) = happyGoto action_9
action_102 (24) = happyGoto action_11
action_102 (25) = happyGoto action_12
action_102 (26) = happyGoto action_13
action_102 _ = happyFail

action_103 _ = happyReduce_51

action_104 (36) = happyShift action_118
action_104 _ = happyFail

action_105 _ = happyReduce_36

action_106 _ = happyReduce_41

action_107 _ = happyReduce_43

action_108 (53) = happyShift action_16
action_108 (20) = happyGoto action_117
action_108 _ = happyFail

action_109 _ = happyReduce_38

action_110 _ = happyReduce_46

action_111 (36) = happyShift action_116
action_111 _ = happyFail

action_112 (37) = happyShift action_115
action_112 _ = happyFail

action_113 (36) = happyShift action_114
action_113 _ = happyFail

action_114 _ = happyReduce_27

action_115 (53) = happyShift action_16
action_115 (20) = happyGoto action_133
action_115 _ = happyFail

action_116 (35) = happyShift action_14
action_116 (51) = happyShift action_15
action_116 (53) = happyShift action_16
action_116 (54) = happyShift action_17
action_116 (55) = happyShift action_18
action_116 (56) = happyShift action_19
action_116 (57) = happyShift action_20
action_116 (4) = happyGoto action_72
action_116 (5) = happyGoto action_3
action_116 (6) = happyGoto action_4
action_116 (8) = happyGoto action_5
action_116 (9) = happyGoto action_6
action_116 (13) = happyGoto action_7
action_116 (16) = happyGoto action_8
action_116 (20) = happyGoto action_9
action_116 (21) = happyGoto action_132
action_116 (22) = happyGoto action_10
action_116 (24) = happyGoto action_11
action_116 (25) = happyGoto action_12
action_116 (26) = happyGoto action_13
action_116 _ = happyReduce_1

action_117 (36) = happyShift action_131
action_117 _ = happyFail

action_118 _ = happyReduce_50

action_119 (36) = happyShift action_130
action_119 _ = happyFail

action_120 (36) = happyShift action_129
action_120 _ = happyFail

action_121 (36) = happyShift action_128
action_121 _ = happyFail

action_122 (36) = happyShift action_127
action_122 _ = happyFail

action_123 (36) = happyShift action_126
action_123 _ = happyFail

action_124 (36) = happyShift action_125
action_124 _ = happyFail

action_125 _ = happyReduce_69

action_126 _ = happyReduce_56

action_127 (35) = happyShift action_30
action_127 (51) = happyShift action_15
action_127 (53) = happyShift action_16
action_127 (54) = happyShift action_17
action_127 (55) = happyShift action_18
action_127 (56) = happyShift action_19
action_127 (57) = happyShift action_20
action_127 (6) = happyGoto action_136
action_127 (8) = happyGoto action_5
action_127 (9) = happyGoto action_6
action_127 (13) = happyGoto action_7
action_127 (16) = happyGoto action_8
action_127 (20) = happyGoto action_9
action_127 (24) = happyGoto action_11
action_127 (25) = happyGoto action_12
action_127 (26) = happyGoto action_13
action_127 _ = happyFail

action_128 _ = happyReduce_61

action_129 _ = happyReduce_57

action_130 _ = happyReduce_59

action_131 _ = happyReduce_39

action_132 (36) = happyShift action_135
action_132 _ = happyFail

action_133 (36) = happyShift action_134
action_133 _ = happyFail

action_134 (35) = happyShift action_14
action_134 (51) = happyShift action_15
action_134 (53) = happyShift action_16
action_134 (54) = happyShift action_17
action_134 (55) = happyShift action_18
action_134 (56) = happyShift action_19
action_134 (57) = happyShift action_20
action_134 (4) = happyGoto action_72
action_134 (5) = happyGoto action_3
action_134 (6) = happyGoto action_4
action_134 (8) = happyGoto action_5
action_134 (9) = happyGoto action_6
action_134 (13) = happyGoto action_7
action_134 (16) = happyGoto action_8
action_134 (20) = happyGoto action_9
action_134 (21) = happyGoto action_138
action_134 (22) = happyGoto action_10
action_134 (24) = happyGoto action_11
action_134 (25) = happyGoto action_12
action_134 (26) = happyGoto action_13
action_134 _ = happyReduce_1

action_135 _ = happyReduce_47

action_136 (35) = happyShift action_30
action_136 (51) = happyShift action_15
action_136 (53) = happyShift action_16
action_136 (54) = happyShift action_17
action_136 (55) = happyShift action_18
action_136 (56) = happyShift action_19
action_136 (57) = happyShift action_20
action_136 (6) = happyGoto action_44
action_136 (7) = happyGoto action_137
action_136 (8) = happyGoto action_5
action_136 (9) = happyGoto action_6
action_136 (13) = happyGoto action_7
action_136 (16) = happyGoto action_8
action_136 (20) = happyGoto action_9
action_136 (24) = happyGoto action_11
action_136 (25) = happyGoto action_12
action_136 (26) = happyGoto action_13
action_136 _ = happyReduce_12

action_137 (36) = happyShift action_140
action_137 _ = happyFail

action_138 (36) = happyShift action_139
action_138 _ = happyFail

action_139 _ = happyReduce_48

action_140 _ = happyReduce_65

happyReduce_1 = happySpecReduce_0 4 happyReduction_1
happyReduction_1  =  HappyAbsSyn4
		 ([]
	)

happyReduce_2 = happySpecReduce_2 4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_2
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1 5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1 5 happyReduction_4
happyReduction_4 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1 6 happyReduction_5
happyReduction_5 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn6
		 (Variable happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1 6 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1 6 happyReduction_7
happyReduction_7 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1 6 happyReduction_8
happyReduction_8 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1 6 happyReduction_9
happyReduction_9 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1 6 happyReduction_10
happyReduction_10 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1 6 happyReduction_11
happyReduction_11 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_0 7 happyReduction_12
happyReduction_12  =  HappyAbsSyn7
		 ([]
	)

happyReduce_13 = happySpecReduce_2 7 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1 : happy_var_2
	)
happyReduction_13 _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1 8 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1 8 happyReduction_15
happyReduction_15 (HappyTerminal (Lex.Boolean _ happy_var_1))
	 =  HappyAbsSyn8
		 (SelfEval . Boolean $ happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1 8 happyReduction_16
happyReduction_16 (HappyTerminal (Lex.Number _ happy_var_1))
	 =  HappyAbsSyn8
		 (SelfEval . Number $ happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1 8 happyReduction_17
happyReduction_17 (HappyTerminal (Lex.Character _ happy_var_1))
	 =  HappyAbsSyn8
		 (SelfEval . Character $ happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1 8 happyReduction_18
happyReduction_18 (HappyTerminal (Lex.String _ happy_var_1))
	 =  HappyAbsSyn8
		 (SelfEval . String $ happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2 9 happyReduction_19
happyReduction_19 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Quote happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happyReduce 4 9 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Quote happy_var_3
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_1 10 happyReduction_21
happyReduction_21 (HappyTerminal (Lex.Boolean _ happy_var_1))
	 =  HappyAbsSyn10
		 (Boolean happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1 10 happyReduction_22
happyReduction_22 (HappyTerminal (Lex.Number _ happy_var_1))
	 =  HappyAbsSyn10
		 (Number happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1 10 happyReduction_23
happyReduction_23 (HappyTerminal (Lex.Character _ happy_var_1))
	 =  HappyAbsSyn10
		 (Character happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1 10 happyReduction_24
happyReduction_24 (HappyTerminal (Lex.String _ happy_var_1))
	 =  HappyAbsSyn10
		 (String happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1 10 happyReduction_25
happyReduction_25 (HappyTerminal (Lex.Id _ happy_var_1))
	 =  HappyAbsSyn10
		 (Symbol . Sym $ happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3 10 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (List happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 5 10 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (SExp happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_0 11 happyReduction_28
happyReduction_28  =  HappyAbsSyn11
		 ([]
	)

happyReduce_29 = happySpecReduce_2 11 happyReduction_29
happyReduction_29 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1 12 happyReduction_30
happyReduction_30 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_2 12 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1 : happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happyReduce 4 13 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (ProcCall happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_1 14 happyReduction_33
happyReduction_33 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_0 15 happyReduction_34
happyReduction_34  =  HappyAbsSyn15
		 ([]
	)

happyReduce_35 = happySpecReduce_2 15 happyReduction_35
happyReduction_35 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_2 : happy_var_1
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happyReduce 5 16 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_4) `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Lambda happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_1 17 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn17
		 (Args2 [] happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3 17 happyReduction_38
happyReduction_38 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (Args happy_var_2
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happyReduce 5 17 happyReduction_39
happyReduction_39 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (Args2 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_0 18 happyReduction_40
happyReduction_40  =  HappyAbsSyn18
		 ([]
	)

happyReduce_41 = happySpecReduce_2 18 happyReduction_41
happyReduction_41 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1 : happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1 19 happyReduction_42
happyReduction_42 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2 19 happyReduction_43
happyReduction_43 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 : happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1 20 happyReduction_44
happyReduction_44 (HappyTerminal (Lex.Id _ happy_var_1))
	 =  HappyAbsSyn20
		 (Sym happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1 21 happyReduction_45
happyReduction_45 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn21
		 (Body [] happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happyReduce 5 22 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Defvar happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 8 22 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_5) `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Defun happy_var_4 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 10 22 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Defun2 happy_var_4 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_0 23 happyReduction_49
happyReduction_49  =  HappyAbsSyn23
		 ([]
	)

happyReduce_50 = happyReduce 6 24 happyReduction_50
happyReduction_50 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Branch happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_51 = happyReduce 5 25 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (Assign happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happyReduce 4 26 happyReduction_52
happyReduction_52 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Cond happy_var_3
	) `HappyStk` happyRest

happyReduce_53 = happyReduce 5 26 happyReduction_53
happyReduction_53 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Case happy_var_3 happy_var_4 []
	) `HappyStk` happyRest

happyReduce_54 = happyReduce 4 26 happyReduction_54
happyReduction_54 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (And happy_var_3
	) `HappyStk` happyRest

happyReduce_55 = happyReduce 4 26 happyReduction_55
happyReduction_55 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Or happy_var_3
	) `HappyStk` happyRest

happyReduce_56 = happyReduce 7 26 happyReduction_56
happyReduction_56 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn34  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Let happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_57 = happyReduce 5 27 happyReduction_57
happyReduction_57 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 ((happy_var_2, happy_var_3 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_58 = happySpecReduce_3 27 happyReduction_58
happyReduction_58 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn27
		 ((happy_var_2, [] )
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happyReduce 5 27 happyReduction_59
happyReduction_59 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 ((happy_var_2, [happy_var_4])
	) `HappyStk` happyRest

happyReduce_60 = happySpecReduce_1 27 happyReduction_60
happyReduction_60 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 ((SelfEval . Boolean $ True, happy_var_1)
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happyReduce 5 28 happyReduction_61
happyReduction_61 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (happy_var_3 : happy_var_4
	) `HappyStk` happyRest

happyReduce_62 = happySpecReduce_0 29 happyReduction_62
happyReduction_62  =  HappyAbsSyn29
		 ([]
	)

happyReduce_63 = happySpecReduce_2 29 happyReduction_63
happyReduction_63 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1: happy_var_2
	)
happyReduction_63 _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_2 30 happyReduction_64
happyReduction_64 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1 : happy_var_2
	)
happyReduction_64 _ _  = notHappyAtAll 

happyReduce_65 = happyReduce 7 31 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_6) `HappyStk`
	(HappyAbsSyn6  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn31
		 ((happy_var_3, happy_var_5 : happy_var_6)
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_1 31 happyReduction_66
happyReduction_66 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn31
		 (([Void], happy_var_1)
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_0 32 happyReduction_67
happyReduction_67  =  HappyAbsSyn32
		 ([]
	)

happyReduce_68 = happySpecReduce_2 32 happyReduction_68
happyReduction_68 (HappyAbsSyn32  happy_var_2)
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1 : happy_var_2
	)
happyReduction_68 _ _  = notHappyAtAll 

happyReduce_69 = happyReduce 4 33 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 ((happy_var_2, happy_var_3)
	) `HappyStk` happyRest

happyReduce_70 = happySpecReduce_0 34 happyReduction_70
happyReduction_70  =  HappyAbsSyn34
		 ([]
	)

happyReduce_71 = happySpecReduce_2 34 happyReduction_71
happyReduction_71 (HappyAbsSyn34  happy_var_2)
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn34
		 (happy_var_1 : happy_var_2
	)
happyReduction_71 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 58 58 (error "reading EOF!") (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Lex.Leftpar _ -> cont 35;
	Lex.Rightpar _ -> cont 36;
	Lex.Point _ -> cont 37;
	Lex.Else _ -> cont 38;
	Lex.Rightarrow _ -> cont 39;
	Lex.Define _ -> cont 40;
	Lex.Exp_lambda _ -> cont 41;
	Lex.Exp_if _ -> cont 42;
	Lex.Exp_set _ -> cont 43;
	Lex.Exp_cond _ -> cont 44;
	Lex.Exp_case _ -> cont 45;
	Lex.Exp_and _ -> cont 46;
	Lex.Exp_or _ -> cont 47;
	Lex.Let _ -> cont 48;
	Lex.Unquote _ -> cont 49;
	Lex.Unquotesplicing _ -> cont 50;
	Lex.Quote _ -> cont 51;
	Lex.Exp_quote _ -> cont 52;
	Lex.Id _ happy_dollar_dollar -> cont 53;
	Lex.String _ happy_dollar_dollar -> cont 54;
	Lex.Boolean _ happy_dollar_dollar -> cont 55;
	Lex.Character _ happy_dollar_dollar -> cont 56;
	Lex.Number _ happy_dollar_dollar -> cont 57;
	_ -> happyError' (tk:tks)
	}

happyError_ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [Lex.Token] -> HappyIdentity a
happyError' = HappyIdentity . happyError

scmParser tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq

happyError :: [Lex.Token] -> a
happyError (x: xs) =
    error ("Parser error at " ++ (show x))
{-# LINE 1 "GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command line>" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id$

{-# LINE 16 "GenericTemplate.hs" #-}
{-# LINE 28 "GenericTemplate.hs" #-}









































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 239 "GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 303 "GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
