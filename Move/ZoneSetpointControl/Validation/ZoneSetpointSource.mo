within cdl_models.Move.ZoneSetpointControl.Validation;
model ZoneSetpointSource
  extends Modelica.Icons.Example;
  cdl_models.Move.ZoneSetpointControl.ZoneSetpointSource zoneSetpointSource
    annotation (Placement(transformation(extent={{-8,-12},{12,8}})));
  annotation (experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ZoneSetpointSource;
