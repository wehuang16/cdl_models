within cdl_models.Controls;
model multiple_zone_ratchet

  parameter Integer nZones=3;
  Subsequences.single_zone_ratchet_cooling single_zone_ratchet_cooling[nZones](
      TRatThreshold=1)
    annotation (Placement(transformation(extent={{204,-12},{254,16}})));
  Subsequences.temDifSelectionMin temDifSelectionMinHeaRat(nZones=nZones)
    annotation (Placement(transformation(extent={{104,78},{124,98}})));
  Subsequences.temDifSelectionMax temDifSelectionMaxHeaReb(nZones=nZones)
    annotation (Placement(transformation(extent={{126,-62},{146,-42}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput heaCooMod annotation (
      Placement(transformation(extent={{-140,54},{-100,94}}),
        iconTransformation(extent={{-240,64},{-200,104}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput loaShe
    "Load shed event flag" annotation (Placement(transformation(extent={{-140,18},
            {-100,58}}), iconTransformation(extent={{-240,32},{-200,72}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-140,-14},{-100,26}}), iconTransformation(extent={{-240,-78},
            {-200,-38}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonSetCur[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-140,-46},{-100,-6}}), iconTransformation(extent={{-240,-110},
            {-200,-70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetLim(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "thermal limit zone temperature setpoint" annotation (Placement(
        transformation(extent={{-140,-90},{-100,-50}}), iconTransformation(
          extent={{-240,-144},{-200,-104}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetNom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "nominal zone temperature setpoint" annotation (Placement(transformation(
          extent={{-140,-130},{-100,-90}}), iconTransformation(extent={{-240,-180},
            {-200,-140}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetLim(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "thermal limit zone temperature setpoint" annotation (Placement(
        transformation(extent={{-136,-180},{-96,-140}}), iconTransformation(
          extent={{-240,-214},{-200,-174}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetNom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "nominal zone temperature setpoint" annotation (Placement(transformation(
          extent={{-136,-220},{-96,-180}}), iconTransformation(extent={{-238,
            -250},{-198,-210}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonSetCom[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{282,32},{322,72}}), iconTransformation(extent={{300,22},{340,
            62}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=
        nZones) annotation (Placement(transformation(extent={{24,52},{44,72}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep1(nout=
        nZones) annotation (Placement(transformation(extent={{34,24},{54,44}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=nZones)
    annotation (Placement(transformation(extent={{-32,-84},{-12,-64}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep1(nout=
        nZones)
    annotation (Placement(transformation(extent={{-22,-114},{-2,-94}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep2(nout=
        nZones)
    annotation (Placement(transformation(extent={{-14,-150},{6,-130}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep3(nout=
        nZones)
    annotation (Placement(transformation(extent={{-8,-196},{12,-176}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt[nZones]
    annotation (Placement(transformation(extent={{-34,-42},{-14,-22}})));
  Subsequences.temDifSelectionMin temDifSelectionMinCooReb(nZones=nZones)
    annotation (Placement(transformation(extent={{126,-108},{146,-88}})));
  Subsequences.temDifSelectionMax temDifSelectionMaxCooRat(nZones=nZones)
    annotation (Placement(transformation(extent={{102,44},{122,64}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi[nZones]
    annotation (Placement(transformation(extent={{144,62},{164,82}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi1[nZones]
    annotation (Placement(transformation(extent={{174,-82},{194,-62}})));
equation
  connect(heaCooMod, booScaRep.u) annotation (Line(points={{-120,74},{14,74},{
          14,62},{22,62}}, color={255,0,255}));
  connect(booScaRep.y, single_zone_ratchet_cooling.heaCooMod) annotation (Line(
        points={{46,62},{80,62},{80,18},{202,18},{202,14.88}}, color={255,0,255}));
  connect(loaShe, booScaRep1.u) annotation (Line(points={{-120,38},{-46,38},{
          -46,34},{32,34}}, color={255,0,255}));
  connect(booScaRep1.y, single_zone_ratchet_cooling.loaShe) annotation (Line(
        points={{56,34},{72,34},{72,12.64},{202,12.64}}, color={255,0,255}));
  connect(TZonHeaSetLim, reaScaRep.u) annotation (Line(points={{-120,-70},{-44,
          -70},{-44,-74},{-34,-74}}, color={0,0,127}));
  connect(TZonHeaSetNom, reaScaRep1.u) annotation (Line(points={{-120,-110},{
          -34,-110},{-34,-104},{-24,-104}}, color={0,0,127}));
  connect(TZonCooSetLim, reaScaRep2.u) annotation (Line(points={{-116,-160},{
          -30,-160},{-30,-140},{-16,-140}}, color={0,0,127}));
  connect(TZonCooSetNom, reaScaRep3.u) annotation (Line(points={{-116,-200},{
          -18,-200},{-18,-186},{-10,-186}}, color={0,0,127}));
  connect(reaScaRep.y, single_zone_ratchet_cooling.TZonHeaSetLim) annotation (
      Line(points={{-10,-74},{72,-74},{72,0.32},{202,0.32}}, color={0,0,127}));
  connect(reaScaRep1.y, single_zone_ratchet_cooling.TZonHeaSetNom) annotation (
      Line(points={{0,-104},{76,-104},{76,-16},{74,-16},{74,-2.2},{202,-2.2}},
        color={0,0,127}));
  connect(reaScaRep2.y, single_zone_ratchet_cooling.TZonCooSetLim) annotation (
      Line(points={{8,-140},{16,-140},{16,-4.58},{202,-4.58}}, color={0,0,127}));
  connect(reaScaRep3.y, single_zone_ratchet_cooling.TZonCooSetNom) annotation (
      Line(points={{14,-186},{76,-186},{76,-104},{78,-104},{78,-7.1},{202.2,
          -7.1}}, color={0,0,127}));
  connect(TZon, single_zone_ratchet_cooling.TZon) annotation (Line(points={{
          -120,6},{72,6},{72,4.94},{202,4.94}}, color={0,0,127}));
  connect(TZonSetCur, single_zone_ratchet_cooling.TZonSetCur) annotation (Line(
        points={{-120,-26},{-84,-26},{-84,2.7},{202,2.7}}, color={0,0,127}));
  connect(single_zone_ratchet_cooling.TZonSetCom, TZonSetCom) annotation (Line(
        points={{256,11.94},{276,11.94},{276,52},{302,52}}, color={0,0,127}));
  connect(TZon, subt.u1) annotation (Line(points={{-120,6},{-38,6},{-38,-16},{
          -44,-16},{-44,-26},{-36,-26}}, color={0,0,127}));
  connect(TZonSetCur, subt.u2) annotation (Line(points={{-120,-26},{-46,-26},{
          -46,-38},{-36,-38}}, color={0,0,127}));
  connect(temDifSelectionMinHeaRat.actionFlag, logSwi.u1) annotation (Line(
        points={{126,88},{134,88},{134,80},{142,80}}, color={255,0,255}));
  connect(temDifSelectionMaxCooRat.actionFlag, logSwi.u3) annotation (Line(
        points={{124,54},{134,54},{134,64},{142,64}}, color={255,0,255}));
  connect(booScaRep.y, logSwi.u2) annotation (Line(points={{46,62},{92,62},{92,
          72},{142,72}}, color={255,0,255}));
  connect(temDifSelectionMaxHeaReb.actionFlag, logSwi1.u1) annotation (Line(
        points={{148,-52},{164,-52},{164,-64},{172,-64}}, color={255,0,255}));
  connect(temDifSelectionMinCooReb.actionFlag, logSwi1.u3) annotation (Line(
        points={{148,-98},{164,-98},{164,-80},{172,-80}}, color={255,0,255}));
  connect(booScaRep.y, logSwi1.u2) annotation (Line(points={{46,62},{86,62},{86,
          -76},{172,-76},{172,-72}}, color={255,0,255}));
  connect(logSwi.y, single_zone_ratchet_cooling.ratSig) annotation (Line(points
        ={{166,72},{176,72},{176,10.54},{202,10.54}}, color={255,0,255}));
  connect(logSwi1.y, single_zone_ratchet_cooling.rebSig) annotation (Line(
        points={{196,-72},{264,-72},{264,24},{174,24},{174,8.3},{202,8.3}},
        color={255,0,255}));
  connect(subt.y, temDifSelectionMinHeaRat.TZonTemDif) annotation (Line(points=
          {{-12,-32},{-2,-32},{-2,92.6},{102,92.6}}, color={0,0,127}));
  connect(subt.y, temDifSelectionMaxCooRat.TZonTemDif) annotation (Line(points=
          {{-12,-32},{-2,-32},{-2,92},{90,92},{90,58.6},{100,58.6}}, color={0,0,
          127}));
  connect(subt.y, temDifSelectionMaxHeaReb.TZonTemDif) annotation (Line(points=
          {{-12,-32},{114,-32},{114,-47.4},{124,-47.4}}, color={0,0,127}));
  connect(subt.y, temDifSelectionMinCooReb.TZonTemDif) annotation (Line(points=
          {{-12,-32},{84,-32},{84,-93.4},{124,-93.4}}, color={0,0,127}));
  connect(temDifSelectionMaxHeaReb.ignoreFlag, single_zone_ratchet_cooling.reachTZonSetNom)
    annotation (Line(points={{124,-57.8},{116,-57.8},{116,-18},{260,-18},{260,
          -0.52},{256,-0.52}}, color={255,0,255}));
  connect(temDifSelectionMinCooReb.ignoreFlag, single_zone_ratchet_cooling.reachTZonSetNom)
    annotation (Line(points={{124,-103.8},{116,-103.8},{116,-18},{260,-18},{260,
          -0.52},{256,-0.52}}, color={255,0,255}));
  connect(temDifSelectionMinHeaRat.ignoreFlag, single_zone_ratchet_cooling.reachTZonSetLim)
    annotation (Line(points={{102,82.2},{94,82.2},{94,70},{132,70},{132,36},{
          266,36},{266,2.42},{256,2.42}}, color={255,0,255}));
  connect(temDifSelectionMaxCooRat.ignoreFlag, single_zone_ratchet_cooling.reachTZonSetLim)
    annotation (Line(points={{100,48.2},{92,48.2},{92,36},{266,36},{266,2.42},{
          256,2.42}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -220},{280,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-220},{280,
            100}})));
end multiple_zone_ratchet;
