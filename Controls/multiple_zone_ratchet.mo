within cdl_models.Controls;
model multiple_zone_ratchet

  parameter Integer nZones=3;
    parameter Real loadShedDurationTypical(unit="s")=7200;
    parameter Real reboundDuration(unit="s")=3600;
    parameter Real loadShedTempAmountTypical=5;
    parameter Boolean loaSheHeaAct=true;
    parameter Boolean loaSheCooAct=true;
     parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
    parameter Real TRat=1
    "Ratcheting temperature (defined as >0)";
               parameter Real TReb=1
    "rebound temperature (defined as >0)";
      parameter Real samplePeriodRatchet(unit="s")=loadShedDurationTypical*0.3333*TRat/loadShedTempAmountTypical/nZones
    "Sample period of the demand flexibility control";
          parameter Real samplePeriodRebound(unit="s")=reboundDuration*TReb/loadShedTempAmountTypical/nZones
    "Sample period of rebound";
  Subsequences.single_zone_ratchet_heating single_zone_ratchet_heating[nZones](
    samplePeriodRatchet=samplePeriodRatchet,
    samplePeriodRebound=samplePeriodRebound,
    TRatThreshold=TRatThreshold,
    TRat=TRat,
    TReb=TReb)
    annotation (Placement(transformation(extent={{204,-12},{254,16}})));
  Subsequences.temDifSelectionMin temDifSelectionMinHeaRat(nZones=nZones)
    annotation (Placement(transformation(extent={{144,162},{164,182}})));
  Subsequences.temDifSelectionMax temDifSelectionMaxHeaReb(nZones=nZones)
    annotation (Placement(transformation(extent={{148,90},{168,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput loaShe
    "Load shed event flag" annotation (Placement(transformation(extent={{-140,18},
            {-100,58}}), iconTransformation(extent={{-140,16},{-100,56}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-140,-14},{-100,26}}), iconTransformation(extent={{-142,-34},
            {-102,6}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetCur[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-140,-46},{-100,-6}}), iconTransformation(extent={{-142,-66},
            {-102,-26}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetMin(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "thermal limit zone temperature setpoint" annotation (Placement(
        transformation(extent={{-138,-110},{-98,-70}}), iconTransformation(
          extent={{-142,-136},{-102,-96}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetNom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "nominal zone temperature setpoint" annotation (Placement(transformation(
          extent={{-138,-150},{-98,-110}}), iconTransformation(extent={{-142,-172},
            {-102,-132}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetMax(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "thermal limit zone temperature setpoint" annotation (Placement(
        transformation(extent={{-138,-200},{-98,-160}}), iconTransformation(
          extent={{-142,-206},{-102,-166}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetNom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "nominal zone temperature setpoint" annotation (Placement(transformation(
          extent={{-138,-240},{-98,-200}}), iconTransformation(extent={{-140,-242},
            {-100,-202}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonHeaSetCom[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{282,32},{322,72}}), iconTransformation(extent={{280,18},{320,
            58}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1[nZones](k=true)
    annotation (Placement(transformation(extent={{26,72},{46,92}})));
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
    annotation (Placement(transformation(extent={{-24,44},{-4,64}})));
  Subsequences.temDifSelectionMin temDifSelectionMinCooReb(nZones=nZones)
    annotation (Placement(transformation(extent={{126,-108},{146,-88}})));
  Subsequences.temDifSelectionMax temDifSelectionMaxCooRat(nZones=nZones)
    annotation (Placement(transformation(extent={{160,-50},{180,-30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonCooSetCom[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{282,-144},{322,-104}}), iconTransformation(extent={{280,-150},
            {320,-110}})));
  Subsequences.single_zone_ratchet_cooling single_zone_ratchet_cooling[nZones](
    samplePeriodRatchet=samplePeriodRatchet,
    samplePeriodRebound=samplePeriodRebound,
    TRatThreshold=TRatThreshold,
    TRat=TRat,
    TReb=TReb)
    annotation (Placement(transformation(extent={{192,-140},{242,-112}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetCur[nZones](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-140,-78},{-100,-38}}), iconTransformation(extent={{-140,
            -100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi2
                                                  [nZones]
    annotation (Placement(transformation(extent={{138,18},{158,38}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi3
                                                  [nZones]
    annotation (Placement(transformation(extent={{114,-166},{134,-146}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con[nZones](k=false)
    annotation (Placement(transformation(extent={{18,-70},{38,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt1
                                                [nZones]
    annotation (Placement(transformation(extent={{-18,-46},{2,-26}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2[nZones](k=true)
    annotation (Placement(transformation(extent={{-64,44},{-44,64}})));
equation
  connect(loaShe, booScaRep1.u) annotation (Line(points={{-120,38},{-46,38},{
          -46,34},{32,34}}, color={255,0,255}));
  connect(TZonHeaSetMin, reaScaRep.u) annotation (Line(points={{-118,-90},{-42,
          -90},{-42,-74},{-34,-74}}, color={0,0,127}));
  connect(TZonHeaSetNom, reaScaRep1.u) annotation (Line(points={{-118,-130},{
          -34,-130},{-34,-104},{-24,-104}}, color={0,0,127}));
  connect(TZonCooSetMax, reaScaRep2.u) annotation (Line(points={{-118,-180},{
          -30,-180},{-30,-140},{-16,-140}}, color={0,0,127}));
  connect(TZonCooSetNom, reaScaRep3.u) annotation (Line(points={{-118,-220},{
          -18,-220},{-18,-186},{-10,-186}}, color={0,0,127}));
  connect(reaScaRep1.y,single_zone_ratchet_heating. TZonHeaSetNom) annotation (
      Line(points={{0,-104},{76,-104},{76,-16},{74,-16},{74,-2.2},{202,-2.2}},
        color={0,0,127}));
  connect(TZon,single_zone_ratchet_heating. TZon) annotation (Line(points={{
          -120,6},{72,6},{72,4.94},{202,4.94}}, color={0,0,127}));
  connect(TZon, subt.u1) annotation (Line(points={{-120,6},{-28,6},{-28,38},{
          -34,38},{-34,60},{-26,60}},    color={0,0,127}));
  connect(subt.y, temDifSelectionMinHeaRat.TZonTemDif) annotation (Line(points={{-2,54},
          {6,54},{6,104},{134,104},{134,176.6},{142,176.6}},
                                                     color={0,0,127}));
  connect(subt.y, temDifSelectionMaxHeaReb.TZonTemDif) annotation (Line(points={{-2,54},
          {6,54},{6,104.6},{146,104.6}},                 color={0,0,127}));
  connect(single_zone_ratchet_cooling.TZonCooSetCom, TZonCooSetCom) annotation (
     Line(points={{244,-116.06},{276,-116.06},{276,-124},{302,-124}}, color={0,
          0,127}));
  connect(single_zone_ratchet_heating.TZonSetHeaCom, TZonHeaSetCom) annotation (
     Line(points={{256,11.94},{276,11.94},{276,52},{302,52}}, color={0,0,127}));
  connect(con1.y, logSwi2.u2) annotation (Line(points={{48,82},{64,82},{64,92},
          {80,92},{80,28},{136,28}},
                    color={255,0,255}));
  connect(booScaRep1.y, logSwi2.u1) annotation (Line(points={{56,34},{128,34},{
          128,36},{136,36}}, color={255,0,255}));
  connect(logSwi2.y, single_zone_ratchet_heating.loaShe) annotation (Line(
        points={{160,28},{196,28},{196,12.64},{202,12.64}}, color={255,0,255}));
  connect(logSwi3.y, single_zone_ratchet_cooling.loaShe) annotation (Line(
        points={{136,-156},{180,-156},{180,-115.36},{190,-115.36}}, color={255,
          0,255}));
  connect(con.y, logSwi2.u3) annotation (Line(points={{40,-60},{66,-60},{66,8},
          {128,8},{128,20},{136,20}}, color={255,0,255}));
  connect(TZon, single_zone_ratchet_cooling.TZon) annotation (Line(points={{
          -120,6},{72,6},{72,4},{192,4},{192,-56},{204,-56},{204,-106},{182,
          -106},{182,-123.06},{190,-123.06}}, color={0,0,127}));
  connect(reaScaRep.y, single_zone_ratchet_heating.TZonHeaSetMin) annotation (
      Line(points={{-10,-74},{12,-74},{12,-76},{80,-76},{80,0.32},{202,0.32}},
        color={0,0,127}));
  connect(reaScaRep2.y, single_zone_ratchet_cooling.TZonCooSetMax) annotation (
      Line(points={{8,-140},{102,-140},{102,-136},{182,-136},{182,-132.58},{190,
          -132.58}}, color={0,0,127}));
  connect(reaScaRep3.y, single_zone_ratchet_cooling.TZonCooSetNom) annotation (
      Line(points={{14,-186},{184,-186},{184,-135.1},{190.2,-135.1}}, color={0,
          0,127}));
  connect(TZonHeaSetCur, single_zone_ratchet_heating.TZonHeaSetCur) annotation (
     Line(points={{-120,-26},{-46,-26},{-46,-14},{72,-14},{72,2.7},{202,2.7}},
        color={0,0,127}));
  connect(TZonCooSetCur, single_zone_ratchet_cooling.TZonCooSetCur) annotation (
     Line(points={{-120,-58},{4,-58},{4,-96},{116,-96},{116,-125.3},{190,-125.3}},
        color={0,0,127}));
  connect(temDifSelectionMinHeaRat.actionFlag, single_zone_ratchet_heating.ratSig)
    annotation (Line(points={{166,172},{180,172},{180,10.54},{202,10.54}},
        color={255,0,255}));
  connect(temDifSelectionMaxHeaReb.actionFlag, single_zone_ratchet_heating.rebSig)
    annotation (Line(points={{170,100},{184,100},{184,8.3},{202,8.3}}, color={
          255,0,255}));
  connect(single_zone_ratchet_heating.reachTZonHeaSetMin,
    temDifSelectionMinHeaRat.ignoreFlag) annotation (Line(points={{256,2.42},{
          256,166.2},{142,166.2}}, color={255,0,255}));
  connect(single_zone_ratchet_heating.reachTZonHeaSetNom,
    temDifSelectionMaxHeaReb.ignoreFlag) annotation (Line(points={{256,-0.52},{
          266,-0.52},{266,112},{146,112},{146,94.2}}, color={255,0,255}));
  connect(temDifSelectionMaxCooRat.actionFlag, single_zone_ratchet_cooling.ratSig)
    annotation (Line(points={{182,-40},{190,-40},{190,-104},{186,-104},{186,
          -112},{184,-112},{184,-117.46},{190,-117.46}}, color={255,0,255}));
  connect(temDifSelectionMinCooReb.actionFlag, single_zone_ratchet_cooling.rebSig)
    annotation (Line(points={{148,-98},{176,-98},{176,-119.7},{190,-119.7}},
        color={255,0,255}));
  connect(single_zone_ratchet_cooling.reachTZonCooSetNom,
    temDifSelectionMinCooReb.ignoreFlag) annotation (Line(points={{244,-128.52},
          {124,-128.52},{124,-103.8}}, color={255,0,255}));
  connect(temDifSelectionMaxCooRat.ignoreFlag, single_zone_ratchet_cooling.reachTZonCooSetMax)
    annotation (Line(points={{158,-45.8},{150,-45.8},{150,-58},{254,-58},{254,
          -125.58},{244,-125.58}}, color={255,0,255}));
  connect(TZonHeaSetCur, subt.u2) annotation (Line(points={{-120,-26},{-46,-26},
          {-46,-14},{-36,-14},{-36,48},{-26,48}}, color={0,0,127}));
  connect(TZon, subt1.u1) annotation (Line(points={{-120,6},{-22,6},{-22,-20},{
          -28,-20},{-28,-30},{-20,-30}}, color={0,0,127}));
  connect(TZonCooSetCur, subt1.u2) annotation (Line(points={{-120,-58},{-30,-58},
          {-30,-42},{-20,-42}}, color={0,0,127}));
  connect(subt1.y, temDifSelectionMaxCooRat.TZonTemDif)
    annotation (Line(points={{4,-36},{6,-35.4},{158,-35.4}}, color={0,0,127}));
  connect(subt1.y, temDifSelectionMinCooReb.TZonTemDif) annotation (Line(points
        ={{4,-36},{114,-36},{114,-93.4},{124,-93.4}}, color={0,0,127}));
  connect(booScaRep1.y, logSwi3.u1) annotation (Line(points={{56,34},{64,34},{64,
          -148},{112,-148}}, color={255,0,255}));
  connect(con.y, logSwi3.u3) annotation (Line(points={{40,-60},{52,-60},{52,-170},
          {112,-170},{112,-164}}, color={255,0,255}));
  connect(con2.y, logSwi3.u2) annotation (Line(points={{-42,54},{-36,54},{-36,72},
          {10,72},{10,-28},{18,-28},{18,-44},{54,-44},{54,-156},{112,-156}},
        color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -220},{280,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-220},{280,
            100}})));
end multiple_zone_ratchet;
