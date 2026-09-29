within cdl_models.Move.Generic;
block BooleanPassThrough "Boolean pass through"
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y annotation (Placement(
        transformation(extent={{100,-20},{140,20}}), iconTransformation(extent=
            {{100,-20},{140,20}})));
equation
  connect(u, not1.u) annotation (Line(points={{-120,0},{-80,0},{-80,0},{-42,0}},
        color={255,0,255}));
  connect(not1.y, not2.u)
    annotation (Line(points={{-18,0},{18,0}}, color={255,0,255}));
  connect(not2.y, y)
    annotation (Line(points={{42,0},{120,0}}, color={255,0,255}));
  annotation (defaultComponentName="booPasThr",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}},
    grid={2,2}), graphics={Rectangle(
      extent={{-100,100},{100,-100}},
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid), Text(
      extent={{-100,140},{100,100}},
      textColor={0,0,255},
          textString="%name")}), Diagram(
    coordinateSystem(preserveAspectRatio=false,
    grid={2,2})),
    Documentation(revisions="<html>
<ul>
<li>
July 20, 2026, by Weiping Huang:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
</html>"));
end BooleanPassThrough;
