within cdl_models.demand_flexibility;
model demand_flexibility_v1
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TRat(final k=1)
    "Ratchet Amount"
    annotation (Placement(transformation(extent={{-74,18},{-54,38}})));
  DF_Controller dF_Controller(TZonSetNominal(displayUnit="degC") = 294.15,
      TMaxSet(displayUnit="degC") = 300.15)
    annotation (Placement(transformation(extent={{10,8},{30,28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TReb(final k=0.3)
    "Rebound Amount"
    annotation (Placement(transformation(extent={{-42,-6},{-22,14}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0,273.15 + 20.5; 10800,0,273.15 + 20.5; 21600,1,273.15 + 20.5;
        32400,1,273.15 + 24; 43200,1,273.15 + 25; 54000,1,273.15 + 26; 64800,0,
        273.15 + 20.5; 75600,0,273.15 + 20.5; 86400,0,273.15 + 20.5],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-102,58},{-82,78}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-38,58},{-18,78}})));
equation
  connect(TRat.y, dF_Controller.TRat) annotation (Line(points={{-52,28},{-2,28},
          {-2,20},{8,20}}, color={0,0,127}));
  connect(TReb.y, dF_Controller.TReb) annotation (Line(points={{-20,4},{-2,4},{
          -2,15.2},{8,15.2}}, color={0,0,127}));
  connect(combiTimeTable.y[1], realToBoolean.u)
    annotation (Line(points={{-81,68},{-40,68}}, color={0,0,127}));
  connect(realToBoolean.y, dF_Controller.loadShed)
    annotation (Line(points={{-17,68},{8,68},{8,26}}, color={255,0,255}));
  connect(combiTimeTable.y[2], dF_Controller.TZon) annotation (Line(points={{
          -81,68},{-76,68},{-76,42},{-78,42},{-78,-12},{8,-12},{8,10}}, color={
          0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end demand_flexibility_v1;
