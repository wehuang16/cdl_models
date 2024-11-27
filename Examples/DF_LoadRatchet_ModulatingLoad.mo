within cdl_models.Examples;
model DF_LoadRatchet_ModulatingLoad
    extends Modelica.Icons.Example;
           parameter Integer nZones=3;
replaceable package MediumAir = Buildings.Media.Air;
          parameter Real TCooSetOcc(unit="K")=273.15+24
    "Zone cooling temperature setpoint";
        parameter Real THeaSetOcc(unit="K")=273.15+20
    "Zone heating temperature setpoint";
              parameter Real TCooSetUnocc(unit="K")=273.15+32
    "Zone cooling temperature setpoint";
        parameter Real THeaSetUnocc(unit="K")=273.15+12
    "Zone heating temperature setpoint";
   parameter Real TZonCooSetMax(unit="K")=273.15+28
    "maximum zone cooling ratcheting temperature setpoint";
   parameter Real TZonHeaSetMin(unit="K")=273.15+16
    "minimum zone heating ratcheting temperature setpoint";
       parameter Real demand_limit(unit="W")=200;

  Controls.DF_Controller_ratchet_cooling dF_Controller_cooling[nZones](
    TZonCooSetNominal=TCooSetOcc,
    TZonCooSetMax(displayUnit="degC") = TZonCooSetMax,
    TRatThreshold=0.2,
    TRat=0.4,
    TReb=0.3) annotation (Placement(transformation(extent={{8,76},{28,96}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable
                                         loadShedMode(table=[0,0; 3600*14,1; 3600
        *18,0; 3600*24,0],                   period=86400)
    annotation (Placement(transformation(extent={{-228,118},{-208,138}})));
  ThermalZones.ModelicaRoom modelicaRoom[nZones]
    annotation (Placement(transformation(extent={{130,58},{172,88}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition1(
    table=[0,0; 10800,0; 21600,0; 27000,0; 32400,150; 43200,250; 54000,250; 64800,
        150; 75600,0.0; 86400,0.0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{52,58},{72,78}})));
  BaseClasses.custom_air_conditioner_OnOff
                                     custom_air_conditioner_OnOff
                                                           [nZones](
      mRec_flow_nominal=0.7,
    heater_thermal_power_nominal=350,
    cooler_thermal_power_nominal=400)
    annotation (Placement(transformation(extent={{100,12},{120,32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingOccSetpoint[nZones](
      final k=THeaSetOcc)
    annotation (Placement(transformation(extent={{-84,-8},{-64,12}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition2(
    table=[0,200; 10800,200; 21600,200; 27000,200; 32400,350; 43200,450; 54000,450;
        64800,350; 75600,200; 86400,200],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,24},{70,44}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition3(
    table=[0,-100; 10800,-100; 21600,-100; 27000,-100; 32400,50; 43200,150; 54000,
        150; 64800,50; 75600,-100; 86400,-100],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,-12},{70,8}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        totalElectricPower
    annotation (Placement(transformation(extent={{150,-58},{170,-38}})));
  BaseClasses.ratchetSelectionCooling ratchetSelection(nValues=nZones)
    annotation (Placement(transformation(extent={{-196,-30},{-176,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre[nZones]
    annotation (Placement(transformation(extent={{-120,-28},{-100,-8}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=
        nZones)
    annotation (Placement(transformation(extent={{-136,116},{-116,136}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable occupiedMode(table=[0,0;
        3600*7,1; 3600*22,0; 3600*24,0],                   period=86400)
    annotation (Placement(transformation(extent={{-46,116},{-26,136}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi[nZones]
    annotation (Placement(transformation(extent={{64,116},{84,136}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep1(nout=
        nZones)
    annotation (Placement(transformation(extent={{2,116},{22,136}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant coolingUnoccSetpoint[nZones](
      final k=TCooSetUnocc)
    annotation (Placement(transformation(extent={{0,148},{20,168}})));
  BaseClasses.thermostatSetpointResolution thermostatSetpointResolution[nZones]
    annotation (Placement(transformation(extent={{118,108},{138,128}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[nZones](k={1,0.5,0.2})
    annotation (Placement(transformation(extent={{80,150},{100,170}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=3)
    annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
  BaseClasses.reboundSelectionCooling reboundSelection(nValues=nZones)
    annotation (Placement(transformation(extent={{-160,58},{-140,78}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre1
                                            [nZones]
    annotation (Placement(transformation(extent={{-104,54},{-84,74}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingUnoccSetpoint1[nZones](
      final k=THeaSetUnocc)
    annotation (Placement(transformation(extent={{-58,-58},{-38,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
                                             [nZones]
    annotation (Placement(transformation(extent={{-8,-42},{12,-22}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=demand_limit, h=0)
    annotation (Placement(transformation(extent={{-254,-66},{-234,-46}})));
  Buildings.Controls.OBC.CDL.Logical.Switch
                                          logSwi
                                             [nZones]
    annotation (Placement(transformation(extent={{-154,-50},{-134,-30}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep2(nout=
        nZones)
    annotation (Placement(transformation(extent={{-208,-88},{-188,-68}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant boolconst[nZones](final k
      =false)
    annotation (Placement(transformation(extent={{-164,-104},{-144,-84}})));
  BaseClasses.thermostatSetpointResolution thermostatSetpointResolution1
                                                                       [nZones]
    annotation (Placement(transformation(extent={{36,-48},{56,-28}})));
equation
  connect(custom_air_conditioner_OnOff.port_b, modelicaRoom.port_a2)
    annotation (Line(points={{120.2,14.6},{138,14.6},{138,76.4},{129.4,76.4}},
        color={0,127,255}));
  connect(modelicaRoom.port_b2, custom_air_conditioner_OnOff.port_a)
    annotation (Line(points={{172.4,76.8},{194,76.8},{194,-6},{99.6,-6},{99.6,
          14.6}}, color={0,127,255}));
  connect(modelicaRoom.TZon, custom_air_conditioner_OnOff.ZAT) annotation (Line(
        points={{149.6,89},{149.6,24.8},{98,24.8}}, color={0,0,127}));
  connect(customHeatAddition1.y[1], modelicaRoom[1].CustomHeatFlow) annotation (
     Line(points={{73,68},{124,68},{124,61.8},{129,61.8}}, color={0,0,127}));
  connect(customHeatAddition2.y[1], modelicaRoom[2].CustomHeatFlow) annotation (
     Line(points={{71,34},{92,34},{92,68},{124,68},{124,61.8},{129,61.8}},
        color={0,0,127}));
  connect(customHeatAddition3.y[1], modelicaRoom[3].CustomHeatFlow) annotation (
     Line(points={{71,-2},{78,-2},{78,34},{92,34},{92,68},{124,68},{124,61.8},{129,
          61.8}}, color={0,0,127}));
  connect(modelicaRoom.TZon, dF_Controller_cooling.TZon) annotation (Line(
        points={{149.6,89},{149.6,102},{-2,102},{-2,78},{6,78}}, color={0,0,127}));
  connect(booScaRep.y, dF_Controller_cooling.loadShed) annotation (Line(points={
          {-114,126},{-114,108},{6,108},{6,94}}, color={255,0,255}));
  connect(pre.y, dF_Controller_cooling.DoRat) annotation (Line(points={{-98,-18},
          {-90,-18},{-90,40},{-68,40},{-68,91},{6,91}},
                                                 color={255,0,255}));
  connect(loadShedMode.y[1], booScaRep.u) annotation (Line(points={{-206,128},{
          -146,128},{-146,126},{-138,126}}, color={255,0,255}));
  connect(occupiedMode.y[1], booScaRep1.u)
    annotation (Line(points={{-24,126},{0,126}}, color={255,0,255}));
  connect(booScaRep1.y, swi.u2)
    annotation (Line(points={{24,126},{62,126}}, color={255,0,255}));
  connect(dF_Controller_cooling.TZonCooSet, swi.u1) annotation (Line(points={{30,
          90.8},{38,90.8},{38,134},{62,134}}, color={0,0,127}));
  connect(coolingUnoccSetpoint.y, swi.u3) annotation (Line(points={{22,158},{42,
          158},{42,118},{62,118}}, color={0,0,127}));
  connect(swi.y, thermostatSetpointResolution.setpointCommand) annotation (Line(
        points={{86,126},{106,126},{106,118},{116,118}}, color={0,0,127}));
  connect(thermostatSetpointResolution.actualSetpoint,
    custom_air_conditioner_OnOff.TCooSet) annotation (Line(points={{140,118},{
          148,118},{148,94},{88,94},{88,30.4},{98,30.4}}, color={0,0,127}));
  connect(thermostatSetpointResolution.actualSetpoint, dF_Controller_cooling.TZonCooSetAct)
    annotation (Line(points={{140,118},{166,118},{166,120},{186,120},{186,56},{6.2,
          56},{6.2,75.4}}, color={0,0,127}));
  connect(con.y, thermostatSetpointResolution.temRes) annotation (Line(points={
          {102,160},{110,160},{110,126},{108,126},{108,110.6},{116,110.6}},
        color={0,0,127}));
  connect(mulSum.y, totalElectricPower) annotation (Line(points={{122,-42},{144,
          -42},{144,-48},{160,-48}}, color={0,0,127}));
  connect(mulSum.u[1:3], custom_air_conditioner_OnOff.electricPower)
    annotation (Line(points={{98,-41.3333},{90,-41.3333},{90,6},{164,6},{164,
          26.8},{122,26.8}},
        color={0,0,127}));
  connect(dF_Controller_cooling.TZonTempDiff, ratchetSelection.TZonTempDiff)
    annotation (Line(points={{30.2,86.6},{36,86.6},{36,100},{-172,100},{-172,64},
          {-208,64},{-208,-15.4},{-198,-15.4}}, color={0,0,127}));
  connect(dF_Controller_cooling.reachComfortLimit, ratchetSelection.reachComfortLimit)
    annotation (Line(points={{30,79.6},{36,79.6},{36,68},{-74,68},{-74,62},{-76,
          62},{-76,42},{-206,42},{-206,44},{-210,44},{-210,-22},{-206,-22},{-206,
          -25.8},{-198,-25.8}}, color={255,0,255}));
  connect(pre1.y, dF_Controller_cooling.DoReb) annotation (Line(points={{-82,64},
          {-20,64},{-20,87.8},{6,87.8}}, color={255,0,255}));
  connect(reboundSelection.DoReb, pre1.u) annotation (Line(points={{-138,68},{-116,
          68},{-116,64},{-106,64}}, color={255,0,255}));
  connect(dF_Controller_cooling.TZonTempDiff, reboundSelection.TZonTempDiff)
    annotation (Line(points={{30.2,86.6},{36,86.6},{36,100},{-172,100},{-172,72.6},
          {-162,72.6}}, color={0,0,127}));
  connect(dF_Controller_cooling.reachNominalTemp, reboundSelection.reachNominalTemp)
    annotation (Line(points={{30,75.8},{38,75.8},{38,62},{-74,62},{-74,48},{-172,
          48},{-172,62.2},{-162,62.2}}, color={255,0,255}));
  connect(heatingOccSetpoint.y, swi1.u1) annotation (Line(points={{-62,2},{-18,2},
          {-18,-24},{-10,-24}}, color={0,0,127}));
  connect(heatingUnoccSetpoint1.y, swi1.u3) annotation (Line(points={{-36,-48},{
          -18,-48},{-18,-40},{-10,-40}}, color={0,0,127}));
  connect(booScaRep1.y, swi1.u2) annotation (Line(points={{24,126},{12,126},{12,
          4},{-10,4},{-10,-32}}, color={255,0,255}));
  connect(mulSum.y, greThr.u) annotation (Line(points={{122,-42},{130,-42},{130,
          -64},{-180,-64},{-180,-38},{-264,-38},{-264,-56},{-256,-56}}, color={
          0,0,127}));
  connect(greThr.y, booScaRep2.u) annotation (Line(points={{-232,-56},{-220,-56},
          {-220,-78},{-210,-78}}, color={255,0,255}));
  connect(booScaRep2.y, logSwi.u2) annotation (Line(points={{-186,-78},{-178,
          -78},{-178,-40},{-156,-40}}, color={255,0,255}));
  connect(ratchetSelection.DoRat, logSwi.u1) annotation (Line(points={{-174,-20},
          {-164,-20},{-164,-32},{-156,-32}}, color={255,0,255}));
  connect(logSwi.y, pre.u) annotation (Line(points={{-132,-40},{-124,-40},{-124,
          -32},{-132,-32},{-132,-18},{-122,-18}}, color={255,0,255}));
  connect(boolconst.y, logSwi.u3) annotation (Line(points={{-142,-94},{-134,-94},
          {-134,-48},{-156,-48}}, color={255,0,255}));
  connect(con.y, thermostatSetpointResolution1.temRes) annotation (Line(points=
          {{102,160},{110,160},{110,126},{108,126},{108,54},{78,54},{78,50},{26,
          50},{26,-45.4},{34,-45.4}}, color={0,0,127}));
  connect(swi1.y, thermostatSetpointResolution1.setpointCommand) annotation (
      Line(points={{14,-32},{24,-32},{24,-38},{34,-38}}, color={0,0,127}));
  connect(thermostatSetpointResolution1.actualSetpoint,
    custom_air_conditioner_OnOff.THeaSet) annotation (Line(points={{58,-38},{88,
          -38},{88,19.6},{98,19.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=24192000,
      StopTime=24364800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end DF_LoadRatchet_ModulatingLoad;
