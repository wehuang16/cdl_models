within cdl_models.Examples.BaseClasses;
model demand_control_signal
  parameter Integer nZones=3
    "Number of zones to compare";
  parameter Real demand_limit(unit="W")=200;
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi[nZones]
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep2(nout=
        nZones)
    annotation (Placement(transformation(extent={{-50,-16},{-30,4}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant boolconst[nZones](final k=
        false)
    annotation (Placement(transformation(extent={{-8,-46},{12,-26}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=demand_limit, h=0)
    annotation (Placement(transformation(extent={{-82,28},{-62,48}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput
                                        totalElectricPower
    annotation (Placement(transformation(extent={{-134,-88},{-100,-54}}),
        iconTransformation(extent={{-134,-88},{-100,-54}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput DoRatFin[nZones]
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput DoRatIni[nZones]
    annotation (Placement(transformation(extent={{-140,48},{-100,88}}),
        iconTransformation(extent={{-140,42},{-100,82}})));
equation
  connect(booScaRep2.y, logSwi.u2) annotation (Line(points={{-28,-6},{14,-6},{
          14,30},{24,30}}, color={255,0,255}));
  connect(boolconst.y, logSwi.u3) annotation (Line(points={{14,-36},{22,-36},{
          22,14},{24,14},{24,22}}, color={255,0,255}));
  connect(greThr.y, booScaRep2.u) annotation (Line(points={{-60,38},{-52,38},{
          -52,8},{-62,8},{-62,-6},{-52,-6}}, color={255,0,255}));
  connect(totalElectricPower, greThr.u) annotation (Line(points={{-117,-71},{
          -94,-71},{-94,38},{-84,38}}, color={0,0,127}));
  connect(DoRatIni, logSwi.u1) annotation (Line(points={{-120,68},{16,68},{16,
          38},{24,38}}, color={255,0,255}));
  connect(logSwi.y, DoRatFin) annotation (Line(points={{48,30},{94,30},{94,0},{
          120,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end demand_control_signal;
