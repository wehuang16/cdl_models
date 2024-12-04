within cdl_models.Examples.BaseClasses;
model custom_air_conditioner

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";



          parameter Real heater_thermal_power_nominal(unit="W")=550
    "Nominal heater power";
          parameter Real cooler_thermal_power_nominal(unit="W")=600
    "Nominal cooler power";
      parameter Real COPCoo=2.5
    "Coefficient of performance cooling";
          parameter Real COPHea=3.5
    "Coefficient of performance heating";
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
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(
    kCooCon=0.3,
    TiCooCon=300,
    kHeaCon=0.3,
    TiHeaCon=300)
    annotation (Placement(transformation(extent={{-10,56},{10,76}})));
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
  Modelica.Blocks.Interfaces.RealInput TCooSet annotation (Placement(
        transformation(extent={{-140,66},{-100,106}}), iconTransformation(
          extent={{-140,64},{-100,104}})));
  Modelica.Blocks.Interfaces.RealInput THeaSet annotation (Placement(
        transformation(extent={{-140,-6},{-100,34}}), iconTransformation(extent
          ={{-140,-44},{-100,-4}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{46,40},{66,60}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold
                                           greThr(t=0, h=0)
    annotation (Placement(transformation(extent={{222,40},{242,60}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{254,42},{274,62}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=
        heater_thermal_power_nominal)
    annotation (Placement(transformation(extent={{178,66},{198,86}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=
        cooler_thermal_power_nominal)
    annotation (Placement(transformation(extent={{180,14},{200,34}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cop_heating(final k=COPHea)
    "coefficient of performance"
    annotation (Placement(transformation(extent={{6,176},{26,196}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cop_cooling(final k=COPCoo)
    "coefficient of performance"
    annotation (Placement(transformation(extent={{84,140},{104,160}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Divide              div1
    annotation (Placement(transformation(extent={{46,194},{66,214}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Divide              div2
    annotation (Placement(transformation(extent={{140,176},{160,196}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Add                 add2
    "50% of setpoint"
    annotation (Placement(transformation(extent={{192,138},{212,158}})));
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
  connect(conLoo.TZon, ZAT) annotation (Line(points={{-12,66},{-94,66},{-94,28},
          {-120,28}},color={0,0,127}));
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
  connect(hea.Q_flow, thermalPower) annotation (Line(points={{-13,-36},{-8,-36},
          {-8,94},{120,94}}, color={0,0,127}));
  connect(conLoo.TCooSet, TCooSet)
    annotation (Line(points={{-12,72},{-12,86},{-120,86}}, color={0,0,127}));
  connect(conLoo.THeaSet, THeaSet) annotation (Line(points={{-12,60},{-12,22},{
          -94,22},{-94,14},{-120,14}}, color={0,0,127}));
  connect(conLoo.yHea, sub.u1) annotation (Line(points={{12,60},{34,60},{34,56},
          {44,56}}, color={0,0,127}));
  connect(conLoo.yCoo, sub.u2) annotation (Line(points={{12,72},{28,72},{28,44},
          {44,44}}, color={0,0,127}));
  connect(sub.y, greThr.u) annotation (Line(points={{68,50},{68,34},{178,34},{178,
          38},{180,38},{180,50},{220,50}}, color={0,0,127}));
  connect(greThr.y, swi.u2)
    annotation (Line(points={{244,50},{244,52},{252,52}}, color={255,0,255}));
  connect(sub.y, gai.u) annotation (Line(points={{68,50},{68,34},{178,34},{178,38},
          {180,38},{180,60},{168,60},{168,76},{176,76}}, color={0,0,127}));
  connect(sub.y, gai1.u) annotation (Line(points={{68,50},{68,34},{170,34},{170,
          24},{178,24}}, color={0,0,127}));
  connect(gai.y, swi.u1)
    annotation (Line(points={{200,76},{252,76},{252,60}}, color={0,0,127}));
  connect(gai1.y, swi.u3)
    annotation (Line(points={{202,24},{252,24},{252,44}}, color={0,0,127}));
  connect(swi.y, hea.u) annotation (Line(points={{276,52},{292,52},{292,-88},{-36,
          -88},{-36,-36}}, color={0,0,127}));
  connect(cop_heating.y,div1. u2)
    annotation (Line(points={{28,186},{36,186},{36,198},{44,198}},
                                                          color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy,div1. u1)
    annotation (Line(points={{38,-24.4},{54,-24.4},{54,34},{36,34},{36,210},{44,
          210}},          color={0,0,127}));
  connect(div1.y, add2.u1) annotation (Line(points={{68,204},{184,204},{184,162},
          {182,162},{182,154},{190,154}},
                      color={0,0,127}));
  connect(div2.y, add2.u2) annotation (Line(points={{162,186},{178,186},{178,142},
          {190,142}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,div2. u1)
    annotation (Line(points={{38,-33.8},{50,-33.8},{50,38},{148,38},{148,170},{130,
          170},{130,192},{138,192}},                                    color={0,
          0,127}));
  connect(cop_cooling.y,div2. u2) annotation (Line(points={{106,150},{128,150},{
          128,180},{138,180}},
                           color={0,0,127}));
  connect(add2.y, electricPower) annotation (Line(points={{214,148},{222,148},{222,
          130},{120,130},{120,68}},
                         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end custom_air_conditioner;
