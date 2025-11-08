within cdl_models.Controls.Subsequences;
model single_zone_ratchet_base

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
  one_zone_ratchet_heating_single_zone ratHea(
    samplePeriodRatchet=samplePeriodRatchet,
    samplePeriodRebound=samplePeriodRebound,
    TRatThreshold=TRatThreshold,
    TRat=TRat,
    TReb=TReb,
    reboundDuration=reboundDuration)
    annotation (Placement(transformation(extent={{118,54},{168,82}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZon(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone room air temperature" annotation (Placement(transformation(
          extent={{-240,-22},{-200,18}}), iconTransformation(extent={{-240,-22},
            {-200,18}})),
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
          extent={{-238,-110},{-198,-70}}),
                                          iconTransformation(extent={{-238,-106},
            {-198,-66}})),
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
          extent={{202,48},{242,88}}), iconTransformation(extent={{200,102},{
            240,142}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle" "@prefix brick: <https://brickschema.org/schema/Brick#> .
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
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=loaSheHeaAct)
    annotation (Placement(transformation(extent={{-86,162},{-66,182}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZonCooSetCom(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone temperature setpoint command" annotation (Placement(transformation(
          extent={{202,-128},{242,-88}}),  iconTransformation(extent={{200,-118},
            {240,-78}})),
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
  one_zone_ratchet_cooling_single_zone ratCoo(
    samplePeriodRatchet=samplePeriodRatchet,
    samplePeriodRebound=samplePeriodRebound,
    TRatThreshold=TRatThreshold,
    TRat=TRat,
    TReb=TReb,
    reboundDuration=reboundDuration)
    annotation (Placement(transformation(extent={{120,-122},{170,-94}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSetCur(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Current zone temperature setpoint" annotation (Placement(transformation(
          extent={{-238,-196},{-198,-156}}),
                                           iconTransformation(extent={{-238,
            -186},{-198,-146}})),
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
    annotation (Placement(transformation(extent={{-6,144},{14,164}})));

  Buildings.Controls.OBC.CDL.Logical.Switch logSwi3
    annotation (Placement(transformation(extent={{-6,94},{14,114}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=false)
    annotation (Placement(transformation(extent={{-86,118},{-66,138}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(k=
        loaSheCooAct)
    annotation (Placement(transformation(extent={{-86,76},{-66,96}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput occSta "occupancy status"
    annotation (Placement(transformation(extent={{-238,78},{-198,118}}),
        iconTransformation(extent={{-238,78},{-198,118}})),
            __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle" "@prefix brick: <https://brickschema.org/schema/Brick#> .
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=loadShedTempAmount)
    annotation (Placement(transformation(extent={{-84,-94},{-64,-74}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract TZonHeaSetMin
    annotation (Placement(transformation(extent={{-2,-66},{18,-46}})));
  Buildings.Controls.OBC.CDL.Reals.Add TZonCooSetMax
    annotation (Placement(transformation(extent={{0,-138},{20,-118}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          TZonHeaSetNom(realTrue=
        TZonHeaSetNomOcc, realFalse=TZonHeaSetNomUnocc)
    annotation (Placement(transformation(extent={{-86,-48},{-66,-28}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal
                                          TZonCooSetNom(realTrue=
        TZonCooSetNomOcc, realFalse=TZonCooSetNomUnocc)
    annotation (Placement(transformation(extent={{-78,-154},{-58,-134}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput loaShe annotation (
      Placement(transformation(extent={{-240,168},{-200,208}}),
        iconTransformation(extent={{-242,160},{-202,200}})), __cdl(semantic(
          metadataLanguage="Brick 1.3 text/turtle" "@prefix brick: <https://brickschema.org/schema/Brick#> .
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
                sh:path ref:hasExternalReference .", naturalLanguage="en"
          "<cdl_instance_name> is a temperature heating setpoint input")));
equation
  connect(ratCoo.TZonCooSetCom, TZonCooSetCom) annotation (Line(points={{172,
          -107.72},{196,-107.72},{196,-108},{222,-108}}, color={0,0,127}));
  connect(ratHea.TZonSetHeaCom, TZonHeaSetCom) annotation (Line(points={{170,
          67.86},{196,67.86},{196,68},{222,68}}, color={0,0,127}));
  connect(con.y, logSwi2.u2) annotation (Line(points={{-64,172},{-16,172},{-16,
          154},{-8,154}}, color={255,0,255}));
  connect(logSwi2.y, ratHea.loaShe) annotation (Line(points={{16,154},{106,154},
          {106,78.64},{116,78.64}}, color={255,0,255}));
  connect(logSwi3.y, ratCoo.loaShe) annotation (Line(points={{16,104},{24,104},
          {24,-52},{108,-52},{108,-97.36},{118,-97.36}}, color={255,0,255}));
  connect(con1.y, logSwi2.u3) annotation (Line(points={{-64,128},{-32,128},{-32,
          146},{-8,146}}, color={255,0,255}));
  connect(TZonHeaSetCur, ratHea.TZonHeaSetCur) annotation (Line(points={{-218,
          -90},{-108,-90},{-108,68},{116,68},{116,68.28}}, color={0,0,127}));
  connect(TZonCooSetCur, ratCoo.TZonCooSetCur) annotation (Line(points={{-218,
          -176},{-90,-176},{-90,-107.3},{118,-107.3}}, color={0,0,127}));
  connect(con1.y, logSwi3.u3) annotation (Line(points={{-64,128},{-32,128},{-32,
          96},{-8,96}}, color={255,0,255}));
  connect(con2.y, logSwi3.u2) annotation (Line(points={{-64,86},{-24,86},{-24,
          104},{-8,104}},
        color={255,0,255}));
  connect(TZonHeaSetNom.y, TZonHeaSetMin.u1) annotation (Line(points={{-64,-38},
          {-38,-38},{-38,-50},{-4,-50}},                             color={0,0,
          127}));
  connect(con3.y, TZonHeaSetMin.u2) annotation (Line(points={{-62,-84},{-16,-84},
          {-16,-62},{-4,-62}},      color={0,0,127}));
  connect(TZonCooSetNom.y, TZonCooSetMax.u2) annotation (Line(points={{-56,-144},
          {-16,-144},{-16,-134},{-2,-134}},                             color={0,
          0,127}));
  connect(con3.y, TZonCooSetMax.u1) annotation (Line(points={{-62,-84},{-16,-84},
          {-16,-122},{-2,-122}},    color={0,0,127}));
  connect(occSta, TZonHeaSetNom.u) annotation (Line(points={{-218,98},{-152,98},
          {-152,-38},{-88,-38}},  color={255,0,255}));
  connect(occSta, TZonCooSetNom.u) annotation (Line(points={{-218,98},{-152,98},
          {-152,-144},{-80,-144}},  color={255,0,255}));
  connect(TZonHeaSetNom.y, ratHea.TZonHeaSetNom) annotation (Line(points={{-64,
          -38},{-38,-38},{-38,58.48},{116,58.48}}, color={0,0,127}));
  connect(TZonCooSetNom.y, ratCoo.TZonCooSetNom) annotation (Line(points={{-56,
          -144},{100,-144},{100,-117.1},{118.2,-117.1}}, color={0,0,127}));
  connect(TZonCooSetMax.y, ratCoo.TZonCooSetMax) annotation (Line(points={{22,
          -128},{28,-128},{28,-112.34},{118.2,-112.34}}, color={0,0,127}));
  connect(TZonHeaSetMin.y, ratHea.TZonHeaSetMin) annotation (Line(points={{20,
          -56},{40,-56},{40,63.24},{116,63.24}}, color={0,0,127}));
  connect(loaShe, logSwi2.u1) annotation (Line(points={{-220,188},{-8,188},{-8,
          162}}, color={255,0,255}));
  connect(loaShe, logSwi3.u1) annotation (Line(points={{-220,188},{-46,188},{
          -46,112},{-8,112}}, color={255,0,255}));
  connect(TZon, ratCoo.TZon) annotation (Line(points={{-220,-2},{80,-2},{80,
          -102},{118,-102},{118,-102.68}}, color={0,0,127}));
  connect(TZon, ratHea.TZon) annotation (Line(points={{-220,-2},{80,-2},{80,74},
          {116,74},{116,73.46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -220},{200,220}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,
            220}})));
end single_zone_ratchet_base;
