within cdl_models.Move.Generic;
model ZoneSetpointSource

    parameter Real TDefOccHeaSet(unit="K")=273.15+20;
  parameter Real TDefUnoHeaSet(unit="K")=273.15+15.5556;
  parameter Real TDefOccCooSet(unit="K")=273.15+25.5556;
  parameter Real TDefUnoCooSet(unit="K")=273.15+32.2222;
  parameter Real dTSheHeaSet(unit="K")=5.5556 "zone temperature setpoint delta for heating load shed";
  parameter Real dTSheCooSet(unit="K")=5.5556 "zone temperature setpoint delta for cooling load shed";

  parameter Real dTPreHeaSet(unit="K")=1.1111 "zone temperature setpoint delta for heating pre-heat";
  parameter Real dTPreCooSet(unit="K")=1.1111 "zone temperature setpoint delta for cooling pre-cool";

  parameter Real occHouSta=7;
  parameter Real occHouEnd=20;
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TPreTarHeaSet
    annotation (Placement(transformation(extent={{120,80},{160,120}}),
        iconTransformation(extent={{100,60},{140,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSheTarHeaSet
    "setpoint target for load shed"
    annotation (Placement(transformation(extent={{120,40},{160,80}}),
        iconTransformation(extent={{100,26},{140,66}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TDefHeaSet
    "nominal setpoint"
    annotation (Placement(transformation(extent={{120,0},{160,40}}),
        iconTransformation(extent={{100,-2},{140,38}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TPreTarCooSet
    "setpoint target for precool"
    annotation (Placement(transformation(extent={{120,-40},{160,0}}),
        iconTransformation(extent={{100,-40},{140,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSheTarCooSet
    "setpoint target for load shed"
    annotation (Placement(transformation(extent={{120,-80},{160,-40}}),
        iconTransformation(extent={{100,-66},{140,-26}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TDefCooSet
    "nominal setpoint"
    annotation (Placement(transformation(extent={{120,-120},{160,-80}}),
        iconTransformation(extent={{100,-102},{140,-62}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable booTimTab(
    table=[0,0; occHouSta,1; occHouEnd,0; 24,0],
    timeScale=3600,
    period=86400) if occHouSta <= occHouEnd
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable booTimTab1(
    table=[0,1; occHouEnd,0; occHouSta,1; 24,1],
    timeScale=3600,
    period=86400)
    if occHouSta > occHouEnd
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(final realTrue=
        TDefOccHeaSet, final realFalse=TDefUnoHeaSet)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1(final realTrue
      =TDefOccCooSet, final realFalse=TDefUnoCooSet)
    annotation (Placement(transformation(extent={{-20,-110},{0,-90}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    annotation (Placement(transformation(extent={{80,90},{100,110}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub1
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(final k=dTPreHeaSet)
    annotation (Placement(transformation(extent={{-20,90},{0,110}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(final k=dTSheHeaSet)
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(final k=dTPreCooSet)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(final k=dTSheCooSet)
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea2(final realTrue
      =TDefOccHeaSet + dTPreHeaSet, final realFalse=TDefUnoHeaSet + dTPreHeaSet)
    annotation (Placement(transformation(extent={{-78,92},{-58,112}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea3(final realTrue
      =TDefOccHeaSet + dTPreHeaSet, final realFalse=TDefUnoHeaSet)
    annotation (Placement(transformation(extent={{-62,64},{-42,84}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea4(final realTrue
      =TDefOccHeaSet - dTSheHeaSet, final realFalse=TDefUnoHeaSet - dTSheHeaSet)
    annotation (Placement(transformation(extent={{-96,42},{-76,62}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea5(final realTrue
      =TDefOccHeaSet - dTSheHeaSet, final realFalse=TDefUnoHeaSet)
    annotation (Placement(transformation(extent={{-90,16},{-70,36}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea6(final realTrue
      =TDefOccCooSet - dTPreCooSet, final realFalse=TDefUnoCooSet - dTPreCooSet)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea7(final realTrue
      =TDefOccCooSet - dTPreCooSet, final realFalse=TDefUnoCooSet)
    annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea8(final realTrue
      =TDefOccCooSet + dTSheCooSet, final realFalse=TDefUnoCooSet + dTSheCooSet)
    annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea9(final realTrue
      =TDefOccCooSet + dTSheCooSet, final realFalse=TDefUnoCooSet)
    annotation (Placement(transformation(extent={{-54,-126},{-34,-106}})));
equation
  connect(booTimTab.y[1], booToRea.u) annotation (Line(points={{-78,-10},{-60,
          -10},{-60,20},{-22,20}},
                              color={255,0,255}));
  connect(booTimTab.y[1], booToRea1.u) annotation (Line(points={{-78,-10},{-60,
          -10},{-60,-100},{-22,-100}},
                                color={255,0,255}));
  connect(booToRea.y, TDefHeaSet) annotation (Line(points={{2,20},{140,20}},
                     color={0,0,127}));
  connect(booToRea1.y, TDefCooSet) annotation (Line(points={{2,-100},{140,-100}},
                           color={0,0,127}));
  connect(add1.y, TPreTarHeaSet) annotation (Line(points={{102,100},{140,100}},
                     color={0,0,127}));
  connect(sub.y, TSheTarHeaSet) annotation (Line(points={{102,60},{140,60}},
                     color={0,0,127}));
  connect(sub1.y, TPreTarCooSet) annotation (Line(points={{102,-20},{140,-20}},
                           color={0,0,127}));
  connect(add2.y, TSheTarCooSet) annotation (Line(points={{102,-60},{140,-60}},
                           color={0,0,127}));
  connect(booToRea.y, add1.u1) annotation (Line(points={{2,20},{60,20},{60,106},
          {78,106}},color={0,0,127}));
  connect(booToRea.y, sub.u1) annotation (Line(points={{2,20},{60,20},{60,66},{78,
          66}},    color={0,0,127}));
  connect(booToRea1.y, sub1.u1) annotation (Line(points={{2,-100},{60,-100},{60,
          -14},{78,-14}},
                    color={0,0,127}));
  connect(booToRea1.y, add2.u1) annotation (Line(points={{2,-100},{60,-100},{60,
          -54},{78,-54}},
                     color={0,0,127}));
  connect(con.y, add1.u2) annotation (Line(points={{2,100},{40,100},{40,94},{78,
          94}}, color={0,0,127}));
  connect(con2.y, sub1.u2) annotation (Line(points={{2,-20},{40,-20},{40,-26},{78,
          -26}},    color={0,0,127}));
  connect(con3.y, add2.u2)
    annotation (Line(points={{2,-60},{40,-60},{40,-66},{78,-66}},
                                                 color={0,0,127}));
  connect(con1.y, sub.u2) annotation (Line(points={{2,60},{40,60},{40,54},{78,54}},
                color={0,0,127}));
  connect(booTimTab1.y[1], booToRea.u) annotation (Line(points={{-78,-70},{-60,
          -70},{-60,20},{-22,20}}, color={255,0,255}));
  connect(booTimTab1.y[1], booToRea1.u) annotation (Line(points={{-78,-70},{-60,
          -70},{-60,-100},{-22,-100}}, color={255,0,255}));
  annotation (defaultComponentName="douSwi",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,120}},
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
        extent={{-120,-120},{120,120}})),
    Documentation(info="<html>
<p>This block creates outputs for the zone&apos;s cooling and heating setpoint under different occupancy 
and different demand flexibility (pre-cool/pre-heat, baseline, load shed, load rebound) conditions. 
The pre-set variables are heating and cooling occupied and unoccupied setpoints under the baseline 
scenario. Then, adjustment variables such as <code>dTPreHeaSet </code>and 
<code>dTSheHeaSet </code> are applied to the heating and cooling occupied and unoccupied setpoints 
to output the desired setpoints. </p>
</html>"));
end ZoneSetpointSource;
