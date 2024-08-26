within cdl_models.Controls;
model DF_Controller_ratchet_cooling

  parameter Real TZonCooSetNominal(unit="K")=273.15+23
    "Nominal zone air temperature setpoint";

      parameter Real TZonCooSetMax(unit="K")=273.15+27
    "Maximum zone cooling temperature setpoint";
      parameter Real samplePeriod(unit="s")=300
    "Sample period of the demand flexibility control";
       parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
           parameter Real TRat=0.5
    "Ratcheting temperature";
               parameter Real TReb=0.3
    "rebound temperature";
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
    annotation (Placement(transformation(extent={{100,28},{140,68}}),
        iconTransformation(extent={{100,28},{140,68}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=
        samplePeriod, final y_start=TZonCooSetNominal)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{-10,4},{10,24}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-50,-46},{-30,-26}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold    lesThr(t=TRatThreshold, h=0)
    "Check if the real requests is more than ignored requests setting"
    annotation (Placement(transformation(extent={{-4,-96},{16,-76}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{-164,-44},{-144,-24}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=TZonCooSetMax, uMin=
        TZonCooSetNominal)
    annotation (Placement(transformation(extent={{36,-2},{56,18}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=TRat,
      realFalse=0)
    annotation (Placement(transformation(extent={{90,-84},{110,-64}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const(final k=TReb)
    annotation (Placement(transformation(extent={{-192,-40},{-172,-20}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler   sam(final samplePeriod=
        samplePeriod)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-34,-2})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={44,-88})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonTempDiff annotation (
      Placement(transformation(extent={{100,-44},{140,-4}}), iconTransformation(
          extent={{100,-64},{140,-24}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi2
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-160,14},{-140,34}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi3
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-116,-54},{-96,-34}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput DoRat annotation (
      Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput DoReb annotation (
      Placement(transformation(extent={{-140,-2},{-100,38}}),
        iconTransformation(extent={{-140,-2},{-100,38}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const1(final k=0)
    annotation (Placement(transformation(extent={{-188,-82},{-168,-62}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr1(t=TZonCooSetMax)
    annotation (Placement(transformation(extent={{88,6},{108,26}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi4
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{70,-52},{90,-32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const2(final k=100)
    annotation (Placement(transformation(extent={{8,-36},{28,-16}})));
equation
  connect(uniDel.y,add1. u1)
    annotation (Line(points={{-48,20},{-12,20}},
      color={0,0,127}));
  connect(loadShed, swi1.u2) annotation (Line(points={{-120,80},{-90,80},{-90,
          -6},{-74,-6},{-74,-36},{-52,-36}},
        color={255,0,255}));
  connect(TZon, subt.u2) annotation (Line(points={{-120,-80},{-118,-80},{-118,
          -78},{-72,-78}}, color={0,0,127}));
  connect(subt.y, lesThr.u) annotation (Line(points={{-48,-72},{-14,-72},{-14,
          -86},{-6,-86}},  color={0,0,127}));
  connect(add1.y, lim.u)
    annotation (Line(points={{12,14},{24,14},{24,8},{34,8}}, color={0,0,127}));
  connect(lim.y, TZonSet)
    annotation (Line(points={{58,8},{66,8},{66,48},{120,48}},
                                                            color={0,0,127}));
  connect(lim.y, uniDel.u) annotation (Line(points={{58,8},{66,8},{66,46},{-72,46},
          {-72,20}}, color={0,0,127}));
  connect(const.y, gai.u) annotation (Line(points={{-170,-30},{-170,-34},{-166,
          -34}},           color={0,0,127}));
  connect(lim.y, subt.u1) annotation (Line(points={{58,8},{58,-48},{-72,-48},{
          -72,-66}}, color={0,0,127}));
  connect(sam.y, add1.u2) annotation (Line(points={{-34,10},{-34,18},{-20,18},{
          -20,8},{-12,8}}, color={0,0,127}));
  connect(sam.u, swi1.y) annotation (Line(points={{-34,-14},{-34,-22},{-22,-22},
          {-22,-32},{-20,-32},{-20,-36},{-28,-36}}, color={0,0,127}));
  connect(lesThr.y, pre.u) annotation (Line(points={{18,-86},{25,-86},{25,-88},
          {32,-88}}, color={255,0,255}));
  connect(pre.y, booToRea.u)
    annotation (Line(points={{56,-88},{88,-88},{88,-74}}, color={255,0,255}));
  connect(swi3.y, swi1.u3)
    annotation (Line(points={{-94,-44},{-52,-44}}, color={0,0,127}));
  connect(gai.y, swi3.u1) annotation (Line(points={{-142,-34},{-140,-34},{-140,
          -36},{-118,-36}}, color={0,0,127}));
  connect(swi3.u2, DoReb) annotation (Line(points={{-118,-44},{-128,-44},{-128,
          18},{-120,18}}, color={255,0,255}));
  connect(const1.y, swi3.u3) annotation (Line(points={{-166,-72},{-146,-72},{
          -146,-52},{-118,-52}}, color={0,0,127}));
  connect(DoRat, swi2.u2) annotation (Line(points={{-120,50},{-180,50},{-180,24},
          {-162,24}}, color={255,0,255}));
  connect(booToRea.y, swi2.u1) annotation (Line(points={{112,-74},{128,-74},{
          128,-100},{-198,-100},{-198,32},{-162,32}}, color={0,0,127}));
  connect(const1.y, swi2.u3) annotation (Line(points={{-166,-72},{-158,-72},{
          -158,-48},{-196,-48},{-196,16},{-162,16}}, color={0,0,127}));
  connect(swi2.y, swi1.u1) annotation (Line(points={{-138,24},{-84,24},{-84,-28},
          {-52,-28}}, color={0,0,127}));
  connect(subt.y, swi4.u1) annotation (Line(points={{-48,-72},{60,-72},{60,-34},
          {68,-34}}, color={0,0,127}));
  connect(swi4.y, TZonTempDiff) annotation (Line(points={{92,-42},{92,-50},{120,
          -50},{120,-24}}, color={0,0,127}));
  connect(const2.y, swi4.u3) annotation (Line(points={{30,-26},{38,-26},{38,-56},
          {62,-56},{62,-58},{68,-58},{68,-50}}, color={0,0,127}));
  connect(lim.y, lesThr1.u)
    annotation (Line(points={{58,8},{66,8},{66,16},{86,16}}, color={0,0,127}));
  connect(lesThr1.y, swi4.u2) annotation (Line(points={{110,16},{118,16},{118,0},
          {62,0},{62,-6},{56,-6},{56,-42},{68,-42}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DF_Controller_ratchet_cooling;
