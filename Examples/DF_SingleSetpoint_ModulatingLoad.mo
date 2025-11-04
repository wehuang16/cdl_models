within cdl_models.Examples;
model DF_SingleSetpoint_ModulatingLoad
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

  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable
                                         loadShedMode(table=[0,0; 3600*14,1; 3600
        *18,0; 3600*24,0],                   period=86400)
    annotation (Placement(transformation(extent={{-228,118},{-208,138}})));
  ThermalZones.ModelicaRoom modelicaRoom[nZones]
    annotation (Placement(transformation(extent={{130,58},{172,88}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition1(
    table=[0,0; 10800,0; 21600,0; 27000,0; 32400,150; 43200,250; 54000,250;
        64800,150; 75600,0.0; 86400,0.0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{52,58},{72,78}})));
  ThermalZones.BaseClasses.custom_air_conditioner custom_air_conditioner_OnOff[
    nZones](
    mRec_flow_nominal=0.7,
    heater_thermal_power_nominal=700,
    cooler_thermal_power_nominal=800)
    annotation (Placement(transformation(extent={{100,12},{120,32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingOccSetpoint[nZones](
      final k=THeaSetOcc)
    annotation (Placement(transformation(extent={{-84,-8},{-64,12}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition2(
    table=[0,200; 10800,200; 21600,200; 27000,200; 32400,350; 43200,450; 54000,
        450; 64800,350; 75600,200; 86400,200],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,24},{70,44}})));
  Modelica.Blocks.Sources.CombiTimeTable customHeatAddition3(
    table=[0,-100; 10800,-100; 21600,-100; 27000,-100; 32400,50; 43200,150;
        54000,150; 64800,50; 75600,-100; 86400,-100],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{50,-12},{70,8}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        totalElectricPower
    annotation (Placement(transformation(extent={{150,-58},{170,-38}})));
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
  ThermalZones.BaseClasses.thermostatSetpointResolution
    thermostatSetpointResolution[nZones]
    annotation (Placement(transformation(extent={{118,108},{138,128}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[nZones](k={1,0.5,0.2})
    annotation (Placement(transformation(extent={{80,150},{100,170}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=3)
    annotation (Placement(transformation(extent={{100,-52},{120,-32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant heatingUnoccSetpoint1[nZones](
      final k=THeaSetUnocc)
    annotation (Placement(transformation(extent={{-58,-58},{-38,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
                                             [nZones]
    annotation (Placement(transformation(extent={{-8,-42},{12,-22}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant coolingOccSetpoint[nZones](
      final k=TCooSetOcc)
    annotation (Placement(transformation(extent={{-124,34},{-104,54}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant coolingShedSetpoint[nZones](
      final k=TZonCooSetMax)
    annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi2
                                             [nZones]
    annotation (Placement(transformation(extent={{-72,86},{-52,106}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution
    thermostatSetpointResolution1[nZones]
    annotation (Placement(transformation(extent={{42,-76},{62,-56}})));
equation
  connect(custom_air_conditioner_OnOff.port_b, modelicaRoom.port_a) annotation (
     Line(points={{120.2,14.6},{138,14.6},{138,76.4},{129.4,76.4}}, color={0,
          127,255}));
  connect(modelicaRoom.port_b, custom_air_conditioner_OnOff.port_a) annotation (
     Line(points={{172.4,76.8},{194,76.8},{194,-6},{99.6,-6},{99.6,14.6}},
        color={0,127,255}));
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
  connect(loadShedMode.y[1], booScaRep.u) annotation (Line(points={{-206,128},{
          -146,128},{-146,126},{-138,126}}, color={255,0,255}));
  connect(occupiedMode.y[1], booScaRep1.u)
    annotation (Line(points={{-24,126},{0,126}}, color={255,0,255}));
  connect(booScaRep1.y, swi.u2)
    annotation (Line(points={{24,126},{62,126}}, color={255,0,255}));
  connect(coolingUnoccSetpoint.y, swi.u3) annotation (Line(points={{22,158},{42,
          158},{42,118},{62,118}}, color={0,0,127}));
  connect(swi.y, thermostatSetpointResolution.setpointCommand) annotation (Line(
        points={{86,126},{106,126},{106,118},{116,118}}, color={0,0,127}));
  connect(thermostatSetpointResolution.actualSetpoint,
    custom_air_conditioner_OnOff.TCooSet) annotation (Line(points={{140,118},{
          148,118},{148,94},{88,94},{88,30.4},{98,30.4}}, color={0,0,127}));
  connect(con.y, thermostatSetpointResolution.temRes) annotation (Line(points={
          {102,160},{110,160},{110,126},{108,126},{108,110.6},{116,110.6}},
        color={0,0,127}));
  connect(mulSum.y, totalElectricPower) annotation (Line(points={{122,-42},{144,
          -42},{144,-48},{160,-48}}, color={0,0,127}));
  connect(mulSum.u[1:3], custom_air_conditioner_OnOff.electricPower)
    annotation (Line(points={{98,-41.3333},{90,-41.3333},{90,6},{164,6},{164,
          26.8},{122,26.8}},
        color={0,0,127}));
  connect(heatingOccSetpoint.y, swi1.u1) annotation (Line(points={{-62,2},{-18,
          2},{-18,-24},{-10,-24}}, color={0,0,127}));
  connect(heatingUnoccSetpoint1.y, swi1.u3) annotation (Line(points={{-36,-48},
          {-18,-48},{-18,-40},{-10,-40}}, color={0,0,127}));
  connect(booScaRep1.y, swi1.u2) annotation (Line(points={{24,126},{12,126},{12,
          4},{-10,4},{-10,-32}}, color={255,0,255}));
  connect(booScaRep.y, swi2.u2) annotation (Line(points={{-114,126},{-84,126},{
          -84,96},{-74,96}}, color={255,0,255}));
  connect(coolingShedSetpoint.y, swi2.u1) annotation (Line(points={{-158,96},{
          -88,96},{-88,104},{-74,104}}, color={0,0,127}));
  connect(coolingOccSetpoint.y, swi2.u3) annotation (Line(points={{-102,44},{
          -82,44},{-82,88},{-74,88}}, color={0,0,127}));
  connect(swi2.y, swi.u1) annotation (Line(points={{-50,96},{46,96},{46,134},{
          62,134}}, color={0,0,127}));
  connect(con.y, thermostatSetpointResolution1.temRes) annotation (Line(points=
          {{102,160},{110,160},{110,126},{108,126},{108,66},{82,66},{82,-50},{
          32,-50},{32,-73.4},{40,-73.4}}, color={0,0,127}));
  connect(swi1.y, thermostatSetpointResolution1.setpointCommand) annotation (
      Line(points={{14,-32},{30,-32},{30,-66},{40,-66}}, color={0,0,127}));
  connect(thermostatSetpointResolution1.actualSetpoint,
    custom_air_conditioner_OnOff.THeaSet) annotation (Line(points={{64,-66},{88,
          -66},{88,19.6},{98,19.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=24192000,
      StopTime=24364800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end DF_SingleSetpoint_ModulatingLoad;
