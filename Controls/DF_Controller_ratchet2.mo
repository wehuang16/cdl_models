within cdl_models.Controls;
model DF_Controller_ratchet2

  parameter Real TZonSetNominal(unit="K")=273.15+23
    "Nominal zone air temperature setpoint";

      parameter Real TMaxSet(unit="K")=273.15+27
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
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
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
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold    lesThr(t=TRatThreshold, h=1.05*
        TRat)
    "Check if the real requests is more than ignored requests setting"
    annotation (Placement(transformation(extent={{-4,-96},{16,-76}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{-90,-56},{-70,-36}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=TMaxSet, uMin=
        TZonSetNominal)
    annotation (Placement(transformation(extent={{36,-2},{56,18}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=TRat,
      realFalse=0)
    annotation (Placement(transformation(extent={{90,-84},{110,-64}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const(final k=TReb)
    annotation (Placement(transformation(extent={{-154,-46},{-134,-26}})));
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
  connect(TZon, subt.u2) annotation (Line(points={{-120,-80},{-118,-80},{-118,
          -78},{-72,-78}}, color={0,0,127}));
  connect(subt.y, lesThr.u) annotation (Line(points={{-48,-72},{-14,-72},{-14,
          -86},{-6,-86}},  color={0,0,127}));
  connect(gai.y, swi1.u3)
    annotation (Line(points={{-68,-46},{-68,-44},{-52,-44}}, color={0,0,127}));
  connect(add1.y, lim.u)
    annotation (Line(points={{12,14},{24,14},{24,8},{34,8}}, color={0,0,127}));
  connect(lim.y, TZonSet)
    annotation (Line(points={{58,8},{94,8},{94,0},{120,0}}, color={0,0,127}));
  connect(lim.y, uniDel.u) annotation (Line(points={{58,8},{66,8},{66,46},{-72,46},
          {-72,20}}, color={0,0,127}));
  connect(lesThr.y, booToRea.u) annotation (Line(points={{18,-86},{88,-86},{88,
          -74}},          color={255,0,255}));
  connect(booToRea.y, swi1.u1) annotation (Line(points={{112,-74},{120,-74},{
          120,-60},{-14,-60},{-14,-30},{-20,-30},{-20,-20},{-52,-20},{-52,-28}},
                                color={0,0,127}));
  connect(const.y, gai.u) annotation (Line(points={{-132,-36},{-100,-36},{-100,
          -46},{-92,-46}}, color={0,0,127}));
  connect(lim.y, subt.u1) annotation (Line(points={{58,8},{58,-48},{-72,-48},{
          -72,-66}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DF_Controller_ratchet2;
