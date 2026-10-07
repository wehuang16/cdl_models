within cdl_models.FanSpeedLimiting.Subsequences;
block ElectricityDemand "Electricity demand"

  parameter Real PBuiRedDifMin(
    final unit="W",
    final quantity="Power")
    "Minimum difference between the electricity demand reduction target and the actual electricity demand reduction of the building";
  parameter Real PBuiRed_nominal(
    min=0,
    unit="W")
    "Nominal electricity demand reduction of the building";
  parameter Real PBuiRedHys(
    min=0,
    unit="W")=0.05*PBuiRed_nominal
    "Hysteresis for the electricity demand reduction of the building";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput PBuiRed(
    final unit="W",
    final quantity="Power")
    "Electricity demand reduction of the building, defined as the counterfactual baseline electricity demand minus the actual eletricity demand "
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput PBuiRedTar(
    final unit="W",
    final quantity="Power")
    "Target electricity demand reduction of the building" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}),   iconTransformation(
          extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold
                                           greThr(t=PBuiRedDifMin, h=PBuiRedHys)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract PBuiRedDif
    "Difference between the electricity demand reduction target and the actual electricity demand reduction of the building"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput need_PBuiShe
    "True: electricity demand shed of the building is needed" annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{100,-20},{140,20}})));
equation
  connect(PBuiRedTar, PBuiRedDif.u1) annotation (Line(points={{-120,60},{-80,60},
          {-80,6},{-62,6}},   color={0,0,127}));
  connect(PBuiRed, PBuiRedDif.u2) annotation (Line(points={{-120,-60},{-80,-60},
          {-80,-6},{-62,-6}},
                            color={0,0,127}));
  connect(PBuiRedDif.y, greThr.u)
    annotation (Line(points={{-38,0},{-2,0}},   color={0,0,127}));
  connect(greThr.y, need_PBuiShe)
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
end ElectricityDemand;
