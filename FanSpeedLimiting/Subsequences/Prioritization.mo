within cdl_models.FanSpeedLimiting.Subsequences;
block Prioritization "Prioritization"
  parameter Real fanSiz[nAHU](each start=0)
    "Fan size; can be in any unit, but a larger value should represent a larger fan"
    annotation (Dialog(enable = priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.FanSize));
  parameter cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria priCri
    "Fan limiting prioritization criteria";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpe[nAHU](each unit="1") if
    priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.CurrentFanSpeed
    "Fan speed of the air handling unit"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput disFla[nAHU]
    "True: disqualify fans from fan limiting"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nSel
    "Number of air handling unit fans to select for prioritization"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.DemandFlexibility.Generic.SelectLargestValues selLarVal(final
      nVal=nAHU)
    "Select the largest value, either the fan speed or the fan size"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conFanSiz[nAHU](
    final k=fanSiz)
    if priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.FanSize
    "Constant for fan size"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEna[nAHU]
    "True: enable fan limiting"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
equation
  connect(disFla, selLarVal.disFla) annotation (Line(points={{-120,60},{-20,60},
          {-20,6},{-2,6}}, color={255,0,255}));
  connect(fanSpe, selLarVal.u)
    annotation (Line(points={{-120,0},{-2,0}}, color={0,0,127}));
  connect(conFanSiz.y, selLarVal.u) annotation (Line(points={{-58,30},{-40,30},{
          -40,0},{-2,0}}, color={0,0,127}));
  connect(nSel, selLarVal.nSel) annotation (Line(points={{-120,-60},{-20,-60},{-20,
          -6},{-2,-6}}, color={255,127,0}));
  connect(selLarVal.y, yEna)
    annotation (Line(points={{22,0},{120,0}}, color={255,0,255}));
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
August 18, 2026, by Weiping Huang:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Passes a Boolean signal through without modification.
</p>
</html>"));

end Prioritization;
