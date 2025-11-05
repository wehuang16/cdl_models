within cdl_models.Controls;
block Controller

 parameter Real loadShedHourStart=16;
  parameter Real loadShedHourEnd=21;
  parameter Real TZonHeaSetNomOcc(unit="K")=273.15+22.2222;
  parameter Real TZonHeaSetNomUnocc(unit="K")=273.15+15.5556;
  parameter Real TZonCooSetNomOcc(unit="K")=273.15+25.5556;
  parameter Real TZonCooSetNomUnocc(unit="K")=273.15+32.2222;
    parameter Real loadShedDurationTypical(unit="s")=(loadShedHourEnd-loadShedHourStart)*3600;
    parameter Real reboundDuration(unit="s")=3600;
    parameter Real loadShedTempAmount=5;
    parameter Boolean loaSheHeaAct=true;
    parameter Boolean loaSheCooAct=true;
     parameter Real TRatThreshold=1.1111
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
    parameter Real TRat=0.5556
    "Ratcheting temperature (defined as >0)";
               parameter Real TReb=0.5556
    "rebound temperature (defined as >0)";
      parameter Real samplePeriodRatchet(unit="s")=loadShedDurationTypical*0.3333*TRat/loadShedTempAmount
    "Sample period of the demand flexibility control";
          parameter Real samplePeriodRebound(unit="s")=reboundDuration*TReb/loadShedTempAmount
    "Sample period of rebound";
  cdl_models.Controls.Subsequences.single_zone_ratchet_heating single_zone_ratchet_heating(
    samplePeriodRatchet=samplePeriodRatchet,
    samplePeriodRebound=samplePeriodRebound,
    TRatThreshold=TRatThreshold,
    TRat=TRat,
    TReb=TReb)
    annotation (Placement(transformation(extent={{204,-12},{254,16}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-320,58},{-280,98}}),  iconTransformation(extent={{-322,42},{
            -282,82}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle"
            "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Zone_Air_Temperature_Sensor ;
              sh:property hpfs:temperature_Kelvin, hpfs:temperature_ref .
            hpfs:temperature_Kelvin a sh:PropertyShape ;
              sh:hasValue unit:Kelvin ;
              sh:minCount 1 ;
              sh:path qudt:hasUnit .
            hpfs:temperature_ref a sh:PropertyShape ;
              sh:minCount 1 ;
              sh:path ref:hasExternalReference .",
          naturalLanguage="en"
            "<cdl_instance_name> is a temperature reading input that should be hardwired to the zone air temperature sensor")));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSetCur(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-320,26},{-280,66}}),  iconTransformation(extent={{-322,10},{
            -282,50}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle"
            "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Heating_Zone_Air_Temperature_Setpoint ;
              sh:property hpfs:temperature-setpoint_Kelvin, hpfs:temperature-setpoint_ref .
            hpfs:temperature-setpoint_Kelvin a sh:PropertyShape ;
              sh:hasValue unit:Kelvin ;
              sh:minCount 1 ;
              sh:path qudt:hasUnit .
            hpfs:temperature-setpoint_ref a sh:PropertyShape ;
                sh:minCount 1 ;
                sh:path ref:hasExternalReference .",
          naturalLanguage="en"
            "<cdl_instance_name> is a temperature heating setpoint input")));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonHeaSetCom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{282,32},{322,72}}), iconTransformation(extent={{280,18},{320,
            58}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle"
            "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Heating_Zone_Air_Temperature_Setpoint ;
              sh:property hpfs:temperature-setpoint_Kelvin, hpfs:temperature-setpoint_ref .
            hpfs:temperature-setpoint_Kelvin a sh:PropertyShape ;
              sh:hasValue unit:Kelvin ;
              sh:minCount 1 ;
              sh:path qudt:hasUnit .
            hpfs:temperature-setpoint_ref a sh:PropertyShape ;
                sh:minCount 1 ;
                sh:path ref:hasExternalReference .",
          naturalLanguage="en"
            "<cdl_instance_name> is a temperature heating setpoint input")));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=
        loaSheHeaAct)
    annotation (Placement(transformation(extent={{0,158},{20,178}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonCooSetCom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{282,-144},{322,-104}}), iconTransformation(extent={{280,-150},
            {320,-110}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle"
            "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Cooling_Zone_Air_Temperature_Setpoint ;
              sh:property hpfs:temperature-setpoint_Kelvin, hpfs:temperature-setpoint_ref .
            hpfs:temperature-setpoint_Kelvin a sh:PropertyShape ;
              sh:hasValue unit:Kelvin ;
              sh:minCount 1 ;
              sh:path qudt:hasUnit .
            hpfs:temperature-setpoint_ref a sh:PropertyShape ;
                sh:minCount 1 ;
                sh:path ref:hasExternalReference .",
          naturalLanguage="en"
            "<cdl_instance_name> is a temperature cooling setpoint input")));
  cdl_models.Controls.Subsequences.single_zone_ratchet_cooling single_zone_ratchet_cooling(
    samplePeriodRatchet=samplePeriodRatchet,
    samplePeriodRebound=samplePeriodRebound,
    TRatThreshold=TRatThreshold,
    TRat=TRat,
    TReb=TReb)
    annotation (Placement(transformation(extent={{192,-140},{242,-112}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetCur(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-320,-6},{-280,34}}),   iconTransformation(extent={{-320,-24},
            {-280,16}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle"
            "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Cooling_Zone_Air_Temperature_Setpoint ;
              sh:property hpfs:temperature-setpoint_Kelvin, hpfs:temperature-setpoint_ref .
            hpfs:temperature-setpoint_Kelvin a sh:PropertyShape ;
              sh:hasValue unit:Kelvin ;
              sh:minCount 1 ;
              sh:path qudt:hasUnit .
            hpfs:temperature-setpoint_ref a sh:PropertyShape ;
                sh:minCount 1 ;
                sh:path ref:hasExternalReference .",
          naturalLanguage="en"
            "<cdl_instance_name> is a temperature cooling setpoint input")));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi2
    annotation (Placement(transformation(extent={{118,136},{138,156}})));

  Buildings.Controls.OBC.CDL.Logical.Switch logSwi3
    annotation (Placement(transformation(extent={{114,-82},{134,-62}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=false)
    annotation (Placement(transformation(extent={{6,-58},{26,-38}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(k=
        loaSheCooAct)
    annotation (Placement(transformation(extent={{-4,-176},{16,-156}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput occSta "occupancy status"
    annotation (Placement(transformation(extent={{-320,134},{-280,174}}),
        iconTransformation(extent={{-320,134},{-280,174}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle"
            "@prefix brick: <https://brickschema.org/schema/Brick#> .
            @prefix hpfs: <http://hpflex/shapes#> .
            @prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
            @prefix sh: <http://www.w3.org/ns/shacl#> .
            @prefix qudt: <http://qudt.org/schema/qudt/> .
            @prefix ref: <https://brickschema.org/schema/Brick/ref#> .
            @prefix unit: <http://qudt.org/vocab/unit/> .
            hpfs:<cdl_instance_name> a rdfs:Class, sh:NodeShape ;
              sh:class brick:Occupancy_Sensor ;
              sh:property hpfs:occupancy_ref .
            hpfs:occupancy_ref a sh:PropertyShape ;
                sh:minCount 1 ;
                sh:path ref:hasExternalReference .",
          naturalLanguage="en"
            "<cdl_instance_name> is a temperature heating setpoint input")));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable loaShe(
    table=[0,0; loadShedHourStart,1; loadShedHourEnd,0; 24,0],
    timeScale=3600,
    period=86400)
    annotation (Placement(transformation(extent={{-208,108},{-188,128}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=loadShedTempAmount)
    annotation (Placement(transformation(extent={{-260,-142},{-240,-122}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract TZonHeaSetMin
    annotation (Placement(transformation(extent={{-190,-84},{-170,-64}})));
  Buildings.Controls.OBC.CDL.Reals.Add TZonCooSetMax
    annotation (Placement(transformation(extent={{-188,-142},{-168,-122}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          TZonHeaSetNom(realTrue=
        TZonHeaSetNomOcc, realFalse=TZonHeaSetNomUnocc)
    annotation (Placement(transformation(extent={{-240,-42},{-220,-22}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          TZonCooSetNom(realTrue=
        TZonCooSetNomOcc, realFalse=TZonCooSetNomUnocc)
    annotation (Placement(transformation(extent={{-240,-200},{-220,-180}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con4(k=true)
    annotation (Placement(transformation(extent={{118,98},{138,118}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con5(k=true)
    annotation (Placement(transformation(extent={{114,-114},{134,-94}})));
equation
  connect(TZon,single_zone_ratchet_heating. TZon) annotation (Line(points={{-300,78},
          {-256,78},{-256,80},{-210,80},{-210,-2},{112,-2},{112,6},{194,6},{194,
          4.94},{202,4.94}},                    color={0,0,127}));
  connect(single_zone_ratchet_cooling.TZonCooSetCom, TZonCooSetCom) annotation (
     Line(points={{244,-116.06},{276,-116.06},{276,-124},{302,-124}}, color={0,
          0,127}));
  connect(single_zone_ratchet_heating.TZonSetHeaCom, TZonHeaSetCom) annotation (
     Line(points={{256,11.94},{276,11.94},{276,52},{302,52}}, color={0,0,127}));
  connect(con1.y, logSwi2.u2) annotation (Line(points={{22,168},{78,168},{78,146},
          {116,146}},
                    color={255,0,255}));
  connect(logSwi2.y, single_zone_ratchet_heating.loaShe) annotation (Line(
        points={{140,146},{188,146},{188,14},{194,14},{194,12.64},{202,12.64}},
                                                            color={255,0,255}));
  connect(logSwi3.y, single_zone_ratchet_cooling.loaShe) annotation (Line(
        points={{136,-72},{186,-72},{186,-115.36},{190,-115.36}},   color={255,
          0,255}));
  connect(con.y, logSwi2.u3) annotation (Line(points={{28,-48},{114,-48},{114,0},
          {110,0},{110,138},{116,138}},
                                      color={255,0,255}));
  connect(TZon, single_zone_ratchet_cooling.TZon) annotation (Line(points={{-300,78},
          {-286,78},{-286,46},{-64,46},{-64,-4},{86,-4},{86,-122},{152,-122},{152,
          -123.06},{190,-123.06}},            color={0,0,127}));
  connect(TZonHeaSetCur, single_zone_ratchet_heating.TZonHeaSetCur) annotation (
     Line(points={{-300,46},{-148,46},{-148,-8},{-2,-8},{-2,2.7},{202,2.7}},
        color={0,0,127}));
  connect(TZonCooSetCur, single_zone_ratchet_cooling.TZonCooSetCur) annotation (
     Line(points={{-300,14},{-252,14},{-252,-88},{-196,-88},{-196,-116},{-36,-116},
          {-36,-130},{144,-130},{144,-128},{182,-128},{182,-125.3},{190,-125.3}},
        color={0,0,127}));
  connect(con.y, logSwi3.u3) annotation (Line(points={{28,-48},{36,-48},{36,-80},
          {112,-80}},             color={255,0,255}));
  connect(con2.y, logSwi3.u2) annotation (Line(points={{18,-166},{94,-166},{94,-72},
          {112,-72}},
        color={255,0,255}));
  connect(TZonHeaSetNom.y, TZonHeaSetMin.u1) annotation (Line(points={{-218,-32},
          {-202,-32},{-202,-68},{-192,-68}},                         color={0,0,
          127}));
  connect(con3.y, TZonHeaSetMin.u2) annotation (Line(points={{-238,-132},{-200,-132},
          {-200,-80},{-192,-80}},   color={0,0,127}));
  connect(TZonCooSetNom.y, TZonCooSetMax.u2) annotation (Line(points={{-218,-190},
          {-208,-190},{-208,-138},{-190,-138}},                         color={0,
          0,127}));
  connect(con3.y, TZonCooSetMax.u1) annotation (Line(points={{-238,-132},{-200,-132},
          {-200,-126},{-190,-126}}, color={0,0,127}));
  connect(occSta, TZonHeaSetNom.u) annotation (Line(points={{-300,154},{-270,154},
          {-270,-32},{-242,-32}}, color={255,0,255}));
  connect(occSta, TZonCooSetNom.u) annotation (Line(points={{-300,154},{-270,154},
          {-270,-190},{-242,-190}}, color={255,0,255}));
  connect(TZonHeaSetNom.y, single_zone_ratchet_heating.TZonHeaSetNom)
    annotation (Line(points={{-218,-32},{200,-32},{200,-18},{194,-18},{194,-2.2},
          {202,-2.2}}, color={0,0,127}));
  connect(TZonCooSetNom.y, single_zone_ratchet_cooling.TZonCooSetNom)
    annotation (Line(points={{-218,-190},{-208,-190},{-208,-184},{144,-184},{144,
          -156},{180,-156},{180,-135.1},{190.2,-135.1}}, color={0,0,127}));
  connect(TZonCooSetMax.y, single_zone_ratchet_cooling.TZonCooSetMax)
    annotation (Line(points={{-166,-132},{-164,-132.58},{190,-132.58}}, color={0,
          0,127}));
  connect(TZonHeaSetMin.y, single_zone_ratchet_heating.TZonHeaSetMin)
    annotation (Line(points={{-168,-74},{-120,-74},{-120,0},{190,0},{190,0.32},{
          202,0.32}}, color={0,0,127}));
  connect(loaShe.y[1], logSwi2.u1) annotation (Line(points={{-186,118},{-6,118},
          {-6,184},{108,184},{108,154},{116,154}}, color={255,0,255}));
  connect(loaShe.y[1], logSwi3.u1) annotation (Line(points={{-186,118},{-37,118},
          {-37,-64},{112,-64}}, color={255,0,255}));
  connect(con4.y, single_zone_ratchet_heating.ratSig) annotation (Line(points={{
          140,108},{186,108},{186,10.54},{202,10.54}}, color={255,0,255}));
  connect(con4.y, single_zone_ratchet_heating.rebSig) annotation (Line(points={{
          140,108},{186,108},{186,10},{198,10},{198,8.3},{202,8.3}}, color={255,
          0,255}));
  connect(con5.y, single_zone_ratchet_cooling.ratSig) annotation (Line(points={{
          136,-104},{180,-104},{180,-117.46},{190,-117.46}}, color={255,0,255}));
  connect(con5.y, single_zone_ratchet_cooling.rebSig) annotation (Line(points={{
          136,-104},{180,-104},{180,-118},{186,-118},{186,-119.7},{190,-119.7}},
        color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-220},
            {280,220}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-280,-220},{280,220}})));
end Controller;
