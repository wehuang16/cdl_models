within cdl_models.Move.Generic.Subsequences;
block RealNumberEqualHysteresis "Exact equal block for real numbers"
  parameter Real alwDev(min=1E-6)=0.01
    "Allowed deviation for equality";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u1 "Input real number 1"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u2 "Input real number 2"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEquFla "Equal flag"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre(h=alwDev)
                                               "Greater than"
    annotation (Placement(transformation(extent={{18,-68},{38,-48}})));
  Buildings.Controls.OBC.CDL.Reals.Less les(h=alwDev)
                                            "Less than"
    annotation (Placement(transformation(extent={{16,14},{36,34}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    "Input u1 within input u2 plus or minus allowed deviation"
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
equation
  connect(u1, les.u1) annotation (Line(points={{-120,60},{0,60},{0,24},{14,24}},
        color={0,0,127}));
  connect(u1, gre.u1) annotation (Line(points={{-120,60},{0,60},{0,-58},{16,-58}},
        color={0,0,127}));
  connect(les.y, and2.u1) annotation (Line(points={{38,24},{54,24},{54,0},{64,0}},
                                   color={255,0,255}));
  connect(gre.y, and2.u2) annotation (Line(points={{40,-58},{56,-58},{56,-8},{
          64,-8}},        color={255,0,255}));
  connect(and2.y, yEquFla) annotation (Line(points={{88,0},{120,0}},
               color={255,0,255}));
  connect(u2, les.u2) annotation (Line(points={{-120,-60},{-52,-60},{-52,16},{
          14,16}}, color={0,0,127}));
  connect(u2, gre.u2) annotation (Line(points={{-120,-60},{-52,-60},{-52,-66},{
          16,-66}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This block checks whether the values of 2 real input variables are equal to each other. </p>
<p>The 2 real input variables are <code>u1</code> and <code>u2</code>.
The allowed deviation is represented by the parameter <code>alwDev</code>. 
If <code>u1 &lt; u2 + alwDev</code> and <code>u1 &gt; 
u2 - alwDev</code>, then the output <code>yEuqFla</code> is <code>true</code>. 
Otherwise, the output <code>yEuqFla</code> is <code>false</code>. </p>
</html>",
        revisions="<html>
<ul>
<li>
April 03, 2026, by Weiping Huang:<br/>
First implementation.
</li>

</ul>
</html>"));
end RealNumberEqualHysteresis;
