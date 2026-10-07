within cdl_models.FanSpeedLimiting.Subsequences;
block Adjustment "Adjustment"

  parameter Real delFanSpeLimShe(
    min=0,
    start=0.5,
    unit="1")
    "Fan speed limit change amount for the load-shed mode (positive value)"
    annotation (Dialog(enable = use_mulSteSetCha));
  parameter Real delFanSpeLimReb(
    min=0,
    start=0.5,
    unit="1")
    "Fan speed limit change amount for the load-rebound mode (positive value)"
    annotation (Dialog(enable = use_mulSteSetCha));
  parameter Boolean use_mulSteSetCha
    "If true, there are multiple smaller and incremental setpoint change steps for the load-shed mode and the load-rebound mode; if false, there is a single setpoint change step";
  parameter Integer nAHU(min=1)
    "Number of air handling units";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uEna
    "True: enable setpoint change" annotation (Placement(transformation(extent={
            {-140,60},{-100,100}}), iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput demFleMod
    "Demand flexibility mode; 0 = pre-cool or pre-heat, 1 = default, 2 = load-shed, 3 = load-rebound"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimCur(
    unit="1")
    "Current fan speed limit" annotation (Placement(transformation(extent={{
            -140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput fanSpeLimCom(
    unit="1")
    "Commanded fan speed limit" annotation (Placement(transformation(extent={{100,-20},
            {140,20}}),         iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimDef(
    unit="1")
    "Default fan speed limit" annotation (Placement(transformation(extent={{
            -140,-60},{-100,-20}}), iconTransformation(extent={{-140,-60},{-100,
            -20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimTarShe(
    unit="1")
    "Target fan speed limit for the load-shed mode" annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(
          extent={{-140,-100},{-100,-60}})));
protected
  Buildings.Controls.OBC.DemandFlexibility.Generic.SetpointChange setChaShe(
    final setChaDel=delFanSpeLimShe,
    final ascSet=false,
    final use_mulSteSetCha=use_mulSteSetCha)
    "Setpoint change logic for the load-shed mode"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Controls.OBC.DemandFlexibility.Generic.SetpointChange setChaReb(
    final setChaDel=delFanSpeLimReb,
    final ascSet=true,
    final use_mulSteSetCha=use_mulSteSetCha)
    "Setpoint change logic for the load-rebound mode"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Buildings.Controls.OBC.DemandFlexibility.Generic.RealValueSelectionByMode fanSpeLimSelByMod(
    final use_pre=false)
    "Output the corresponding commanded zone temperature setpoint value based on the demand flexibility mode"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Reals.Less lesFanSpeLimTarShe
    "Check if the pre-heat target temperature setpoint is less than the default temperature setpoint"
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Buildings.Controls.OBC.CDL.Logical.Not notLesFanSpeLimTarShe
    "Check if the pre-heat target temperature setpoint is no less than the default temperature setpoint"
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Buildings.Controls.OBC.CDL.Utilities.Assert assMesFanSpeLimTarShe(message="Error: the pre-heat target temperature setpoint must be greater than or equal to the default temperature setpoint during the heating mode.")
    "Error message for the pre-heat target temperature setpoint during the heating mode"
    annotation (Placement(transformation(extent={{60,-120},{80,-100}})));
equation
  connect(fanSpeLimDef, fanSpeLimSelByMod.uDef) annotation (Line(points={{-120,-40},
          {-40,-40},{-40,0},{58,0}}, color={0,0,127}));
  connect(uEna, setChaShe.uEna) annotation (Line(points={{-120,80},{-80,80},{-80,
          76},{-2,76}}, color={255,0,255}));
  connect(uEna, setChaReb.uEna) annotation (Line(points={{-120,80},{-80,80},{-80,
          -44},{-2,-44}}, color={255,0,255}));
  connect(fanSpeLimSelByMod.y, fanSpeLimCom)
    annotation (Line(points={{82,0},{120,0}}, color={0,0,127}));
  connect(setChaShe.y, fanSpeLimSelByMod.uShe) annotation (Line(points={{22,70},
          {40,70},{40,-4},{58,-4}}, color={0,0,127}));
  connect(setChaReb.y, fanSpeLimSelByMod.uReb) annotation (Line(points={{22,-50},
          {40,-50},{40,-8},{58,-8}}, color={0,0,127}));
  connect(demFleMod, fanSpeLimSelByMod.demFleMod) annotation (Line(points={{-120,
          40},{20,40},{20,8},{58,8}}, color={255,127,0}));
  connect(fanSpeLimCur, setChaShe.uCurSet) annotation (Line(points={{-120,0},{-60,
          0},{-60,72},{-2,72}}, color={0,0,127}));
  connect(fanSpeLimCur, setChaReb.uCurSet) annotation (Line(points={{-120,0},{-60,
          0},{-60,-48},{-2,-48}}, color={0,0,127}));
  connect(fanSpeLimDef, setChaReb.uAllMaxSet) annotation (Line(points={{-120,-40},
          {-40,-40},{-40,-51.8},{-2,-51.8}}, color={0,0,127}));
  connect(fanSpeLimDef, setChaShe.uAllMaxSet) annotation (Line(points={{-120,-40},
          {-40,-40},{-40,68.2},{-2,68.2}}, color={0,0,127}));
  connect(fanSpeLimTarShe, setChaReb.uAllMinSet) annotation (Line(points={{-120,
          -80},{-20,-80},{-20,-56},{-2,-56}}, color={0,0,127}));
  connect(fanSpeLimTarShe, setChaShe.uAllMinSet) annotation (Line(points={{-120,
          -80},{-20,-80},{-20,64},{-2,64}}, color={0,0,127}));
  connect(lesFanSpeLimTarShe.y, notLesFanSpeLimTarShe.u)
    annotation (Line(points={{2,-110},{18,-110}}, color={255,0,255}));
  connect(notLesFanSpeLimTarShe.y, assMesFanSpeLimTarShe.u)
    annotation (Line(points={{42,-110},{58,-110}}, color={255,0,255}));
  connect(fanSpeLimDef, lesFanSpeLimTarShe.u1) annotation (Line(points={{-120,-40},
          {-40,-40},{-40,-110},{-22,-110}}, color={0,0,127}));
  connect(fanSpeLimTarShe, lesFanSpeLimTarShe.u2) annotation (Line(points={{-120,
          -80},{-60,-80},{-60,-118},{-22,-118}}, color={0,0,127}));
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
    grid={2,2},
        extent={{-100,-140},{100,120}})),
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
