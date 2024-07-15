within cdl_models.Examples;
model demand_flexibility_ratchet_simple
    extends Modelica.Icons.Example;

replaceable package MediumAir = Buildings.Media.Air;
          parameter Real TCooSet(unit="K")=273.15+21
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+18
    "Zone heating temperature setpoint";
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TRat(final k=8)
    "Ratchet Amount"
    annotation (Placement(transformation(extent={{-74,18},{-54,38}})));
  Controls.DF_Controller_ratchet_simple dF_Controller(TZonSetNominal(
        displayUnit="degC") = TCooSet,TMaxSet(displayUnit="degC") = 300.15)
    annotation (Placement(transformation(extent={{10,8},{30,28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TReb(final k=8)
    "Rebound Amount"
    annotation (Placement(transformation(extent={{-42,-6},{-22,14}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0,273.15 + 20.5,250; 10800,0,273.15 + 20.5,500; 21600,1,273.15 +
        20.5,500; 27000,1,273.15 + 24,0; 32400,1,273.15 + 24,0.0; 43200,1,
        273.15 + 25,0.0; 54000,1,273.15 + 26,0.0; 64800,0,273.15 + 20.5,0.0;
        75600,0,273.15 + 20.5,0.0; 86400,0,273.15 + 20.5,0.0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-142,32},{-122,52}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-38,58},{-18,78}})));
  ThermalZones.ModelicaRoom modelicaRoom
    annotation (Placement(transformation(extent={{112,-64},{154,-34}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                   hea(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.5,
    dp_nominal=1,
    T_start=289.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=5000)       "Cooler"
    annotation (Placement(transformation(extent={{28,-94},{48,-74}})));
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(TiCooCon=
        60, TiHeaCon=60)
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant COP(final k=-3)
    "coefficient of performance"
    annotation (Placement(transformation(extent={{50,-22},{70,-2}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const1(final k=THeaSet)
    "Ratchet Amount"
    annotation (Placement(transformation(extent={{-120,-86},{-100,-66}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={198,-55})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{66,-94},{86,-74}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const2(final k=0.5)
    "Ratchet Amount"
    annotation (Placement(transformation(extent={{42,-62},{62,-42}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingLoad
    annotation (Placement(transformation(extent={{116,34},{136,54}})));
  Modelica.Blocks.Interfaces.RealOutput ElectricPower
    annotation (Placement(transformation(extent={{118,6},{138,26}})));
protected
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(final k=-1)
    "50% of setpoint"
    annotation (Placement(transformation(extent={{-36,-84},{-16,-64}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Divide              div1
    "50% of setpoint"
    annotation (Placement(transformation(extent={{74,0},{94,20}})));
equation
  connect(TRat.y, dF_Controller.TRat) annotation (Line(points={{-52,28},{-2,28},
          {-2,20},{8,20}}, color={0,0,127}));
  connect(TReb.y, dF_Controller.TReb) annotation (Line(points={{-20,4},{-2,4},
          {-2,15.2},{8,15.2}}, color={0,0,127}));
  connect(combiTimeTable.y[1], realToBoolean.u)
    annotation (Line(points={{-121,42},{-118,42},{-118,68},{-40,68}},
                                                 color={0,0,127}));
  connect(realToBoolean.y, dF_Controller.loadShed)
    annotation (Line(points={{-17,68},{8,68},{8,26}}, color={255,0,255}));
  connect(modelicaRoom.ZoneTAir2, dF_Controller.TZon) annotation (Line(points={{131.6,
          -33},{131.6,-28},{8,-28},{8,10}}, color={0,0,127}));
  connect(modelicaRoom.port_b2, hea.port_a) annotation (Line(points={{154.4,
          -45.2},{158,-45.2},{158,-100},{24,-100},{24,-84},{28,-84}}, color={0,
          127,255}));
  connect(const1.y, conLoo.THeaSet) annotation (Line(points={{-98,-76},{-78,-76},
          {-78,-66},{-70,-66}}, color={0,0,127}));
  connect(modelicaRoom.ZoneTAir2, conLoo.TZon) annotation (Line(points={{131.6,
          -33},{131.6,-28},{-80,-28},{-80,-60},{-70,-60}}, color={0,0,127}));
  connect(conLoo.yCoo, gai1.u) annotation (Line(points={{-46,-54},{-6,-54},{-6,
          -90},{-48,-90},{-48,-74},{-38,-74}}, color={0,0,127}));
  connect(gai1.y, hea.u) annotation (Line(points={{-14,-74},{16,-74},{16,-78},{
          26,-78}}, color={0,0,127}));
  connect(modelicaRoom.port_b2, boundary2.ports[1]) annotation (Line(points={{
          154.4,-45.2},{158,-45.2},{158,-55},{188,-55}}, color={0,127,255}));
  connect(hea.port_b, mov.port_a)
    annotation (Line(points={{48,-84},{66,-84}}, color={0,127,255}));
  connect(mov.port_b, modelicaRoom.port_a2) annotation (Line(points={{86,-84},{
          102,-84},{102,-45.6},{111.4,-45.6}}, color={0,127,255}));
  connect(const2.y, mov.m_flow_in)
    annotation (Line(points={{64,-52},{76,-52},{76,-72}}, color={0,0,127}));
  connect(dF_Controller.TZonSet, conLoo.TCooSet) annotation (Line(points={{32,
          18},{40,18},{40,-18},{-92,-18},{-92,-54},{-70,-54}}, color={0,0,127}));
  connect(combiTimeTable.y[3], modelicaRoom.CustomHeatFlow) annotation (Line(
        points={{-121,42},{-16,42},{-16,44},{96,44},{96,-60.2},{111,-60.2}},
        color={0,0,127}));
  connect(hea.Q_flow, CoolingLoad) annotation (Line(points={{49,-78},{58,-78},{
          58,-68},{68,-68},{68,-60},{96,-60},{96,-58},{100,-58},{100,44},{126,
          44}}, color={0,0,127}));
  connect(COP.y, div1.u2)
    annotation (Line(points={{72,-12},{72,4}}, color={0,0,127}));
  connect(div1.y, ElectricPower) annotation (Line(points={{96,10},{114,10},{114,
          16},{128,16}}, color={0,0,127}));
  connect(hea.Q_flow, div1.u1)
    annotation (Line(points={{49,-78},{49,16},{72,16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end demand_flexibility_ratchet_simple;
