within cdl_models.HVAC;
model thermostatSetpointResolution

  Buildings.Controls.OBC.CDL.Interfaces.RealInput setpointCommand annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput actualSetpoint annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput temRes
    "Temperature resolution" annotation (Placement(transformation(extent={{-140,
            -100},{-100,-60}}), iconTransformation(extent={{-140,-94},{-100,-54}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=293.15)
    annotation (Placement(transformation(extent={{-78,-32},{-58,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-42,24},{-22,44}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{-6,-34},{14,-14}})));
  Buildings.Controls.OBC.CDL.Reals.Round rou(n=0)
    annotation (Placement(transformation(extent={{34,-36},{54,-16}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{84,-62},{104,-42}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{134,-52},{154,-32}})));
equation
  connect(setpointCommand, sub.u1) annotation (Line(points={{-120,0},{-52,0},{
          -52,40},{-44,40}}, color={0,0,127}));
  connect(con.y, sub.u2)
    annotation (Line(points={{-56,-22},{-44,-22},{-44,28}}, color={0,0,127}));
  connect(temRes, div1.u2) annotation (Line(points={{-120,-80},{-90,-80},{-90,
          -68},{-8,-68},{-8,-30}}, color={0,0,127}));
  connect(sub.y, div1.u1) annotation (Line(points={{-20,34},{-18,34},{-18,-18},
          {-8,-18}}, color={0,0,127}));
  connect(div1.y, rou.u)
    annotation (Line(points={{16,-24},{16,-26},{32,-26}}, color={0,0,127}));
  connect(temRes, mul.u2) annotation (Line(points={{-120,-80},{-90,-80},{-90,
          -68},{-8,-68},{-8,-58},{82,-58}}, color={0,0,127}));
  connect(rou.y, mul.u1) annotation (Line(points={{56,-26},{74,-26},{74,-46},{
          82,-46}}, color={0,0,127}));
  connect(mul.y, add2.u2) annotation (Line(points={{106,-52},{124,-52},{124,-48},
          {132,-48}}, color={0,0,127}));
  connect(con.y, add2.u1) annotation (Line(points={{-56,-22},{-44,-22},{-44,-14},
          {-16,-14},{-16,-10},{94,-10},{94,-36},{132,-36}}, color={0,0,127}));
  connect(add2.y, actualSetpoint) annotation (Line(points={{156,-42},{164,-42},
          {164,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end thermostatSetpointResolution;
