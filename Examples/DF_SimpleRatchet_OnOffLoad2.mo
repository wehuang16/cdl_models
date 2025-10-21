within cdl_models.Examples;
model DF_SimpleRatchet_OnOffLoad2
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
                                         loadShedMode(
    table=[0,0; 14,1; 18,0; 24,0],
    timeScale=3600,                          period=86400)
    annotation (Placement(transformation(extent={{-88,56},{-68,76}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://cdl_models/Resources/weatherdata/HAF_epw_modified_5mins.mos"))
    annotation (Placement(transformation(extent={{-100,-84},{-80,-64}})));
  ThermalZones.building_3_zone building_3_zone
    annotation (Placement(transformation(extent={{58,-84},{78,-62}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution thermostatSetpointResolutionCoo[3]
    annotation (Placement(transformation(extent={{78,80},{98,100}})));
  ThermalZones.BaseClasses.custom_air_conditioner_OnOff
    custom_air_conditioner_OnOff[3]
    annotation (Placement(transformation(extent={{76,-4},{96,16}})));
  Controls.multiple_zone_ratchet multiple_zone_ratchet(
    nZones=3,
    loadShedDurationTypical(displayUnit="h") = 14400,
    TRatThreshold=1)
               annotation (Placement(transformation(extent={{22,60},{60,92}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1[3](k={1,1,1})
    annotation (Placement(transformation(extent={{38,110},{58,130}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable heatingSetpoint(
    table=[0,273.15 + 12; 7,273.15 + 20; 19,273.15 + 12; 24,273.15 + 12],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-210,66},{-190,86}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable coolingSetpoint(
    table=[0,273.15 + 32; 7,273.15 + 25; 19,273.15 + 32; 24,273.15 + 32],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-220,-8},{-200,12}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{-140,8},{-120,28}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-150,40},{-130,60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=5)
    annotation (Placement(transformation(extent={{-202,38},{-182,58}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel[3](samplePeriod=10,
      y_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,42})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=3)
    annotation (Placement(transformation(extent={{156,-122},{176,-102}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        totalElectricPower
    annotation (Placement(transformation(extent={{206,-128},{226,-108}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution thermostatSetpointResolutionHea[3]
    annotation (Placement(transformation(extent={{132,116},{152,136}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel1
                                                      [3](samplePeriod=10,
      y_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={146,48})));
equation
  connect(loadShedMode.y[1], multiple_zone_ratchet.loaShe) annotation (Line(
        points={{-66,66},{10,66},{10,85.6},{20,85.6}},
                                                     color={255,0,255}));
  connect(con1.y, thermostatSetpointResolutionCoo.temRes) annotation (Line(
        points={{60,120},{108,120},{108,72},{76,72},{76,82.6}}, color={0,0,127}));
  connect(custom_air_conditioner_OnOff.port_b, building_3_zone.port_a)
    annotation (Line(points={{96.2,-1.4},{96.2,-10},{74,-10},{74,-52},{50,-52},{
          50,-66.62},{58.2,-66.62}}, color={0,127,255}));
  connect(custom_air_conditioner_OnOff.port_a, building_3_zone.port_b)
    annotation (Line(points={{75.6,-1.4},{75.6,-24},{96,-24},{96,-68},{82,-68},{
          82,-66.62},{78.2,-66.62}}, color={0,127,255}));
  connect(building_3_zone.TZon, custom_air_conditioner_OnOff.ZAT) annotation (
      Line(points={{79,-72.78},{96,-72.78},{96,-24},{30,-24},{30,8.8},{74,8.8}},
        color={0,0,127}));
  connect(building_3_zone.TZon, multiple_zone_ratchet.TZon) annotation (Line(
        points={{79,-72.78},{96,-72.78},{96,-24},{-8,-24},{-8,80.6},{19.8,80.6}},
        color={0,0,127}));
  connect(heatingSetpoint.y[1], sub.u1) annotation (Line(points={{-188,76},{-162,
          76},{-162,56},{-152,56}}, color={0,0,127}));
  connect(con2.y, sub.u2) annotation (Line(points={{-180,48},{-172,48},{-172,44},
          {-152,44}}, color={0,0,127}));
  connect(coolingSetpoint.y[1], add2.u1) annotation (Line(points={{-198,2},{-158,
          2},{-158,24},{-142,24}}, color={0,0,127}));
  connect(con2.y, add2.u2) annotation (Line(points={{-180,48},{-172,48},{-172,44},
          {-160,44},{-160,12},{-142,12}}, color={0,0,127}));
  connect(heatingSetpoint.y[1], multiple_zone_ratchet.TZonHeaSetNom)
    annotation (Line(points={{-188,76},{-94,76},{-94,50},{-58,50},{-58,64},{14,64},
          {14,66.8},{19.8,66.8}}, color={0,0,127}));
  connect(coolingSetpoint.y[1], multiple_zone_ratchet.TZonCooSetNom)
    annotation (Line(points={{-198,2},{12,2},{12,59.8},{20,59.8}}, color={0,0,127}));
  connect(weaDat1.weaBus, building_3_zone.weaBus) annotation (Line(
      points={{-80,-74},{52,-74},{52,-76.96},{57.4,-76.96}},
      color={255,204,51},
      thickness=0.5));
  connect(multiple_zone_ratchet.TZonCooSetCom, thermostatSetpointResolutionCoo.setpointCommand)
    annotation (Line(points={{62,69},{122,69},{122,100},{104,100},{104,106},{76,
          106},{76,90}}, color={0,0,127}));
  connect(sub.y, multiple_zone_ratchet.TZonHeaSetMin) annotation (Line(points={
          {-128,50},{-120,50},{-120,82},{12,82},{12,70.4},{19.8,70.4}}, color={
          0,0,127}));
  connect(add2.y, multiple_zone_ratchet.TZonCooSetMax) annotation (Line(points=
          {{-118,18},{10,18},{10,62},{14,62},{14,63.4},{19.8,63.4}}, color={0,0,
          127}));
  connect(thermostatSetpointResolutionCoo.actualSetpoint, uniDel.u) annotation
    (Line(points={{100,90},{110,90},{110,42},{98,42}}, color={0,0,127}));
  connect(uniDel.y, custom_air_conditioner_OnOff.TCooSet) annotation (Line(
        points={{74,42},{60,42},{60,14.4},{74,14.4}}, color={0,0,127}));
  connect(uniDel.y, multiple_zone_ratchet.TZonCooSetCur)
    annotation (Line(points={{74,42},{8,42},{8,74},{20,74}}, color={0,0,127}));
  connect(mulSum.u[1:3], custom_air_conditioner_OnOff.electricPower)
    annotation (Line(points={{154,-111.333},{146,-111.333},{146,-64},{220,-64},
          {220,10.8},{98,10.8}},
        color={0,0,127}));
  connect(mulSum.y,totalElectricPower)  annotation (Line(points={{178,-112},{
          200,-112},{200,-118},{216,-118}},
                                     color={0,0,127}));
  connect(con1.y, thermostatSetpointResolutionHea.temRes) annotation (Line(
        points={{60,120},{122,120},{122,118.6},{130,118.6}}, color={0,0,127}));
  connect(multiple_zone_ratchet.TZonHeaSetCom, thermostatSetpointResolutionHea.setpointCommand)
    annotation (Line(points={{62,85.8},{62,104},{32,104},{32,136},{122,136},{
          122,126},{130,126}}, color={0,0,127}));
  connect(thermostatSetpointResolutionHea.actualSetpoint, uniDel1.u)
    annotation (Line(points={{154,126},{166,126},{166,48},{158,48}}, color={0,0,
          127}));
  connect(uniDel1.y, multiple_zone_ratchet.TZonHeaSetCur) annotation (Line(
        points={{134,48},{76,48},{76,77.4},{19.8,77.4}}, color={0,0,127}));
  connect(uniDel1.y, custom_air_conditioner_OnOff.THeaSet) annotation (Line(
        points={{134,48},{126,48},{126,24},{58,24},{58,3.6},{74,3.6}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=0,
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end DF_SimpleRatchet_OnOffLoad2;
