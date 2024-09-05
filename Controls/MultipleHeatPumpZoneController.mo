within cdl_models.Controls;
model MultipleHeatPumpZoneController

   parameter Integer numHeaPum=3 "number of heat pumps";
   parameter Integer numApa=4 "number of apartments";
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput reqDomHotWat[numApa]
    "request domestic hot water" annotation (Placement(transformation(extent={{
            -140,38},{-100,78}}), iconTransformation(extent={{-140,60},{-100,
            100}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput reqSpaCon[numApa]
    "request space conditioning" annotation (Placement(transformation(extent={{
            -140,-66},{-100,-26}}), iconTransformation(extent={{-140,60},{-100,
            100}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput comHeaPumMod[numHeaPum]
    "a command of heat pump modes" annotation (Placement(transformation(extent=
            {{100,-22},{140,18}}), iconTransformation(extent={{-140,60},{-100,
            100}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[numApa]
    annotation (Placement(transformation(extent={{-76,52},{-56,72}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=numApa)
    annotation (Placement(transformation(extent={{-28,52},{-8,72}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter fraHeaPumPerApa(k=
        numHeaPum/numApa) "fraction of heat pump per apartment"
    annotation (Placement(transformation(extent={{22,52},{42,72}})));
equation
  connect(reqDomHotWat, intToRea.u) annotation (Line(points={{-120,58},{-86,58},
          {-86,62},{-78,62}}, color={255,127,0}));
  connect(intToRea.y, mulSum.u)
    annotation (Line(points={{-54,62},{-30,62}}, color={0,0,127}));
  connect(mulSum.y, fraHeaPumPerApa.u)
    annotation (Line(points={{-6,62},{20,62}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultipleHeatPumpZoneController;
