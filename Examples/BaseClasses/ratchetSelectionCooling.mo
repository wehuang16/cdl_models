within cdl_models.Examples.BaseClasses;
model ratchetSelectionCooling
             parameter Integer nValues=3
    "Number of values to compare";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonTempDiff[nValues]
    annotation (Placement(transformation(extent={{-140,16},{-100,56}}),
        iconTransformation(extent={{-140,26},{-100,66}})));
  Buildings.Controls.OBC.CDL.Reals.MultiMin mulMin(nin=nValues)
    annotation (Placement(transformation(extent={{-88,-18},{-68,2}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre[nValues]
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=
        nValues)
    annotation (Placement(transformation(extent={{-52,-14},{-32,6}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[nValues]
    annotation (Placement(transformation(extent={{28,20},{48,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput DoRat[nValues]
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput reachComfortLimit[nValues]
    annotation (Placement(transformation(extent={{-142,-90},{-102,-50}}),
        iconTransformation(extent={{-140,-78},{-100,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi[nValues]
    annotation (Placement(transformation(extent={{-68,28},{-48,48}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[nValues](k=1000)
    annotation (Placement(transformation(extent={{-182,66},{-162,86}})));
equation
  connect(mulMin.y, reaScaRep.u) annotation (Line(points={{-66,-8},{-60,-8},{-60,
          -4},{-54,-4}}, color={0,0,127}));
  connect(reaScaRep.y, gre.u2) annotation (Line(points={{-30,-4},{-20,-4},{-20,22},
          {-12,22}}, color={0,0,127}));
  connect(gre.y, not1.u)
    annotation (Line(points={{12,30},{26,30}}, color={255,0,255}));
  connect(not1.y, DoRat) annotation (Line(points={{50,30},{94,30},{94,0},{120,0}},
        color={255,0,255}));
  connect(reachComfortLimit, swi.u2) annotation (Line(points={{-122,-70},{-122,
          12},{-80,12},{-80,38},{-70,38}}, color={255,0,255}));
  connect(con.y, swi.u1) annotation (Line(points={{-160,76},{-78,76},{-78,46},{
          -70,46}}, color={0,0,127}));
  connect(TZonTempDiff, swi.u3) annotation (Line(points={{-120,36},{-120,10},{
          -78,10},{-78,30},{-70,30}}, color={0,0,127}));
  connect(swi.y, gre.u1) annotation (Line(points={{-46,38},{-22,38},{-22,30},{
          -12,30}}, color={0,0,127}));
  connect(swi.y, mulMin.u) annotation (Line(points={{-46,38},{-42,38},{-42,6},{
          -90,6},{-90,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ratchetSelectionCooling;
