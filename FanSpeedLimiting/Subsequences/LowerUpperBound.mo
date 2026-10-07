within cdl_models.FanSpeedLimiting.Subsequences;
block LowerUpperBound "Lower upper bound"

  parameter Real TResInt(
    min=0)
    "Temperature resolution interval used by an external zone temperature controller"
    annotation (Dialog(group="Temperature setpoint parameters"));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput demFleMod
    "Demand flexibility mode; 0 = pre-cool or pre-heat, 1 = default, 2 = load-shed, 3 = load-rebound"
    annotation (Placement(transformation(extent={{-240,60},{-200,100}}),
      iconTransformation(extent={{-140,58},{-100,98}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimCur[nAHU](unit="1")
    "Current fan speed limit" annotation (Placement(transformation(extent={{-240,0},
            {-200,40}}),    iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimDef[nAHU](unit="1")
    "Default fan speed limit" annotation (Placement(transformation(extent={{-240,
            -40},{-200,0}}), iconTransformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput fanSpeLimTarShe[nAHU](unit="1")
    "Target fan speed limit for the load-shed mode" annotation (Placement(
        transformation(extent={{-240,-80},{-200,-40}}), iconTransformation(
          extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reach_lowUppBou[nAHU]
    "Reach the lower or upper bound" annotation (Placement(transformation(
          extent={{200,-20},{240,20}}), iconTransformation(extent={{100,-20},{
            140,20}})));
protected
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conIntShe(
    final k=Buildings.Controls.OBC.DemandFlexibility.Types.DemandFlexibilityModes.loadShed)
    "Integer constant for the load-shed mode"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEquShe
    "Check whether it is the load-shed mode"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRepShe(
    final nout=nAHU)
    "Repeat the boolean scalar for being in the load-shed mode"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRepReb(
    final nout=nAHU)
    "Repeat the boolean scalar for being in the load-rebound mode"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEquReb
    "Check whether it is the load-rebound mode"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conIntReb(
    final k=Buildings.Controls.OBC.DemandFlexibility.Types.DemandFlexibilityModes.loadRebound)
    "Integer constant for the load-rebound mode"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addTResIntSheHea[nAHU](
    final p=fill(0.99*TResInt, nAHU))
    "Add 0.99 times the temperature resolution interval during the heating load-shed mode"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Less lesTSetSheHea[nAHU](
    final h=fill(0.5*TResInt, nAHU))
    "The zone heating temperature setpoint is less than the load-shed heating target temperature setpoint, taking into account of the temperature resolution"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter subTResIntRebHea[nAHU](
    final p=fill(-0.99*TResInt, nAHU))
    "Subtract 0.99 times the temperature resolution interval during the heating load-rebound mode"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Greater greTSetRebHea[nAHU](
    final h=fill(0.5*TResInt, nAHU))
    "The zone heating temperature setpoint is greater than the default heating temperature setpoint during the load-rebound mode, taking into account of the temperature resolution"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Buildings.Controls.OBC.CDL.Logical.And reaTSheTarSet[nAHU]
    "In the load-shed mode, the zone temperature setpoint has reached the load-shed target temperature setpoint"
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
  Buildings.Controls.OBC.CDL.Logical.And reaTDefSet[nAHU]
    "In the load-rebound mode, the zone temperature setpoint has reached the default temperature setpoint"
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Buildings.Controls.OBC.CDL.Logical.Or orReaLimSheReb[nAHU]
    "The zone temperature setpoint has reached a setpoint limit during the load-shed mode and the load-rebound mode"
    annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
equation
  connect(demFleMod, intEquShe.u1) annotation (Line(points={{-220,80},{-130,80},
          {-130,30},{-42,30}},
                            color={255,127,0}));
  connect(demFleMod, intEquReb.u1) annotation (Line(points={{-220,80},{-130,80},
          {-130,70},{-42,70}},
                            color={255,127,0}));
  connect(conIntShe.y, intEquShe.u2) annotation (Line(points={{-78,10},{-58,10},
          {-58,22},{-42,22}},
                        color={255,127,0}));
  connect(conIntReb.y, intEquReb.u2) annotation (Line(points={{-78,50},{-60,50},
          {-60,62},{-42,62}},
                        color={255,127,0}));
  connect(intEquShe.y, booScaRepShe.u)
    annotation (Line(points={{-18,30},{-2,30}}, color={255,0,255}));
  connect(intEquReb.y, booScaRepReb.u)
    annotation (Line(points={{-18,70},{18,70}}, color={255,0,255}));
  connect(fanSpeLimCur, greTSetRebHea.u1) annotation (Line(points={{-220,20},{-160,
          20},{-160,-10},{-42,-10}},
                                   color={0,0,127}));
  connect(fanSpeLimDef, subTResIntRebHea.u) annotation (Line(points={{-220,-20},
          {-180,-20},{-180,-30},{-122,-30}},
                                          color={0,0,127}));
  connect(subTResIntRebHea.y, greTSetRebHea.u2) annotation (Line(points={{-98,-30},
          {-68,-30},{-68,-18},{-42,-18}},
                                     color={0,0,127}));
  connect(fanSpeLimCur, lesTSetSheHea.u1) annotation (Line(points={{-220,20},{-160,
          20},{-160,-50},{-42,-50}},   color={0,0,127}));
  connect(fanSpeLimTarShe, addTResIntSheHea.u) annotation (Line(points={{-220,-60},
          {-180,-60},{-180,-70},{-122,-70}},   color={0,0,127}));
  connect(addTResIntSheHea.y, lesTSetSheHea.u2) annotation (Line(points={{-98,-70},
          {-68,-70},{-68,-58},{-42,-58}},
                                       color={0,0,127}));
  connect(booScaRepReb.y, reaTDefSet.u1) annotation (Line(points={{42,70},{60,70},
          {60,10},{78,10}},         color={255,0,255}));
  connect(greTSetRebHea.y, reaTDefSet.u2) annotation (Line(points={{-18,-10},{60,
          -10},{60,2},{78,2}}, color={255,0,255}));
  connect(booScaRepShe.y, reaTSheTarSet.u1) annotation (Line(points={{22,30},{40,
          30},{40,-70},{78,-70}}, color={255,0,255}));
  connect(lesTSetSheHea.y, reaTSheTarSet.u2) annotation (Line(points={{-18,-50},
          {20,-50},{20,-78},{78,-78}}, color={255,0,255}));
  connect(reaTDefSet.y, orReaLimSheReb.u1) annotation (Line(points={{102,10},{120,
          10},{120,-30},{138,-30}}, color={255,0,255}));
  connect(reaTSheTarSet.y, orReaLimSheReb.u2) annotation (Line(points={{102,-70},
          {120,-70},{120,-38},{138,-38}}, color={255,0,255}));
  connect(orReaLimSheReb.y, reach_lowUppBou) annotation (Line(points={{162,-30},
          {180,-30},{180,0},{220,0}}, color={255,0,255}));
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
        extent={{-200,-100},{200,100}})),
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
end LowerUpperBound;
