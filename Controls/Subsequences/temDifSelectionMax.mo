within cdl_models.Controls.Subsequences;
model temDifSelectionMax
             parameter Integer nZones=3
    "Number of values to compare";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonTemDif[nZones]
    annotation (Placement(transformation(extent={{-140,16},{-100,56}}),
        iconTransformation(extent={{-140,26},{-100,66}})));
  Buildings.Controls.OBC.CDL.Reals.MultiMax mulMax(nin=nZones)
    annotation (Placement(transformation(extent={{36,-26},{56,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Less    les[nZones]
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=
        nZones)
    annotation (Placement(transformation(extent={{72,-22},{92,-2}})));
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[nZones](k=-1000)
    annotation (Placement(transformation(extent={{-182,66},{-162,86}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2[nZones]
    annotation (Placement(transformation(extent={{-44,-14},{-24,6}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai[nZones](k=0.000001)
    annotation (Placement(transformation(extent={{-26,-98},{-6,-78}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const[nZones](k=1:1:nZones)
    annotation (Placement(transformation(extent={{-78,-94},{-58,-74}})));
equation
  connect(mulMax.y, reaScaRep.u) annotation (Line(points={{58,-16},{64,-16},{64,
          -12},{70,-12}},color={0,0,127}));
  connect(reaScaRep.y,les. u2) annotation (Line(points={{94,-12},{94,-26},{58,
          -26},{58,14},{-12,14},{-12,22}},
                     color={0,0,127}));
  connect(les.y, not1.u)
    annotation (Line(points={{12,30},{26,30}}, color={255,0,255}));
  connect(not1.y, actionFlag) annotation (Line(points={{50,30},{94,30},{94,0},{
          120,0}}, color={255,0,255}));
  connect(ignoreFlag, swi.u2) annotation (Line(points={{-122,-70},{-122,12},{-80,
          12},{-80,38},{-70,38}}, color={255,0,255}));
  connect(con.y, swi.u1) annotation (Line(points={{-160,76},{-78,76},{-78,46},{
          -70,46}}, color={0,0,127}));
  connect(TZonTemDif, swi.u3) annotation (Line(points={{-120,36},{-120,10},{
          -78,10},{-78,30},{-70,30}}, color={0,0,127}));
  connect(gai.y, add2.u2) annotation (Line(points={{-4,-88},{4,-88},{4,-18},{
          -46,-18},{-46,-10}}, color={0,0,127}));
  connect(const.y, gai.u) annotation (Line(points={{-56,-84},{-38,-84},{-38,-88},
          {-28,-88}}, color={0,0,127}));
  connect(swi.y, add2.u1) annotation (Line(points={{-46,38},{-38,38},{-38,10},{
          -46,10},{-46,2}}, color={0,0,127}));
  connect(add2.y, les.u1) annotation (Line(points={{-22,-4},{-14,-4},{-14,14},{
          -20,14},{-20,30},{-12,30}}, color={0,0,127}));
  connect(add2.y, mulMax.u) annotation (Line(points={{-22,-4},{26,-4},{26,-16},
          {34,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end temDifSelectionMax;
