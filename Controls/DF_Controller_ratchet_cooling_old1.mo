within cdl_models.Controls;
model DF_Controller_ratchet_cooling_old1

  parameter Real TZonCooSetNominal(unit="K")=273.15+23
    "Nominal zone air temperature setpoint";

      parameter Real TZonCooSetMax(unit="K")=273.15+27
    "Maximum zone cooling temperature setpoint";
      parameter Real samplePeriodRatchet(unit="s")=300
    "Sample period of the demand flexibility control";
          parameter Real samplePeriodRebound(unit="s")=900
    "Sample period of rebound";
       parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
           parameter Real TRat=0.5
    "Ratcheting temperature";
               parameter Real TReb=0.3
    "rebound temperature";
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput loadShed
    "Load shed event flag" annotation (Placement(transformation(extent={{-238,56},
            {-198,96}}), iconTransformation(extent={{-238,56},{-198,96}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-238,-104},{-198,-64}}), iconTransformation(extent={{-238,
            -104},{-198,-64}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonCooSet(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature cooling setpoint" annotation (Placement(transformation(
          extent={{300,20},{340,60}}), iconTransformation(extent={{300,20},{340,
            60}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=
        samplePeriodRatchet, final y_start=TZonCooSetNominal)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-56,78},{-36,98}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{12,32},{32,52}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-50,-46},{-30,-26}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold    lesThr(t=TRatThreshold, h=0)
    annotation (Placement(transformation(extent={{-4,-96},{16,-76}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{-164,-44},{-144,-24}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=TZonCooSetMax, uMin=
        TZonCooSetNominal)
    annotation (Placement(transformation(extent={{36,-2},{56,18}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=TRat,
      realFalse=0)
    annotation (Placement(transformation(extent={{66,-166},{86,-146}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const(final k=TReb)
    annotation (Placement(transformation(extent={{-192,-40},{-172,-20}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler   sam(final samplePeriod=
        samplePeriodRatchet)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-44,4})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={44,-88})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonTempDiff annotation (
      Placement(transformation(extent={{300,-52},{340,-12}}),iconTransformation(
          extent={{102,-14},{142,26}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi2
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-160,14},{-140,34}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi3
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-116,-54},{-96,-34}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput DoRat annotation (
      Placement(transformation(extent={{-238,26},{-198,66}}),
        iconTransformation(extent={{-238,26},{-198,66}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput DoReb annotation (
      Placement(transformation(extent={{-238,-6},{-198,34}}),
        iconTransformation(extent={{-238,-6},{-198,34}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant const1(final k=0)
    annotation (Placement(transformation(extent={{-188,-82},{-168,-62}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetAct(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Actual zone temperature cooling setpoint" annotation (Placement(
        transformation(extent={{-240,-156},{-200,-116}}), iconTransformation(
          extent={{-138,-126},{-98,-86}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachComfortLimit
    annotation (Placement(transformation(extent={{300,-92},{340,-52}}),
        iconTransformation(extent={{300,-92},{340,-52}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr1(t=TZonCooSetMax)
    annotation (Placement(transformation(extent={{88,6},{108,26}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{138,4},{158,24}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel1(final samplePeriod=
        samplePeriodRebound, final y_start=TZonCooSetNominal)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-58,44},{-38,64}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi4
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-20,68},{0,88}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler   sam1(final samplePeriod=
        samplePeriodRebound)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={24,-34})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi5
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-24,14},{-4,34}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachNominalTemp
    annotation (Placement(transformation(extent={{302,-134},{342,-94}}),
        iconTransformation(extent={{100,-122},{140,-82}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold
                                                 greThr(t=TZonCooSetNominal)
    annotation (Placement(transformation(extent={{196,-20},{216,0}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{250,-24},{270,-4}})));
equation
  connect(loadShed, swi1.u2) annotation (Line(points={{-218,76},{-62,76},{-62,
          72},{-30,72},{-30,62},{-28,62},{-28,40},{-34,40},{-34,36},{-42,36},{
          -42,32},{-70,32},{-70,-26},{-72,-26},{-72,-36},{-52,-36}},
        color={255,0,255}));
  connect(TZon, subt.u2) annotation (Line(points={{-218,-84},{-82,-84},{-82,-78},
          {-72,-78}},      color={0,0,127}));
  connect(subt.y, lesThr.u) annotation (Line(points={{-48,-72},{-14,-72},{-14,
          -86},{-6,-86}},  color={0,0,127}));
  connect(add1.y, lim.u)
    annotation (Line(points={{34,42},{42,42},{42,24},{26,24},{26,8},{34,8}},
                                                             color={0,0,127}));
  connect(lim.y, TZonCooSet) annotation (Line(points={{58,8},{66,8},{66,48},{
          184,48},{184,40},{320,40}},
                    color={0,0,127}));
  connect(lim.y, uniDel.u) annotation (Line(points={{58,8},{66,8},{66,104},{-66,
          104},{-66,88},{-58,88}},
                     color={0,0,127}));
  connect(const.y, gai.u) annotation (Line(points={{-170,-30},{-170,-34},{-166,
          -34}},           color={0,0,127}));
  connect(sam.u, swi1.y) annotation (Line(points={{-44,-8},{-44,-20},{-20,-20},
          {-20,-36},{-28,-36}},                     color={0,0,127}));
  connect(lesThr.y, pre.u) annotation (Line(points={{18,-86},{25,-86},{25,-88},
          {32,-88}}, color={255,0,255}));
  connect(pre.y, booToRea.u)
    annotation (Line(points={{56,-88},{64,-88},{64,-140},{56,-140},{56,-156},{64,
          -156}},                                         color={255,0,255}));
  connect(swi3.y, swi1.u3)
    annotation (Line(points={{-94,-44},{-52,-44}}, color={0,0,127}));
  connect(gai.y, swi3.u1) annotation (Line(points={{-142,-34},{-140,-34},{-140,
          -36},{-118,-36}}, color={0,0,127}));
  connect(swi3.u2, DoReb) annotation (Line(points={{-118,-44},{-130,-44},{-130,
          8},{-192,8},{-192,14},{-218,14}},
                          color={255,0,255}));
  connect(const1.y, swi3.u3) annotation (Line(points={{-166,-72},{-146,-72},{
          -146,-52},{-118,-52}}, color={0,0,127}));
  connect(DoRat, swi2.u2) annotation (Line(points={{-218,46},{-188,46},{-188,24},
          {-162,24}}, color={255,0,255}));
  connect(booToRea.y, swi2.u1) annotation (Line(points={{88,-156},{128,-156},{128,
          -100},{-198,-100},{-198,32},{-162,32}},     color={0,0,127}));
  connect(const1.y, swi2.u3) annotation (Line(points={{-166,-72},{-158,-72},{
          -158,-48},{-196,-48},{-196,16},{-162,16}}, color={0,0,127}));
  connect(swi2.y, swi1.u1) annotation (Line(points={{-138,24},{-84,24},{-84,-28},
          {-52,-28}}, color={0,0,127}));
  connect(subt.y, TZonTempDiff) annotation (Line(points={{-48,-72},{-10,-72},{
          -10,-70},{290,-70},{290,-32},{320,-32}},
                           color={0,0,127}));
  connect(TZonCooSetAct, subt.u1) annotation (Line(points={{-220,-136},{-186,
          -136},{-186,-88},{-80,-88},{-80,-66},{-72,-66}},
                                                 color={0,0,127}));
  connect(lim.y, lesThr1.u)
    annotation (Line(points={{58,8},{66,8},{66,16},{86,16}}, color={0,0,127}));
  connect(lesThr1.y, not1.u) annotation (Line(points={{110,16},{128,16},{128,14},
          {136,14}}, color={255,0,255}));
  connect(not1.y, reachComfortLimit) annotation (Line(points={{160,14},{182,14},
          {182,-72},{320,-72}}, color={255,0,255}));
  connect(uniDel1.u, lim.y) annotation (Line(points={{-60,54},{-62,54},{-62,48},
          {-68,48},{-68,-6},{74,-6},{74,8},{58,8}}, color={0,0,127}));
  connect(swi1.y, sam1.u) annotation (Line(points={{-28,-36},{8,-36},{8,-56},{
          24,-56},{24,-46}}, color={0,0,127}));
  connect(add1.u2, swi5.y) annotation (Line(points={{10,36},{2,36},{2,30},{6,30},
          {6,24},{-2,24}}, color={0,0,127}));
  connect(swi4.y, add1.u1) annotation (Line(points={{2,78},{10,78},{10,58},{2,
          58},{2,48},{10,48}}, color={0,0,127}));
  connect(uniDel.y, swi4.u1)
    annotation (Line(points={{-34,88},{-34,86},{-22,86}}, color={0,0,127}));
  connect(uniDel1.y, swi4.u3)
    annotation (Line(points={{-36,54},{-22,54},{-22,70}}, color={0,0,127}));
  connect(sam.y, swi5.u1) annotation (Line(points={{-44,16},{-40,16},{-40,34},{
          -26,34},{-26,32}}, color={0,0,127}));
  connect(sam1.y, swi5.u3) annotation (Line(points={{24,-22},{24,6},{-26,6},{
          -26,16}}, color={0,0,127}));
  connect(loadShed, swi4.u2) annotation (Line(points={{-218,76},{-62,76},{-62,
          72},{-30,72},{-30,78},{-22,78}}, color={255,0,255}));
  connect(loadShed, swi5.u2) annotation (Line(points={{-218,76},{-62,76},{-62,
          72},{-30,72},{-30,62},{-28,62},{-28,40},{-34,40},{-34,36},{-42,36},{
          -42,32},{-34,32},{-34,24},{-26,24}},
                                           color={255,0,255}));
  connect(lim.y, greThr.u) annotation (Line(points={{58,8},{66,8},{66,48},{94,
          48},{94,74},{184,74},{184,-10},{194,-10}}, color={0,0,127}));
  connect(greThr.y, not2.u) annotation (Line(points={{218,-10},{238,-10},{238,
          -14},{248,-14}}, color={255,0,255}));
  connect(not2.y, reachNominalTemp) annotation (Line(points={{272,-14},{294,-14},
          {294,-114},{322,-114}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -180},{300,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},{300,
            100}})));
end DF_Controller_ratchet_cooling_old1;
