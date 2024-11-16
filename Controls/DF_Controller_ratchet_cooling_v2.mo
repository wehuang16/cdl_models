within cdl_models.Controls;
model DF_Controller_ratchet_cooling_v2

  parameter Real TZonCooSetNominal(unit="K")=273.15+23
    "Nominal zone air temperature setpoint";

      parameter Real TZonCooSetMax(unit="K")=273.15+27
    "Maximum zone cooling temperature setpoint";
      parameter Real samplePeriod(unit="s")=300
    "Sample period of the demand flexibility control";
       parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
           parameter Real TRat=0.5
    "Ratcheting temperature";
               parameter Real TReb=0.3
    "rebound temperature";
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=1)
    annotation (Placement(transformation(extent={{-26,-54},{-6,-34}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
    table=[0,205; 43200,265; 86400,290],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-170,-22},{-150,-2}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{-88,-38},{-68,-18}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{120,-60},{140,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=3)
    annotation (Placement(transformation(extent={{70,-32},{90,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{144,-112},{164,-92}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter valueToIncrease(k=1)
    annotation (Placement(transformation(extent={{-128,22},{-96,54}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler   sam(final samplePeriod=180)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-138,10})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={24,-66})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput myOutput2 annotation (
      Placement(transformation(extent={{98,10},{138,50}}),   iconTransformation(
          extent={{100,-20},{140,20}})));
equation
  connect(lesThr.u,subt. y) annotation (Line(points={{-28,-44},{-58,-44},{-58,
          -28},{-66,-28}}, color={0,0,127}));
  connect(combiTimeTable2.y[1],subt. u2) annotation (Line(points={{-149,-12},{
          -98,-12},{-98,-34},{-90,-34}},   color={0,0,127}));
  connect(con.y,swi. u1) annotation (Line(points={{92,-22},{110,-22},{110,-42},
          {118,-42}}, color={0,0,127}));
  connect(con1.y,swi. u3) annotation (Line(points={{166,-102},{174,-102},{174,
          -66},{118,-66},{118,-58}},
                             color={0,0,127}));
  connect(combiTimeTable2.y[1],myOutput2)  annotation (Line(points={{-149,-12},
          {64,-12},{64,30},{118,30}},                       color={0,0,127}));
  connect(valueToIncrease.y, add1.u2) annotation (Line(points={{-92.8,38},{-66,
          38},{-66,64},{-56,64}},  color={0,0,127}));
  connect(swi.y,sam. u) annotation (Line(points={{142,-50},{150,-50},{150,-4},{
          -122,-4},{-122,-10},{-138,-10},{-138,-2}},
                       color={0,0,127}));
  connect(sam.y,valueToIncrease. u) annotation (Line(points={{-138,22},{-138,30},
          {-140,30},{-140,38},{-131.2,38}},         color={0,0,127}));
  connect(lim.y,subt. u1) annotation (Line(points={{28,90},{36,90},{36,-10},{
          -98,-10},{-98,-22},{-90,-22}}, color={0,0,127}));
  connect(lesThr.y,pre. u)
    annotation (Line(points={{-4,-44},{24,-44},{24,-54}}, color={255,0,255}));
  connect(pre.y,swi. u2) annotation (Line(points={{24,-78},{24,-86},{108,-86},{
          108,-50},{118,-50}},    color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DF_Controller_ratchet_cooling_v2;
