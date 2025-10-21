within cdl_models.Controls.Subsequences;
model single_zone_ratchet_heating

      parameter Real samplePeriodRatchet(unit="s")=300
    "Sample period of the demand flexibility control";
          parameter Real samplePeriodRebound(unit="s")=900
    "Sample period of rebound";
     parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";

           parameter Real TRat=-1
    "Ratcheting temperature";
           parameter Real TReb=1
    "rebound temperature";
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput loaShe
    "Load shed event flag" annotation (Placement(transformation(extent={{-240,32},
            {-200,72}}), iconTransformation(extent={{-240,32},{-200,72}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-240,-78},{-200,-38}}),  iconTransformation(extent={{-240,
            -78},{-200,-38}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonSetHeaCom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{300,22},{340,62}}), iconTransformation(extent={{300,22},{340,
            62}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ratSig annotation (
      Placement(transformation(extent={{-240,2},{-200,42}}), iconTransformation(
          extent={{-240,2},{-200,42}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput rebSig annotation (
      Placement(transformation(extent={{-240,-30},{-200,10}}),
        iconTransformation(extent={{-240,-30},{-200,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetCur(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-240,-110},{-200,-70}}), iconTransformation(extent={{-240,-110},
            {-200,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachTZonHeaSetMin
    annotation (Placement(transformation(extent={{300,-114},{340,-74}}),
        iconTransformation(extent={{300,-114},{340,-74}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachTZonHeaSetNom
    annotation (Placement(transformation(extent={{300,-156},{340,-116}}),
        iconTransformation(extent={{300,-156},{340,-116}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler sam(samplePeriod=
        samplePeriodRatchet)
    annotation (Placement(transformation(extent={{206,58},{226,78}})));
  Buildings.Controls.OBC.CDL.Reals.Add add
    annotation (Placement(transformation(extent={{70,34},{90,54}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler sam1(samplePeriod=
        samplePeriodRebound)
    annotation (Placement(transformation(extent={{206,12},{226,32}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{252,32},{272,52}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetMin(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "thermal limit zone temperature setpoint" annotation (Placement(
        transformation(extent={{-240,-154},{-200,-114}}), iconTransformation(
          extent={{-240,-144},{-200,-104}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetNom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "nominal zone temperature setpoint" annotation (Placement(transformation(
          extent={{-240,-194},{-200,-154}}), iconTransformation(extent={{-240,-180},
            {-200,-140}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          booToRea1(realTrue=TReb, realFalse=0)
    annotation (Placement(transformation(extent={{-42,-68},{-22,-48}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          booToRea(realTrue=-TRat,realFalse=0)
    annotation (Placement(transformation(extent={{-56,34},{-36,54}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi6
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{20,34},{40,54}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{156,34},{176,54}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1
    annotation (Placement(transformation(extent={{116,34},{136,54}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{152,-42},{172,-22}})));
  Buildings.Controls.OBC.CDL.Reals.Less    les1
    annotation (Placement(transformation(extent={{136,-214},{156,-194}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{178,-214},{198,-194}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{176,-104},{196,-84}})));
  Buildings.Controls.OBC.CDL.Reals.Greater
                                        gre3
    annotation (Placement(transformation(extent={{134,-104},{154,-84}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold    lesThr(t=TRatThreshold, h=0)
    annotation (Placement(transformation(extent={{-268,184},{-248,204}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-138,18},{-118,38}})));
equation
  connect(sam.y, swi1.u1) annotation (Line(points={{228,68},{242,68},{242,50},{
          250,50}},
                color={0,0,127}));
  connect(sam1.y, swi1.u3) annotation (Line(points={{228,22},{242,22},{242,34},
          {250,34}},color={0,0,127}));
  connect(swi1.y, TZonSetHeaCom)
    annotation (Line(points={{274,42},{320,42}}, color={0,0,127}));
  connect(loaShe, swi6.u2) annotation (Line(points={{-220,52},{-96,52},{-96,8},
          {2,8},{2,44},{18,44}}, color={255,0,255}));
  connect(swi6.y, add.u1) annotation (Line(points={{42,44},{60,44},{60,50},{68,
          50}}, color={0,0,127}));
  connect(add.y, min1.u1) annotation (Line(points={{92,44},{104,44},{104,50},{
          114,50}}, color={0,0,127}));
  connect(max1.u1, min1.y) annotation (Line(points={{154,50},{146,50},{146,44},
          {138,44}}, color={0,0,127}));
  connect(sam.u, max1.y) annotation (Line(points={{204,68},{192,68},{192,44},{
          178,44}}, color={0,0,127}));
  connect(max1.y, sam1.u) annotation (Line(points={{178,44},{192,44},{192,22},{
          204,22}}, color={0,0,127}));
  connect(TZon, subt.u1) annotation (Line(points={{-220,-58},{-170,-58},{-170,
          -26},{150,-26}}, color={0,0,127}));
  connect(les1.y, not1.u)
    annotation (Line(points={{158,-204},{176,-204}}, color={255,0,255}));
  connect(gre3.y, not2.u) annotation (Line(
      points={{156,-94},{174,-94}},
      color={255,0,255},
      smooth=Smooth.Bezier));
  connect(swi1.u2, loaShe) annotation (Line(points={{250,42},{186,42},{186,28},
          {2,28},{2,8},{-96,8},{-96,52},{-220,52}}, color={255,0,255}));
  connect(TZonHeaSetCur, gre3.u1) annotation (Line(points={{-220,-90},{-178,-90},
          {-178,-116},{50,-116},{50,-94},{132,-94}}, color={0,0,127}));
  connect(TZonHeaSetCur, les1.u1) annotation (Line(points={{-220,-90},{-220,-92},
          {-180,-92},{-180,-116},{52,-116},{52,-96},{124,-96},{124,-204},{134,-204}},
        color={0,0,127}));
  connect(subt.u2, TZonHeaSetCur) annotation (Line(points={{150,-38},{62,-38},{62,
          -118},{-166,-118},{-166,-90},{-220,-90}}, color={0,0,127}));
  connect(add.u2, TZonHeaSetCur) annotation (Line(points={{68,38},{50,38},{50,-116},
          {-178,-116},{-178,-90},{-220,-90}}, color={0,0,127}));
  connect(subt.y, lesThr.u) annotation (Line(points={{174,-32},{194,-32},{194,
          154},{-280,154},{-280,194},{-270,194}}, color={0,0,127}));
  connect(ratSig, and2.u2) annotation (Line(points={{-220,22},{-148,22},{-148,
          20},{-140,20}}, color={255,0,255}));
  connect(TZonHeaSetMin, gre3.u2) annotation (Line(points={{-220,-134},{-220,
          -136},{-60,-136},{-60,-184},{172,-184},{172,-112},{132,-112},{132,
          -102}}, color={0,0,127}));
  connect(TZonHeaSetNom, les1.u2) annotation (Line(points={{-220,-174},{-220,
          -176},{-140,-176},{-140,-172},{-136,-172},{-136,-132},{-88,-132},{-88,
          -176},{-64,-176},{-64,-192},{116,-192},{116,-208},{134,-208},{134,
          -212}}, color={0,0,127}));
  connect(not1.y, reachTZonHeaSetNom) annotation (Line(points={{200,-204},{292,
          -204},{292,-136},{320,-136}}, color={255,0,255}));
  connect(not2.y, reachTZonHeaSetMin)
    annotation (Line(points={{198,-94},{320,-94}}, color={255,0,255}));
  connect(TZonHeaSetNom, min1.u2) annotation (Line(points={{-220,-174},{114,-174},
          {114,38}}, color={0,0,127}));
  connect(TZonHeaSetMin, max1.u2) annotation (Line(points={{-220,-134},{-220,-136},
          {-60,-136},{-60,-184},{172,-184},{172,-112},{164,-112},{164,-52},{144,
          -52},{144,36},{148,36},{148,38},{154,38}}, color={0,0,127}));
  connect(lesThr.y, and2.u1) annotation (Line(points={{-246,194},{-184,194},{
          -184,156},{-180,156},{-180,92},{-176,92},{-176,28},{-140,28}}, color=
          {255,0,255}));
  connect(booToRea.y, swi6.u1) annotation (Line(points={{-34,44},{0,44},{0,52},
          {18,52}}, color={0,0,127}));
  connect(and2.y, booToRea.u) annotation (Line(points={{-116,28},{-68,28},{-68,
          44},{-58,44}}, color={255,0,255}));
  connect(rebSig, booToRea1.u) annotation (Line(points={{-220,-10},{-220,-12},{
          -180,-12},{-180,-64},{-52,-64},{-52,-58},{-44,-58}}, color={255,0,255}));
  connect(booToRea1.y, swi6.u3) annotation (Line(points={{-20,-58},{-20,-60},{
          -12,-60},{-12,36},{18,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -300},{300,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-300},{300,
            100}})));
end single_zone_ratchet_heating;
