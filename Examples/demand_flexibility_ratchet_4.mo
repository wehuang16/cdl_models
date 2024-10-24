within cdl_models.Examples;
model demand_flexibility_ratchet_4
    extends Modelica.Icons.Example;
           parameter Integer nZones=3;
replaceable package MediumAir = Buildings.Media.Air;
          parameter Real TCooSet(unit="K")=273.15+22
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+16
    "Zone heating temperature setpoint";
  Controls.DF_Controller_ratchet_cooling dF_Controller[nZones](
    TZonCooSetNominal=TCooSet,
    TZonCooSetMax(displayUnit="degC") = 301.15,
    TRatThreshold=0.2,
    TRat=0.5,
    TReb=0.06)
              annotation (Placement(transformation(extent={{6,62},{26,82}})));
  Modelica.Blocks.Sources.CombiTimeTable loadShedMode(
    table=[0,0; 3600*14,1; 3600*18,0; 3600*24,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-152,44},{-132,64}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-110,46},{-90,66}})));
  ThermalZones.ModelicaRoom modelicaRoom[nZones]
    annotation (Placement(transformation(extent={{130,58},{172,88}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition1(
    table=[0,0; 10800,0; 21600,0; 27000,0; 32400,0; 43200,0; 54000,0.0; 64800,
        0.0; 75600,0.0; 86400,0.0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{52,58},{72,78}})));
  BaseClasses.custom_air_conditioner custom_air_conditioner[nZones](
      mRec_flow_nominal=0.7)
    annotation (Placement(transformation(extent={{100,12},{120,32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingSetpoint[nZones](
      final k=THeaSet)
    annotation (Placement(transformation(extent={{10,18},{30,38}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition2(
    table=[0,200; 10800,200; 21600,200; 27000,200; 32400,200; 43200,200; 54000,
        200; 64800,200; 75600,200; 86400,200],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,24},{70,44}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition3(
    table=[0,-100; 10800,-100; 21600,-100; 27000,-100; 32400,-100; 43200,-100;
        54000,-100; 64800,-100; 75600,-100; 86400,-100],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,-12},{70,8}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum1(nin=3)
    annotation (Placement(transformation(extent={{-168,-56},{-148,-36}})));
  Modelica.Blocks.Interfaces.RealOutput totalElectricPower
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[nZones]
    annotation (Placement(transformation(extent={{-64,70},{-44,90}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=200, h=0)
    annotation (Placement(transformation(extent={{-126,-86},{-106,-66}})));
  BaseClasses.smallPass smallPass(nValues=nZones)
    annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre[nZones]
    annotation (Placement(transformation(extent={{-56,-80},{-36,-60}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=
        nZones)
    annotation (Placement(transformation(extent={{-74,40},{-54,60}})));
equation
  connect(loadShedMode.y[1], realToBoolean.u)
    annotation (Line(points={{-131,54},{-131,56},{-112,56}},
                                                   color={0,0,127}));
  connect(mulSum1.y, totalElectricPower) annotation (Line(points={{-146,-46},{-138,
          -46},{-138,-26},{-90,-26}}, color={0,0,127}));
  connect(mulSum1.y, greThr.u) annotation (Line(points={{-146,-46},{-138,-46},{-138,
          -76},{-128,-76}}, color={0,0,127}));
  connect(greThr.y, smallPass.defaultBool) annotation (Line(points={{-104,-76},
          {-102,-76},{-102,-77.2},{-90,-77.2}}, color={255,0,255}));
  connect(smallPass.targetBool, pre.u)
    annotation (Line(points={{-66,-70},{-58,-70}}, color={255,0,255}));
  connect(booleanConstant.y, dF_Controller.DoReb) annotation (Line(points={{-43,
          80},{-6,80},{-6,73.8},{4,73.8}}, color={255,0,255}));
  connect(custom_air_conditioner.port_b, modelicaRoom.port_a2) annotation (Line(
        points={{120.2,14.6},{138,14.6},{138,76.4},{129.4,76.4}}, color={0,127,255}));
  connect(modelicaRoom.port_b2, custom_air_conditioner.port_a) annotation (Line(
        points={{172.4,76.8},{194,76.8},{194,-6},{99.6,-6},{99.6,14.6}}, color={
          0,127,255}));
  connect(heatingSetpoint.y, custom_air_conditioner.THeaSet) annotation (Line(
        points={{32,28},{44,28},{44,18},{90,18},{90,19.6},{98,19.6}}, color={0,0,
          127}));
  connect(modelicaRoom.TZon, custom_air_conditioner.ZAT) annotation (Line(
        points={{149.6,89},{149.6,24.8},{98,24.8}}, color={0,0,127}));
  connect(dF_Controller.TZonSet, custom_air_conditioner.TCooSet) annotation (
      Line(points={{28,76.8},{46,76.8},{46,50},{90,50},{90,30.4},{98,30.4}},
        color={0,0,127}));
  connect(customHeatAddition1.y[1], modelicaRoom[1].CustomHeatFlow) annotation (
     Line(points={{73,68},{124,68},{124,61.8},{129,61.8}}, color={0,0,127}));
  connect(customHeatAddition2.y[1], modelicaRoom[2].CustomHeatFlow) annotation (
     Line(points={{71,34},{92,34},{92,68},{124,68},{124,61.8},{129,61.8}},
        color={0,0,127}));
  connect(customHeatAddition3.y[1], modelicaRoom[3].CustomHeatFlow) annotation (
     Line(points={{71,-2},{78,-2},{78,34},{92,34},{92,68},{124,68},{124,61.8},{129,
          61.8}}, color={0,0,127}));
  connect(modelicaRoom.TZon, dF_Controller.TZon)
    annotation (Line(points={{149.6,89},{149.6,64},{4,64}}, color={0,0,127}));
  connect(dF_Controller.TZonTempDiff, smallPass.targetValue) annotation (Line(
        points={{28,67.6},{34,67.6},{34,68},{36,68},{36,36},{-90,36},{-90,-65.4}},
        color={0,0,127}));
  connect(realToBoolean.y, booScaRep.u) annotation (Line(points={{-89,56},{-84,56},
          {-84,50},{-76,50}}, color={255,0,255}));
  connect(booScaRep.y, dF_Controller.loadShed) annotation (Line(points={{-52,50},
          {-32,50},{-32,90},{4,90},{4,80}}, color={255,0,255}));
  connect(pre.y, dF_Controller.DoRat) annotation (Line(points={{-34,-70},{-26,-70},
          {-26,82},{-4,82},{-4,77},{4,77}}, color={255,0,255}));
  connect(mulSum1.u[1], custom_air_conditioner[1].electricPower) annotation (
      Line(points={{-170,-46.6667},{-180,-46.6667},{-180,-26},{128,-26},{128,
          26.8},{122,26.8}}, color={0,0,127}));
  connect(mulSum1.u[2], custom_air_conditioner[2].electricPower) annotation (
      Line(points={{-170,-46},{-178,-46},{-178,-14},{40,-14},{40,20},{84,20},{
          84,36},{94,36},{94,38},{130,38},{130,26.8},{122,26.8}}, color={0,0,
          127}));
  connect(mulSum1.u[3], custom_air_conditioner[3].electricPower) annotation (
      Line(points={{-170,-45.3333},{-178,-45.3333},{-178,-14},{40,-14},{40,20},
          {84,20},{84,36},{94,36},{94,38},{130,38},{130,26.8},{122,26.8}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=24192000,
      StopTime=24364800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end demand_flexibility_ratchet_4;
