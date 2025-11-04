within cdl_models.Controls.Subsequences;
model temDifSelectionMin
             parameter Integer nZones=3
    "Number of values to compare";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonTemDif[nZones]
    annotation (Placement(transformation(extent={{-140,16},{-100,56}}),
        iconTransformation(extent={{-140,26},{-100,66}})));
  Buildings.Controls.OBC.CDL.Reals.MultiMin mulMin(nin=nZones)
    annotation (Placement(transformation(extent={{-12,-26},{8,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre[nZones]
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=
        nZones)
    annotation (Placement(transformation(extent={{28,-30},{48,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1[nZones]
    annotation (Placement(transformation(extent={{28,20},{48,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput actionFlag[nZones]
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ignoreFlag[nZones]
    annotation (Placement(transformation(extent={{-142,-90},{-102,-50}}),
        iconTransformation(extent={{-140,-78},{-100,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi[nZones]
    annotation (Placement(transformation(extent={{-68,28},{-48,48}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[nZones](k=1000)
    annotation (Placement(transformation(extent={{-182,66},{-162,86}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const[nZones](k=1:1:nZones)
    annotation (Placement(transformation(extent={{-88,-66},{-68,-46}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai[nZones](k=0.000001)
    annotation (Placement(transformation(extent={{-36,-70},{-16,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2[nZones]
    annotation (Placement(transformation(extent={{-48,-18},{-28,2}})));
equation
  connect(mulMin.y, reaScaRep.u) annotation (Line(points={{10,-16},{18,-16},{18,
          -20},{26,-20}},color={0,0,127}));
  connect(reaScaRep.y, gre.u2) annotation (Line(points={{50,-20},{58,-20},{58,
          14},{-12,14},{-12,22}},
                     color={0,0,127}));
  connect(gre.y, not1.u)
    annotation (Line(points={{12,30},{26,30}}, color={255,0,255}));
  connect(not1.y, actionFlag) annotation (Line(points={{50,30},{94,30},{94,0},{
          120,0}}, color={255,0,255}));
  connect(ignoreFlag, swi.u2) annotation (Line(points={{-122,-70},{-122,12},{-80,
          12},{-80,38},{-70,38}}, color={255,0,255}));
  connect(con.y, swi.u1) annotation (Line(points={{-160,76},{-78,76},{-78,46},{
          -70,46}}, color={0,0,127}));
  connect(TZonTemDif, swi.u3) annotation (Line(points={{-120,36},{-120,10},{
          -78,10},{-78,30},{-70,30}}, color={0,0,127}));
  connect(const.y, gai.u) annotation (Line(points={{-67,-56},{-48,-56},{-48,-60},
          {-38,-60}}, color={0,0,127}));
  connect(gai.y, add2.u2) annotation (Line(points={{-14,-60},{-6,-60},{-6,-30},
          {-50,-30},{-50,-14}}, color={0,0,127}));
  connect(swi.y, add2.u1) annotation (Line(points={{-46,38},{-38,38},{-38,6},{
          -50,6},{-50,-2}}, color={0,0,127}));
  connect(add2.y, gre.u1)
    annotation (Line(points={{-26,-8},{-26,30},{-12,30}}, color={0,0,127}));
  connect(add2.y, mulMin.u) annotation (Line(points={{-26,-8},{-26,8},{-20,8},{
          -20,-16},{-14,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
hello
</html>"));
end temDifSelectionMin;
