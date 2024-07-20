within cdl_models.Controls;
model DF_Controller_ratchet

  parameter Real TZonSetNominal(unit="K")=273.15+23
    "Nominal zone air temperature setpoint";

      parameter Real TMaxSet(unit="K")=273.15+27
    "Maximum zone cooling temperature setpoint";
      parameter Real samplePeriod(unit="s")=300
    "Sample period of the demand flexibility control";
       parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRat "Ratchet Amount"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput loadShed
    "Load shed event flag" annotation (Placement(transformation(extent={{-140,60},
            {-100,100}}),iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-140,-100},{-100,-60}}), iconTransformation(extent={{-140,-100},
            {-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Zone temperature setpoint"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const(final k=0)
    annotation (Placement(transformation(extent={{-64,-136},{-44,-116}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=
        samplePeriod, final y_start=TZonSetNominal)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{-10,4},{10,24}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-50,-46},{-30,-26}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TReb
    "Rebound Down Ratchet Amount" annotation (Placement(transformation(extent={{
            -140,-66},{-100,-26}}), iconTransformation(extent={{-140,-48},{-100,
            -8}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1
    "Reset setpoint should not be higher than the maximum setpoint"
    annotation (Placement(transformation(extent={{28,-2},{48,18}})));
  Buildings.Controls.OBC.CDL.Reals.Max maxInp
    "Reset setpoint should not be lower than the minimum setpoint"
    annotation (Placement(transformation(extent={{68,-2},{88,18}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant maxSetCon(k=TMaxSet)
    "Maximum setpoint constant"
    annotation (Placement(transformation(extent={{-12,-32},{8,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minSetCon(k=TZonSetNominal)
    "Minimum setpoint constant"
    annotation (Placement(transformation(extent={{28,-32},{48,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold    lesThr(t=TRatThreshold, h=0)
    "Check if the real requests is more than ignored requests setting"
    annotation (Placement(transformation(extent={{-32,-88},{-12,-68}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi2
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{210,-84},{230,-64}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{-90,-56},{-70,-36}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=1)
    annotation (Placement(transformation(extent={{18,-90},{38,-70}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=1)
    annotation (Placement(transformation(extent={{110,-114},{130,-94}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{56,-104},{76,-84}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{150,-112},{170,-92}})));
equation
  connect(uniDel.y,add1. u1)
    annotation (Line(points={{-48,20},{-12,20}},
      color={0,0,127}));
  connect(loadShed, swi1.u2) annotation (Line(points={{-120,80},{-90,80},{-90,
          -6},{-74,-6},{-74,-36},{-52,-36}},
        color={255,0,255}));
  connect(swi1.y, add1.u2) annotation (Line(points={{-28,-36},{-18,-36},{-18,0},
          {-20,0},{-20,8},{-12,8}},
                    color={0,0,127}));
  connect(minSetCon.y,maxInp. u2)
    annotation (Line(points={{50,-22},{58,-22},{58,2},{66,2}},
      color={0,0,127}));
  connect(maxSetCon.y,min1. u2)
    annotation (Line(points={{10,-22},{22,-22},{22,-6},{26,-6},{26,2}},
      color={0,0,127}));
  connect(add1.y, min1.u1)
    annotation (Line(points={{12,14},{26,14}}, color={0,0,127}));
  connect(min1.y, maxInp.u1)
    annotation (Line(points={{50,8},{58,8},{58,14},{66,14}}, color={0,0,127}));
  connect(maxInp.y, uniDel.u) annotation (Line(points={{90,8},{92,8},{92,54},{-70,
          54},{-70,20},{-72,20}}, color={0,0,127}));
  connect(maxInp.y, TZonSet)
    annotation (Line(points={{90,8},{98,8},{98,0},{120,0}}, color={0,0,127}));
  connect(maxInp.y, subt.u1) annotation (Line(points={{90,8},{98,8},{98,0},{94,
          0},{94,-58},{-72,-58},{-72,-66}}, color={0,0,127}));
  connect(TZon, subt.u2) annotation (Line(points={{-120,-80},{-118,-80},{-118,
          -78},{-72,-78}}, color={0,0,127}));
  connect(subt.y, lesThr.u) annotation (Line(points={{-48,-72},{-40,-72},{-40,
          -78},{-34,-78}}, color={0,0,127}));
  connect(TRat, swi2.u1) annotation (Line(points={{-120,20},{-80,20},{-80,56},{
          200,56},{200,-66},{208,-66}},        color={0,0,127}));
  connect(const.y, swi2.u3) annotation (Line(points={{-42,-126},{200,-126},{200,
          -82},{208,-82}},color={0,0,127}));
  connect(TReb, gai.u)
    annotation (Line(points={{-120,-46},{-92,-46}}, color={0,0,127}));
  connect(gai.y, swi1.u3)
    annotation (Line(points={{-68,-46},{-68,-44},{-52,-44}}, color={0,0,127}));
  connect(swi1.u1, swi2.y) annotation (Line(points={{-52,-28},{-60,-28},{-60,
          -60},{202,-60},{202,-58},{240,-58},{240,-74},{232,-74}},
                                              color={0,0,127}));
  connect(lesThr.y, truDel.u) annotation (Line(points={{-10,-78},{6,-78},{6,-80},
          {16,-80}}, color={255,0,255}));
  connect(not1.y, truDel1.u) annotation (Line(points={{78,-94},{100,-94},{100,
          -104},{108,-104}}, color={255,0,255}));
  connect(truDel1.y, not2.u) annotation (Line(points={{132,-104},{132,-102},{
          148,-102}}, color={255,0,255}));
  connect(not2.y, swi2.u2) annotation (Line(points={{172,-102},{194,-102},{194,
          -74},{208,-74}}, color={255,0,255}));
  connect(lesThr.y, not1.u) annotation (Line(points={{-10,-78},{-2,-78},{-2,
          -100},{54,-100},{54,-94}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DF_Controller_ratchet;
