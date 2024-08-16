within cdl_models.Examples;
model demand_flexibility_ratchet_3
    extends Modelica.Icons.Example;

replaceable package MediumAir = Buildings.Media.Air;
          parameter Real TCooSet(unit="K")=273.15+22
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+16
    "Zone heating temperature setpoint";
  Controls.DF_Controller_ratchet_cooling dF_Controller1(
    TZonCooSetNominal=TCooSet,
    TZonCooSetMax(displayUnit="degC") = 301.15,
    TRatThreshold=0.2,
    TRat=0.5,
    TReb=0.3) annotation (Placement(transformation(extent={{6,62},{26,82}})));
  Modelica.Blocks.Sources.CombiTimeTable loadShedMode(
    table=[0,0; 10800,0; 21600,0.0; 27000,0.0; 32400,0; 43200,0; 54000,1; 64800,
        0; 75600,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-142,32},{-122,52}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-98,32},{-78,52}})));
  ThermalZones.ModelicaRoom modelicaRoom1
    annotation (Placement(transformation(extent={{106,56},{148,86}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition1(
    table=[0,0; 10800,0; 21600,0; 27000,0; 32400,0; 43200,0; 54000,0.0; 64800,
        0.0; 75600,0.0; 86400,0.0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{52,58},{72,78}})));
  BaseClasses.custom_air_conditioner custom_air_conditioner1(mRec_flow_nominal=
        0.7) annotation (Placement(transformation(extent={{78,24},{98,44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingSetpoint1(final k=
        THeaSet)
    annotation (Placement(transformation(extent={{10,18},{30,38}})));
  Controls.DF_Controller_ratchet_cooling dF_Controller2(
    TZonCooSetNominal=TCooSet,
    TZonCooSetMax(displayUnit="degC") = 301.15,
    TRatThreshold=0.2,
    TRat=0.5,
    TReb=0.3) annotation (Placement(transformation(extent={{4,-26},{24,-6}})));
  ThermalZones.ModelicaRoom modelicaRoom2
    annotation (Placement(transformation(extent={{104,-32},{146,-2}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition2(
    table=[0,200; 10800,200; 21600,200; 27000,200; 32400,200; 43200,200; 54000,
        200; 64800,200; 75600,200; 86400,200],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{52,-32},{72,-12}})));
  BaseClasses.custom_air_conditioner custom_air_conditioner2(mRec_flow_nominal=
        0.7) annotation (Placement(transformation(extent={{76,-64},{96,-44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingSetpoint2(final k=
        THeaSet)
    annotation (Placement(transformation(extent={{8,-70},{28,-50}})));
  Controls.DF_Controller_ratchet_cooling dF_Controller3(
    TZonCooSetNominal=TCooSet,
    TZonCooSetMax(displayUnit="degC") = 301.15,
    TRatThreshold=0.2,
    TRat=0.5,
    TReb=0.3)
    annotation (Placement(transformation(extent={{8,-130},{28,-110}})));
  ThermalZones.ModelicaRoom modelicaRoom3
    annotation (Placement(transformation(extent={{108,-136},{150,-106}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition3(
    table=[0,-100; 10800,-100; 21600,-100; 27000,-100; 32400,-100; 43200,-100;
        54000,-100; 64800,-100; 75600,-100; 86400,-100],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{54,-134},{74,-114}})));
  BaseClasses.custom_air_conditioner custom_air_conditioner3(mRec_flow_nominal=
        0.7)
    annotation (Placement(transformation(extent={{80,-168},{100,-148}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingSetpoint3(final k=
        THeaSet)
    annotation (Placement(transformation(extent={{12,-174},{32,-154}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=
        custom_air_conditioner1.electricPower + custom_air_conditioner2.electricPower
         + custom_air_conditioner3.electricPower)
    annotation (Placement(transformation(extent={{-166,-36},{-146,-16}})));
  Modelica.Blocks.Interfaces.RealOutput totalElectricPower
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-64,70},{-44,90}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2
    annotation (Placement(transformation(extent={{-48,-18},{-28,2}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant3
    annotation (Placement(transformation(extent={{-40,-128},{-20,-108}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=280, h=0)
    annotation (Placement(transformation(extent={{-126,-86},{-106,-66}})));
  BaseClasses.smallPass smallPass(nValues=3)
    annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre[3]
    annotation (Placement(transformation(extent={{-56,-80},{-36,-60}})));
equation
  connect(loadShedMode.y[1], realToBoolean.u)
    annotation (Line(points={{-121,42},{-100,42}}, color={0,0,127}));
  connect(realToBoolean.y, dF_Controller1.loadShed) annotation (Line(points={{
          -77,42},{-4,42},{-4,80},{4,80}}, color={255,0,255}));
  connect(customHeatAddition1.y[1], modelicaRoom1.CustomHeatFlow) annotation (
      Line(points={{73,68},{100,68},{100,59.8},{105,59.8}}, color={0,0,127}));
  connect(heatingSetpoint1.y, custom_air_conditioner1.THeaSet) annotation (Line(
        points={{32,28},{66,28},{66,31.6},{76,31.6}}, color={0,0,127}));
  connect(dF_Controller1.TZonSet, custom_air_conditioner1.TCooSet) annotation (
      Line(points={{28,76.8},{46,76.8},{46,42.4},{76,42.4}}, color={0,0,127}));
  connect(modelicaRoom1.TZon, dF_Controller1.TZon) annotation (Line(points={{
          125.6,87},{125.6,10},{4,10},{4,64}}, color={0,0,127}));
  connect(modelicaRoom1.TZon, custom_air_conditioner1.ZAT) annotation (Line(
        points={{125.6,87},{125.6,10},{4,10},{4,42},{44,42},{44,36.8},{76,36.8}},
        color={0,0,127}));
  connect(custom_air_conditioner1.port_b, modelicaRoom1.port_a2) annotation (
      Line(points={{98.2,26.6},{98.2,24},{108,24},{108,52},{102,52},{102,74.4},
          {105.4,74.4}}, color={0,127,255}));
  connect(modelicaRoom1.port_b2, custom_air_conditioner1.port_a) annotation (
      Line(points={{148.4,74.8},{152,74.8},{152,52},{110,52},{110,18},{77.6,18},
          {77.6,26.6}}, color={0,127,255}));
  connect(realToBoolean.y, dF_Controller2.loadShed) annotation (Line(points={{
          -77,42},{-6,42},{-6,-8},{2,-8}}, color={255,0,255}));
  connect(customHeatAddition2.y[1], modelicaRoom2.CustomHeatFlow) annotation (
      Line(points={{73,-22},{98,-22},{98,-28.2},{103,-28.2}}, color={0,0,127}));
  connect(heatingSetpoint2.y, custom_air_conditioner2.THeaSet) annotation (Line(
        points={{30,-60},{64,-60},{64,-56.4},{74,-56.4}}, color={0,0,127}));
  connect(dF_Controller2.TZonSet, custom_air_conditioner2.TCooSet) annotation (
      Line(points={{26,-11.2},{44,-11.2},{44,-45.6},{74,-45.6}}, color={0,0,127}));
  connect(modelicaRoom2.TZon, dF_Controller2.TZon) annotation (Line(points={{
          123.6,-1},{-6,-1},{-6,-24},{2,-24}}, color={0,0,127}));
  connect(modelicaRoom2.TZon, custom_air_conditioner2.ZAT) annotation (Line(
        points={{123.6,-1},{76,-1},{76,-38},{66,-38},{66,-51.2},{74,-51.2}},
        color={0,0,127}));
  connect(custom_air_conditioner2.port_b, modelicaRoom2.port_a2) annotation (
      Line(points={{96.2,-61.4},{96.2,-68},{106,-68},{106,-36},{100,-36},{100,
          -13.6},{103.4,-13.6}}, color={0,127,255}));
  connect(modelicaRoom2.port_b2, custom_air_conditioner2.port_a) annotation (
      Line(points={{146.4,-13.2},{150,-13.2},{150,-68},{75.6,-68},{75.6,-61.4}},
        color={0,127,255}));
  connect(realToBoolean.y, dF_Controller3.loadShed) annotation (Line(points={{
          -77,42},{-6,42},{-6,-8},{-8,-8},{-8,-112},{6,-112}}, color={255,0,255}));
  connect(customHeatAddition3.y[1], modelicaRoom3.CustomHeatFlow) annotation (
      Line(points={{75,-124},{102,-124},{102,-132.2},{107,-132.2}}, color={0,0,
          127}));
  connect(heatingSetpoint3.y, custom_air_conditioner3.THeaSet) annotation (Line(
        points={{34,-164},{68,-164},{68,-160.4},{78,-160.4}}, color={0,0,127}));
  connect(dF_Controller3.TZonSet, custom_air_conditioner3.TCooSet) annotation (
      Line(points={{30,-115.2},{48,-115.2},{48,-149.6},{78,-149.6}}, color={0,0,
          127}));
  connect(modelicaRoom3.TZon, dF_Controller3.TZon) annotation (Line(points={{
          127.6,-105},{-2,-105},{-2,-128},{6,-128}}, color={0,0,127}));
  connect(modelicaRoom3.TZon, custom_air_conditioner3.ZAT) annotation (Line(
        points={{127.6,-105},{80,-105},{80,-142},{70,-142},{70,-155.2},{78,
          -155.2}}, color={0,0,127}));
  connect(custom_air_conditioner3.port_b, modelicaRoom3.port_a2) annotation (
      Line(points={{100.2,-165.4},{100.2,-172},{110,-172},{110,-140},{104,-140},
          {104,-117.6},{107.4,-117.6}}, color={0,127,255}));
  connect(modelicaRoom3.port_b2, custom_air_conditioner3.port_a) annotation (
      Line(points={{150.4,-117.2},{154,-117.2},{154,-172},{79.6,-172},{79.6,
          -165.4}}, color={0,127,255}));
  connect(realExpression.y, totalElectricPower)
    annotation (Line(points={{-145,-26},{-90,-26}}, color={0,0,127}));
  connect(booleanConstant1.y, dF_Controller1.DoReb) annotation (Line(points={{
          -43,80},{-6,80},{-6,73.8},{4,73.8}}, color={255,0,255}));
  connect(booleanConstant2.y, dF_Controller2.DoReb) annotation (Line(points={{
          -27,-8},{-28,-8},{-28,-14.2},{2,-14.2}}, color={255,0,255}));
  connect(booleanConstant3.y, dF_Controller3.DoReb) annotation (Line(points={{
          -19,-118},{-6.5,-118},{-6.5,-118.2},{6,-118.2}}, color={255,0,255}));
  connect(realExpression.y, greThr.u) annotation (Line(points={{-145,-26},{-138,
          -26},{-138,-76},{-128,-76}}, color={0,0,127}));
  connect(dF_Controller1.TZonTempDiff, smallPass.targetValue[1]) annotation (
      Line(points={{28,67.6},{36,67.6},{36,40},{-68,40},{-68,-66.0667},{-90,
          -66.0667}}, color={0,0,127}));
  connect(dF_Controller2.TZonTempDiff, smallPass.targetValue[2]) annotation (
      Line(points={{26,-20.4},{34,-20.4},{34,-34},{-68,-34},{-68,-65.4},{-90,
          -65.4}}, color={0,0,127}));
  connect(dF_Controller3.TZonTempDiff, smallPass.targetValue[3]) annotation (
      Line(points={{30,-124.4},{38,-124.4},{38,-76},{-6,-76},{-6,-34},{-68,-34},
          {-68,-64.7333},{-90,-64.7333}}, color={0,0,127}));
  connect(greThr.y, smallPass.defaultBool) annotation (Line(points={{-104,-76},
          {-102,-76},{-102,-77.2},{-90,-77.2}}, color={255,0,255}));
  connect(smallPass.targetBool, pre.u)
    annotation (Line(points={{-66,-70},{-58,-70}}, color={255,0,255}));
  connect(pre[1].y, dF_Controller1.DoRat) annotation (Line(points={{-34,-70},{
          -26,-70},{-26,-22},{-16,-22},{-16,-6},{-4,-6},{-4,42},{-2,42},{-2,82},
          {-4,82},{-4,88},{4,88},{4,77}}, color={255,0,255}));
  connect(pre[2].y, dF_Controller2.DoRat) annotation (Line(points={{-34,-70},{
          -26,-70},{-26,-22},{-16,-22},{-16,-6},{-4,-6},{-4,0},{2,0},{2,-11}},
        color={255,0,255}));
  connect(pre[3].y, dF_Controller3.DoRat) annotation (Line(points={{-34,-70},{
          -10,-70},{-10,-115},{6,-115}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end demand_flexibility_ratchet_3;
