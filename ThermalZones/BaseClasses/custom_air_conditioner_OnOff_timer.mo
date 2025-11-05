within cdl_models.ThermalZones.BaseClasses;
model custom_air_conditioner_OnOff_timer

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";
    parameter Real cycling_time( unit="s")=600
    "heater cooler cycling time";
      parameter Real heater_thermal_power_nominal(unit="W")=550
    "Nominal heater power";
          parameter Real cooler_thermal_power_nominal(unit="W")=600
    "Nominal cooler power";
      parameter Real COPCoo=2.5
    "Coefficient of performance cooling";
          parameter Real COPHea=3.5
    "Coefficient of performance heating";
              parameter Real temSetHys=0.5
    "temperature setpoint hysteresis";
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mRec_flow_nominal)
    "Fan"
    annotation (Placement(transformation(extent={{-72,-52},{-52,-32}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                hea(
    redeclare final package Medium = MediumAir,
    m_flow_nominal=mRec_flow_nominal,
    dp_nominal=200,
    show_T=true,
    Q_flow_nominal=1)
    "Ideal heater"
    annotation (Placement(transformation(extent={{-34,-52},{-14,-32}})));
  Modelica.Blocks.Sources.Constant const(k=mRec_flow_nominal)
    annotation (Placement(transformation(extent={{-140,-38},{-120,-18}})));
  Controls.SeparateHeatingCoolingThermalEnergy     separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{16,-38},{36,-18}})));
  Modelica.Blocks.Continuous.Integrator coolingEnergy0(k=1/3600000)
    annotation (Placement(transformation(extent={{68,-56},{88,-36}})));
  Modelica.Blocks.Continuous.Integrator heatingEnergy0(k=1/3600000)
    annotation (Placement(transformation(extent={{66,-18},{86,2}})));
  Modelica.Blocks.Interfaces.RealInput ZAT annotation (Placement(transformation(
          extent={{-140,8},{-100,48}}),  iconTransformation(extent={{-140,8},{
            -100,48}})));
  Modelica.Blocks.Interfaces.RealOutput heatingEnergy annotation (Placement(
        transformation(extent={{100,-12},{140,28}}),iconTransformation(extent={{100,-12},
            {140,28}})));
  Modelica.Blocks.Interfaces.RealOutput coolingEnergy annotation (Placement(
        transformation(extent={{100,-54},{140,-14}}),iconTransformation(extent={{100,-54},
            {140,-14}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{-114,-84},{-94,
            -64}}), iconTransformation(extent={{-114,-84},{-94,-64}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{92,-84},{112,-64}}),
        iconTransformation(extent={{92,-84},{112,-64}})));
  Modelica.Blocks.Interfaces.RealOutput thermalPower annotation (Placement(
        transformation(extent={{100,74},{140,114}}), iconTransformation(extent={{100,68},
            {140,108}})));
  Modelica.Blocks.Interfaces.RealOutput electricPower annotation (Placement(
        transformation(extent={{100,48},{140,88}}), iconTransformation(extent={{100,28},
            {140,68}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cop_heating(final k=COPHea)
    "coefficient of performance"
    annotation (Placement(transformation(extent={{-22,140},{-2,160}})));
  Modelica.Blocks.Interfaces.RealInput TCooSet annotation (Placement(
        transformation(extent={{-140,66},{-100,106}}), iconTransformation(
          extent={{-140,64},{-100,104}})));
  Modelica.Blocks.Interfaces.RealInput THeaSet annotation (Placement(
        transformation(extent={{-140,-6},{-100,34}}), iconTransformation(extent
          ={{-140,-44},{-100,-4}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre(   h=temSetHys)
    annotation (Placement(transformation(extent={{-78,64},{-58,84}})));
  Buildings.Controls.OBC.CDL.Reals.Less les1(  h=temSetHys)
    annotation (Placement(transformation(extent={{-78,32},{-58,52}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{2,68},{22,88}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
    annotation (Placement(transformation(extent={{62,30},{82,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=
        heater_thermal_power_nominal)
    annotation (Placement(transformation(extent={{-172,68},{-152,88}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{-172,24},{-152,44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=-1*
        cooler_thermal_power_nominal)
    annotation (Placement(transformation(extent={{-170,-14},{-150,6}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cop_cooling(final k=COPCoo)
    "coefficient of performance"
    annotation (Placement(transformation(extent={{56,104},{76,124}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=cycling_time)
    annotation (Placement(transformation(extent={{14,32},{34,52}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=cycling_time)
    annotation (Placement(transformation(extent={{-34,68},{-14,88}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Divide              div1
    annotation (Placement(transformation(extent={{18,158},{38,178}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Divide              div2
    annotation (Placement(transformation(extent={{112,140},{132,160}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Add                 add2
    "50% of setpoint"
    annotation (Placement(transformation(extent={{166,108},{186,128}})));
equation
  connect(fan.port_b,hea.port_a)
    annotation (Line(points={{-52,-42},{-34,-42}},
                                                color={0,127,255}));
  connect(const.y,fan. m_flow_in) annotation (Line(points={{-119,-28},{-70,-28},
          {-70,-22},{-62,-22},{-62,-30}},
                      color={0,0,127}));
  connect(hea.Q_flow, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-13,-36},{4,-36},{4,-28},{14,-28}},  color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy,
    heatingEnergy0.u) annotation (Line(points={{38,-24.4},{54,-24.4},{54,-8},{64,
          -8}},       color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,
    coolingEnergy0.u) annotation (Line(points={{38,-33.8},{58,-33.8},{58,-46},{66,
          -46}},      color={0,0,127}));
  connect(coolingEnergy0.y, coolingEnergy) annotation (Line(points={{89,-46},{
          120,-46},{120,-34}},   color={0,0,127}));
  connect(heatingEnergy0.y, heatingEnergy) annotation (Line(points={{87,-8},{94,
          -8},{94,8},{120,8}},                                           color={
          0,0,127}));
  connect(port_a, fan.port_a) annotation (Line(points={{-104,-74},{-104,-42},{-72,
          -42}},           color={0,127,255}));
  connect(hea.port_b, port_b) annotation (Line(points={{-14,-42},{56,-42},{56,-74},
          {102,-74}},           color={0,127,255}));
  connect(port_b, port_b)
    annotation (Line(points={{102,-74},{102,-74}}, color={0,127,255}));
  connect(cop_heating.y, div1.u2)
    annotation (Line(points={{0,150},{8,150},{8,162},{16,162}},
                                                          color={0,0,127}));
  connect(hea.Q_flow, thermalPower) annotation (Line(points={{-13,-36},{-8,-36},
          {-8,94},{120,94}}, color={0,0,127}));
  connect(ZAT, gre.u1) annotation (Line(points={{-120,28},{-120,62},{-88,62},{-88,
          74},{-80,74}}, color={0,0,127}));
  connect(TCooSet, gre.u2) annotation (Line(points={{-120,86},{-120,56},{-80,56},
          {-80,66}}, color={0,0,127}));
  connect(ZAT, les1.u1) annotation (Line(points={{-120,28},{-88,28},{-88,42},{-80,
          42}}, color={0,0,127}));
  connect(THeaSet, les1.u2)
    annotation (Line(points={{-120,14},{-80,14},{-80,34}}, color={0,0,127}));
  connect(swi.y, swi1.u3) annotation (Line(points={{24,78},{52,78},{52,32},{60,
          32}}, color={0,0,127}));
  connect(con.y, swi1.u1) annotation (Line(points={{-150,78},{-150,58},{32,58},
          {32,80},{60,80},{60,48}},
                    color={0,0,127}));
  connect(con2.y, swi.u1) annotation (Line(points={{-148,-4},{-148,18},{-142,18},
          {-142,50},{-92,50},{-92,90},{-46,90},{-46,86},{0,86}},   color={0,0,
          127}));
  connect(con1.y, swi.u3) annotation (Line(points={{-150,34},{-150,56},{-116,56},
          {-116,60},{-46,60},{-46,70},{0,70}},   color={0,0,127}));
  connect(swi1.y, hea.u) annotation (Line(points={{84,40},{92,40},{92,24},{-46,
          24},{-46,-36},{-36,-36}},
                      color={0,0,127}));
  connect(cop_cooling.y, div2.u2) annotation (Line(points={{78,114},{96,114},{96,
          144},{110,144}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy, div1.u1)
    annotation (Line(points={{38,-24.4},{54,-24.4},{54,96},{48,96},{48,184},{16,
          184},{16,174}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy, div2.u1)
    annotation (Line(points={{38,-33.8},{50,-33.8},{50,156},{110,156}}, color={0,
          0,127}));
  connect(div1.y, add2.u1) annotation (Line(points={{40,168},{154,168},{154,124},
          {164,124}}, color={0,0,127}));
  connect(div2.y, add2.u2) annotation (Line(points={{134,150},{152,150},{152,112},
          {164,112}}, color={0,0,127}));
  connect(add2.y, electricPower) annotation (Line(points={{188,118},{194,118},{194,
          68},{120,68}}, color={0,0,127}));
  connect(les1.y, truDel.u)
    annotation (Line(points={{-56,42},{12,42}}, color={255,0,255}));
  connect(truDel.y, swi1.u2) annotation (Line(points={{36,42},{48,42},{48,40},{
          60,40}}, color={255,0,255}));
  connect(gre.y, truDel1.u) annotation (Line(points={{-56,74},{-40,74},{-40,78},
          {-36,78}}, color={255,0,255}));
  connect(truDel1.y, swi.u2)
    annotation (Line(points={{-12,78},{0,78}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end custom_air_conditioner_OnOff_timer;
