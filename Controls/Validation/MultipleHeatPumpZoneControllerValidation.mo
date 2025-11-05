within cdl_models.Controls.Validation;
model MultipleHeatPumpZoneControllerValidation
   extends Modelica.Icons.Example;
  CCC_test.cdl.MultipleHeatPumpZoneController multipleHeatPumpZoneController
    annotation (Placement(transformation(extent={{-36,-6},{18,14}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2[4](k={1,1,0,0})
    "Integer inputs"
    annotation (Placement(transformation(extent={{-118,30},{-98,50}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1[4](k={1,1,-1,0})
    "Integer inputs"
    annotation (Placement(transformation(extent={{-112,-18},{-92,2}})));
equation
  connect(conInt2.y, multipleHeatPumpZoneController.reqDomHotWat) annotation (
      Line(points={{-96,40},{-46,40},{-46,12},{-38,12}}, color={255,127,0}));
  connect(conInt1.y, multipleHeatPumpZoneController.reqSpaCon) annotation (Line(
        points={{-90,-8},{-48,-8},{-48,-0.6},{-38.2,-0.6}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultipleHeatPumpZoneControllerValidation;
