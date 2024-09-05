within cdl_models.Controls;
model MultipleHeatPumpZoneController

   parameter Integer numHeaPum=3 "number of heat pumps";
   parameter Integer numApa=4 "number of apartments";
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput reqDomHotWat[numApa]
    "request domestic hot water" annotation (Placement(transformation(extent={{
            -140,38},{-100,78}}), iconTransformation(extent={{-140,60},{-100,
            100}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput reqSpaCon[numApa]
    "request space conditioning" annotation (Placement(transformation(extent={{
            -140,-66},{-100,-26}}), iconTransformation(extent={{-142,-66},{-102,
            -26}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput comHeaPumMod[numHeaPum]
    "a command of heat pump modes" annotation (Placement(transformation(extent={{440,-20},
            {480,20}}),            iconTransformation(extent={{440,-18},{480,22}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[numApa]
    annotation (Placement(transformation(extent={{-76,52},{-56,72}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=numApa)
    annotation (Placement(transformation(extent={{-28,52},{-8,72}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter fraHeaPumPerApa(k=
        numHeaPum/numApa) "fraction of heat pump per apartment"
    annotation (Placement(transformation(extent={{22,52},{42,72}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{62,60},{82,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.499)
    annotation (Placement(transformation(extent={{20,86},{40,106}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{110,56},{130,76}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2[numHeaPum](k=
        numHeaPum:-1:1) "Integer inputs"
    annotation (Placement(transformation(extent={{144,86},{164,106}})));
  Buildings.Controls.OBC.CDL.Integers.LessEqual intLesEqu[numHeaPum]
    annotation (Placement(transformation(extent={{208,80},{228,100}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep(nout=
        numHeaPum)
    annotation (Placement(transformation(extent={{154,44},{174,64}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr[numApa]
    annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[numApa]
    annotation (Placement(transformation(extent={{-28,-30},{-8,-10}})));
  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr[numApa]
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[numApa]
    annotation (Placement(transformation(extent={{-34,-82},{-14,-62}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum1(nin=numApa)
    annotation (Placement(transformation(extent={{14,-30},{34,-10}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum2(nin=numApa)
    annotation (Placement(transformation(extent={{12,-82},{32,-62}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter fraHeaPumPerApa1(k=
        numHeaPum/numApa) "fraction of heat pump per apartment"
    annotation (Placement(transformation(extent={{56,-30},{76,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    annotation (Placement(transformation(extent={{96,-36},{116,-16}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0.499)
    annotation (Placement(transformation(extent={{54,4},{74,24}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter fraHeaPumPerApa2(k=
        numHeaPum/numApa) "fraction of heat pump per apartment"
    annotation (Placement(transformation(extent={{60,-98},{80,-78}})));
  Buildings.Controls.OBC.CDL.Reals.Add add3
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=0.499)
    annotation (Placement(transformation(extent={{58,-64},{78,-44}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{132,-24},{152,-4}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    annotation (Placement(transformation(extent={{134,-94},{154,-74}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqual intGreEqu
    annotation (Placement(transformation(extent={{176,-54},{196,-34}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1[numHeaPum](k=1:1:
        numHeaPum) "Integer inputs"
    annotation (Placement(transformation(extent={{298,-42},{318,-22}})));
  Buildings.Controls.OBC.CDL.Integers.LessEqual intLesEqu1
                                                         [numHeaPum]
    annotation (Placement(transformation(extent={{362,-48},{382,-28}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep1(nout=
        numHeaPum)
    annotation (Placement(transformation(extent={{308,-84},{328,-64}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{218,-52},{238,-32}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1[numHeaPum]
    annotation (Placement(transformation(extent={{340,58},{360,78}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi2[numHeaPum]
    annotation (Placement(transformation(extent={{406,-44},{426,-24}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt3[numHeaPum](k=0)
    "Integer inputs"
    annotation (Placement(transformation(extent={{360,-86},{380,-66}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi3
    annotation (Placement(transformation(extent={{272,-2},{292,18}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt4(k=1)
    "Integer inputs" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={231,37})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt5(k=-1)
    "Integer inputs" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={231,-9})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep2(nout=
        numHeaPum)
    annotation (Placement(transformation(extent={{316,-6},{336,14}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt6[numHeaPum](k=2)
    "Integer inputs"
    annotation (Placement(transformation(extent={{292,92},{312,112}})));
equation
  connect(reqDomHotWat, intToRea.u) annotation (Line(points={{-120,58},{-86,58},
          {-86,62},{-78,62}}, color={255,127,0}));
  connect(intToRea.y, mulSum.u)
    annotation (Line(points={{-54,62},{-30,62}}, color={0,0,127}));
  connect(mulSum.y, fraHeaPumPerApa.u)
    annotation (Line(points={{-6,62},{20,62}}, color={0,0,127}));
  connect(con.y, add2.u1) annotation (Line(points={{42,96},{52,96},{52,76},{60,76}},
        color={0,0,127}));
  connect(fraHeaPumPerApa.y, add2.u2)
    annotation (Line(points={{44,62},{44,64},{60,64}}, color={0,0,127}));
  connect(add2.y, reaToInt.u) annotation (Line(points={{84,70},{100,70},{100,66},
          {108,66}}, color={0,0,127}));
  connect(conInt2.y, intLesEqu.u1) annotation (Line(points={{166,96},{196,96},{196,
          90},{206,90}}, color={255,127,0}));
  connect(intScaRep.y, intLesEqu.u2) annotation (Line(points={{176,54},{198,54},
          {198,82},{206,82}}, color={255,127,0}));
  connect(reaToInt.y, intScaRep.u) annotation (Line(points={{132,66},{142,66},{142,
          54},{152,54}}, color={255,127,0}));
  connect(reqSpaCon, intGreThr.u) annotation (Line(points={{-120,-46},{-84,-46},
          {-84,-20},{-74,-20}}, color={255,127,0}));
  connect(intGreThr.y, booToRea.u)
    annotation (Line(points={{-50,-20},{-30,-20}}, color={255,0,255}));
  connect(reqSpaCon, intLesThr.u) annotation (Line(points={{-120,-46},{-76,-46},
          {-76,-72},{-72,-72}}, color={255,127,0}));
  connect(intLesThr.y, booToRea1.u)
    annotation (Line(points={{-48,-72},{-36,-72}}, color={255,0,255}));
  connect(booToRea.y, mulSum1.u)
    annotation (Line(points={{-6,-20},{12,-20}}, color={0,0,127}));
  connect(booToRea1.y, mulSum2.u)
    annotation (Line(points={{-12,-72},{10,-72}}, color={0,0,127}));
  connect(con1.y, add1.u1) annotation (Line(points={{76,14},{84,14},{84,-12},{
          86,-12},{86,-20},{94,-20}}, color={0,0,127}));
  connect(fraHeaPumPerApa1.y, add1.u2) annotation (Line(points={{78,-20},{78,
          -36},{86,-36},{86,-32},{94,-32}}, color={0,0,127}));
  connect(mulSum1.y, fraHeaPumPerApa1.u)
    annotation (Line(points={{36,-20},{54,-20}}, color={0,0,127}));
  connect(con2.y, add3.u1) annotation (Line(points={{80,-54},{88,-54},{88,-74},
          {98,-74}}, color={0,0,127}));
  connect(fraHeaPumPerApa2.y, add3.u2)
    annotation (Line(points={{82,-88},{82,-86},{98,-86}}, color={0,0,127}));
  connect(mulSum2.y, fraHeaPumPerApa2.u) annotation (Line(points={{34,-72},{50,
          -72},{50,-88},{58,-88}}, color={0,0,127}));
  connect(add1.y, reaToInt1.u) annotation (Line(points={{118,-26},{126,-26},{
          126,-20},{122,-20},{122,-14},{130,-14}}, color={0,0,127}));
  connect(add3.y, reaToInt2.u) annotation (Line(points={{122,-80},{126,-80},{
          126,-84},{132,-84}}, color={0,0,127}));
  connect(reaToInt1.y, intGreEqu.u1) annotation (Line(points={{154,-14},{164,
          -14},{164,-44},{174,-44}}, color={255,127,0}));
  connect(reaToInt2.y, intGreEqu.u2) annotation (Line(points={{156,-84},{166,
          -84},{166,-52},{174,-52}}, color={255,127,0}));
  connect(conInt1.y, intLesEqu1.u1) annotation (Line(points={{320,-32},{350,-32},
          {350,-38},{360,-38}}, color={255,127,0}));
  connect(intScaRep1.y, intLesEqu1.u2) annotation (Line(points={{330,-74},{352,
          -74},{352,-46},{360,-46}}, color={255,127,0}));
  connect(intGreEqu.y, intSwi.u2) annotation (Line(points={{198,-44},{198,-42},
          {216,-42}}, color={255,0,255}));
  connect(reaToInt1.y, intSwi.u1) annotation (Line(points={{154,-14},{164,-14},
          {164,-24},{216,-24},{216,-34}}, color={255,127,0}));
  connect(reaToInt2.y, intSwi.u3) annotation (Line(points={{156,-84},{166,-84},
          {166,-60},{216,-60},{216,-50}}, color={255,127,0}));
  connect(intSwi.y, intScaRep1.u) annotation (Line(points={{240,-42},{274,-42},
          {274,-72},{306,-72},{306,-74}}, color={255,127,0}));
  connect(intLesEqu1.y, intSwi2.u2) annotation (Line(points={{384,-38},{392,-38},
          {392,-34},{404,-34}}, color={255,0,255}));
  connect(conInt3.y, intSwi2.u3) annotation (Line(points={{382,-76},{396,-76},{
          396,-42},{404,-42}}, color={255,127,0}));
  connect(intGreEqu.y, intSwi3.u2) annotation (Line(points={{198,-44},{198,-42},
          {208,-42},{208,8},{270,8}}, color={255,0,255}));
  connect(conInt4.y, intSwi3.u1) annotation (Line(points={{241.8,37},{262,37},{
          262,16},{270,16}}, color={255,127,0}));
  connect(conInt5.y, intSwi3.u3) annotation (Line(points={{241.8,-9},{241.8,-10},
          {262,-10},{262,0},{270,0}}, color={255,127,0}));
  connect(intSwi3.y, intScaRep2.u) annotation (Line(points={{294,8},{306,8},{
          306,4},{314,4}}, color={255,127,0}));
  connect(intScaRep2.y, intSwi2.u1) annotation (Line(points={{338,4},{396,4},{
          396,-26},{404,-26}}, color={255,127,0}));
  connect(conInt6.y, intSwi1.u1) annotation (Line(points={{314,102},{330,102},{
          330,76},{338,76}}, color={255,127,0}));
  connect(intLesEqu.y, intSwi1.u2) annotation (Line(points={{230,90},{286,90},{
          286,68},{338,68}}, color={255,0,255}));
  connect(intSwi2.y, intSwi1.u3) annotation (Line(points={{428,-34},{434,-34},{
          434,44},{338,44},{338,60}}, color={255,127,0}));
  connect(intSwi1.y, comHeaPumMod) annotation (Line(points={{362,68},{370,68},{
          370,6},{430,6},{430,0},{460,0}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{440,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{440,
            100}})));
end MultipleHeatPumpZoneController;
