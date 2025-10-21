within cdl_models.Controls.Subsequences;
model single_zone_ratchet

      parameter Real samplePeriodRatchet(unit="s")=300
    "Sample period of the demand flexibility control";
          parameter Real samplePeriodRebound(unit="s")=900
    "Sample period of rebound";
     parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
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
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachTZonSetLim
    annotation (Placement(transformation(extent={{300,-114},{340,-74}}),
        iconTransformation(extent={{300,-114},{340,-74}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput reachTZonSetNom
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
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetLim(
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
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=-1*TRatThreshold,
      h=0)
    annotation (Placement(transformation(extent={{-274,118},{-254,138}})));
  Buildings.Controls.OBC.CDL.Logical.Switch
                                          logSwi
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{-176,122},{-156,142}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-138,18},{-118,38}})));
  Buildings.Controls.OBC.CDL.Reals.Switch
                                       TZonSetMax
    annotation (Placement(transformation(extent={{-48,-144},{-28,-124}})));
  Buildings.Controls.OBC.CDL.Reals.Switch
                                       TZonSetMin
    annotation (Placement(transformation(extent={{-44,-174},{-24,-154}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetLim(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "thermal limit zone temperature setpoint" annotation (Placement(
        transformation(extent={{-236,-244},{-196,-204}}), iconTransformation(
          extent={{-240,-214},{-200,-174}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetNom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "nominal zone temperature setpoint" annotation (Placement(transformation(
          extent={{-236,-284},{-196,-244}}), iconTransformation(extent={{-238,
            -250},{-198,-210}})));
  Buildings.Controls.OBC.CDL.Reals.Less    les
    annotation (Placement(transformation(extent={{138,-142},{158,-122}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{180,-142},{200,-122}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre2
    annotation (Placement(transformation(extent={{138,-252},{158,-232}})));
  Buildings.Controls.OBC.CDL.Logical.Not not4
    annotation (Placement(transformation(extent={{180,-252},{200,-232}})));
  Buildings.Controls.OBC.CDL.Logical.Switch
                                          logSwi1
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{238,-118},{258,-98}})));
  Buildings.Controls.OBC.CDL.Logical.Switch
                                          logSwi2
    "Switch to zero adjustment when window is open"
    annotation (Placement(transformation(extent={{254,-202},{274,-182}})));
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
  connect(TZonSetCur, gre3.u1) annotation (Line(points={{-220,-90},{-178,-90},{
          -178,-116},{50,-116},{50,-94},{132,-94}}, color={0,0,127}));
  connect(TZonSetCur, les1.u1) annotation (Line(points={{-220,-90},{-220,-92},{
          -180,-92},{-180,-116},{52,-116},{52,-96},{124,-96},{124,-204},{134,
          -204}}, color={0,0,127}));
  connect(subt.u2, TZonSetCur) annotation (Line(points={{150,-38},{62,-38},{62,
          -118},{-166,-118},{-166,-90},{-220,-90}},     color={0,0,127}));
  connect(add.u2, TZonSetCur) annotation (Line(points={{68,38},{50,38},{50,-116},
          {-178,-116},{-178,-90},{-220,-90}},                      color={0,0,
          127}));
  connect(heaCooMod, booToRea.u) annotation (Line(points={{-220,88},{-108,88},{-108,
          70},{-90,70}}, color={255,0,255}));
  connect(heaCooMod, booToRea1.u) annotation (Line(points={{-220,88},{-108,88},{
          -108,-56},{-92,-56}}, color={255,0,255}));
  connect(subt.y, lesThr.u) annotation (Line(points={{174,-32},{194,-32},{194,
          154},{-280,154},{-280,194},{-270,194}}, color={0,0,127}));
  connect(subt.y, greThr.u) annotation (Line(points={{174,-32},{194,-32},{194,
          154},{-286,154},{-286,128},{-276,128}}, color={0,0,127}));
  connect(heaCooMod, logSwi.u2) annotation (Line(points={{-220,88},{-220,132},{
          -178,132}}, color={255,0,255}));
  connect(ratSig, and2.u2) annotation (Line(points={{-220,22},{-148,22},{-148,
          20},{-140,20}}, color={255,0,255}));
  connect(and2.y, swi4.u2) annotation (Line(points={{-116,28},{-94,28},{-94,42},
          {-38,42}}, color={255,0,255}));
  connect(lesThr.y, logSwi.u1) annotation (Line(points={{-246,194},{-238,194},{
          -238,140},{-178,140}}, color={255,0,255}));
  connect(greThr.y, logSwi.u3) annotation (Line(points={{-252,128},{-188,128},{
          -188,124},{-178,124}}, color={255,0,255}));
  connect(logSwi.y, and2.u1) annotation (Line(points={{-154,132},{-146,132},{
          -146,36},{-148,36},{-148,28},{-140,28}}, color={255,0,255}));
  connect(TZonSetMax.y, min1.u2) annotation (Line(points={{-26,-134},{-20,-134},
          {-20,-108},{56,-108},{56,24},{108,24},{108,38},{114,38}},
                    color={0,0,127}));
  connect(TZonSetMin.y, max1.u2) annotation (Line(points={{-22,-164},{56,-164},
          {56,-112},{64,-112},{64,20},{144,20},{144,36},{148,36},{148,38},{154,
          38}},                                                   color={0,0,
          127}));
  connect(heaCooMod, TZonSetMax.u2) annotation (Line(points={{-220,88},{-108,88},
          {-108,-134},{-50,-134}}, color={255,0,255}));
  connect(heaCooMod, TZonSetMin.u2) annotation (Line(points={{-220,88},{-108,88},
          {-108,-136},{-64,-136},{-64,-164},{-46,-164}}, color={255,0,255}));
  connect(TZonHeaSetNom, TZonSetMax.u1) annotation (Line(points={{-220,-174},{
          -216,-174},{-216,-176},{-140,-176},{-140,-172},{-136,-172},{-136,-132},
          {-60,-132},{-60,-126},{-50,-126}}, color={0,0,127}));
  connect(TZonCooSetLim, TZonSetMax.u3) annotation (Line(points={{-216,-224},{
          -84,-224},{-84,-142},{-50,-142}}, color={0,0,127}));
  connect(TZonHeaSetLim, TZonSetMin.u1) annotation (Line(points={{-220,-134},{
          -216,-134},{-216,-136},{-60,-136},{-60,-156},{-46,-156}}, color={0,0,
          127}));
  connect(TZonCooSetNom, TZonSetMin.u3) annotation (Line(points={{-216,-264},{
          -216,-136},{-192,-136},{-192,-180},{-56,-180},{-56,-172},{-46,-172}},
        color={0,0,127}));
  connect(logSwi1.y, reachTZonSetLim) annotation (Line(points={{260,-108},{288,
          -108},{288,-94},{320,-94}}, color={255,0,255}));
  connect(logSwi2.y, reachTZonSetNom) annotation (Line(points={{276,-192},{292,
          -192},{292,-136},{320,-136}}, color={255,0,255}));
  connect(heaCooMod, logSwi1.u2) annotation (Line(points={{-220,88},{-190,88},{
          -190,24},{186,24},{186,-108},{236,-108}}, color={255,0,255}));
  connect(logSwi2.u2, heaCooMod) annotation (Line(points={{252,-192},{144,-192},
          {144,-210},{-220,-210},{-220,88}}, color={255,0,255}));
  connect(les.u1, TZonSetCur) annotation (Line(points={{136,-132},{124,-132},{
          124,-96},{52,-96},{52,-116},{-168,-116},{-168,-92},{-220,-92},{-220,
          -90}}, color={0,0,127}));
  connect(gre2.u1, TZonSetCur) annotation (Line(points={{136,-242},{136,-244},{
          112,-244},{112,-96},{52,-96},{52,-116},{-168,-116},{-168,-92},{-220,
          -92},{-220,-90}}, color={0,0,127}));
  connect(TZonHeaSetLim, gre3.u2) annotation (Line(points={{-220,-134},{-220,
          -136},{-60,-136},{-60,-184},{172,-184},{172,-112},{132,-112},{132,
          -102}}, color={0,0,127}));
  connect(TZonCooSetLim, les.u2) annotation (Line(points={{-216,-224},{-120,
          -224},{-120,-216},{98,-216},{98,-140},{136,-140}}, color={0,0,127}));
  connect(les.y, not3.u)
    annotation (Line(points={{160,-132},{178,-132}}, color={255,0,255}));
  connect(not3.y, logSwi1.u3) annotation (Line(points={{202,-132},{224,-132},{
          224,-116},{236,-116}}, color={255,0,255}));
  connect(not2.y, logSwi1.u1) annotation (Line(points={{198,-94},{200,-100},{
          236,-100}}, color={255,0,255}));
  connect(not1.y, logSwi2.u1) annotation (Line(points={{200,-204},{208,-204},{
          208,-184},{252,-184}}, color={255,0,255}));
  connect(not4.y, logSwi2.u3) annotation (Line(points={{202,-242},{240,-242},{
          240,-200},{252,-200}}, color={255,0,255}));
  connect(TZonHeaSetNom, les1.u2) annotation (Line(points={{-220,-174},{-220,
          -176},{-140,-176},{-140,-172},{-136,-172},{-136,-132},{-88,-132},{-88,
          -176},{-64,-176},{-64,-192},{116,-192},{116,-208},{134,-208},{134,
          -212}}, color={0,0,127}));
  connect(TZonCooSetNom, gre2.u2) annotation (Line(points={{-216,-264},{-216,
          116},{-248,116},{-248,-292},{136,-292},{136,-250}}, color={0,0,127}));
  connect(gre2.y, not4.u)
    annotation (Line(points={{160,-242},{178,-242}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -300},{300,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-300},{300,
            100}})));
end single_zone_ratchet;
