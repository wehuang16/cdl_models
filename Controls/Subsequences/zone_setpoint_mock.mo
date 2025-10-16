within cdl_models.Controls.Subsequences;
model zone_setpoint_mock
  Buildings.Controls.OBC.CDL.Interfaces.RealInput setpointCommand
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpoint
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel1(final samplePeriod=10, y_start=
        293.15)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-12,-12},{8,8}})));
equation
  connect(setpointCommand, uniDel1.u) annotation (Line(points={{-120,0},{-22,0},
          {-22,-2},{-14,-2}}, color={0,0,127}));
  connect(uniDel1.y, setpoint) annotation (Line(points={{10,-2},{96,-2},{96,0},
          {120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end zone_setpoint_mock;
