within cdl_models.Examples;
model DF_SimpleRatchet_OnOffLoad_1Zone
    extends Modelica.Icons.Example;
           parameter Integer nZones=5;
replaceable package MediumAir = Buildings.Media.Air;
          parameter Real TCooSetOcc(unit="K")=273.15 + 25.56
    "Zone cooling temperature setpoint";
        parameter Real THeaSetOcc(unit="K")=273.15 + 22.22
    "Zone heating temperature setpoint";
              parameter Real TCooSetUnocc(unit="K")=273.15+32.22
    "Zone cooling temperature setpoint";
        parameter Real THeaSetUnocc(unit="K")=273.15+15.56
    "Zone heating temperature setpoint";

  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable occupancyMode(
    table=[0,0; 7,1; 20,0; 24,0],
    timeScale=3600,
    period=86400)
    annotation (Placement(transformation(extent={{-88,56},{-68,76}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://cdl_models/Resources/weatherdata/HAF_epw_modified_5mins.mos"))
    annotation (Placement(transformation(extent={{-100,-84},{-80,-64}})));
  ThermalZones.building_5_zone building_5_zone
    annotation (Placement(transformation(extent={{58,-84},{78,-62}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution thermostatSetpointResolutionCoo[5]
    annotation (Placement(transformation(extent={{78,80},{98,100}})));
  ThermalZones.BaseClasses.custom_air_conditioner_OnOff_timer
    custom_air_conditioner_OnOff_timer[5]
    annotation (Placement(transformation(extent={{76,-4},{96,16}})));
  Controls.multiple_zone_ratchet multiple_zone_ratchet(
    nZones=5,
    TZonHeaSetNomOcc=THeaSetOcc,
    TZonHeaSetNomUnocc=THeaSetUnocc,
    TZonCooSetNomOcc=TCooSetOcc,
    TZonCooSetNomUnocc=TCooSetUnocc,
    loadShedDurationTypical(displayUnit="h"),
    loadShedTempAmount=5)
               annotation (Placement(transformation(extent={{22,60},{60,92}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1[5](k={0.5556,0.5556,0.5556,
        0.5556,0.5556})
    annotation (Placement(transformation(extent={{38,110},{58,130}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel[5](samplePeriod=10,
      y_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,42})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=5)
    annotation (Placement(transformation(extent={{156,-122},{176,-102}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        totalElectricPower
    annotation (Placement(transformation(extent={{206,-128},{226,-108}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution thermostatSetpointResolutionHea[5]
    annotation (Placement(transformation(extent={{132,116},{152,136}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel1
                                                      [5](samplePeriod=10,
      y_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={146,48})));
  ThermalZones.BaseClasses.custom_air_conditioner_OnOff_timer custom_air_conditioner_OnOff_timer_baseline[5]
    annotation (Placement(transformation(extent={{168,-172},{188,-152}})));
  ThermalZones.building_5_zone building_5_zone_baseline
    annotation (Placement(transformation(extent={{186,-214},{206,-192}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum1(nin=5)
    annotation (Placement(transformation(extent={{280,-190},{300,-170}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput totalElectricPower_baseline
    annotation (Placement(transformation(extent={{330,-196},{350,-176}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=THeaSetOcc)
    annotation (Placement(transformation(extent={{-174,-176},{-154,-156}})));
  Buildings.Controls.OBC.CDL.Reals.Switch THeaSet
    annotation (Placement(transformation(extent={{-114,-184},{-94,-164}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con6(k=THeaSetUnocc)
    annotation (Placement(transformation(extent={{-168,-214},{-148,-194}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=TCooSetOcc)
    annotation (Placement(transformation(extent={{-172,-256},{-152,-236}})));
  Buildings.Controls.OBC.CDL.Reals.Switch TCooSet
    annotation (Placement(transformation(extent={{-118,-282},{-98,-262}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con7(k=TCooSetUnocc)
    annotation (Placement(transformation(extent={{-160,-292},{-140,-272}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=5)
    annotation (Placement(transformation(extent={{-76,-180},{-56,-160}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep1(nout=5)
    annotation (Placement(transformation(extent={{-78,-280},{-58,-260}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution thermostatSetpointResolutionHea_baseline[5]
    annotation (Placement(transformation(extent={{-16,-218},{4,-198}})));
  ThermalZones.BaseClasses.thermostatSetpointResolution thermostatSetpointResolutionCoo_baseline[5]
    annotation (Placement(transformation(extent={{-4,-286},{16,-266}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2[5](k={0.5556,0.5556,
        0.5556,0.5556,0.5556})
    annotation (Placement(transformation(extent={{-98,-344},{-78,-324}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel2
                                                      [5](samplePeriod=10,
      y_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={48,-214})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel3
                                                      [5](samplePeriod=10,
      y_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={56,-268})));
equation
  connect(con1.y, thermostatSetpointResolutionCoo.temRes) annotation (Line(
        points={{60,120},{108,120},{108,72},{76,72},{76,82.6}}, color={0,0,127}));
  connect(custom_air_conditioner_OnOff_timer.port_b, building_5_zone.port_a)
    annotation (Line(points={{96.2,-1.4},{96.2,-10},{74,-10},{74,-52},{50,-52},{
          50,-66.62},{58.2,-66.62}}, color={0,127,255}));
  connect(custom_air_conditioner_OnOff_timer.port_a, building_5_zone.port_b)
    annotation (Line(points={{75.6,-1.4},{75.6,-24},{96,-24},{96,-68},{82,-68},{
          82,-66.62},{78.2,-66.62}}, color={0,127,255}));
  connect(building_5_zone.TZon, custom_air_conditioner_OnOff_timer.ZAT)
    annotation (Line(points={{79,-72.78},{96,-72.78},{96,-24},{30,-24},{30,8.8},
          {74,8.8}}, color={0,0,127}));
  connect(building_5_zone.TZon, multiple_zone_ratchet.TZon) annotation (Line(
        points={{79,-72.78},{96,-72.78},{96,-24},{-8,-24},{-8,80.5091},{20.5071,
          80.5091}},
        color={0,0,127}));
  connect(weaDat1.weaBus,building_5_zone. weaBus) annotation (Line(
      points={{-80,-74},{52,-74},{52,-76.96},{57.4,-76.96}},
      color={255,204,51},
      thickness=0.5));
  connect(multiple_zone_ratchet.TZonCooSetCom, thermostatSetpointResolutionCoo.setpointCommand)
    annotation (Line(points={{61.3571,66.5455},{122,66.5455},{122,100},{104,100},
          {104,106},{76,106},{76,90}},
                         color={0,0,127}));
  connect(thermostatSetpointResolutionCoo.actualSetpoint, uniDel.u) annotation (
     Line(points={{100,90},{110,90},{110,42},{98,42}}, color={0,0,127}));
  connect(uniDel.y, custom_air_conditioner_OnOff_timer.TCooSet) annotation (
      Line(points={{74,42},{60,42},{60,14.4},{74,14.4}}, color={0,0,127}));
  connect(uniDel.y, multiple_zone_ratchet.TZonCooSetCur)
    annotation (Line(points={{74,42},{8,42},{8,75.7091},{20.6429,75.7091}},
                                                             color={0,0,127}));
  connect(mulSum.u[1:5], custom_air_conditioner_OnOff_timer.electricPower)
    annotation (Line(points={{154,-111.2},{146,-111.2},{146,-64},{220,-64},{220,
          10.8},{98,10.8}}, color={0,0,127}));
  connect(mulSum.y,totalElectricPower)  annotation (Line(points={{178,-112},{
          200,-112},{200,-118},{216,-118}},
                                     color={0,0,127}));
  connect(con1.y, thermostatSetpointResolutionHea.temRes) annotation (Line(
        points={{60,120},{122,120},{122,118.6},{130,118.6}}, color={0,0,127}));
  connect(multiple_zone_ratchet.TZonHeaSetCom, thermostatSetpointResolutionHea.setpointCommand)
    annotation (Line(points={{61.3571,78.7636},{61.3571,104},{32,104},{32,136},
          {122,136},{122,126},{130,126}},
                               color={0,0,127}));
  connect(thermostatSetpointResolutionHea.actualSetpoint, uniDel1.u)
    annotation (Line(points={{154,126},{166,126},{166,48},{158,48}}, color={0,0,
          127}));
  connect(uniDel1.y, multiple_zone_ratchet.TZonHeaSetCur) annotation (Line(
        points={{134,48},{76,48},{76,78.1818},{20.5071,78.1818}},
                                                         color={0,0,127}));
  connect(uniDel1.y, custom_air_conditioner_OnOff_timer.THeaSet) annotation (
      Line(points={{134,48},{126,48},{126,24},{58,24},{58,3.6},{74,3.6}}, color
        ={0,0,127}));
  connect(occupancyMode.y[1], multiple_zone_ratchet.occSta) annotation (Line(
        points={{-66,66},{-58,66},{-58,87.2},{20.6429,87.2}},
                                                         color={255,0,255}));
  connect(custom_air_conditioner_OnOff_timer_baseline.port_a,
    building_5_zone_baseline.port_b) annotation (Line(points={{167.6,-169.4},{
          167.6,-220},{212,-220},{212,-196.62},{206.2,-196.62}},
                                             color={0,127,255}));
  connect(custom_air_conditioner_OnOff_timer_baseline.port_b,
    building_5_zone_baseline.port_a) annotation (Line(points={{188.2,-169.4},{
          188.2,-186},{180,-186},{180,-196.62},{186.2,-196.62}},
                                                        color={0,127,255}));
  connect(building_5_zone_baseline.TZon,
    custom_air_conditioner_OnOff_timer_baseline.ZAT) annotation (Line(points={{207,
          -202.78},{214,-202.78},{214,-144},{158,-144},{158,-159.2},{166,-159.2}},
        color={0,0,127}));
  connect(weaDat1.weaBus, building_5_zone_baseline.weaBus) annotation (Line(
      points={{-80,-74},{52,-74},{52,-178},{176,-178},{176,-206.96},{185.4,
          -206.96}},
      color={255,204,51},
      thickness=0.5));
  connect(mulSum1.y, totalElectricPower_baseline) annotation (Line(points={{302,
          -180},{324,-180},{324,-186},{340,-186}}, color={0,0,127}));
  connect(custom_air_conditioner_OnOff_timer_baseline.electricPower, mulSum1.u[1
    :5]) annotation (Line(points={{190,-157.2},{268,-157.2},{268,-179.2},{278,
          -179.2}},
        color={0,0,127}));
  connect(con4.y, THeaSet.u1)
    annotation (Line(points={{-152,-166},{-116,-166}}, color={0,0,127}));
  connect(con6.y, THeaSet.u3) annotation (Line(points={{-146,-204},{-124,-204},
          {-124,-182},{-116,-182}}, color={0,0,127}));
  connect(con5.y, TCooSet.u1) annotation (Line(points={{-150,-246},{-128,-246},
          {-128,-264},{-120,-264}}, color={0,0,127}));
  connect(con7.y, TCooSet.u3) annotation (Line(points={{-138,-282},{-128,-282},
          {-128,-280},{-120,-280}}, color={0,0,127}));
  connect(THeaSet.y, reaScaRep.u) annotation (Line(points={{-92,-174},{-92,-154},
          {-78,-154},{-78,-170}}, color={0,0,127}));
  connect(TCooSet.y, reaScaRep1.u) annotation (Line(points={{-96,-272},{-88,
          -272},{-88,-270},{-80,-270}}, color={0,0,127}));
  connect(occupancyMode.y[1], THeaSet.u2) annotation (Line(points={{-66,66},{
          -58,66},{-58,-56},{-126,-56},{-126,-174},{-116,-174}}, color={255,0,
          255}));
  connect(occupancyMode.y[1], TCooSet.u2) annotation (Line(points={{-66,66},{
          -58,66},{-58,-56},{-126,-56},{-126,-256},{-130,-256},{-130,-272},{
          -120,-272}}, color={255,0,255}));
  connect(con2.y, thermostatSetpointResolutionHea_baseline.temRes) annotation (
      Line(points={{-76,-334},{-26,-334},{-26,-215.4},{-18,-215.4}}, color={0,0,
          127}));
  connect(con2.y, thermostatSetpointResolutionCoo_baseline.temRes) annotation (
      Line(points={{-76,-334},{-26,-334},{-26,-283.4},{-6,-283.4}}, color={0,0,
          127}));
  connect(reaScaRep.y, thermostatSetpointResolutionHea_baseline.setpointCommand)
    annotation (Line(points={{-54,-170},{-42,-170},{-42,-208},{-18,-208}},
        color={0,0,127}));
  connect(reaScaRep1.y, thermostatSetpointResolutionCoo_baseline.setpointCommand)
    annotation (Line(points={{-56,-270},{-16,-270},{-16,-276},{-6,-276}}, color
        ={0,0,127}));
  connect(thermostatSetpointResolutionHea_baseline.actualSetpoint, uniDel2.u)
    annotation (Line(points={{6,-208},{26,-208},{26,-214},{36,-214}}, color={0,
          0,127}));
  connect(thermostatSetpointResolutionCoo_baseline.actualSetpoint, uniDel3.u)
    annotation (Line(points={{18,-276},{36,-276},{36,-268},{44,-268}}, color={0,
          0,127}));
  connect(uniDel2.y, custom_air_conditioner_OnOff_timer_baseline.THeaSet)
    annotation (Line(points={{60,-214},{68,-214},{68,-164.4},{166,-164.4}},
        color={0,0,127}));
  connect(uniDel3.y, custom_air_conditioner_OnOff_timer_baseline.TCooSet)
    annotation (Line(points={{68,-268},{104,-268},{104,-153.6},{166,-153.6}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=0,
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end DF_SimpleRatchet_OnOffLoad_1Zone;
