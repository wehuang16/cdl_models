within cdl_models.Examples.BaseClasses;
model HeatingCoolingControl
      parameter Real TCooSet(unit="K")=273.15+24
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+20
    "Zone heating temperature setpoint";

      parameter Real zone_temp_setpoint_delta=0.5
    "Zone air setpoint hysteresis delta";
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysteresisHeating(uLow=THeaSet -
        zone_temp_setpoint_delta, uHigh=THeaSet + zone_temp_setpoint_delta)
    annotation (Placement(transformation(extent={{-70,14},{-50,34}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysteresisCooling(uLow=TCooSet -
        zone_temp_setpoint_delta, uHigh=TCooSet + zone_temp_setpoint_delta)
    annotation (Placement(transformation(extent={{-70,-48},{-50,-28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const(k=-1)
    annotation (Placement(transformation(extent={{-42,-18},{-22,2}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-38,-84},{-18,-64}})));
  Buildings.Controls.OBC.CDL.Reals.Switch switch1
    annotation (Placement(transformation(extent={{48,4},{68,24}})));
  Buildings.Controls.OBC.CDL.Reals.Switch switch2
    annotation (Placement(transformation(extent={{-2,-40},{18,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hysteresis2(
    uLow=-0.5,
    uHigh=0.5,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{54,48},{74,68}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput Mode
    "-1 is cooling, 0 is deadband, 1 is heating" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-6})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput ModeBoolean
    "true for heating; false for cooling; output the previous state if in deadband"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,44})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(final quantity="ThermodynamicTemperature",
      final unit="K") "Measured room temperature" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const5(final k=1)
    annotation (Placement(transformation(extent={{-64,64},{-44,84}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{70,-54},{90,-34}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-30,18},{-10,38}})));
equation
  connect(hysteresisCooling.y,switch2. u2) annotation (Line(points={{-48,-38},{
          -14,-38},{-14,-30},{-4,-30}},
                                    color={255,0,255}));
  connect(switch2.y,switch1. u3) annotation (Line(points={{20,-30},{38,-30},{38,
          6},{46,6}},   color={0,0,127}));
  connect(const.y,switch2. u1) annotation (Line(points={{-20,-8},{-12,-8},{-12,-22},
          {-4,-22}},color={0,0,127}));
  connect(const1.y,switch2. u3) annotation (Line(points={{-16,-74},{-12,-74},{-12,
          -38},{-4,-38}}, color={0,0,127}));
  connect(switch1.y,hysteresis2. u) annotation (Line(points={{70,14},{74,14},{74,
          44},{42,44},{42,58},{52,58}}, color={0,0,127}));
  connect(hysteresis2.y, ModeBoolean) annotation (Line(points={{76,58},{94,58},
          {94,44},{120,44}},color={255,0,255}));
  connect(hysteresisHeating.u, TZon) annotation (Line(points={{-72,24},{-94,24},
          {-94,0},{-120,0}}, color={0,0,127}));
  connect(hysteresisCooling.u, TZon) annotation (Line(points={{-72,-38},{-94,-38},
          {-94,0},{-120,0}}, color={0,0,127}));
  connect(const5.y, switch1.u1) annotation (Line(points={{-42,74},{38,74},{38,22},
          {46,22}}, color={0,0,127}));
  connect(switch1.y, reaToInt.u) annotation (Line(points={{70,14},{74,14},{74,22},
          {78,22},{78,-30},{58,-30},{58,-44},{68,-44}}, color={0,0,127}));
  connect(reaToInt.y, Mode) annotation (Line(points={{92,-44},{102,-44},{102,-30},
          {96,-30},{96,-6},{120,-6}}, color={255,127,0}));
  connect(hysteresisHeating.y, not2.u) annotation (Line(points={{-48,24},{-40,
          24},{-40,28},{-32,28}},
                              color={255,0,255}));
  connect(not2.y, switch1.u2) annotation (Line(points={{-8,28},{36,28},{36,14},{
          46,14}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatingCoolingControl;
