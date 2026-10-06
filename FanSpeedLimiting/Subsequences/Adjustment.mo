within cdl_models.FanSpeedLimiting.Subsequences;
block Adjustment "Adjustment"

  parameter Integer nZon(min=1)
    "Number of zones in the building";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEna[nZon]
    "True: enable setpoint change"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput demFleMod
    "Demand flexibility mode; 0 = pre-cool or pre-heat, 1 = default, 2 = load-shed, 3 = load-rebound"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimCur[nAHU](each unit=
        "1") if priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.CurrentFanSpeed
    "Current fan speed limit" annotation (Placement(transformation(extent={{
            -140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,
            20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimCom[nAHU](each unit=
        "1") if priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.CurrentFanSpeed
    "Commanded fan speed limit" annotation (Placement(transformation(extent={{
            80,-20},{120,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimDef[nAHU](each unit=
        "1") if priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.CurrentFanSpeed
    "Default fan speed limit" annotation (Placement(transformation(extent={{
            -140,-60},{-100,-20}}), iconTransformation(extent={{-140,-20},{-100,
            20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimTarShe[nAHU](each
      unit="1") if priCri == cdl_models.FanSpeedLimiting.Types.PrioritizationCriteria.CurrentFanSpeed
    "Target fan speed limit for the load-shed mode" annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
protected
  Buildings.Controls.OBC.DemandFlexibility.Generic.SetpointChange setChaShe(
    final setChaDel=dTShe,
    final ascSet=airConMod == Buildings.Controls.OBC.DemandFlexibility.Types.AirConditioningMode.Cooling,
    final use_mulSteSetCha=use_mulSteSetCha)
    "Setpoint change logic for the load-shed mode"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Buildings.Controls.OBC.DemandFlexibility.Generic.SetpointChange setChaReb(
    final setChaDel=dTReb,
    final ascSet=airConMod == Buildings.Controls.OBC.DemandFlexibility.Types.AirConditioningMode.Heating,
    final use_mulSteSetCha=use_mulSteSetCha)
    "Setpoint change logic for the load-rebound mode"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Buildings.Controls.OBC.DemandFlexibility.Generic.RealValueSelectionByMode zonSetSelByMod(final
      use_pre=false)
    "Output the corresponding commanded zone temperature setpoint value based on the demand flexibility mode"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
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
end Adjustment;
