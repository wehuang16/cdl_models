within cdl_models.Examples.BaseClasses;
model custom_air_conditioner

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

      parameter Modelica.Units.SI.Power heater_cooler_power_nominal=5000
    "Nominal heater and cooler power";
      parameter Real COP=3
    "Coefficient of performance";
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
  Modelica.Blocks.Math.Gain        gain(k=heater_cooler_power_nominal)
    annotation (Placement(transformation(extent={{-52,-6},{-32,14}})));
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(
    kCooCon=0.3,
    TiCooCon=300,
    kHeaCon=0.3,
    TiHeaCon=300)
    annotation (Placement(transformation(extent={{-10,56},{10,76}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{24,-2},{44,18}})));
  CCC.Controls.SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cop_value(final k=COP)
    "coefficient of performance"
    annotation (Placement(transformation(extent={{18,124},{38,144}})));
  Buildings.Controls.OBC.CDL.Reals.Abs abs1
    annotation (Placement(transformation(extent={{80,146},{100,166}})));
  Modelica.Blocks.Interfaces.RealInput TCooSet annotation (Placement(
        transformation(extent={{-140,66},{-100,106}}), iconTransformation(
          extent={{-140,64},{-100,104}})));
  Modelica.Blocks.Interfaces.RealInput THeaSet annotation (Placement(
        transformation(extent={{-140,-6},{-100,34}}), iconTransformation(extent
          ={{-140,-44},{-100,-4}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Divide              div1
    "50% of setpoint"
    annotation (Placement(transformation(extent={{42,146},{62,166}})));
equation
  connect(fan.port_b,hea.port_a)
    annotation (Line(points={{-52,-42},{-34,-42}},
                                                color={0,127,255}));
  connect(const.y,fan. m_flow_in) annotation (Line(points={{-119,-28},{-70,-28},
          {-70,-22},{-62,-22},{-62,-30}},
                      color={0,0,127}));
  connect(gain.y,hea. u)
    annotation (Line(points={{-31,4},{-28,4},{-28,-28},{-36,-28},{-36,-36}},
                                                          color={0,0,127}));
  connect(conLoo.yCoo,add. u1) annotation (Line(points={{12,72},{20,72},{20,22},
          {22,22},{22,14}},
                    color={0,0,127}));
  connect(conLoo.yHea,add. u2) annotation (Line(points={{12,60},{12,2},{22,2}},
                     color={0,0,127}));
  connect(add.y,gain. u) annotation (Line(points={{45,8},{52,8},{52,-8},{-26,-8},
          {-26,18},{-64,18},{-64,4},{-54,4}},
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
  connect(cop_value.y, div1.u2)
    annotation (Line(points={{40,134},{40,150}}, color={0,0,127}));
  connect(div1.y, abs1.u)
    annotation (Line(points={{64,156},{78,156}}, color={0,0,127}));
  connect(abs1.y, electricPower) annotation (Line(points={{102,156},{162,156},{162,
          68},{120,68}}, color={0,0,127}));
  connect(hea.Q_flow, thermalPower) annotation (Line(points={{-13,-36},{-8,-36},
          {-8,94},{120,94}}, color={0,0,127}));
  connect(hea.Q_flow, div1.u1) annotation (Line(points={{-13,-36},{6,-36},{6,162},
          {40,162}}, color={0,0,127}));
  connect(conLoo.TCooSet, TCooSet)
    annotation (Line(points={{-12,72},{-12,86},{-120,86}}, color={0,0,127}));
  connect(conLoo.THeaSet, THeaSet) annotation (Line(points={{-12,60},{-12,22},{
          -94,22},{-94,14},{-120,14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end custom_air_conditioner;
