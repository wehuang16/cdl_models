within cdl_models.HVAC.Validation;
model thermostatSetpointResolutionValidation
  HVAC.thermostatSetpointResolution thermostatSetpointResolution
    annotation (Placement(transformation(extent={{6,4},{26,24}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.5)
    annotation (Placement(transformation(extent={{-76,-44},{-56,-24}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin(
    amplitude=15,
    freqHz=0.00013888888,
    offset=290.15)
    annotation (Placement(transformation(extent={{-164,-26},{-144,-6}})));
equation
  connect(con.y, thermostatSetpointResolution.temRes) annotation (Line(points={
          {-54,-34},{-4,-34},{-4,6.6},{4,6.6}}, color={0,0,127}));
  connect(sin.y, thermostatSetpointResolution.setpointCommand) annotation (Line(
        points={{-142,-16},{-6,-16},{-6,14},{4,14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end thermostatSetpointResolutionValidation;
