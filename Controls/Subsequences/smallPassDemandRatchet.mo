within cdl_models.Controls.Subsequences;
model smallPassDemandRatchet
             parameter Integer nValues=3
    "Number of values to compare";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput targetValue[nValues]
    annotation (Placement(transformation(extent={{-140,16},{-100,56}}),
        iconTransformation(extent={{-140,26},{-100,66}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput defaultBool annotation (
      Placement(transformation(extent={{-138,-86},{-98,-46}}),
        iconTransformation(extent={{-140,-92},{-100,-52}})));
  Buildings.Controls.OBC.CDL.Reals.MultiMin mulMin(nin=3)
    annotation (Placement(transformation(extent={{-88,-18},{-68,2}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre[nValues]
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=
        nValues)
    annotation (Placement(transformation(extent={{-52,-14},{-32,6}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[nValues]
    annotation (Placement(transformation(extent={{28,20},{48,40}})));
  Buildings.Controls.OBC.CDL.Logical.And and1[nValues]
    annotation (Placement(transformation(extent={{70,16},{90,38}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=
        nValues)
    annotation (Placement(transformation(extent={{-4,-64},{16,-44}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput targetBool[nValues]
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
equation
  connect(targetValue, mulMin.u) annotation (Line(points={{-120,36},{-96,36},{-96,
          0},{-98,0},{-98,-8},{-90,-8}}, color={0,0,127}));
  connect(targetValue, gre.u1) annotation (Line(points={{-120,36},{-96,36},{-96,
          30},{-12,30}}, color={0,0,127}));
  connect(mulMin.y, reaScaRep.u) annotation (Line(points={{-66,-8},{-60,-8},{-60,
          -4},{-54,-4}}, color={0,0,127}));
  connect(reaScaRep.y, gre.u2) annotation (Line(points={{-30,-4},{-20,-4},{-20,22},
          {-12,22}}, color={0,0,127}));
  connect(gre.y, not1.u)
    annotation (Line(points={{12,30},{26,30}}, color={255,0,255}));
  connect(not1.y, and1.u1)
    annotation (Line(points={{50,30},{50,27},{68,27}}, color={255,0,255}));
  connect(defaultBool, booScaRep.u) annotation (Line(points={{-118,-66},{-14,
          -66},{-14,-54},{-6,-54}}, color={255,0,255}));
  connect(booScaRep.y, and1.u2) annotation (Line(points={{18,-54},{60,-54},{60,
          18.2},{68,18.2}}, color={255,0,255}));
  connect(and1.y, targetBool) annotation (Line(points={{92,27},{100,27},{100,22},
          {96,22},{96,0},{120,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end smallPassDemandRatchet;
