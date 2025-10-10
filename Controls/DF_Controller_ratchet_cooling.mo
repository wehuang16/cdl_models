within cdl_models.Controls;
model DF_Controller_ratchet_cooling


      parameter Real samplePeriodRatchet(unit="s")=300
    "Sample period of the demand flexibility control";
          parameter Real samplePeriodRebound(unit="s")=900
    "Sample period of rebound";
    parameter Real TRatCoo=0.5
    "Ratcheting temperature cooling (>0)";
               parameter Real TRebCoo=-0.3
    "rebound temperature cooling (<0)";
           parameter Real TRatHea=-0.5
    "Ratcheting temperature heating (<0)";
           parameter Real TRebHea=0.3
    "rebound temperature heating (>0)";
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
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonSetCom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{300,22},{340,62}}), iconTransformation(extent={{300,22},{340,
            62}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonTemDif annotation (
      Placement(transformation(extent={{300,-52},{340,-12}}),
        iconTransformation(extent={{300,-20},{340,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ratSig annotation (
      Placement(transformation(extent={{-240,2},{-200,42}}), iconTransformation(
          extent={{-240,2},{-200,42}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput rebSig annotation (
      Placement(transformation(extent={{-240,-30},{-200,10}}),
        iconTransformation(extent={{-240,-30},{-200,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonSetCur(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-240,-110},{-200,-70}}), iconTransformation(extent={{-240,
            -110},{-200,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachTZonSetMax
    annotation (Placement(transformation(extent={{300,-114},{340,-74}}),
        iconTransformation(extent={{300,-114},{340,-74}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachTZonSetMin
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const1(final k=0)
    annotation (Placement(transformation(extent={{-90,-108},{-70,-88}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi2
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-38,-90},{-18,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput heaCooMod annotation (
      Placement(transformation(extent={{-240,68},{-200,108}}),
        iconTransformation(extent={{-240,64},{-200,104}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonSetMax(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Maximum zone temperature setpoint" annotation (Placement(transformation(
          extent={{-240,-154},{-200,-114}}), iconTransformation(extent={{-240,
            -144},{-200,-104}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonSetMin(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "minimum zone temperature setpoint" annotation (Placement(transformation(
          extent={{-240,-194},{-200,-154}}), iconTransformation(extent={{-240,
            -180},{-200,-140}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          booToRea1(realTrue=TRebHea, realFalse
      =TRebCoo)
    annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi4
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-36,32},{-16,52}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const3(final k=0)
    annotation (Placement(transformation(extent={{-86,16},{-66,36}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          booToRea(realTrue=TRatHea, realFalse=
        TRatCoo)
    annotation (Placement(transformation(extent={{-88,60},{-68,80}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi6
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{20,34},{40,54}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{156,34},{176,54}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1
    annotation (Placement(transformation(extent={{116,34},{136,54}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{152,-42},{172,-22}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre
    annotation (Placement(transformation(extent={{134,-146},{154,-126}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{176,-146},{196,-126}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{176,-104},{196,-84}})));
  Buildings.Controls.OBC.CDL.Reals.Less les
    annotation (Placement(transformation(extent={{134,-104},{154,-84}})));
equation
  connect(sam.y, swi1.u1) annotation (Line(points={{228,68},{242,68},{242,50},{
          250,50}},
                color={0,0,127}));
  connect(sam1.y, swi1.u3) annotation (Line(points={{228,22},{242,22},{242,34},
          {250,34}},color={0,0,127}));
  connect(rebSig, swi2.u2) annotation (Line(points={{-220,-10},{-154,-10},{-154,
          -80},{-40,-80}}, color={255,0,255}));
  connect(const1.y, swi2.u3) annotation (Line(points={{-68,-98},{-48,-98},{-48,
          -88},{-40,-88}},
                      color={0,0,127}));
  connect(booToRea1.y, swi2.u1) annotation (Line(points={{-68,-56},{-48,-56},{-48,
          -72},{-40,-72}}, color={0,0,127}));
  connect(ratSig, swi4.u2) annotation (Line(points={{-220,22},{-158,22},{-158,
          42},{-38,42}},
                    color={255,0,255}));
  connect(booToRea.y, swi4.u1) annotation (Line(points={{-66,70},{-58,70},{-58,50},
          {-38,50}}, color={0,0,127}));
  connect(const3.y, swi4.u3) annotation (Line(points={{-64,26},{-46,26},{-46,34},
          {-38,34}}, color={0,0,127}));
  connect(swi1.y, TZonSetCom)
    annotation (Line(points={{274,42},{320,42}}, color={0,0,127}));
  connect(loaShe, swi6.u2) annotation (Line(points={{-220,52},{-96,52},{-96,8},
          {2,8},{2,44},{18,44}}, color={255,0,255}));
  connect(swi4.y, swi6.u1) annotation (Line(points={{-14,42},{-4,42},{-4,52},{
          18,52}}, color={0,0,127}));
  connect(swi2.y, swi6.u3) annotation (Line(points={{-16,-80},{10,-80},{10,36},
          {18,36}}, color={0,0,127}));
  connect(swi6.y, add.u1) annotation (Line(points={{42,44},{60,44},{60,50},{68,
          50}}, color={0,0,127}));
  connect(TZonSetMax, min1.u2) annotation (Line(points={{-220,-134},{70,-134},{70,
          18},{106,18},{106,38},{114,38}},    color={0,0,127}));
  connect(TZonSetMin, max1.u2) annotation (Line(points={{-220,-174},{88,-174},{
          88,8},{144,8},{144,38},{154,38}}, color={0,0,127}));
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
  connect(subt.y, TZonTemDif)
    annotation (Line(points={{174,-32},{320,-32}}, color={0,0,127}));
  connect(TZonSetMin, gre.u2) annotation (Line(points={{-220,-174},{88,-174},{
          88,-144},{132,-144}}, color={0,0,127}));
  connect(gre.y, not1.u)
    annotation (Line(points={{156,-136},{174,-136}}, color={255,0,255}));
  connect(not1.y, reachTZonSetMin)
    annotation (Line(points={{198,-136},{320,-136}}, color={255,0,255}));
  connect(TZonSetMax, les.u2) annotation (Line(points={{-220,-134},{70,-134},{
          70,-102},{132,-102}}, color={0,0,127}));
  connect(not2.y, reachTZonSetMax)
    annotation (Line(points={{198,-94},{320,-94}}, color={255,0,255}));
  connect(les.y, not2.u) annotation (Line(
      points={{156,-94},{174,-94}},
      color={255,0,255},
      smooth=Smooth.Bezier));
  connect(swi1.u2, loaShe) annotation (Line(points={{250,42},{186,42},{186,28},
          {2,28},{2,8},{-96,8},{-96,52},{-220,52}}, color={255,0,255}));
  connect(TZonSetCur, les.u1) annotation (Line(points={{-220,-90},{-178,-90},{-178,
          -116},{50,-116},{50,-94},{132,-94}},        color={0,0,127}));
  connect(TZonSetCur, gre.u1) annotation (Line(points={{-220,-90},{-178,-90},{-178,
          -116},{118,-116},{118,-136},{132,-136}},      color={0,0,127}));
  connect(subt.u2, TZonSetCur) annotation (Line(points={{150,-38},{50,-38},{50,-116},
          {-178,-116},{-178,-90},{-220,-90}},           color={0,0,127}));
  connect(add.u2, TZonSetCur) annotation (Line(points={{68,38},{50,38},{50,-116},
          {-178,-116},{-178,-90},{-220,-90}},                      color={0,0,
          127}));
  connect(heaCooMod, booToRea.u) annotation (Line(points={{-220,88},{-108,88},{-108,
          70},{-90,70}}, color={255,0,255}));
  connect(heaCooMod, booToRea1.u) annotation (Line(points={{-220,88},{-108,88},{
          -108,-56},{-92,-56}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},
            {300,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},{300,100}})));
end DF_Controller_ratchet_cooling;
