within cdl_models.Examples.BaseClasses;
model linearSetpointControl
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetMax
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetNominal
    annotation (Placement(transformation(extent={{-136,14},{-96,54}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput LoadShedTime
    annotation (Placement(transformation(extent={{-138,-64},{-98,-24}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput ReboundTime
    annotation (Placement(transformation(extent={{-140,-106},{-100,-66}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TCooSet
    annotation (Placement(transformation(extent={{100,-18},{140,22}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput LoadShed
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Reals.Ramp ram(raisingSlewRate=1)
    annotation (Placement(transformation(extent={{26,-28},{46,-8}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{-38,-64},{-18,-44}})));
  Buildings.Controls.OBC.CDL.Reals.Ramp ram1(raisingSlewRate=1)
    annotation (Placement(transformation(extent={{14,-98},{34,-78}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-56,-104},{-36,-84}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul1
    annotation (Placement(transformation(extent={{-18,-148},{2,-128}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{72,-56},{92,-36}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div2
    annotation (Placement(transformation(extent={{82,-116},{102,-96}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{120,-72},{140,-52}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{198,-58},{218,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{144,-36},{164,-16}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=1)
    annotation (Placement(transformation(extent={{142,-100},{162,-80}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{-60,58},{-40,78}})));
  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam(y_start=3600)
    annotation (Placement(transformation(extent={{-148,-140},{-128,-120}})));
  Buildings.Controls.OBC.CDL.Discrete.TriggeredSampler triSam1(y_start=3600)
    annotation (Placement(transformation(extent={{-146,-186},{-126,-166}})));
equation
  connect(LoadShed, ram.active) annotation (Line(points={{-120,0},{-84,0},{-84,
          -26},{24,-26}}, color={255,0,255}));
  connect(booToRea.y, mul.u1) annotation (Line(points={{-18,6},{-44,6},{-44,-40},
          {-48,-40},{-48,-48},{-40,-48}}, color={0,0,127}));
  connect(mul.y, ram.u) annotation (Line(points={{-16,-54},{-6,-54},{-6,-18},{
          24,-18}}, color={0,0,127}));
  connect(LoadShed, not1.u) annotation (Line(points={{-120,0},{-84,0},{-84,-26},
          {-60,-26},{-60,-60},{-76,-60},{-76,-94},{-58,-94}}, color={255,0,255}));
  connect(not1.y, ram1.active) annotation (Line(points={{-34,-94},{-32,-94},{
          -32,-96},{12,-96}}, color={255,0,255}));
  connect(booToRea.y, mul1.u1) annotation (Line(points={{-18,6},{-44,6},{-44,
          -40},{-48,-40},{-48,-78},{-22,-78},{-22,-122},{-28,-122},{-28,-132},{
          -20,-132}}, color={0,0,127}));
  connect(mul1.y, ram1.u) annotation (Line(points={{4,-138},{12,-138},{12,-104},
          {4,-104},{4,-88},{12,-88}}, color={0,0,127}));
  connect(ram.y, div1.u1) annotation (Line(points={{48,-18},{62,-18},{62,-40},{
          70,-40}}, color={0,0,127}));
  connect(ram1.y, div2.u1) annotation (Line(points={{36,-88},{72,-88},{72,-100},
          {80,-100}}, color={0,0,127}));
  connect(div1.y, swi.u1) annotation (Line(points={{94,-46},{110,-46},{110,-54},
          {118,-54}}, color={0,0,127}));
  connect(div2.y, swi.u3) annotation (Line(points={{104,-106},{118,-106},{118,
          -70}}, color={0,0,127}));
  connect(LoadShed, swi.u2) annotation (Line(points={{-120,0},{-84,0},{-84,-26},
          {16,-26},{16,-58},{64,-58},{64,-62},{118,-62}}, color={255,0,255}));
  connect(swi.y, lin.u) annotation (Line(points={{142,-62},{186,-62},{186,-48},
          {196,-48}}, color={0,0,127}));
  connect(TZonCooSetNominal, lin.f1) annotation (Line(points={{-116,34},{186,34},
          {186,-44},{196,-44}}, color={0,0,127}));
  connect(TZonCooSetMax, lin.f2) annotation (Line(points={{-120,90},{228,90},{
          228,-64},{196,-64},{196,-56}}, color={0,0,127}));
  connect(con.y, lin.x1) annotation (Line(points={{166,-26},{188,-26},{188,-40},
          {196,-40}}, color={0,0,127}));
  connect(con1.y, lin.x2) annotation (Line(points={{164,-90},{186,-90},{186,-64},
          {188,-64},{188,-52},{196,-52}}, color={0,0,127}));
  connect(lin.y, TCooSet) annotation (Line(points={{220,-48},{232,-48},{232,-46},
          {248,-46},{248,2},{120,2}}, color={0,0,127}));
  connect(LoadShed, pre.u) annotation (Line(points={{-120,0},{-84,0},{-84,68},{
          -62,68}}, color={255,0,255}));
  connect(pre.y, booToRea.u) annotation (Line(points={{-38,68},{-30,68},{-30,22},
          {-50,22},{-50,6},{-42,6}}, color={255,0,255}));
  connect(LoadShedTime, triSam.u) annotation (Line(points={{-118,-44},{-152,-44},
          {-152,-114},{-158,-114},{-158,-130},{-150,-130}}, color={0,0,127}));
  connect(ReboundTime, triSam1.u) annotation (Line(points={{-120,-86},{-162,-86},
          {-162,-176},{-148,-176}}, color={0,0,127}));
  connect(LoadShed, triSam.trigger) annotation (Line(points={{-120,0},{-84,0},{
          -84,-26},{-76,-26},{-76,-142},{-122,-142},{-122,-150},{-138,-150},{
          -138,-142}}, color={255,0,255}));
  connect(not1.y, triSam1.trigger) annotation (Line(points={{-34,-94},{-26,-94},
          {-26,-134},{-78,-134},{-78,-198},{-136,-198},{-136,-188}}, color={255,
          0,255}));
  connect(triSam.y, mul.u2) annotation (Line(points={{-126,-130},{-126,-92},{
          -68,-92},{-68,-62},{-50,-62},{-50,-60},{-40,-60}}, color={0,0,127}));
  connect(triSam.y, div1.u2) annotation (Line(points={{-126,-130},{-126,-92},{
          -68,-92},{-68,-62},{-50,-62},{-50,-60},{-46,-60},{-46,-70},{20,-70},{
          20,-52},{70,-52}}, color={0,0,127}));
  connect(triSam1.y, mul1.u2) annotation (Line(points={{-124,-176},{-34,-176},{
          -34,-166},{-30,-166},{-30,-144},{-20,-144}}, color={0,0,127}));
  connect(triSam1.y, div2.u2) annotation (Line(points={{-124,-176},{-34,-176},{
          -34,-166},{-30,-166},{-30,-156},{70,-156},{70,-112},{80,-112}}, color
        ={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end linearSetpointControl;
