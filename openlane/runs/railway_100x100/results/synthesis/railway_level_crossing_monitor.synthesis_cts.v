module railway_level_crossing_monitor (barrier_down_sensor,
    barrier_up_sensor,
    clk,
    fail_safe,
    light_on_sensor,
    reset,
    sequence_ok,
    train_approach,
    train_depart,
    VPWR,
    VGND,
    error_code);
 input barrier_down_sensor;
 input barrier_up_sensor;
 input clk;
 output fail_safe;
 input light_on_sensor;
 input reset;
 output sequence_ok;
 input train_approach;
 input train_depart;
 input VPWR;
 input VGND;
 output [2:0] error_code;

 sky130_fd_sc_hd__inv_2 _118_ (.A(\state[5] ),
    .Y(_092_));
 sky130_fd_sc_hd__clkbuf_2 _119_ (.A(net6),
    .X(_093_));
 sky130_fd_sc_hd__inv_2 _120_ (.A(\counter[7] ),
    .Y(_024_));
 sky130_fd_sc_hd__inv_2 _121_ (.A(\counter[6] ),
    .Y(_021_));
 sky130_fd_sc_hd__inv_2 _122_ (.A(\counter[5] ),
    .Y(_018_));
 sky130_fd_sc_hd__inv_2 _123_ (.A(\counter[4] ),
    .Y(_015_));
 sky130_fd_sc_hd__or4_4 _124_ (.A(_024_),
    .B(_021_),
    .C(_018_),
    .D(_015_),
    .X(_094_));
 sky130_fd_sc_hd__inv_2 _125_ (.A(\counter[1] ),
    .Y(_006_));
 sky130_fd_sc_hd__inv_2 _126_ (.A(\counter[0] ),
    .Y(_095_));
 sky130_fd_sc_hd__nor2_2 _127_ (.A(_006_),
    .B(_095_),
    .Y(_096_));
 sky130_fd_sc_hd__and3_1 _128_ (.A(\counter[3] ),
    .B(\counter[2] ),
    .C(_096_),
    .X(_097_));
 sky130_fd_sc_hd__inv_2 _129_ (.A(_097_),
    .Y(_098_));
 sky130_fd_sc_hd__or2_2 _130_ (.A(_094_),
    .B(_098_),
    .X(_099_));
 sky130_fd_sc_hd__nor2_1 _131_ (.A(_093_),
    .B(_099_),
    .Y(_100_));
 sky130_fd_sc_hd__inv_2 _132_ (.A(\state[2] ),
    .Y(_101_));
 sky130_fd_sc_hd__clkbuf_2 _133_ (.A(net1),
    .X(_102_));
 sky130_fd_sc_hd__inv_2 _134_ (.A(\counter[2] ),
    .Y(_009_));
 sky130_fd_sc_hd__inv_2 _135_ (.A(\counter[3] ),
    .Y(_012_));
 sky130_fd_sc_hd__a211o_1 _136_ (.A1(_009_),
    .A2(_006_),
    .B1(_012_),
    .C1(_094_),
    .X(_103_));
 sky130_fd_sc_hd__nor2_1 _137_ (.A(_102_),
    .B(_103_),
    .Y(_104_));
 sky130_fd_sc_hd__inv_2 _138_ (.A(\state[0] ),
    .Y(_105_));
 sky130_fd_sc_hd__or2_2 _139_ (.A(net1),
    .B(net6),
    .X(_106_));
 sky130_fd_sc_hd__inv_2 _140_ (.A(_106_),
    .Y(_107_));
 sky130_fd_sc_hd__nor2_1 _141_ (.A(net5),
    .B(_107_),
    .Y(_108_));
 sky130_fd_sc_hd__inv_2 _142_ (.A(\state[3] ),
    .Y(_109_));
 sky130_fd_sc_hd__inv_2 _143_ (.A(\state[1] ),
    .Y(_110_));
 sky130_fd_sc_hd__buf_1 _144_ (.A(_110_),
    .X(_111_));
 sky130_fd_sc_hd__o21a_1 _145_ (.A1(_109_),
    .A2(_106_),
    .B1(_111_),
    .X(_112_));
 sky130_fd_sc_hd__o311a_1 _146_ (.A1(\counter[5] ),
    .A2(\counter[4] ),
    .A3(\counter[3] ),
    .B1(\counter[7] ),
    .C1(\counter[6] ),
    .X(_113_));
 sky130_fd_sc_hd__inv_2 _147_ (.A(net2),
    .Y(_114_));
 sky130_fd_sc_hd__inv_2 _148_ (.A(net3),
    .Y(_115_));
 sky130_fd_sc_hd__inv_2 _149_ (.A(net10),
    .Y(_116_));
 sky130_fd_sc_hd__o221a_1 _150_ (.A1(_110_),
    .A2(_114_),
    .B1(_115_),
    .B2(_109_),
    .C1(_116_),
    .X(_117_));
 sky130_fd_sc_hd__o221a_1 _151_ (.A1(_105_),
    .A2(_108_),
    .B1(_112_),
    .B2(_113_),
    .C1(_117_),
    .X(_039_));
 sky130_fd_sc_hd__o221a_2 _152_ (.A1(_092_),
    .A2(_100_),
    .B1(_101_),
    .B2(_104_),
    .C1(_039_),
    .X(_040_));
 sky130_fd_sc_hd__inv_2 _153_ (.A(_040_),
    .Y(_041_));
 sky130_fd_sc_hd__inv_2 _154_ (.A(_102_),
    .Y(_042_));
 sky130_fd_sc_hd__clkbuf_2 _155_ (.A(_042_),
    .X(_043_));
 sky130_fd_sc_hd__a211o_1 _156_ (.A1(_043_),
    .A2(\state[0] ),
    .B1(\state[3] ),
    .C1(\state[5] ),
    .X(_044_));
 sky130_fd_sc_hd__inv_2 _157_ (.A(net4),
    .Y(_045_));
 sky130_fd_sc_hd__buf_1 _158_ (.A(_045_),
    .X(_046_));
 sky130_fd_sc_hd__o221a_1 _159_ (.A1(\error_code_r[1] ),
    .A2(_040_),
    .B1(_041_),
    .B2(_044_),
    .C1(_046_),
    .X(_037_));
 sky130_fd_sc_hd__a2111o_1 _160_ (.A1(_042_),
    .A2(\state[0] ),
    .B1(\state[2] ),
    .C1(\state[5] ),
    .D1(\state[1] ),
    .X(_047_));
 sky130_fd_sc_hd__a31o_1 _161_ (.A1(_043_),
    .A2(\state[3] ),
    .A3(_093_),
    .B1(_047_),
    .X(_048_));
 sky130_fd_sc_hd__o221a_1 _162_ (.A1(_041_),
    .A2(_048_),
    .B1(\error_code_r[0] ),
    .B2(_040_),
    .C1(_046_),
    .X(_036_));
 sky130_fd_sc_hd__or2_2 _163_ (.A(net3),
    .B(_109_),
    .X(_049_));
 sky130_fd_sc_hd__or3_1 _164_ (.A(net6),
    .B(_092_),
    .C(_099_),
    .X(_050_));
 sky130_fd_sc_hd__or3_1 _165_ (.A(net1),
    .B(_101_),
    .C(_103_),
    .X(_051_));
 sky130_fd_sc_hd__o211a_1 _166_ (.A1(_107_),
    .A2(_049_),
    .B1(_050_),
    .C1(_051_),
    .X(_052_));
 sky130_fd_sc_hd__buf_1 _167_ (.A(_052_),
    .X(_053_));
 sky130_fd_sc_hd__buf_1 _168_ (.A(_045_),
    .X(_054_));
 sky130_fd_sc_hd__o21a_1 _169_ (.A1(_111_),
    .A2(net2),
    .B1(_049_),
    .X(_055_));
 sky130_fd_sc_hd__buf_1 _170_ (.A(_055_),
    .X(_056_));
 sky130_fd_sc_hd__or2_1 _171_ (.A(_015_),
    .B(_098_),
    .X(_057_));
 sky130_fd_sc_hd__or2_1 _172_ (.A(_018_),
    .B(_057_),
    .X(_058_));
 sky130_fd_sc_hd__nor2_1 _173_ (.A(_021_),
    .B(_058_),
    .Y(_059_));
 sky130_fd_sc_hd__o21ai_1 _174_ (.A1(\counter[7] ),
    .A2(_059_),
    .B1(_099_),
    .Y(_025_));
 sky130_fd_sc_hd__o22a_1 _175_ (.A1(_093_),
    .A2(_092_),
    .B1(_102_),
    .B2(_101_),
    .X(_060_));
 sky130_fd_sc_hd__buf_1 _176_ (.A(_060_),
    .X(_061_));
 sky130_fd_sc_hd__buf_1 _177_ (.A(_052_),
    .X(_062_));
 sky130_fd_sc_hd__o221ai_1 _178_ (.A1(_026_),
    .A2(_056_),
    .B1(_025_),
    .B2(_061_),
    .C1(_062_),
    .Y(_063_));
 sky130_fd_sc_hd__o211a_1 _179_ (.A1(\counter[7] ),
    .A2(_053_),
    .B1(_054_),
    .C1(_063_),
    .X(_035_));
 sky130_fd_sc_hd__a21o_1 _180_ (.A1(_021_),
    .A2(_058_),
    .B1(_059_),
    .X(_022_));
 sky130_fd_sc_hd__o221ai_1 _181_ (.A1(_023_),
    .A2(_056_),
    .B1(_061_),
    .B2(_022_),
    .C1(_062_),
    .Y(_064_));
 sky130_fd_sc_hd__o211a_1 _182_ (.A1(\counter[6] ),
    .A2(_053_),
    .B1(_054_),
    .C1(_064_),
    .X(_034_));
 sky130_fd_sc_hd__a21bo_1 _183_ (.A1(_018_),
    .A2(_057_),
    .B1_N(_058_),
    .X(_019_));
 sky130_fd_sc_hd__o221ai_1 _184_ (.A1(_020_),
    .A2(_056_),
    .B1(_061_),
    .B2(_019_),
    .C1(_062_),
    .Y(_065_));
 sky130_fd_sc_hd__o211a_1 _185_ (.A1(\counter[5] ),
    .A2(_053_),
    .B1(_045_),
    .C1(_065_),
    .X(_033_));
 sky130_fd_sc_hd__inv_2 _186_ (.A(_052_),
    .Y(_066_));
 sky130_fd_sc_hd__o21ai_1 _187_ (.A1(\counter[4] ),
    .A2(_097_),
    .B1(_057_),
    .Y(_016_));
 sky130_fd_sc_hd__o22ai_1 _188_ (.A1(_017_),
    .A2(_056_),
    .B1(_061_),
    .B2(_016_),
    .Y(_067_));
 sky130_fd_sc_hd__o221a_1 _189_ (.A1(_066_),
    .A2(_067_),
    .B1(\counter[4] ),
    .B2(_053_),
    .C1(_046_),
    .X(_032_));
 sky130_fd_sc_hd__nand2_1 _190_ (.A(\counter[2] ),
    .B(_096_),
    .Y(_068_));
 sky130_fd_sc_hd__a21o_1 _191_ (.A1(_012_),
    .A2(_068_),
    .B1(_097_),
    .X(_013_));
 sky130_fd_sc_hd__o22ai_1 _192_ (.A1(_014_),
    .A2(_056_),
    .B1(_061_),
    .B2(_013_),
    .Y(_069_));
 sky130_fd_sc_hd__o221a_1 _193_ (.A1(_066_),
    .A2(_069_),
    .B1(\counter[3] ),
    .B2(_053_),
    .C1(_046_),
    .X(_031_));
 sky130_fd_sc_hd__o21ai_1 _194_ (.A1(\counter[2] ),
    .A2(_096_),
    .B1(_068_),
    .Y(_010_));
 sky130_fd_sc_hd__o22ai_1 _195_ (.A1(_011_),
    .A2(_055_),
    .B1(_060_),
    .B2(_010_),
    .Y(_070_));
 sky130_fd_sc_hd__o221a_1 _196_ (.A1(_066_),
    .A2(_070_),
    .B1(\counter[2] ),
    .B2(_062_),
    .C1(_054_),
    .X(_030_));
 sky130_fd_sc_hd__a21o_1 _197_ (.A1(_006_),
    .A2(_095_),
    .B1(_096_),
    .X(_007_));
 sky130_fd_sc_hd__o22ai_1 _198_ (.A1(_008_),
    .A2(_055_),
    .B1(_060_),
    .B2(_007_),
    .Y(_071_));
 sky130_fd_sc_hd__o221a_1 _199_ (.A1(_066_),
    .A2(_071_),
    .B1(\counter[1] ),
    .B2(_062_),
    .C1(_054_),
    .X(_029_));
 sky130_fd_sc_hd__buf_1 _200_ (.A(net4),
    .X(_072_));
 sky130_fd_sc_hd__clkbuf_4 _201_ (.A(_113_),
    .X(_027_));
 sky130_fd_sc_hd__o21a_1 _202_ (.A1(_027_),
    .A2(_055_),
    .B1(_060_),
    .X(_073_));
 sky130_fd_sc_hd__inv_2 _203_ (.A(_027_),
    .Y(_074_));
 sky130_fd_sc_hd__o21a_1 _204_ (.A1(_074_),
    .A2(_055_),
    .B1(_052_),
    .X(_075_));
 sky130_fd_sc_hd__o32a_1 _205_ (.A1(\counter[0] ),
    .A2(_073_),
    .A3(_066_),
    .B1(_095_),
    .B2(_075_),
    .X(_076_));
 sky130_fd_sc_hd__nor2_1 _206_ (.A(_072_),
    .B(_076_),
    .Y(_028_));
 sky130_fd_sc_hd__inv_2 _207_ (.A(_103_),
    .Y(_077_));
 sky130_fd_sc_hd__o32a_1 _208_ (.A1(_102_),
    .A2(_101_),
    .A3(_077_),
    .B1(_115_),
    .B2(_109_),
    .X(_078_));
 sky130_fd_sc_hd__nor2_1 _209_ (.A(_072_),
    .B(_078_),
    .Y(_002_));
 sky130_fd_sc_hd__inv_2 _210_ (.A(_099_),
    .Y(_079_));
 sky130_fd_sc_hd__o32a_1 _211_ (.A1(_093_),
    .A2(_092_),
    .A3(_079_),
    .B1(_043_),
    .B2(_101_),
    .X(_080_));
 sky130_fd_sc_hd__nor2_1 _212_ (.A(_072_),
    .B(_080_),
    .Y(_005_));
 sky130_fd_sc_hd__inv_2 _213_ (.A(net5),
    .Y(_081_));
 sky130_fd_sc_hd__o32a_1 _214_ (.A1(_106_),
    .A2(_049_),
    .A3(_027_),
    .B1(_105_),
    .B2(_081_),
    .X(_082_));
 sky130_fd_sc_hd__nor2_1 _215_ (.A(_072_),
    .B(_082_),
    .Y(_003_));
 sky130_fd_sc_hd__or2_1 _216_ (.A(_105_),
    .B(net5),
    .X(_083_));
 sky130_fd_sc_hd__o221ai_1 _217_ (.A1(_111_),
    .A2(_114_),
    .B1(_106_),
    .B2(_083_),
    .C1(_046_),
    .Y(_000_));
 sky130_fd_sc_hd__o221a_1 _218_ (.A1(_107_),
    .A2(_083_),
    .B1(_043_),
    .B2(_049_),
    .C1(_116_),
    .X(_084_));
 sky130_fd_sc_hd__o31a_1 _219_ (.A1(_111_),
    .A2(net2),
    .A3(_074_),
    .B1(_051_),
    .X(_085_));
 sky130_fd_sc_hd__inv_2 _220_ (.A(_093_),
    .Y(_086_));
 sky130_fd_sc_hd__a211o_1 _221_ (.A1(_086_),
    .A2(_074_),
    .B1(_102_),
    .C1(_049_),
    .X(_087_));
 sky130_fd_sc_hd__a41o_1 _222_ (.A1(_050_),
    .A2(_084_),
    .A3(_085_),
    .A4(_087_),
    .B1(net4),
    .X(_088_));
 sky130_fd_sc_hd__inv_2 _223_ (.A(_088_),
    .Y(_004_));
 sky130_fd_sc_hd__o32a_1 _224_ (.A1(_111_),
    .A2(net2),
    .A3(_027_),
    .B1(_086_),
    .B2(_092_),
    .X(_089_));
 sky130_fd_sc_hd__nor2_1 _225_ (.A(_072_),
    .B(_089_),
    .Y(_001_));
 sky130_fd_sc_hd__and2_1 _226_ (.A(\error_code_r[0] ),
    .B(net10),
    .X(net7));
 sky130_fd_sc_hd__and2_1 _227_ (.A(\error_code_r[1] ),
    .B(net10),
    .X(net8));
 sky130_fd_sc_hd__and2_1 _228_ (.A(\error_code_r[2] ),
    .B(net10),
    .X(net9));
 sky130_fd_sc_hd__nor2_1 _229_ (.A(net10),
    .B(\state[0] ),
    .Y(net11));
 sky130_fd_sc_hd__nor2_1 _230_ (.A(\state[5] ),
    .B(\state[1] ),
    .Y(_090_));
 sky130_fd_sc_hd__o221ai_2 _231_ (.A1(_043_),
    .A2(_105_),
    .B1(_109_),
    .B2(_106_),
    .C1(_090_),
    .Y(_091_));
 sky130_fd_sc_hd__o221a_1 _232_ (.A1(\error_code_r[2] ),
    .A2(_040_),
    .B1(_041_),
    .B2(_091_),
    .C1(_054_),
    .X(_038_));
 sky130_fd_sc_hd__mux2_1 _233_ (.A0(_016_),
    .A1(_015_),
    .S(_027_),
    .X(_017_));
 sky130_fd_sc_hd__mux2_1 _234_ (.A0(_019_),
    .A1(_018_),
    .S(_027_),
    .X(_020_));
 sky130_fd_sc_hd__mux2_1 _235_ (.A0(_022_),
    .A1(_021_),
    .S(_027_),
    .X(_023_));
 sky130_fd_sc_hd__mux2_1 _236_ (.A0(_025_),
    .A1(_024_),
    .S(_027_),
    .X(_026_));
 sky130_fd_sc_hd__mux2_1 _237_ (.A0(_007_),
    .A1(_006_),
    .S(_027_),
    .X(_008_));
 sky130_fd_sc_hd__mux2_1 _238_ (.A0(_013_),
    .A1(_012_),
    .S(_027_),
    .X(_014_));
 sky130_fd_sc_hd__mux2_1 _239_ (.A0(_010_),
    .A1(_009_),
    .S(_027_),
    .X(_011_));
 sky130_fd_sc_hd__dfxtp_1 _240_ (.D(_000_),
    .Q(\state[0] ),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _241_ (.D(_001_),
    .Q(\state[1] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _242_ (.D(_002_),
    .Q(\state[2] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _243_ (.D(_003_),
    .Q(\state[3] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_2 _244_ (.D(_004_),
    .Q(net10),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _245_ (.D(_005_),
    .Q(\state[5] ),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _246_ (.D(_028_),
    .Q(\counter[0] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _247_ (.D(_029_),
    .Q(\counter[1] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _248_ (.D(_030_),
    .Q(\counter[2] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _249_ (.D(_031_),
    .Q(\counter[3] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _250_ (.D(_032_),
    .Q(\counter[4] ),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _251_ (.D(_033_),
    .Q(\counter[5] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _252_ (.D(_034_),
    .Q(\counter[6] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _253_ (.D(_035_),
    .Q(\counter[7] ),
    .CLK(clknet_1_1_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _254_ (.D(_036_),
    .Q(\error_code_r[0] ),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _255_ (.D(_037_),
    .Q(\error_code_r[1] ),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__dfxtp_1 _256_ (.D(_038_),
    .Q(\error_code_r[2] ),
    .CLK(clknet_1_0_0_clk));
 sky130_fd_sc_hd__decap_3 PHY_0 ();
 sky130_fd_sc_hd__decap_3 PHY_1 ();
 sky130_fd_sc_hd__decap_3 PHY_2 ();
 sky130_fd_sc_hd__decap_3 PHY_3 ();
 sky130_fd_sc_hd__decap_3 PHY_4 ();
 sky130_fd_sc_hd__decap_3 PHY_5 ();
 sky130_fd_sc_hd__decap_3 PHY_6 ();
 sky130_fd_sc_hd__decap_3 PHY_7 ();
 sky130_fd_sc_hd__decap_3 PHY_8 ();
 sky130_fd_sc_hd__decap_3 PHY_9 ();
 sky130_fd_sc_hd__decap_3 PHY_10 ();
 sky130_fd_sc_hd__decap_3 PHY_11 ();
 sky130_fd_sc_hd__decap_3 PHY_12 ();
 sky130_fd_sc_hd__decap_3 PHY_13 ();
 sky130_fd_sc_hd__decap_3 PHY_14 ();
 sky130_fd_sc_hd__decap_3 PHY_15 ();
 sky130_fd_sc_hd__decap_3 PHY_16 ();
 sky130_fd_sc_hd__decap_3 PHY_17 ();
 sky130_fd_sc_hd__decap_3 PHY_18 ();
 sky130_fd_sc_hd__decap_3 PHY_19 ();
 sky130_fd_sc_hd__decap_3 PHY_20 ();
 sky130_fd_sc_hd__decap_3 PHY_21 ();
 sky130_fd_sc_hd__decap_3 PHY_22 ();
 sky130_fd_sc_hd__decap_3 PHY_23 ();
 sky130_fd_sc_hd__decap_3 PHY_24 ();
 sky130_fd_sc_hd__decap_3 PHY_25 ();
 sky130_fd_sc_hd__decap_3 PHY_26 ();
 sky130_fd_sc_hd__decap_3 PHY_27 ();
 sky130_fd_sc_hd__decap_3 PHY_28 ();
 sky130_fd_sc_hd__decap_3 PHY_29 ();
 sky130_fd_sc_hd__decap_3 PHY_30 ();
 sky130_fd_sc_hd__decap_3 PHY_31 ();
 sky130_fd_sc_hd__decap_3 PHY_32 ();
 sky130_fd_sc_hd__decap_3 PHY_33 ();
 sky130_fd_sc_hd__decap_3 PHY_34 ();
 sky130_fd_sc_hd__decap_3 PHY_35 ();
 sky130_fd_sc_hd__decap_3 PHY_36 ();
 sky130_fd_sc_hd__decap_3 PHY_37 ();
 sky130_fd_sc_hd__decap_3 PHY_38 ();
 sky130_fd_sc_hd__decap_3 PHY_39 ();
 sky130_fd_sc_hd__decap_3 PHY_40 ();
 sky130_fd_sc_hd__decap_3 PHY_41 ();
 sky130_fd_sc_hd__decap_3 PHY_42 ();
 sky130_fd_sc_hd__decap_3 PHY_43 ();
 sky130_fd_sc_hd__decap_3 PHY_44 ();
 sky130_fd_sc_hd__decap_3 PHY_45 ();
 sky130_fd_sc_hd__decap_3 PHY_46 ();
 sky130_fd_sc_hd__decap_3 PHY_47 ();
 sky130_fd_sc_hd__decap_3 PHY_48 ();
 sky130_fd_sc_hd__decap_3 PHY_49 ();
 sky130_fd_sc_hd__decap_3 PHY_50 ();
 sky130_fd_sc_hd__decap_3 PHY_51 ();
 sky130_fd_sc_hd__decap_3 PHY_52 ();
 sky130_fd_sc_hd__decap_3 PHY_53 ();
 sky130_fd_sc_hd__decap_3 PHY_54 ();
 sky130_fd_sc_hd__decap_3 PHY_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 PHY_145 ();
 sky130_fd_sc_hd__buf_1 input1 (.A(barrier_down_sensor),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_2 input2 (.A(barrier_up_sensor),
    .X(net2));
 sky130_fd_sc_hd__buf_1 input3 (.A(light_on_sensor),
    .X(net3));
 sky130_fd_sc_hd__buf_1 input4 (.A(reset),
    .X(net4));
 sky130_fd_sc_hd__buf_1 input5 (.A(train_approach),
    .X(net5));
 sky130_fd_sc_hd__buf_1 input6 (.A(train_depart),
    .X(net6));
 sky130_fd_sc_hd__clkbuf_2 output7 (.A(net7),
    .X(error_code[0]));
 sky130_fd_sc_hd__clkbuf_2 output8 (.A(net8),
    .X(error_code[1]));
 sky130_fd_sc_hd__clkbuf_2 output9 (.A(net9),
    .X(error_code[2]));
 sky130_fd_sc_hd__clkbuf_2 output10 (.A(net10),
    .X(fail_safe));
 sky130_fd_sc_hd__clkbuf_2 output11 (.A(net11),
    .X(sequence_ok));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_1_0_0_clk (.A(clknet_0_clk),
    .X(clknet_1_0_0_clk));
 sky130_fd_sc_hd__clkbuf_1 clkbuf_1_1_0_clk (.A(clknet_0_clk),
    .X(clknet_1_1_0_clk));
endmodule
